using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.SceneManagement;
using YooAsset;

namespace GameFramework.Resource;

public sealed class YooObjectHub
{
	private readonly struct AssetKey(string pkg, string loc) : IEquatable<AssetKey>
	{
		public readonly string Package = pkg;

		public readonly string Location = loc;

		public bool Equals(AssetKey other)
		{
			return Package == other.Package && Location == other.Location;
		}

		public override bool Equals(object obj)
		{
			return obj is AssetKey other && Equals(other);
		}

		public override int GetHashCode()
		{
			return HashCode.Combine(Package, Location);
		}

		public override string ToString()
		{
			return (string.IsNullOrEmpty(Package) ? "<default>" : Package) + ":" + Location;
		}
	}

	private readonly struct SceneKey(string pkg, string loc) : IEquatable<SceneKey>
	{
		public readonly string Package = pkg;

		public readonly string Location = loc;

		public bool Equals(SceneKey other)
		{
			return Package == other.Package && Location == other.Location;
		}

		public override bool Equals(object obj)
		{
			return obj is SceneKey other && Equals(other);
		}

		public override int GetHashCode()
		{
			return HashCode.Combine(Package, Location);
		}

		public override string ToString()
		{
			return (string.IsNullOrEmpty(Package) ? "<default>" : Package) + ":" + Location;
		}
	}

	private enum EntryState
	{
		None,
		Loading,
		Ready
	}

	private abstract class EntryBase : IReference
	{
		public EntryState State;

		public int Epoch;

		public int StartEpoch;

		public UniTask Barrier;

		public UniTaskCompletionSource BarrierTcs;

		public float LastIdleAt;

		public virtual void Clear()
		{
			State = EntryState.None;
			Epoch = 0;
			StartEpoch = 0;
			Barrier = default(UniTask);
			BarrierTcs = null;
			LastIdleAt = 0f;
		}

		public void MarkIdleNow()
		{
			State = EntryState.None;
			Barrier = default(UniTask);
			BarrierTcs = null;
			LastIdleAt = Time.realtimeSinceStartup;
		}

		public abstract void Dispose();
	}

	private sealed class AssetEntry : EntryBase
	{
		public UnityEngine.Object Asset;

		public AssetHandle RootHandle;

		public Stack<AssetHandle> Subs;

		public static AssetEntry Create()
		{
			AssetEntry assetEntry = ReferencePool.Acquire<AssetEntry>();
			assetEntry.State = EntryState.Loading;
			assetEntry.Epoch = 0;
			assetEntry.StartEpoch = 0;
			assetEntry.Asset = null;
			assetEntry.RootHandle = null;
			assetEntry.Subs = assetEntry.Subs ?? new Stack<AssetHandle>(4);
			assetEntry.Subs.Clear();
			assetEntry.BarrierTcs = new UniTaskCompletionSource();
			assetEntry.Barrier = assetEntry.BarrierTcs.Task;
			assetEntry.LastIdleAt = 0f;
			return assetEntry;
		}

		public override void Clear()
		{
			base.Clear();
			Asset = null;
			RootHandle = null;
			Subs?.Clear();
		}

		public override void Dispose()
		{
			Clear();
			ReferencePool.Release(this);
		}
	}

	private sealed class SceneEntry : EntryBase
	{
		public UnityEngine.SceneManagement.Scene SceneObj;

		public SceneHandle Handle;

		public LoadSceneMode Mode;

		public LocalPhysicsMode Physics;

		public bool SuspendLoad;

		public uint Priority;

		public static SceneEntry Create(LoadSceneMode mode, LocalPhysicsMode physics, bool suspend, uint priority)
		{
			SceneEntry sceneEntry = ReferencePool.Acquire<SceneEntry>();
			sceneEntry.State = EntryState.Loading;
			sceneEntry.Epoch = 0;
			sceneEntry.StartEpoch = 0;
			sceneEntry.SceneObj = default(UnityEngine.SceneManagement.Scene);
			sceneEntry.Handle = null;
			sceneEntry.Mode = mode;
			sceneEntry.Physics = physics;
			sceneEntry.SuspendLoad = suspend;
			sceneEntry.Priority = priority;
			sceneEntry.BarrierTcs = new UniTaskCompletionSource();
			sceneEntry.Barrier = sceneEntry.BarrierTcs.Task;
			sceneEntry.LastIdleAt = 0f;
			return sceneEntry;
		}

		public override void Clear()
		{
			base.Clear();
			SceneObj = default(UnityEngine.SceneManagement.Scene);
			Handle = null;
			Mode = LoadSceneMode.Additive;
			Physics = LocalPhysicsMode.None;
			SuspendLoad = false;
			Priority = 0u;
		}

		public override void Dispose()
		{
			Clear();
			ReferencePool.Release(this);
		}
	}

	private sealed class _ReturnOnDestroy : MonoBehaviour
	{
		private YooObjectHub _hub;

		private string _loc;

		private string _pkg;

		public void Init(YooObjectHub hub, string loc, string pkg)
		{
			_hub = hub;
			_loc = loc;
			_pkg = pkg;
		}

		private void OnDestroy()
		{
			_hub.ReleaseAsync(_loc, _pkg);
		}
	}

	private readonly string _defaultPackageName;

	private readonly float _assetIdleTTL;

	private readonly float _sceneIdleTTL;

	private readonly SemaphoreSlim _gate = new SemaphoreSlim(1, 1);

	private readonly Dictionary<AssetKey, AssetEntry> _assets;

	private readonly Dictionary<SceneKey, SceneEntry> _scenes;

	public YooObjectHub(string defaultPackageName, float assetIdleTTL = 300f, float sceneIdleTTL = 300f, int assetCapacity = 128, int sceneCapacity = 32)
	{
		if (string.IsNullOrEmpty(defaultPackageName))
		{
			throw new ArgumentException("defaultPackageName required.", "defaultPackageName");
		}
		_defaultPackageName = defaultPackageName;
		_assetIdleTTL = Mathf.Max(0f, assetIdleTTL);
		_sceneIdleTTL = Mathf.Max(0f, sceneIdleTTL);
		_assets = new Dictionary<AssetKey, AssetEntry>(assetCapacity);
		_scenes = new Dictionary<SceneKey, SceneEntry>(sceneCapacity);
	}

	private string GetPackageName(string packageName)
	{
		return string.IsNullOrEmpty(packageName) ? _defaultPackageName : packageName;
	}

	private ResourcePackage GetPackageByName(string packageName)
	{
		string packageName2 = GetPackageName(packageName);
		ResourcePackage package = YooAssets.GetPackage(packageName2);
		if (package == null)
		{
			throw new Exception("Package not found: '" + packageName2 + "'");
		}
		return package;
	}

	public async UniTask<T> AcquireAsync<T>(string location, string packageName = "", CancellationToken ct = default(CancellationToken)) where T : UnityEngine.Object
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new ArgumentNullException("location");
		}
		ResourcePackage pkg = GetPackageByName(packageName);
		AssetKey key = new AssetKey(GetPackageName(packageName), location);
		await _gate.WaitAsync(ct);
		try
		{
			if (!_assets.TryGetValue(key, out AssetEntry ent))
			{
				ent = AssetEntry.Create();
				_assets.Add(key, ent);
				LoadAssetCore<T>(pkg, key, ent);
			}
			else if (ent.State == EntryState.None)
			{
				ent.State = EntryState.Loading;
				ent.StartEpoch = ent.Epoch;
				ent.BarrierTcs = new UniTaskCompletionSource();
				ent.Barrier = ent.BarrierTcs.Task;
				LoadAssetCore<T>(pkg, key, ent);
			}
			if (ent.State == EntryState.Ready)
			{
				AssetHandle sub = pkg.LoadAssetAsync<T>(key.Location, 0u);
				await UniTask.WaitUntil(() => ((HandleBase)sub).IsDone, PlayerLoopTiming.Update, ct);
				if (!((HandleBase)sub).IsValid)
				{
					throw new Exception($"Acquire subhandle failed: {key}");
				}
				ent.Subs.Push(sub);
				T obj = ent.Asset as T;
				_gate.Release();
				return obj;
			}
			UniTask barrier = ent.Barrier;
			_gate.Release();
			await barrier.AttachExternalCancellation(ct);
			await _gate.WaitAsync(ct);
			try
			{
				if (!_assets.TryGetValue(key, out ent) || ent.State != EntryState.Ready)
				{
					throw new OperationCanceledException($"Acquire canceled/obsoleted: {key}");
				}
				AssetHandle sub2 = pkg.LoadAssetAsync<T>(key.Location, 0u);
				await UniTask.WaitUntil(() => ((HandleBase)sub2).IsDone, PlayerLoopTiming.Update, ct);
				if (!((HandleBase)sub2).IsValid)
				{
					throw new Exception($"Acquire subhandle failed: {key}");
				}
				ent.Subs.Push(sub2);
				return ent.Asset as T;
			}
			finally
			{
				_gate.Release();
			}
		}
		catch
		{
			if (_gate.CurrentCount == 0)
			{
				_gate.Release();
			}
			throw;
		}
	}

	public async UniTask ReleaseAsync(string location, string packageName = "")
	{
		AssetKey key = new AssetKey(GetPackageName(packageName), location);
		await _gate.WaitAsync();
		try
		{
			if (!_assets.TryGetValue(key, out AssetEntry ent) || ent.State != EntryState.Ready || ent.Subs == null || ent.Subs.Count <= 0)
			{
				return;
			}
			AssetHandle sub = ent.Subs.Pop();
			try
			{
				if (sub != null && ((HandleBase)sub).IsValid)
				{
					((HandleBase)sub).Release();
				}
			}
			catch
			{
			}
		}
		finally
		{
			_gate.Release();
		}
	}

	public async UniTask UnloadAsync(string location, string packageName = "")
	{
		AssetKey key = new AssetKey(GetPackageName(packageName), location);
		await _gate.WaitAsync();
		try
		{
			if (_assets.TryGetValue(key, out AssetEntry ent) && ent.State == EntryState.Ready && ent.Subs != null && ent.Subs.Count > 0)
			{
				AssetHandle sub = ent.Subs.Pop();
				if (sub != null && ((HandleBase)sub).IsValid)
				{
					((HandleBase)sub).Release();
				}
			}
		}
		finally
		{
			_gate.Release();
		}
	}

	public async UniTask<GameObject> InstantiateAsync(string location, string packageName = "", Transform parent = null, CancellationToken ct = default(CancellationToken))
	{
		GameObject go = UnityEngine.Object.Instantiate(await AcquireAsync<GameObject>(location, packageName, ct), parent);
		_ReturnOnDestroy hook = go.AddComponent<_ReturnOnDestroy>();
		hook.Init(this, location, packageName);
		return go;
	}

	public async UniTask<UnityEngine.SceneManagement.Scene> AcquireSceneAsync(string location, string packageName = "", LoadSceneMode mode = LoadSceneMode.Additive, LocalPhysicsMode physics = LocalPhysicsMode.None, bool suspendLoad = false, uint priority = 0u, CancellationToken ct = default(CancellationToken))
	{
		if (string.IsNullOrEmpty(location))
		{
			throw new ArgumentNullException("location");
		}
		ResourcePackage pkg = GetPackageByName(packageName);
		SceneKey key = new SceneKey(GetPackageName(packageName), location);
		await _gate.WaitAsync(ct);
		try
		{
			if (!_scenes.TryGetValue(key, out SceneEntry ent))
			{
				ent = SceneEntry.Create(mode, physics, suspendLoad, priority);
				_scenes.Add(key, ent);
				LoadSceneCore(pkg, key, ent);
			}
			else if (ent.State == EntryState.None)
			{
				ent.State = EntryState.Loading;
				ent.StartEpoch = ent.Epoch;
				ent.Mode = mode;
				ent.Physics = physics;
				ent.SuspendLoad = suspendLoad;
				ent.Priority = priority;
				ent.BarrierTcs = new UniTaskCompletionSource();
				ent.Barrier = ent.BarrierTcs.Task;
				LoadSceneCore(pkg, key, ent);
			}
			if (ent.State == EntryState.Ready)
			{
				UnityEngine.SceneManagement.Scene s = ent.SceneObj;
				_gate.Release();
				return s;
			}
			UniTask barrier = ent.Barrier;
			_gate.Release();
			await barrier.AttachExternalCancellation(ct);
			await _gate.WaitAsync(ct);
			try
			{
				if (!_scenes.TryGetValue(key, out ent) || ent.State != EntryState.Ready)
				{
					throw new OperationCanceledException($"Scene acquire canceled/obsoleted: {key}");
				}
				return ent.SceneObj;
			}
			finally
			{
				_gate.Release();
			}
		}
		catch
		{
			if (_gate.CurrentCount == 0)
			{
				_gate.Release();
			}
			throw;
		}
	}

	public async UniTask UnloadSceneAsync(string location, string packageName = "")
	{
		SceneKey key = new SceneKey(GetPackageName(packageName), location);
		await _gate.WaitAsync();
		try
		{
			if (!_scenes.TryGetValue(key, out SceneEntry ent))
			{
				return;
			}
			ent.Epoch++;
			if (ent.Handle != null && ((HandleBase)ent.Handle).IsValid)
			{
				try
				{
					await (AsyncOperationBase)(object)ent.Handle.UnloadAsync();
				}
				catch
				{
				}
			}
			ent.Handle = null;
			ent.SceneObj = default(UnityEngine.SceneManagement.Scene);
			ent.MarkIdleNow();
		}
		finally
		{
			_gate.Release();
		}
	}

	private async UniTaskVoid LoadAssetCore<T>(ResourcePackage pkg, AssetKey key, AssetEntry ent) where T : UnityEngine.Object
	{
		AssetHandle h = null;
		Exception err;
		try
		{
			ent.StartEpoch = ent.Epoch;
			h = pkg.LoadAssetAsync<T>(key.Location, 0u);
			await UniTask.WaitUntil(() => ((HandleBase)h).IsDone);
			if (!((HandleBase)h).IsValid || h.AssetObject == null)
			{
				throw new Exception($"Load failed: {key}");
			}
			await _gate.WaitAsync();
			try
			{
				if (!_assets.TryGetValue(key, out AssetEntry cur) || cur != ent)
				{
					return;
				}
				if (ent.Epoch != ent.StartEpoch)
				{
					try
					{
						if (((HandleBase)h).IsValid)
						{
							((HandleBase)h).Release();
						}
					}
					catch
					{
					}
					ent.MarkIdleNow();
					ent.BarrierTcs.TrySetException(new OperationCanceledException($"Obsoleted by unload: {key}"));
				}
				else
				{
					ent.RootHandle = h;
					ent.Asset = (T)h.AssetObject;
					ent.State = EntryState.Ready;
					ent.BarrierTcs.TrySetResult();
				}
				return;
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (Exception ex)
		{
			Exception e = ex;
			err = e;
		}
		await _gate.WaitAsync();
		try
		{
			if (_assets.TryGetValue(key, out AssetEntry cur2) && cur2 == ent)
			{
				ent.Asset = null;
				ent.RootHandle = null;
				ent.MarkIdleNow();
				ent.BarrierTcs.TrySetException(err ?? new Exception($"Load failed: {key}"));
			}
		}
		finally
		{
			_gate.Release();
		}
		if (h != null && ((HandleBase)h).IsValid)
		{
			try
			{
				((HandleBase)h).Release();
			}
			catch
			{
			}
		}
	}

	private async UniTaskVoid LoadSceneCore(ResourcePackage pkg, SceneKey key, SceneEntry ent)
	{
		SceneHandle h = null;
		Exception err;
		try
		{
			ent.StartEpoch = ent.Epoch;
			h = pkg.LoadSceneAsync(key.Location, ent.Mode, ent.Physics, ent.SuspendLoad, ent.Priority);
			await UniTask.WaitUntil(() => ((HandleBase)h).IsDone);
			if (!((HandleBase)h).IsValid)
			{
				throw new Exception($"LoadScene failed: {key}");
			}
			await _gate.WaitAsync();
			try
			{
				if (!_scenes.TryGetValue(key, out SceneEntry cur) || cur != ent)
				{
					return;
				}
				if (ent.Epoch != ent.StartEpoch)
				{
					try
					{
						if (((HandleBase)h).IsValid)
						{
							await (AsyncOperationBase)(object)h.UnloadAsync();
						}
					}
					catch
					{
					}
					ent.MarkIdleNow();
					ent.BarrierTcs.TrySetException(new OperationCanceledException($"Scene obsoleted by unload: {key}"));
				}
				else
				{
					ent.Handle = h;
					ent.SceneObj = h.SceneObject;
					ent.State = EntryState.Ready;
					ent.BarrierTcs.TrySetResult();
				}
				return;
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (Exception ex)
		{
			Exception e = ex;
			err = e;
		}
		await _gate.WaitAsync();
		try
		{
			if (_scenes.TryGetValue(key, out SceneEntry cur2) && cur2 == ent)
			{
				ent.Handle = null;
				ent.SceneObj = default(UnityEngine.SceneManagement.Scene);
				ent.MarkIdleNow();
				ent.BarrierTcs.TrySetException(err ?? new Exception($"LoadScene failed: {key}"));
			}
		}
		finally
		{
			_gate.Release();
		}
		if (h != null && ((HandleBase)h).IsValid)
		{
			try
			{
				await (AsyncOperationBase)(object)h.UnloadAsync();
			}
			catch
			{
			}
		}
	}

	public async void SweepIdleAsync()
	{
		float now = Time.realtimeSinceStartup;
		await _gate.WaitAsync();
		try
		{
			if (_assetIdleTTL > 0f)
			{
				List<AssetKey> rm = CollectionPool<List<AssetKey>, AssetKey>.Get();
				foreach (KeyValuePair<AssetKey, AssetEntry> kv in _assets)
				{
					AssetEntry e = kv.Value;
					if (e.State == EntryState.None && now - e.LastIdleAt >= _assetIdleTTL)
					{
						rm.Add(kv.Key);
					}
				}
				foreach (AssetKey k in rm)
				{
					if (_assets.TryGetValue(k, out AssetEntry ent))
					{
						if (ent.RootHandle != null && ((HandleBase)ent.RootHandle).IsValid)
						{
							try
							{
								((HandleBase)ent.RootHandle).Release();
							}
							catch
							{
							}
						}
						ent.Dispose();
						_assets.Remove(k);
					}
					ent = null;
				}
				CollectionPool<List<AssetKey>, AssetKey>.Release(rm);
			}
			if (!(_sceneIdleTTL > 0f))
			{
				return;
			}
			List<SceneKey> rm2 = CollectionPool<List<SceneKey>, SceneKey>.Get();
			foreach (KeyValuePair<SceneKey, SceneEntry> kv2 in _scenes)
			{
				SceneEntry e2 = kv2.Value;
				if (e2.State == EntryState.None && now - e2.LastIdleAt >= _sceneIdleTTL)
				{
					rm2.Add(kv2.Key);
				}
			}
			foreach (SceneKey k2 in rm2)
			{
				if (_scenes.TryGetValue(k2, out SceneEntry ent2))
				{
					if (ent2.Handle != null && ((HandleBase)ent2.Handle).IsValid)
					{
						try
						{
							ent2.Handle.UnloadAsync();
						}
						catch
						{
						}
					}
					ent2.Dispose();
					_scenes.Remove(k2);
				}
				ent2 = null;
			}
			CollectionPool<List<SceneKey>, SceneKey>.Release(rm2);
		}
		finally
		{
			_gate.Release();
		}
	}

	public async UniTask ShutdownAsync()
	{
		foreach (KeyValuePair<AssetKey, AssetEntry> asset in _assets)
		{
			AssetEntry ent = asset.Value;
			if (ent.Subs != null)
			{
				while (ent.Subs.Count > 0)
				{
					AssetHandle sub = ent.Subs.Pop();
					try
					{
						if (sub != null && ((HandleBase)sub).IsValid)
						{
							((HandleBase)sub).Release();
						}
					}
					catch
					{
					}
				}
			}
			if (ent.RootHandle != null && ((HandleBase)ent.RootHandle).IsValid)
			{
				try
				{
					((HandleBase)ent.RootHandle).Release();
				}
				catch
				{
				}
			}
			ent.Clear();
			ent.Dispose();
		}
		_assets.Clear();
		foreach (KeyValuePair<SceneKey, SceneEntry> scene in _scenes)
		{
			SceneEntry ent2 = scene.Value;
			if (ent2.Handle != null && ((HandleBase)ent2.Handle).IsValid)
			{
				try
				{
					await (AsyncOperationBase)(object)ent2.Handle.UnloadAsync();
				}
				catch
				{
				}
			}
			ent2.Clear();
			ent2.Dispose();
		}
		_scenes.Clear();
	}

	public async void LoadAssetAsync(string location, LoadAssetCallbacks loadAssetCallbacks, object userData, string packageName = "", CancellationToken ct = default(CancellationToken))
	{
		GetPackageName(packageName);
		try
		{
			float duration = Time.time;
			UnityEngine.Object asset = await AcquireAsync<UnityEngine.Object>(location, packageName, ct);
			loadAssetCallbacks.LoadAssetSuccessCallback(location, packageName, asset, Time.time - duration, userData);
		}
		catch (OperationCanceledException)
		{
			loadAssetCallbacks.LoadAssetFailureCallback(location, LoadResourceStatus.NotReady, "Canceled", userData);
		}
		catch (Exception ex2)
		{
			Exception e = ex2;
			loadAssetCallbacks.LoadAssetFailureCallback(location, LoadResourceStatus.AssetError, e.Message, userData);
		}
	}
}
