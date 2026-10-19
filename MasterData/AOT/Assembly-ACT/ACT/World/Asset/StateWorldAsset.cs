using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.World.Asset;

[Serializable]
public class StateWorldAsset
{
	private static class Creator<T> where T : StateWorldAsset, new()
	{
		private static readonly UnityEngine.Pool.ObjectPool<T> m_ObjectPool = new UnityEngine.Pool.ObjectPool<T>(() => new T());

		public static (T, UniTask) CreateAsset(StateWorldAssetData data, CancellationToken syncInit)
		{
			T val = m_ObjectPool.Get();
			CancellationTokenSource cancellationTokenSource = (val.source = new CancellationTokenSource());
			Loaded[data.stateWorldAssetUid] = val;
			return (val, CreateAssetTask(data, val, cancellationTokenSource.Token, syncInit));
		}

		private static async UniTask CreateAssetTask(StateWorldAssetData data, T res, CancellationToken token, CancellationToken syncToken)
		{
			res.isDone = false;
			res.LoadDone = false;
			res.data = data;
			res.stateEntityRef = GameManager.entities.factory.CreateStateEntity();
			int precacheOwnerKey = GetPrecacheOwnerKey(data);
			bool precacheBound = false;
			bool effectPrecacheBound = false;
			int serviceSaveUid = data.stateWorldAssetUid;
			try
			{
				await MonoECS.instance.CoServerSpawnStateWorldAsset(res.stateEntityRef, serviceSaveUid);
			}
			catch (Exception arg)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"[{data.stateWorldAssetUid}]交互物加载失败 {arg}");
				}
				MonoECS.instance.TryRemoveBehave(res.stateEntityRef);
				res.LoadDone = true;
				return;
			}
			res.LoadDone = true;
			if (token.IsCancellationRequested)
			{
				MonoECS.instance.TryRemoveBehave(res.stateEntityRef);
				return;
			}
			int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			CompStateObject compStateObject = res.stateEntityRef.GetCompStateObject();
			compStateObject.StateId = data.stateId;
			if (CoreUtils.TryGetServiceBehaveId(activeWorldId, serviceSaveUid, out var behaveId))
			{
				compStateObject.BehaveId = behaveId;
			}
			StateObjectBase stateObjectBase = (res.stateObjectBase = compStateObject.StateObjectBase);
			data.OnStateObjectCreate(stateObjectBase);
			if (token.IsCancellationRequested)
			{
				MonoECS.instance.TryRemoveBehave(res.stateEntityRef);
				return;
			}
			if (data.IsWaitInit && !syncToken.IsCancellationRequested)
			{
				await UniTask.WaitUntilCanceled(syncToken);
			}
			if (token.IsCancellationRequested)
			{
				MonoECS.instance.TryRemoveBehave(res.stateEntityRef);
				return;
			}
			bool eventListenerBound = false;
			bool shouldPrewarmEffects = EffectPrewarmManager.Enabled && (data is MonsterPointData || data is WorldMonsterPointData || data is FleeMonsterPointData || data is BattleRoomData);
			res._stateObjectInitialized = false;
			res._hasPendingStateRefresh = false;
			try
			{
				Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, res.OnStateRefresh);
				eventListenerBound = true;
				try
				{
					stateObjectBase.InitStateObject(data.stateId);
				}
				catch (Exception arg2)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"[{data.stateWorldAssetUid}]状态[{data.stateId}] 初始化失败! {arg2}");
					}
					MonoECS.instance.TryRemoveBehave(res.stateEntityRef);
					return;
				}
				res._stateObjectInitialized = true;
				res.ApplyPendingStateRefresh();
				PrecacheCollector precacheCollector = new PrecacheCollector();
				try
				{
					await data.CollectPrecacheAsync(precacheCollector, token);
					await PrecacheCoordinator.Instance.ExecuteAsync(precacheOwnerKey, precacheCollector.Build(), token);
					precacheBound = true;
				}
				catch (Exception ex) when (!(ex is OperationCanceledException) || !token.IsCancellationRequested)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"[{data.stateWorldAssetUid}]预加载失败! {ex}");
					}
				}
				if (shouldPrewarmEffects)
				{
					try
					{
						IReadOnlyList<EffectPrewarmRequest> readOnlyList = precacheCollector.EffectPrewarm.Build();
						List<EffectPrewarmRequest> list = new List<EffectPrewarmRequest>(readOnlyList.Count);
						for (int i = 0; i < readOnlyList.Count; i++)
						{
							EffectPrewarmRequest effectPrewarmRequest = readOnlyList[i];
							list.Add(new EffectPrewarmRequest(effectPrewarmRequest.AssetKey, effectPrewarmRequest.InstanceCount, effectPrewarmRequest.Priority, waitUntilReady: true, effectPrewarmRequest.SourceTag));
						}
						effectPrecacheBound = await EffectPrewarmManager.Instance.AcquireAsync(precacheOwnerKey, list, token);
					}
					catch (Exception ex2) when (!(ex2 is OperationCanceledException) || !token.IsCancellationRequested)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogError($"[{data.stateWorldAssetUid}]特效预热准备失败! {ex2}");
						}
					}
				}
				token.ThrowIfCancellationRequested();
				res.OnGet();
				res.isDone = true;
				AssetInitedEvt evt = Singleton<EventManager>.instance.GetEvt<AssetInitedEvt>();
				evt.swuid = data.stateWorldAssetUid;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.asset_Inited, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				await UniTask.WaitUntilCanceled(token);
				res.isDone = false;
				Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, res.OnStateRefresh);
				eventListenerBound = false;
				ReleasePrecacheOwners();
				res.OnRelease();
				res.stateObjectBase.ReleaseStateObject();
				MonoECS.instance.TryRemoveBehave(res.stateEntityRef);
				m_ObjectPool.Release(res);
			}
			catch (OperationCanceledException) when (token.IsCancellationRequested)
			{
				MonoECS.instance.TryRemoveBehave(res.stateEntityRef);
			}
			finally
			{
				try
				{
					if (eventListenerBound)
					{
						Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, res.OnStateRefresh);
					}
				}
				finally
				{
					ReleasePrecacheOwners();
				}
			}
			void ReleasePrecacheOwners()
			{
				if (effectPrecacheBound)
				{
					EffectPrewarmManager.Instance.Release(precacheOwnerKey);
					effectPrecacheBound = false;
				}
				if (precacheBound)
				{
					PrecacheCoordinator.Instance.Release(precacheOwnerKey);
					precacheBound = false;
				}
			}
		}

		public static void Release(T res)
		{
			Loaded.Remove(res.data.stateWorldAssetUid);
			res.source?.Cancel();
			res.source?.Dispose();
			res.source = null;
		}
	}

	private bool isDone;

	private CancellationTokenSource source;

	private bool _stateObjectInitialized;

	private bool _hasPendingStateRefresh;

	private int _pendingStateId;

	private int _pendingBehaveId;

	private int _pendingCleanedTs;

	private static Dictionary<int, StateWorldAsset> Loaded = new Dictionary<int, StateWorldAsset>();

	public StateWorldAssetData data;

	public bool LoadDone { get; private set; }

	public StateObjectBase stateObjectBase { get; private set; }

	public Entity stateEntityRef { get; private set; }

	private static int GetPrecacheOwnerKey(StateWorldAssetData data)
	{
		return data.stateWorldAssetUid;
	}

	public static bool TryGetWorldAssetBySwid(int swid, out StateWorldAsset stateWorldAsset)
	{
		if (Loaded.TryGetValue(swid, out stateWorldAsset))
		{
			return stateWorldAsset.isDone;
		}
		return false;
	}

	[Obsolete]
	public static UniTask<T> CreateAsset<T>(StateWorldAssetData data) where T : StateWorldAsset, new()
	{
		throw new NotSupportedException();
	}

	public static (T, UniTask) Load<T>(StateWorldAssetData data, CancellationToken syncInit) where T : StateWorldAsset, new()
	{
		if (data.serviceSave && MonoECS.instance.ruleManager.SharedGetState(data.stateWorldAssetUid) == -99)
		{
			return (null, UniTask.CompletedTask);
		}
		_ = LuminApplication.LogEnabled;
		(T, UniTask) handle = Creator<T>.CreateAsset(data, syncInit);
		UniTask<int> uniTask = UniTask.WhenAny(UniTask.WaitUntil(() => handle.Item1.isDone, PlayerLoopTiming.Update, syncInit), handle.Item2);
		return (handle.Item1, uniTask);
	}

	public static void Release<T>(StateWorldAssetData data) where T : StateWorldAsset, new()
	{
		if (Loaded.TryGetValue(data.stateWorldAssetUid, out var value))
		{
			_ = LuminApplication.LogEnabled;
			Creator<T>.Release(value as T);
		}
	}

	[Obsolete("使用Release<T>替换")]
	public void ReleaseAsset<T>(MonoECS m_ECS) where T : StateWorldAsset, new()
	{
		Creator<T>.Release(this as T);
	}

	[Obsolete("使用Release<T>替换")]
	public virtual void Release(MonoECS m_ECS)
	{
		ReleaseAsset<StateWorldAsset>(m_ECS);
	}

	private void OnStateRefresh(BaseEventContent content)
	{
		if (!(content is ServiceStateRefresh serviceStateRefresh))
		{
			return;
		}
		if (!_stateObjectInitialized)
		{
			if (data != null && serviceStateRefresh.swid == data.stateWorldAssetUid)
			{
				_hasPendingStateRefresh = true;
				_pendingStateId = serviceStateRefresh.stateId;
				_pendingBehaveId = serviceStateRefresh.behaveId;
				_pendingCleanedTs = serviceStateRefresh.cleanedTs;
			}
		}
		else
		{
			ApplyStateRefresh(serviceStateRefresh.swid, serviceStateRefresh.stateId, serviceStateRefresh.behaveId, serviceStateRefresh.cleanedTs);
		}
	}

	private void ApplyPendingStateRefresh()
	{
		if (_hasPendingStateRefresh)
		{
			ApplyStateRefresh(data.stateWorldAssetUid, _pendingStateId, _pendingBehaveId, _pendingCleanedTs);
			_hasPendingStateRefresh = false;
		}
	}

	private void ApplyStateRefresh(int swid, int stateId, int behaveId, int cleanedTs)
	{
		if (stateEntityRef.IsValid && stateEntityRef.TryGetCompStateObject(out CompStateObject component) && swid == component.StateWorldAssetData.stateWorldAssetUid)
		{
			component.BehaveId = behaveId;
			component.EntityChangeState(stateId);
			stateObjectBase.cleanedTs = cleanedTs;
			stateObjectBase.isStateChanged = true;
		}
	}

	protected virtual void OnGet()
	{
	}

	[Obsolete]
	protected virtual void OnSpawn(StateObjectBase interactObjectBase)
	{
	}

	protected virtual void OnRelease()
	{
	}

	[Obsolete]
	protected virtual void OnStateChange(int form, int stateId)
	{
	}
}
