using System;
using System.Collections.Generic;
using System.Runtime.ExceptionServices;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.SceneManagement;
using YooAsset;

namespace GameFramework.Resource;

public sealed class YooRefManager
{
	private readonly struct Key(string package, string location) : IEquatable<Key>
	{
		public readonly string Package = package;

		public readonly string Location = location;

		public bool Equals(Key other)
		{
			return Package == other.Package && Location == other.Location;
		}

		public override bool Equals(object obj)
		{
			return obj is Key other && Equals(other);
		}

		public override int GetHashCode()
		{
			return HashCode.Combine(Package, Location);
		}

		public override string ToString()
		{
			return Package + ":" + Location;
		}
	}

	private sealed class Entry
	{
		public readonly Key Key;

		public int RefCount;

		public EntryState State = EntryState.None;

		public AssetHandle Handle;

		public UnityEngine.Object Asset;

		public UniTaskCompletionSource<UnityEngine.Object> LoadTcs;

		public CancellationTokenSource UnloadCts;

		public Entry(Key key)
		{
			Key = key;
		}

		public async UniTask WaitLoaded(CancellationToken ct)
		{
			if (State != EntryState.Loaded)
			{
				if (State != EntryState.Loading || LoadTcs == null)
				{
					throw new InvalidOperationException($"Bad asset state {State} for {Key}");
				}
				await LoadTcs.Task.AttachExternalCancellation(ct);
			}
		}

		public void ResetTransient()
		{
			Handle = null;
			Asset = null;
			LoadTcs = null;
			UnloadCts = null;
		}
	}

	private enum EntryState
	{
		None,
		Loading,
		Loaded,
		Unloading
	}

	private sealed class SceneEntry
	{
		public readonly Key Key;

		public int RefCount;

		public SceneState State = SceneState.None;

		public SceneHandle Handle;

		public UniTaskCompletionSource<SceneHandle> LoadTcs;

		public CancellationTokenSource UnloadCts;

		public SceneEntry(Key key)
		{
			Key = key;
		}

		public async UniTask WaitLoaded(CancellationToken ct)
		{
			if (State != SceneState.Loaded)
			{
				if (State != SceneState.Loading || LoadTcs == null)
				{
					throw new InvalidOperationException($"Bad scene state {State} for {Key}");
				}
				await LoadTcs.Task.AttachExternalCancellation(ct);
			}
		}

		public void ResetTransient()
		{
			Handle = null;
			LoadTcs = null;
			UnloadCts = null;
		}
	}

	private enum SceneState
	{
		None,
		Loading,
		Loaded,
		Unloading
	}

	public readonly struct AssetRef<T> : IDisposable where T : UnityEngine.Object
	{
		private readonly YooRefManager _mgr;

		private readonly string _package;

		private readonly string _location;

		public T Asset { get; }

		internal AssetRef(YooRefManager mgr, string package, string location, T asset)
		{
			_mgr = mgr;
			_package = package;
			_location = location;
			Asset = asset;
		}

		public void Dispose()
		{
			_mgr.ReleaseAsync(_location, _package);
		}
	}

	public readonly struct SceneRef : IDisposable
	{
		private readonly YooRefManager _mgr;

		private readonly string _package;

		private readonly string _location;

		public readonly SceneHandle Handle;

		internal SceneRef(YooRefManager mgr, string package, string location, SceneHandle handle)
		{
			_mgr = mgr;
			_package = package;
			_location = location;
			Handle = handle;
		}

		public void Dispose()
		{
			_mgr.ReleaseSceneAsync(_location, _package);
		}
	}

	private readonly Dictionary<Key, Entry> _assetMap = new Dictionary<Key, Entry>();

	private readonly Dictionary<Key, SceneEntry> _sceneMap = new Dictionary<Key, SceneEntry>();

	private readonly SemaphoreSlim _gate = new SemaphoreSlim(1, 1);

	private volatile bool _isShuttingDown = false;

	public string PackageName { get; }

	public YooRefManager(string defaultPackageName)
	{
		if (string.IsNullOrEmpty(defaultPackageName))
		{
			throw new ArgumentNullException("defaultPackageName");
		}
		PackageName = defaultPackageName;
	}

	public async UniTask<AssetRef<T>> AcquireAsync<T>(string location, string packageName = "", CancellationToken ct = default(CancellationToken)) where T : UnityEngine.Object
	{
		if (_isShuttingDown)
		{
			throw new InvalidOperationException("YooRefManager is shutting down");
		}
		if (string.IsNullOrEmpty(location))
		{
			throw new ArgumentNullException("location");
		}
		Key key = new Key(GetPackageName(packageName), location);
		await _gate.WaitAsync(ct);
		Entry ent;
		try
		{
			if (!_assetMap.TryGetValue(key, out ent))
			{
				ent = new Entry(key);
				_assetMap[key] = ent;
			}
			ent.RefCount++;
			switch (ent.State)
			{
			case EntryState.None:
				ent.State = EntryState.Loading;
				ent.LoadTcs = new UniTaskCompletionSource<UnityEngine.Object>();
				LoadAssetCore<T>(ent);
				break;
			case EntryState.Unloading:
				ent.UnloadCts?.Cancel();
				break;
			}
		}
		finally
		{
			_gate.Release();
		}
		await ent.WaitLoaded(ct);
		return new AssetRef<T>(this, key.Package, key.Location, (T)ent.Asset);
	}

	public async UniTask ReleaseAsync(string location, string packageName = "")
	{
		if (string.IsNullOrEmpty(location))
		{
			return;
		}
		Key key = new Key(GetPackageName(packageName), location);
		bool needUnload = false;
		await _gate.WaitAsync();
		Entry ent;
		try
		{
			if (!_assetMap.TryGetValue(key, out ent))
			{
				return;
			}
			ent.RefCount = Math.Max(0, ent.RefCount - 1);
			if (ent.RefCount == 0 && ent.State == EntryState.Loaded)
			{
				ent.State = EntryState.Unloading;
				ent.UnloadCts = new CancellationTokenSource();
				needUnload = true;
			}
		}
		finally
		{
			_gate.Release();
		}
		if (needUnload)
		{
			await DoAssetUnloadCore(ent);
		}
	}

	public async UniTask CleanupUnusedAsync(string packageName = "")
	{
		ResourcePackage pkg = GetPackage(GetPackageName(packageName));
		if (pkg != null)
		{
			await (AsyncOperationBase)(object)pkg.UnloadUnusedAssetsAsync(10);
		}
		await Resources.UnloadUnusedAssets();
		GC.Collect();
	}

	public async UniTask CleanupAllKnownPackagesAsync()
	{
		HashSet<string> pkgs = new HashSet<string>();
		await _gate.WaitAsync();
		try
		{
			foreach (Key key in _assetMap.Keys)
			{
				pkgs.Add(key.Package);
			}
			foreach (Key key2 in _sceneMap.Keys)
			{
				pkgs.Add(key2.Package);
			}
		}
		finally
		{
			_gate.Release();
		}
		foreach (string p in pkgs)
		{
			await CleanupUnusedAsync(p);
		}
	}

	public async UniTask<(SceneRef sref, UnityEngine.SceneManagement.Scene scene)> AcquireSceneAsync(string location, string packageName = "", LoadSceneMode sceneMode = LoadSceneMode.Additive, LocalPhysicsMode physicsMode = LocalPhysicsMode.None, bool suspendLoad = false, uint priority = 0u, CancellationToken ct = default(CancellationToken))
	{
		if (_isShuttingDown)
		{
			throw new InvalidOperationException("YooRefManager is shutting down");
		}
		if (string.IsNullOrEmpty(location))
		{
			throw new ArgumentNullException("location");
		}
		Key key = new Key(GetPackageName(packageName), location);
		await _gate.WaitAsync(ct);
		SceneEntry ent;
		try
		{
			if (!_sceneMap.TryGetValue(key, out ent))
			{
				ent = new SceneEntry(key);
				_sceneMap[key] = ent;
			}
			ent.RefCount++;
			switch (ent.State)
			{
			case SceneState.None:
				ent.State = SceneState.Loading;
				ent.LoadTcs = new UniTaskCompletionSource<SceneHandle>();
				LoadSceneCore(ent, sceneMode, physicsMode, suspendLoad, priority);
				break;
			case SceneState.Unloading:
				ent.UnloadCts?.Cancel();
				break;
			}
		}
		finally
		{
			_gate.Release();
		}
		await ent.WaitLoaded(ct);
		UnityEngine.SceneManagement.Scene scene = ent.Handle.SceneObject;
		SceneRef sref = new SceneRef(this, key.Package, key.Location, ent.Handle);
		return (sref, scene);
	}

	public async UniTask ReleaseSceneAsync(string location, string packageName = "")
	{
		Key key = new Key(GetPackageName(packageName), location);
		bool needUnload = false;
		await _gate.WaitAsync();
		SceneEntry ent;
		try
		{
			if (!_sceneMap.TryGetValue(key, out ent))
			{
				return;
			}
			ent.RefCount = Math.Max(0, ent.RefCount - 1);
			if (ent.RefCount == 0 && ent.State == SceneState.Loaded)
			{
				ent.State = SceneState.Unloading;
				ent.UnloadCts = new CancellationTokenSource();
				needUnload = true;
			}
		}
		finally
		{
			_gate.Release();
		}
		if (needUnload)
		{
			await DoSceneUnloadCore(ent);
		}
	}

	public bool SetActiveScene(SceneRef sref)
	{
		UnityEngine.SceneManagement.Scene sceneObject = sref.Handle.SceneObject;
		return sceneObject.IsValid() && SceneManager.SetActiveScene(sceneObject);
	}

	public async UniTask ShutdownAsync(bool doPackageCleanup = true)
	{
		if (_isShuttingDown)
		{
			return;
		}
		_isShuttingDown = true;
		HashSet<string> packages = new HashSet<string>();
		await _gate.WaitAsync();
		List<Entry> assetEntries;
		List<SceneEntry> sceneEntries;
		try
		{
			assetEntries = new List<Entry>(_assetMap.Values);
			sceneEntries = new List<SceneEntry>(_sceneMap.Values);
			foreach (Key key in _assetMap.Keys)
			{
				packages.Add(key.Package);
			}
			foreach (Key key2 in _sceneMap.Keys)
			{
				packages.Add(key2.Package);
			}
		}
		finally
		{
			_gate.Release();
		}
		foreach (SceneEntry s in sceneEntries)
		{
			try
			{
				if (((HandleBase)s.Handle).IsValid)
				{
					await (AsyncOperationBase)(object)s.Handle.UnloadAsync();
				}
			}
			catch (Exception arg)
			{
				Debug.LogError($"Shutdown scene unload error [{s.Key}]: {arg}");
			}
		}
		foreach (Entry a in assetEntries)
		{
			try
			{
				if (((HandleBase)a.Handle).IsValid)
				{
					((HandleBase)a.Handle).Release();
				}
			}
			catch (Exception arg2)
			{
				Debug.LogError($"Shutdown asset release error [{a.Key}]: {arg2}");
			}
		}
		await _gate.WaitAsync();
		try
		{
			foreach (SceneEntry s2 in sceneEntries)
			{
				s2.ResetTransient();
			}
			foreach (Entry a2 in assetEntries)
			{
				a2.ResetTransient();
			}
			_sceneMap.Clear();
			_assetMap.Clear();
		}
		finally
		{
			_gate.Release();
		}
		if (!doPackageCleanup)
		{
			return;
		}
		foreach (string p in packages)
		{
			ResourcePackage pkg = GetPackage(p);
			if (pkg != null)
			{
				try
				{
					await (AsyncOperationBase)(object)pkg.UnloadUnusedAssetsAsync(10);
				}
				catch (Exception ex)
				{
					Exception ex2 = ex;
					Debug.LogError($"Shutdown cleanup error on package [{p}]: {ex2}");
				}
			}
		}
		try
		{
			await Resources.UnloadUnusedAssets();
		}
		catch
		{
		}
		GC.Collect();
		GC.WaitForPendingFinalizers();
	}

	private async UniTask LoadAssetCore<T>(Entry ent) where T : UnityEngine.Object
	{
		try
		{
			ResourcePackage pkg = GetPackage(ent.Key.Package);
			if (pkg == null)
			{
				throw new Exception("Package not found: " + ent.Key.Package);
			}
			AssetHandle handle = pkg.LoadAssetAsync<T>(ent.Key.Location, 0u);
			await ((HandleBase)handle).Task;
			if (!((HandleBase)handle).IsValid || handle.AssetObject == null)
			{
				throw new Exception("Load failed: " + ent.Key.Package + "/" + ent.Key.Location);
			}
			await _gate.WaitAsync();
			try
			{
				if (_isShuttingDown)
				{
					try
					{
						if (((HandleBase)handle).IsValid)
						{
							((HandleBase)handle).Release();
						}
					}
					catch
					{
					}
					ent.Handle = null;
					ent.Asset = null;
					ent.State = EntryState.None;
					ent.LoadTcs?.TrySetCanceled();
					return;
				}
				ent.Handle = handle;
				ent.Asset = handle.AssetObject;
				ent.State = EntryState.Loaded;
				ent.LoadTcs?.TrySetResult(ent.Asset);
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (OperationCanceledException exception)
		{
			await _gate.WaitAsync();
			try
			{
				ent.State = EntryState.None;
				ent.LoadTcs?.TrySetException(exception);
				ent.ResetTransient();
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (Exception exception2)
		{
			await _gate.WaitAsync();
			try
			{
				ent.State = EntryState.None;
				ent.LoadTcs?.TrySetException(exception2);
				ent.ResetTransient();
			}
			finally
			{
				_gate.Release();
			}
		}
	}

	private async UniTask DoAssetUnloadCore(Entry ent)
	{
		if (_isShuttingDown)
		{
			try
			{
				if (((HandleBase)ent.Handle).IsValid)
				{
					((HandleBase)ent.Handle).Release();
				}
			}
			catch (Exception ex)
			{
				Exception ex2 = ex;
				Debug.LogError($"[Shutdown] Asset release error [{ent.Key}]: {ex2}");
			}
			await _gate.WaitAsync();
			try
			{
				ent.Handle = null;
				ent.Asset = null;
				ent.UnloadCts = null;
				ent.State = EntryState.None;
				_assetMap.Remove(ent.Key);
				return;
			}
			finally
			{
				_gate.Release();
			}
		}
		CancellationTokenSource cts = ent.UnloadCts;
		try
		{
			await UniTask.Yield();
			cts.Token.ThrowIfCancellationRequested();
			if (((HandleBase)ent.Handle).IsValid)
			{
				((HandleBase)ent.Handle).Release();
			}
			await _gate.WaitAsync();
			try
			{
				ent.Handle = null;
				ent.Asset = null;
				ent.UnloadCts = null;
				if (ent.RefCount == 0)
				{
					ent.State = EntryState.None;
					_assetMap.Remove(ent.Key);
				}
				else
				{
					ent.State = EntryState.None;
				}
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (OperationCanceledException)
		{
			await _gate.WaitAsync();
			try
			{
				ent.UnloadCts = null;
				ent.State = ((ent.Handle != null && ((HandleBase)ent.Handle).IsValid && ent.Asset != null) ? EntryState.Loaded : EntryState.None);
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (Exception arg)
		{
			Debug.LogError($"Unload error [{ent.Key.Package}/{ent.Key.Location}]: {arg}");
			await _gate.WaitAsync();
			try
			{
				if (ent.Handle != null && ((HandleBase)ent.Handle).IsValid)
				{
					try
					{
						((HandleBase)ent.Handle).Release();
					}
					catch
					{
					}
				}
				ent.Handle = null;
				ent.Asset = null;
				ent.UnloadCts = null;
				ent.State = EntryState.None;
				if (ent.RefCount == 0)
				{
					_assetMap.Remove(ent.Key);
				}
			}
			finally
			{
				_gate.Release();
			}
		}
	}

	private async UniTask<UnityEngine.SceneManagement.Scene> LoadSceneCore(SceneEntry ent, LoadSceneMode sceneMode, LocalPhysicsMode physicsMode, bool suspendLoad, uint priority)
	{
		UnityEngine.SceneManagement.Scene result = default(UnityEngine.SceneManagement.Scene);
		try
		{
			ResourcePackage pkg = GetPackage(ent.Key.Package);
			if (pkg == null)
			{
				throw new Exception("Package not found: " + ent.Key.Package);
			}
			SceneHandle handle = pkg.LoadSceneAsync(ent.Key.Location, sceneMode, physicsMode, suspendLoad, priority);
			await ((HandleBase)handle).Task;
			if (!((HandleBase)handle).IsValid)
			{
				throw new Exception("LoadScene failed: " + ent.Key.Package + "/" + ent.Key.Location);
			}
			UnityEngine.SceneManagement.Scene scene = handle.SceneObject;
			await _gate.WaitAsync();
			try
			{
				ent.Handle = handle;
				ent.State = SceneState.Loaded;
				ent.LoadTcs?.TrySetResult(handle);
			}
			finally
			{
				_gate.Release();
			}
			result = scene;
			return result;
		}
		catch (OperationCanceledException ex)
		{
			OperationCanceledException oce = ex;
			await _gate.WaitAsync();
			try
			{
				ent.State = SceneState.None;
				ent.LoadTcs?.TrySetException(oce);
				ent.ResetTransient();
			}
			finally
			{
				_gate.Release();
			}
			if (!(ex is Exception source))
			{
				throw ex;
			}
			ExceptionDispatchInfo.Capture(source).Throw();
		}
		catch (Exception ex2)
		{
			await _gate.WaitAsync();
			try
			{
				ent.State = SceneState.None;
				ent.LoadTcs?.TrySetException(ex2);
				ent.ResetTransient();
			}
			finally
			{
				_gate.Release();
			}
			throw new Exception("Failed to load scene " + ent.Key.Package + "/" + ent.Key.Location, ex2);
		}
		return result;
	}

	private async UniTask DoSceneUnloadCore(SceneEntry ent)
	{
		CancellationTokenSource cts = ent.UnloadCts;
		try
		{
			await UniTask.Yield();
			cts.Token.ThrowIfCancellationRequested();
			if (((HandleBase)ent.Handle).IsValid)
			{
				await (AsyncOperationBase)(object)ent.Handle.UnloadAsync();
			}
			await _gate.WaitAsync();
			try
			{
				ent.ResetTransient();
				if (ent.RefCount == 0)
				{
					ent.State = SceneState.None;
					_sceneMap.Remove(ent.Key);
				}
				else
				{
					ent.State = SceneState.None;
				}
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (OperationCanceledException)
		{
			await _gate.WaitAsync();
			try
			{
				ent.UnloadCts = null;
				ent.State = (((HandleBase)ent.Handle).IsValid ? SceneState.Loaded : SceneState.None);
			}
			finally
			{
				_gate.Release();
			}
		}
		catch (Exception arg)
		{
			Debug.LogError($"Scene unload error [{ent.Key.Package}/{ent.Key.Location}]: {arg}");
			await _gate.WaitAsync();
			try
			{
				ent.UnloadCts = null;
				ent.State = SceneState.None;
				if (ent.RefCount == 0)
				{
					_sceneMap.Remove(ent.Key);
				}
			}
			finally
			{
				_gate.Release();
			}
		}
	}

	private string GetPackageName(string customPackageName)
	{
		return string.IsNullOrEmpty(customPackageName) ? PackageName : customPackageName;
	}

	private static ResourcePackage GetPackage(string name)
	{
		try
		{
			return YooAssets.GetPackage(name);
		}
		catch
		{
			return null;
		}
	}
}
