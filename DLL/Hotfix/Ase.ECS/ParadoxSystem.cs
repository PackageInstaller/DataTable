using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.Paradox;
using Cysharp.Threading.Tasks;
using GameFramework;
using NodeCanvas.BehaviourTrees;
using NodeCanvas.Framework;
using NodeCanvas.StateMachines;
using ParadoxNotion.Services;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class ParadoxSystem : BaseSystem, IObserverHandler
{
	private MonoManager _paradoxManager;

	private List<int> cacheRemoveParadox = new List<int>();

	private List<int> _executeTreeKey = new List<int>();

	private Dictionary<int, BaseParadox> executeTrees = new Dictionary<int, BaseParadox>();

	private List<ParadoxTimer> _paradoxTimers = new List<ParadoxTimer>();

	private Dictionary<int, IObjectPool<GameObject>> paradoxPools = new Dictionary<int, IObjectPool<GameObject>>();

	private int serialId;

	private Dictionary<BattleObserverEventEnum, List<EventTree>> _eventTreeDic = new Dictionary<BattleObserverEventEnum, List<EventTree>>();

	private Dictionary<BattleObserverEventEnum, BattleEventParamProcessor> _battleEventParamProcessor = new Dictionary<BattleObserverEventEnum, BattleEventParamProcessor>();

	private int actionIndex;

	private Dictionary<int, BaseEventTreeAction> _eventActionDic;

	protected override bool IsLogicSystem => true;

	public override bool NeedPauseSystem => false;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (data is WorldData worldData)
		{
			if (worldData.PreloadBattleData == null)
			{
				return true;
			}
			if (world.IsStoryWorld)
			{
				foreach (KeyValuePair<int, GameObject> cacheParadoxDatum in worldData.PreloadBattleData.CacheParadoxData)
				{
					if (!paradoxPools.ContainsKey(cacheParadoxDatum.Key))
					{
						DRParadox dataRow = GameEntry.DataTable.GetDataRow<DRParadox>(cacheParadoxDatum.Key);
						if (dataRow != null)
						{
							paradoxPools.Add(cacheParadoxDatum.Key, new ObjectPool<GameObject>(new ParadoxTreeFactory(AssetUtility.GetParadoxAsset(dataRow.AssetPath), cacheParadoxDatum.Value, world.ParadoxRoot, 7), 12));
						}
					}
				}
			}
			else
			{
				foreach (KeyValuePair<int, GameObject> cacheParadoxDatum2 in worldData.PreloadBattleData.CacheParadoxData)
				{
					if (!paradoxPools.ContainsKey(cacheParadoxDatum2.Key))
					{
						DRParadox dataRow2 = GameEntry.DataTable.GetDataRow<DRParadox>(cacheParadoxDatum2.Key);
						if (dataRow2 != null)
						{
							paradoxPools.Add(cacheParadoxDatum2.Key, new ObjectPool<GameObject>(new ParadoxTreeFactory(AssetUtility.GetParadoxAsset(dataRow2.AssetPath), cacheParadoxDatum2.Value, world.ParadoxRoot, 3), 6));
						}
					}
				}
			}
		}
		return true;
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_paradoxManager = MonoManager.current;
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.Any, this);
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		ReleaseDeadParadox();
		for (int i = 0; i < _executeTreeKey.Count; i++)
		{
			BaseParadox baseParadox = executeTrees[_executeTreeKey[i]];
			if (baseParadox.ownerEntity.CacheTickUpdate)
			{
				baseParadox.UpdateGraph(baseParadox.ownerEntity.FinalDeltaTime, baseParadox.ownerEntity.FrozenSpeed);
			}
		}
		for (int j = 0; j < _paradoxTimers.Count; j++)
		{
			_paradoxTimers[j].Update(deltaTime);
		}
	}

	public ParadoxTimer ApplyTimer(float time)
	{
		ParadoxTimer paradoxTimer = ReferencePool.Acquire<ParadoxTimer>();
		paradoxTimer.Init(time);
		_paradoxTimers.Add(paradoxTimer);
		return paradoxTimer;
	}

	private void ReleaseDeadParadox()
	{
		lock (cacheRemoveParadox)
		{
			if (cacheRemoveParadox.Count <= 0)
			{
				return;
			}
			foreach (int item in cacheRemoveParadox)
			{
				if (executeTrees.ContainsKey(item))
				{
					executeTrees[item].Stop(isForceStop: true);
					executeTrees.Remove(item);
					_executeTreeKey.Remove(item);
				}
			}
			cacheRemoveParadox.Clear();
		}
	}

	public int ExecuteTreeOrFsm(BaseEntity entity, int skillId, bool onStopIsReleaseAssets = false, Action<bool> endAction = null)
	{
		GameObject paradoxTreeObj = GetParadoxTreeObj(skillId);
		if (paradoxTreeObj == null)
		{
			return -1;
		}
		BehaviourTreeOwner component = paradoxTreeObj.GetComponent<BehaviourTreeOwner>();
		if (component != null)
		{
			return ExecuteTree(entity, skillId, component, paradoxTreeObj, onStopIsReleaseAssets, endAction);
		}
		FSMOwner component2 = paradoxTreeObj.GetComponent<FSMOwner>();
		if (component2 != null)
		{
			return ExecuteFsm(entity, skillId, component2, paradoxTreeObj, onStopIsReleaseAssets, endAction);
		}
		return -1;
	}

	private int ExecuteTree(BaseEntity entity, int skillId, BehaviourTreeOwner treeOwner, GameObject treeObj, bool onStopIsReleaseAssets = false, Action<bool> endAction = null)
	{
		treeOwner.updateMode = Graph.UpdateMode.NormalUpdate;
		if (entity != null)
		{
			treeOwner.blackboard.SetVariableValue("entity", entity.Id);
			treeOwner.blackboard.SetVariableValue("BaseEntity", entity);
		}
		ParadoxTree paradoxTree = ReferencePool.Acquire<ParadoxTree>();
		paradoxTree.id = ++serialId;
		paradoxTree.treeObj = treeObj;
		paradoxTree.ownerEntity = entity;
		paradoxTree.OnStopIsReleaseAssets = onStopIsReleaseAssets;
		paradoxTree.tree = treeOwner;
		paradoxTree.endAction = endAction;
		paradoxTree.treePlayEnd = TreePlayEnd;
		paradoxTree.Execute();
		executeTrees.Add(paradoxTree.id, paradoxTree);
		_executeTreeKey.Add(paradoxTree.id);
		return paradoxTree.id;
	}

	private int ExecuteFsm(BaseEntity entity, int skillId, FSMOwner fsmOwner, GameObject treeObj, bool onStopIsReleaseAssets = false, Action<bool> endAction = null)
	{
		fsmOwner.updateMode = Graph.UpdateMode.NormalUpdate;
		if (entity != null)
		{
			fsmOwner.blackboard.SetVariableValue("entity", entity.Id);
			fsmOwner.blackboard.SetVariableValue("BaseEntity", entity);
			if (entity is HeroEntity heroEntity)
			{
				fsmOwner.blackboard.SetVariableValue("IsAi", heroEntity.IsAi);
			}
		}
		ParadoxFsm paradoxFsm = ReferencePool.Acquire<ParadoxFsm>();
		paradoxFsm.id = ++serialId;
		paradoxFsm.treeObj = treeObj;
		paradoxFsm.ownerEntity = entity;
		paradoxFsm.fsm = fsmOwner;
		paradoxFsm.endAction = endAction;
		paradoxFsm.OnStopIsReleaseAssets = onStopIsReleaseAssets;
		paradoxFsm.treePlayEnd = TreePlayEnd;
		paradoxFsm.Execute();
		executeTrees.Add(paradoxFsm.id, paradoxFsm);
		_executeTreeKey.Add(paradoxFsm.id);
		return paradoxFsm.id;
	}

	private void TreePlayEnd(BaseParadox paradoxData)
	{
		paradoxData.RefreshBlack();
		executeTrees.Remove(paradoxData.id);
		_executeTreeKey.Remove(paradoxData.id);
		paradoxData.FreeBack();
	}

	private GameObject GetParadoxTreeObj(int skillId)
	{
		if (paradoxPools == null)
		{
			return null;
		}
		if (world == null)
		{
			return null;
		}
		paradoxPools.TryGetValue(skillId, out var value);
		if (value == null)
		{
			DRParadox dRParadox = GameEntry.DataTable?.GetDataRow<DRParadox>(skillId);
			if (dRParadox == null)
			{
				return null;
			}
			string paradoxAsset = AssetUtility.GetParadoxAsset(dRParadox.AssetPath);
			if (GetSystem<GameResourceSystem>() == null)
			{
				return null;
			}
			GameObject gameObject = GetSystem<GameResourceSystem>().LoadAsset<GameObject>(paradoxAsset, "Paradoxs");
			if (gameObject == null)
			{
				return null;
			}
			if (!paradoxPools.ContainsKey(skillId))
			{
				value = new ObjectPool<GameObject>(new ParadoxTreeFactory(paradoxAsset, gameObject, world.ParadoxRoot, 1), 1);
				paradoxPools.Add(skillId, value);
			}
			else
			{
				paradoxPools.TryGetValue(skillId, out value);
			}
		}
		GameObject obj = value?.Allocate();
		if ((object)obj != null)
		{
			obj.SetActive(value: true);
			return obj;
		}
		return obj;
	}

	public void CacheParadoxTreeObj(int skillId)
	{
		paradoxPools.TryGetValue(skillId, out var value);
		if (value != null)
		{
			return;
		}
		DRParadox dataRow = GameEntry.DataTable.GetDataRow<DRParadox>(skillId);
		if (dataRow != null)
		{
			string paradoxAsset = AssetUtility.GetParadoxAsset(dataRow.AssetPath);
			GameObject gameObject = GetSystem<GameResourceSystem>().LoadAsset<GameObject>(paradoxAsset, "Paradoxs");
			if (!(gameObject == null))
			{
				value = new ObjectPool<GameObject>(new ParadoxTreeFactory(paradoxAsset, gameObject, world.ParadoxRoot, 1), 3);
				paradoxPools.Add(skillId, value);
			}
		}
	}

	public async Task<bool> PreLoadParadoxGraph(int paradoxId)
	{
		if (paradoxPools == null)
		{
			return false;
		}
		paradoxPools.TryGetValue(paradoxId, out var value);
		if (value == null)
		{
			DRParadox dataRow = GameEntry.DataTable.GetDataRow<DRParadox>(paradoxId);
			if (dataRow == null)
			{
				return false;
			}
			string fullPath = AssetUtility.GetParadoxAsset(dataRow.AssetPath);
			GameObject gameObject = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(fullPath, "Paradoxs");
			if (gameObject == null)
			{
				return false;
			}
			if (paradoxPools == null || world == null)
			{
				return false;
			}
			if (!paradoxPools.ContainsKey(paradoxId))
			{
				value = new ObjectPool<GameObject>(new ParadoxTreeFactory(fullPath, gameObject, world.ParadoxRoot, 1), 8);
				paradoxPools.Add(paradoxId, value);
			}
			else
			{
				paradoxPools.TryGetValue(paradoxId, out value);
			}
		}
		if (value == null)
		{
			return false;
		}
		return await value.PreLoadData();
	}

	public void PauseTree(int id)
	{
		executeTrees.TryGetValue(id, out var value);
		value?.Pause();
	}

	public void ResumeTree(int id)
	{
		executeTrees.TryGetValue(id, out var value);
		value?.Resume();
	}

	public void StopTree(int id)
	{
		cacheRemoveParadox.Add(id);
	}

	public void SetVariableValues<T>(int id, string paramKey, T paramValue)
	{
		executeTrees.TryGetValue(id, out var value);
		value?.SetVariableValue(paramKey, paramValue);
	}

	public T GetVariableValues<T>(int id, string variableKey)
	{
		executeTrees.TryGetValue(id, out var value);
		if (value == null)
		{
			return default(T);
		}
		return value.GetVariableValues<T>(variableKey);
	}

	public override void OnReset()
	{
		if (executeTrees == null)
		{
			return;
		}
		lock (executeTrees)
		{
			Dictionary<int, BaseParadox>.Enumerator enumerator = executeTrees.GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.Value.Stop(isForceStop: true);
			}
			enumerator.Dispose();
			executeTrees.Clear();
			_executeTreeKey.Clear();
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		OnReset();
		if (_battleEventParamProcessor != null)
		{
			foreach (BattleEventParamProcessor value in _battleEventParamProcessor.Values)
			{
				value?.Clear();
			}
			_battleEventParamProcessor.Clear();
			_battleEventParamProcessor = null;
		}
		if (_eventTreeDic != null)
		{
			foreach (List<EventTree> value2 in _eventTreeDic.Values)
			{
				if (value2 != null)
				{
					for (int i = 0; i < value2.Count; i++)
					{
						ReferencePool.Release(value2[i]);
					}
					value2.Clear();
					CollectionPool<List<EventTree>, EventTree>.Release(value2);
				}
			}
			_eventTreeDic.Clear();
			_eventTreeDic = null;
		}
		foreach (KeyValuePair<int, IObjectPool<GameObject>> paradoxPool in paradoxPools)
		{
			paradoxPool.Value.Dispose();
		}
		paradoxPools.Clear();
		if (_paradoxManager != null)
		{
			_paradoxManager.ClearCache();
			UnityEngine.Object.Destroy(_paradoxManager.gameObject);
			_paradoxManager = null;
		}
		foreach (ParadoxTimer paradoxTimer in _paradoxTimers)
		{
			if (paradoxTimer != null)
			{
				ReferencePool.Release(paradoxTimer);
			}
		}
		_paradoxTimers.Clear();
		if (_eventActionDic != null)
		{
			CollectionPool<Dictionary<int, BaseEventTreeAction>, KeyValuePair<int, BaseEventTreeAction>>.Release(_eventActionDic);
			_eventActionDic = null;
		}
	}

	public int RegistrationTree(BaseEntity ownerEntity, BattleObserverEventEnum eventEnum, string key, float blackValue, Dictionary<int, EventTreeConditionParams> condition, BaseEventTreeAction action)
	{
		if (condition.IsNullOrEmpty())
		{
			return 0;
		}
		if (_eventActionDic == null)
		{
			_eventActionDic = CollectionPool<Dictionary<int, BaseEventTreeAction>, KeyValuePair<int, BaseEventTreeAction>>.Get();
		}
		_eventActionDic[++actionIndex] = action;
		EventTree item = EventTree.Create(ownerEntity, key, blackValue, actionIndex, condition);
		if (!_eventTreeDic.ContainsKey(eventEnum))
		{
			List<EventTree> list = CollectionPool<List<EventTree>, EventTree>.Get();
			list.Add(item);
			_eventTreeDic.Add(eventEnum, list);
		}
		else
		{
			_eventTreeDic[eventEnum].Add(item);
		}
		return actionIndex;
	}

	public void OnNotify(IObserverParams param)
	{
		if (_eventTreeDic == null || _battleEventParamProcessor == null || !_eventTreeDic.TryGetValue(param.ObserverEventType, out var value))
		{
			return;
		}
		if (!_battleEventParamProcessor.TryGetValue(param.ObserverEventType, out var value2))
		{
			value2 = BattleEventParamProcessor.CreateProcessor(param.ObserverEventType);
			_battleEventParamProcessor[param.ObserverEventType] = value2;
		}
		if (value2 != null)
		{
			value2.Processor(param);
			for (int i = 0; i < value.Count; i++)
			{
				value[i].Notify(value2.BattleEventParam);
			}
		}
	}

	public void RemoveTree(int actionID)
	{
		if (!_eventActionDic.TryGetValue(actionID, out var value) || !_eventTreeDic.TryGetValue(value.EventEnum, out var value2))
		{
			return;
		}
		for (int i = 0; i < value2.Count; i++)
		{
			if (value2[i].ID == actionID)
			{
				value2[i].Clear();
				value2.RemoveAt(i);
				_eventActionDic.Remove(actionID);
				break;
			}
		}
	}
}
