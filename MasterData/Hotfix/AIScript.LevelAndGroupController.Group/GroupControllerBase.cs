#define LOG_ERROR
#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.LevelAndGroupController.Group;

public class GroupControllerBase
{
	public delegate IEnumerator OperateDelegate();

	private long _waitingForMonsterId;

	private List<string> _waitingForOperations = new List<string>();

	private int _monsterAIIDForReset;

	private CoroutineNode _waitingForSkillFinishNode;

	private MonsterAdventureActor _monsterActor;

	private List<int> summonMonsterIds;

	protected GroupAIType GroupAIType;

	protected FP _thinkInterval = 0.1;

	private CoroutineNode _checkQualifiedPoolBranchCoroutine;

	private CoroutineNode _checkQualifiedSequenceBranchCoroutine;

	private CoroutineNode _checkTraceInterruptCoroutine;

	private CoroutineNode _waitingOperateCoroutine;

	private CoroutineNode _operateCoroutine;

	protected bool _branchRunning;

	protected BaseGroupBranchInfo _executeGroupBranch;

	private List<CoroutineNode> apiCoroutineNodeList = new List<CoroutineNode>();

	private CoroutineNode _setBranchCdByConfigCoroutine;

	protected FP _delayStartTime = 0;

	private readonly Dictionary<int, PoolGroupBranchesInfo> _poolBranchDict = new Dictionary<int, PoolGroupBranchesInfo>();

	private PoolGroupBranchesInfo _currentPoolGroupBranchesInfo;

	private Dictionary<int, List<int>> _sequenceDict;

	private readonly Dictionary<int, BaseGroupBranchInfo> _sequenceBranchDict = new Dictionary<int, BaseGroupBranchInfo>();

	private List<int> _currentSequences;

	private int _currentIndex;

	private int _currentSeqIndex;

	protected bool pause;

	private int _toughnessStateChangeEventListenReferenceCount;

	private Dictionary<GroupEventType, GroupEventParams> _groupEventDict;

	public int CurrentSeqIndex => _currentSeqIndex;

	public int CurrentIndex => _currentIndex;

	protected void DirectDamage(AdventureActor fromActor, LogicEntity toActor, int damage, string tag, bool showHud = true)
	{
		if (toActor is AdventureActor target)
		{
			ILRuntimeAPI.DirectDamage(fromActor, target, damage, tag, null, showHud);
		}
	}

	protected void DirectHeal(LogicEntity toActor, int value, bool showHud = false)
	{
		if (toActor is AdventureActor adventureActor)
		{
			adventureActor.DirectHeal(value, showHud);
		}
	}

	protected void AddBuffToTarget(AdventureActor fromActor, LogicEntity target, int buffID)
	{
		CommonUtils_MonsterAPI.AddBuffToTarget(target, buffID, fromActor);
	}

	protected void RemoveBuffFromTarget(LogicEntity target, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		CommonUtils_MonsterAPI.RemoveBuffFromTarget(target, buffID, buffGroupID, buffTag);
	}

	protected int GetBuffNum(LogicEntity target, int buffID)
	{
		return CommonUtils_MonsterAPI.GetBuffNum(target, buffID);
	}

	protected void AddShieldToTarget(AdventureActor fromActor, LogicEntity target, int shieldId)
	{
		CommonUtils_MonsterAPI.AddShieldToTarget(target, shieldId, fromActor);
	}

	protected void SummonMonster(AdventureActor summoner, int summonActorID, TSVector2 spawnPosition, TSVector2 spawnDirection)
	{
		ILRuntimeAPI.SummonMonster(summoner, 0, summonActorID, spawnPosition, spawnDirection);
	}

	protected void SummonTeammate(MonsterAdventureActor summoner, int index, TSVector2 spawnPosition, TSVector2 spawnDirection, int maxAmount = 0)
	{
		CommonUtils_MonsterAPI.SummonTeammate(summoner, index, spawnPosition, spawnDirection, maxAmount);
	}

	protected void KillActors(List<LogicEntity> entities)
	{
		CommonUtils_MonsterAPI.KillActors(entities);
	}

	protected void ClearActors(List<LogicEntity> entities)
	{
		CommonUtils_MonsterAPI.ClearActors(entities);
	}

	protected bool GetLogicTagToggleValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagToggleValue(entity, tagName);
	}

	protected string GetLogicTagStringValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagStringValue(entity, tagName);
	}

	protected FP GetLogicTagFpValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagFpValue(entity, tagName);
	}

	protected TSVector2 GetLogicTagTSVector2Value(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagTSVector2Value(entity, tagName);
	}

	protected void SetLogicTagToggleValue(LogicEntity entity, string tagName, bool value)
	{
		CommonUtils_MonsterAPI.SetLogicTagToggleValue(entity, tagName, value);
	}

	protected void SetLogicTagStringValue(LogicEntity entity, string tagName, string value)
	{
		CommonUtils_MonsterAPI.SetLogicTagStringValue(entity, tagName, value);
	}

	protected void SetLogicTagFpValue(LogicEntity entity, string tagName, FP value)
	{
		CommonUtils_MonsterAPI.SetLogicTagFpValue(entity, tagName, value);
	}

	protected void SetLogicTagTSVector2Value(LogicEntity entity, string tagName, TSVector2 value)
	{
		CommonUtils_MonsterAPI.SetLogicTagTSVector2Value(entity, tagName, value);
	}

	protected void SetLogicTagListTSVector2Value(LogicEntity entity, string tagName, List<TSVector2> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagListTSVector2Value(entity, tagName, value);
	}

	protected void SetLogicTagDicIntTSVector2Value(LogicEntity entity, string tagName, Dictionary<int, TSVector2> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagDicIntTSVector2Value(entity, tagName, value);
	}

	protected void SetLogicTagDicTSVector2LongValue(LogicEntity entity, string tagName, Dictionary<TSVector2, long> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagDicTSVector2LongValue(entity, tagName, value);
	}

	protected void SetLogicTagListLongValue(LogicEntity entity, string tagName, List<long> value)
	{
		CommonUtils_MonsterAPI.SetLogicTagListLongValue(entity, tagName, value);
	}

	protected List<TSVector2> GetLogicTagListTSVector2Value(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagListTSVector2Value(entity, tagName);
	}

	protected Dictionary<int, TSVector2> GetLogicTagDicIntTSVector2Value(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagDicIntTSVector2Value(entity, tagName);
	}

	protected Dictionary<TSVector2, long> GetLogicTagDicTSVector2LongValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagDicTSVector2LongValue(entity, tagName);
	}

	protected List<long> GetLogicTagListLongValue(LogicEntity entity, string tagName)
	{
		return CommonUtils_MonsterAPI.GetLogicTagListLongValue(entity, tagName);
	}

	protected DeterministicShape GetShapeData(DeterministicShape.ShapeType shapeT = DeterministicShape.ShapeType.Circle, TSVector2 position = default(TSVector2), FP width = default(FP), FP length = default(FP), FP radius = default(FP), FP innerRadius = default(FP), FP angle = default(FP), FP rotation = default(FP))
	{
		return CommonUtils_MonsterAPI.GetShapeData(shapeT, position, width, length, radius, innerRadius, angle, rotation);
	}

	protected int randomWeight(int[] rdmWeights)
	{
		return CommonUtils_MonsterAPI.randomWeight(rdmWeights);
	}

	protected FP GetRandomValue(FP minValue, FP maxValue, bool isInt = false)
	{
		return CommonUtils_MonsterAPI.GetRandomValue(minValue, maxValue, isInt);
	}

	protected TSVector2 GetShapeRandomPoint(DeterministicShape shape, LogicEntity entity, bool isReachable = false)
	{
		return CommonUtils_MonsterAPI.GetShapeRandomPoint(shape, entity, isReachable);
	}

	protected FP Distance(TSVector2 value1, TSVector2 value2)
	{
		return CommonUtils_MonsterAPI.Distance(value1, value2);
	}

	protected FP GetTSVectToAngle(TSVector2 value, FP angle)
	{
		return CommonUtils_MonsterAPI.GetTSVectToAngle(value, angle);
	}

	protected TSVector2 TransLocalPosToWorldPos(TSVector2 csOrigin, TSVector2 csForward, TSVector2 relativePoint)
	{
		return CommonUtils_MonsterAPI.TransLocalPosToWorldPos(csOrigin, csForward, relativePoint);
	}

	protected TSVector2 RotateTo(TSVector2 from, FP angle)
	{
		return CommonUtils_MonsterAPI.RotateTo(from, angle);
	}

	protected FP AngleBetween2TSVector(TSVector2 from, TSVector2 to, bool signed)
	{
		return CommonUtils_MonsterAPI.AngleBetween2TSVector(from, to, signed);
	}

	private void OnReceiveOperationMessage(IEvent iEvt)
	{
		if (_waitingForOperations.Count != 0 && iEvt is AdventureMonsterToGroupControllerMessage adventureMonsterToGroupControllerMessage)
		{
			if (_waitingForMonsterId > 0 && adventureMonsterToGroupControllerMessage.monsterId == _waitingForMonsterId)
			{
				Process(adventureMonsterToGroupControllerMessage.operationType);
			}
			else
			{
				Process(adventureMonsterToGroupControllerMessage.operationType);
			}
		}
		void Process(string operationType)
		{
			if (_waitingForOperations.Contains(operationType))
			{
				_waitingForOperations.Remove(operationType);
			}
		}
	}

	protected void SendMessageToMonster(long monsterId, string operationType)
	{
		AdventureGroupControllerToMonsterMessage adventureGroupControllerToMonsterMessage = AdventureGroupControllerToMonsterMessage.Generate();
		adventureGroupControllerToMonsterMessage.monsterId = monsterId;
		adventureGroupControllerToMonsterMessage.operationType = operationType;
		ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureGroupControllerToMonsterMessage);
	}

	protected CoroutineNode WaitCertainOperations(List<string> operations, long monsterId = 0L)
	{
		return StartLogicCoroutine(WaitCertainOperationsInternal(operations, monsterId));
	}

	private IEnumerator WaitCertainOperationsInternal(List<string> operations, long monsterId = 0L)
	{
		_waitingForMonsterId = monsterId;
		_waitingForOperations.Clear();
		_waitingForOperations.AddRange(operations);
		while (_waitingForOperations.Count > 0)
		{
			yield return null;
		}
	}

	protected void SwitchPool(int index)
	{
		if (_poolBranchDict.TryGetValue(index, out var value))
		{
			_currentPoolGroupBranchesInfo = value;
			_currentPoolGroupBranchesInfo.ResetBranchCdExpireTime();
		}
		else
		{
			NovaLogger.Error(GetType().Name + " 切换的行为池不存在，index:" + index);
		}
	}

	protected void SetPoolBranchActive(int id, bool active)
	{
		if (_currentPoolGroupBranchesInfo?.braches == null || _currentPoolGroupBranchesInfo.braches.Count == 0)
		{
			return;
		}
		foreach (PoolGroupBranchInfo brach in _currentPoolGroupBranchesInfo.braches)
		{
			if (brach.id == id)
			{
				brach.active = active;
				break;
			}
		}
	}

	protected void SetPoolBranchCD(int id, FP cd)
	{
		if (_currentPoolGroupBranchesInfo?.braches == null || _currentPoolGroupBranchesInfo.braches.Count == 0)
		{
			return;
		}
		foreach (PoolGroupBranchInfo brach in _currentPoolGroupBranchesInfo.braches)
		{
			if (brach.id == id)
			{
				brach.SetBranchCdExpireTime(cd);
				break;
			}
		}
	}

	protected FP GetPoolBranchCD(int id)
	{
		FP fP = 0;
		if (_currentPoolGroupBranchesInfo?.braches == null || _currentPoolGroupBranchesInfo.braches.Count == 0)
		{
			return fP;
		}
		foreach (PoolGroupBranchInfo brach in _currentPoolGroupBranchesInfo.braches)
		{
			if (brach.id == id)
			{
				fP = brach.branchCdExpireTime - LockStepManager.deltaTime;
				break;
			}
		}
		if (!(fP > 0))
		{
			return 0;
		}
		return fP;
	}

	protected void SwitchSequence(int index, bool initialIndex = true)
	{
		if (_sequenceDict.TryGetValue(index, out var value))
		{
			_currentSequences = value;
			_currentSeqIndex = index;
		}
		else
		{
			NovaLogger.Error(GetType().Name + " 切换的行为序列不存在，index:" + index);
		}
		if (initialIndex)
		{
			_currentIndex = 0;
		}
		else if (_currentIndex > _currentSequences.Count - 1)
		{
			_currentIndex = _currentSequences.Count - 1;
		}
	}

	protected void SetCurrentSequenceIndex(int index)
	{
		if (_currentSequences != null)
		{
			_currentIndex = Mathf.Clamp(index, 0, _currentSequences.Count);
		}
	}

	protected int GetCurrentSequenceIndex(bool IsOperateSuccess = true)
	{
		if (IsOperateSuccess)
		{
			if (_currentIndex > 0)
			{
				return _currentIndex - 1;
			}
			return _currentIndex = _currentSequences.Count - 1;
		}
		return _currentIndex;
	}

	protected void ResetMonsterAI(LogicEntity monster, int monsterAIId, bool interruptSkill)
	{
		_monsterActor = monster as MonsterAdventureActor;
		if (!(_monsterActor == null))
		{
			_monsterAIIDForReset = monsterAIId;
			if (interruptSkill)
			{
				_monsterActor.actorSkillManage.DestoryAllSkill();
				_monsterActor.ResetPrimeFSMAI(monsterAIId);
			}
			else if (!_monsterActor.actorSkillManage.HaveRunningSkill())
			{
				_monsterActor.ResetPrimeFSMAI(monsterAIId);
			}
			else
			{
				StartCor(ref _waitingForSkillFinishNode, WaitingForSkillFinish());
			}
		}
	}

	private IEnumerator WaitingForSkillFinish()
	{
		while (_monsterActor.actorSkillManage.HaveRunningSkill())
		{
			yield return null;
		}
		_monsterActor.ResetPrimeFSMAI(_monsterAIIDForReset);
	}

	protected void SetMonsterListenEventActive(GroupEventType type, bool active)
	{
		if (_groupEventDict == null)
		{
			return;
		}
		if (!_groupEventDict.TryGetValue(type, out var value))
		{
			NovaLogger.Error("请先初始化事件监听后再控制开关！" + type);
		}
		else if (value.active != active)
		{
			if (active)
			{
				AddListenEvent(value);
			}
			else
			{
				RemoveListenEvent(value);
			}
			value.active = active;
		}
	}

	protected void InterruptCurrentBranch()
	{
		EndWaitingOperateCoroutine();
		EndOperateCoroutine();
		_branchRunning = false;
		_executeGroupBranch = null;
	}

	protected CoroutineNode StartCor(IEnumerator enumerator)
	{
		CoroutineNode coroutineNode = StartLogicCoroutine(enumerator);
		apiCoroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void StartCor(ref CoroutineNode cor, IEnumerator enumerator)
	{
		if (cor != null)
		{
			StopLogicCoroutine(cor);
		}
		cor = StartLogicCoroutine(enumerator);
		apiCoroutineNodeList.Add(cor);
	}

	protected void StopCor(CoroutineNode cor)
	{
		if (cor != null)
		{
			StopLogicCoroutine(cor);
			apiCoroutineNodeList.Remove(cor);
		}
	}

	protected void InterruptSkill(AdventureActor actor)
	{
		actor?.actorSkillManage?.DestoryAllSkill();
	}

	protected void PlayWwiseSound(string eventName, LogicEntity owner)
	{
		CommonUtils_MonsterAPI.PlayWwiseSound(owner as AdventureActor, eventName, owner);
	}

	protected void TriggerOpListener(string triggerOpIDN)
	{
		CommonUtils_MonsterAPI.TriggerOpLisener(triggerOpIDN);
	}

	protected bool MonsterInState(MonsterAdventureActor actor, int state)
	{
		string[] array = actor.logicVariable.GetLogicTagStringValue("Monster_In_State").Split(',');
		for (int i = 0; i < array.Length - 1; i++)
		{
			CommonUtils.TryParseStringParamToInt(array[i], out var intValue);
			if (intValue == state)
			{
				return true;
			}
		}
		return false;
	}

	protected void DispatchCustomEvent(AdventureActor actor, string eventName, bool isSelfEvent = true)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = actor;
		adventureActorCustomEvent.actor = actor;
		adventureActorCustomEvent.eventName = eventName;
		if (isSelfEvent)
		{
			actor.DispatchEvent(adventureActorCustomEvent);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected CoroutineNode WaitTime(FP waitSeconds)
	{
		return StartLogicCoroutine(WaitForSeconds(waitSeconds));
	}

	protected CoroutineNode WaitFrame(int frameCount)
	{
		FP waitSeconds = (float)frameCount * 0.033f;
		return StartLogicCoroutine(WaitForSeconds(waitSeconds));
	}

	private IEnumerator WaitForSeconds(FP waitSeconds)
	{
		while (waitSeconds > 0)
		{
			waitSeconds -= LockStepManager.deltaTime;
			yield return null;
		}
	}

	protected CoroutineNode WaitUntil(Func<bool> predicate)
	{
		return StartLogicCoroutine(_WaitUntil(predicate));
	}

	private IEnumerator _WaitUntil(Func<bool> predicate)
	{
		while (!predicate())
		{
			yield return null;
		}
	}

	protected void SwitchCameraSetting(bool active, string cameraName)
	{
		if (active)
		{
			ModuleController<AdventureModuleController>.Instance.ActivePlayerCameraTrigger(cameraName);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.DeactivePlayerCameraTrigger(cameraName);
		}
	}

	protected void ShowCenterHpBar(LogicEntity actor)
	{
		if (actor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.ShowCenterHpBar(isShow: true);
			CommonUtils_MonsterAPI.TriggerOpLisener("StartClock");
		}
	}

	protected bool AreaCheckObstacle(DeterministicShape shape, bool checkHeight = false, HeightClass heightClass = HeightClass.Medium)
	{
		return CommonUtils_MonsterAPI.AreaCheckObstacle(shape, checkHeight, heightClass);
	}

	protected bool CheckTargetIsValid(LogicEntity target)
	{
		return CommonUtils_MonsterAPI.CheckTargetIsValid(target);
	}

	protected long GetTargetID(LogicEntity actor = null)
	{
		return CommonUtils_MonsterAPI.GetTargetID(actor);
	}

	protected TSVector2 GetEntityPosition(LogicEntity from, LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityPosition(entity, from);
	}

	protected TSVector2 GetEntityForward(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityForward(entity);
	}

	protected FP GetEntityAngle(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityAngle(entity);
	}

	protected LogicEntity GetCurrentPlayer()
	{
		return CommonUtils_MonsterAPI.GetCurrentPlayer();
	}

	protected int GetMonsterSummonNum(LogicEntity actor, int monsterID = -1, bool iAlive = true)
	{
		return CommonUtils_MonsterAPI.GetMonsterSummonNum(actor, monsterID, iAlive);
	}

	protected LogicEntity GetAttackTargetWithOwnerTauntFrom(long ownerId)
	{
		return CommonUtils_MonsterAPI.GetAttackTargetWithOwnerTauntFrom(ownerId);
	}

	protected TSVector2 GetPlaceHolderPosition(string name)
	{
		return CommonUtils_MonsterAPI.GetPlaceHolderPosition(name);
	}

	protected int GetTeammateIdByIndex(MonsterAdventureActor monster, int index)
	{
		return CommonUtils_MonsterAPI.GetTeammateIdByIndex(monster, index);
	}

	protected int GetPlayerJobType(AdventureActor player)
	{
		if (player is PlayerAdventureActor)
		{
			return (int)player.actorInfo.attackType;
		}
		return 0;
	}

	protected bool EntityInSkill(LogicEntity entity, int skillId = 0)
	{
		return CommonUtils_MonsterAPI.EntityInSkill(entity, skillId);
	}

	protected List<LogicEntity> GetTargetsByLogicTag(LogicTagType logicType, string logicStr, List<LogicEntity> entities = null, bool value1 = false, FP value2 = default(FP), string value3 = null, TSVector2 value4 = default(TSVector2))
	{
		return CommonUtils_MonsterAPI.GetTargetByLogicTag(logicType, logicStr, entities, value1, value2, value3, value4);
	}

	protected List<LogicEntity> GetTargetsFromShape(AdventureActor actor, DeterministicShape shape, List<LogicEntity> entities = null, bool includeSelf = false, LogicEntity targetEntity = null)
	{
		return CommonUtils_MonsterAPI.GetTargetsFromShape(actor, shape, entities, includeSelf, targetEntity);
	}

	protected LogicEntity GetTargetHp(bool hpMin, List<LogicEntity> entities, bool isAbs)
	{
		return CommonUtils_MonsterAPI.GetTargetHp(hpMin, entities, isAbs);
	}

	protected List<LogicEntity> GetTargetByDataID(int dataID, List<LogicEntity> entities = null)
	{
		return CommonUtils_MonsterAPI.GetTargetByDataID(dataID, entities);
	}

	protected LogicEntity GetTargetByID(long id, List<LogicEntity> entities = null)
	{
		return CommonUtils_MonsterAPI.GetTargetByID(id, entities);
	}

	protected List<LogicEntity> GetTargetByBuffID(int BuffID, List<LogicEntity> entities = null)
	{
		return CommonUtils_MonsterAPI.GetTargetByBuffID(BuffID, entities);
	}

	protected List<LogicEntity> GetTargetByDataIDs(List<int> dataIDs)
	{
		return CommonUtils_MonsterAPI.GetTargetByDataIDs(dataIDs);
	}

	protected List<LogicEntity> GetTargetByTeammateIndex(MonsterAdventureActor monster, int index, List<LogicEntity> entities = null)
	{
		int monsterTeammateId = CommonHelper.GetMonsterTeammateId(monster.monsterInfo.teamId, index);
		return GetTargetByDataID(monsterTeammateId, entities);
	}

	protected List<LogicEntity> GetTargetByTeammateIndexes(MonsterAdventureActor monster, List<int> indexes, List<LogicEntity> entities = null)
	{
		if (summonMonsterIds == null)
		{
			summonMonsterIds = new List<int>();
		}
		summonMonsterIds.Clear();
		for (int i = 0; i < indexes.Count; i++)
		{
			int monsterTeammateId = CommonHelper.GetMonsterTeammateId(monster.monsterInfo.teamId, indexes.get_Item(i));
			if (monsterTeammateId > 0)
			{
				summonMonsterIds.Add(monsterTeammateId);
			}
		}
		return CommonUtils_MonsterAPI.GetTargetByDataIDs(summonMonsterIds, entities);
	}

	protected List<LogicEntity> GetTargetsByDataId(int dataId)
	{
		return ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(dataId);
	}

	public void Start()
	{
		NovaLogger.Debug("GroupControllerBase Start");
		OnStart();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TO_GROUPCONTROLLER_MESSAGE", OnReceiveOperationMessage);
		SetListenEvents();
		SetConfig();
		_currentPoolGroupBranchesInfo?.ResetBranchCdExpireTime();
		if (GroupAIType == GroupAIType.POOL)
		{
			StartCheckQualifiedPoolBranchCoroutine();
		}
		else if (GroupAIType == GroupAIType.SEQUENCE)
		{
			StartCheckQualifiedSequenceBranchCoroutine();
		}
	}

	protected virtual void OnStart()
	{
	}

	public void Update()
	{
		OnUpdate();
	}

	protected virtual void OnUpdate()
	{
	}

	public void Stop()
	{
		NovaLogger.Debug("GroupControllerBase Stop");
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TO_GROUPCONTROLLER_MESSAGE", OnReceiveOperationMessage);
		EndCheckQualifiedPoolBranchCoroutine();
		EndCheckQualifiedSequenceBranchCoroutine();
		EndWaitingOperateCoroutine();
		EndOperateCoroutine();
		foreach (CoroutineNode apiCoroutineNode in apiCoroutineNodeList)
		{
			StopLogicCoroutine(apiCoroutineNode);
		}
		apiCoroutineNodeList.Clear();
		_branchRunning = false;
		_executeGroupBranch = null;
		EndProcessBranchCdByConfig();
		OnStop();
		if (GroupAIType == GroupAIType.POOL)
		{
			_poolBranchDict.Clear();
			_currentPoolGroupBranchesInfo = null;
		}
		else if (GroupAIType == GroupAIType.SEQUENCE)
		{
			_currentIndex = 0;
			_sequenceDict.Clear();
			_sequenceBranchDict.Clear();
			_currentSequences.Clear();
			_currentSequences = null;
		}
		RemoveListenEvents();
		pause = false;
	}

	protected virtual void OnStop()
	{
	}

	protected CoroutineNode StartLogicCoroutine(IEnumerator enumerator, bool runImmediately = true)
	{
		return SceneSingleton<AdventurePlayerController>.Instance.StartLogicCoroutine(enumerator, runImmediately);
	}

	protected void StopLogicCoroutine(CoroutineNode coroutineNode)
	{
		SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(coroutineNode);
	}

	protected virtual void SetConfig()
	{
	}

	protected void StartWaitingOperateCoroutine(BaseGroupBranchInfo groupBranchInfo)
	{
		EndWaitingOperateCoroutine();
		_waitingOperateCoroutine = StartLogicCoroutine(OperateBranch(groupBranchInfo));
	}

	private void EndWaitingOperateCoroutine()
	{
		if (_waitingOperateCoroutine != null)
		{
			StopLogicCoroutine(_waitingOperateCoroutine);
			_waitingOperateCoroutine = null;
		}
	}

	private IEnumerator OperateBranch(BaseGroupBranchInfo groupBranchInfo)
	{
		if (groupBranchInfo.operateIEnumerator != null)
		{
			_branchRunning = true;
			if (groupBranchInfo is PoolGroupBranchInfo poolGroupBranchInfo)
			{
				StartProcessBranchCdByConfig(poolGroupBranchInfo);
			}
			if (GroupAIType == GroupAIType.SEQUENCE)
			{
				SequenceBranchOperateComplete();
			}
			yield return StartOperateCoroutine(groupBranchInfo);
			EndProcessBranchCdByConfig();
			_branchRunning = false;
			_executeGroupBranch = null;
			groupBranchInfo.operateCompleteCallback?.Invoke();
			OnSequenceBranchOperateComplete(_currentSeqIndex, _currentIndex, _currentIndex == 0);
		}
		else
		{
			_executeGroupBranch = null;
			groupBranchInfo.operateCompleteCallback?.Invoke();
		}
	}

	private void StartProcessBranchCdByConfig(PoolGroupBranchInfo poolGroupBranchInfo)
	{
		if (poolGroupBranchInfo.startCdTime == 0 || poolGroupBranchInfo.startCdTime == default(FP))
		{
			poolGroupBranchInfo.SetBranchCdExpireTime(poolGroupBranchInfo.cd);
		}
		else
		{
			_setBranchCdByConfigCoroutine = StartLogicCoroutine(ProcessBranchCdByConfig(poolGroupBranchInfo));
		}
	}

	private void EndProcessBranchCdByConfig()
	{
		if (_setBranchCdByConfigCoroutine != null)
		{
			StopLogicCoroutine(_setBranchCdByConfigCoroutine);
			_setBranchCdByConfigCoroutine = null;
		}
	}

	private IEnumerator ProcessBranchCdByConfig(PoolGroupBranchInfo poolGroupBranchInfo)
	{
		FP currentTime = 0;
		while (true)
		{
			currentTime += LockStepManager.deltaTime;
			if (currentTime >= poolGroupBranchInfo.startCdTime)
			{
				break;
			}
			yield return null;
		}
		poolGroupBranchInfo.SetBranchCdExpireTime(poolGroupBranchInfo.cd);
	}

	private CoroutineNode StartOperateCoroutine(BaseGroupBranchInfo groupBranchInfo)
	{
		EndOperateCoroutine();
		_operateCoroutine = StartLogicCoroutine(groupBranchInfo.operateIEnumerator());
		return _operateCoroutine;
	}

	private void EndOperateCoroutine()
	{
		if (_operateCoroutine != null)
		{
			StopLogicCoroutine(_operateCoroutine);
			_operateCoroutine = null;
		}
	}

	protected void InitPoolBranches(int defaultPoolIndex, List<PoolGroupBranchesInfo> poolBranches)
	{
		if (poolBranches == null || poolBranches.Count == 0)
		{
			NovaLogger.Error(GetType().Name + " 请配置行为池！");
			return;
		}
		foreach (PoolGroupBranchesInfo poolBranch in poolBranches)
		{
			poolBranch.braches = poolBranch.braches.OrderByDescending((PoolGroupBranchInfo item) => item.priority).ToList();
			_poolBranchDict.set_Item(poolBranch.index, poolBranch);
			if (poolBranch.index == defaultPoolIndex)
			{
				_currentPoolGroupBranchesInfo = poolBranch;
			}
		}
		if (_currentPoolGroupBranchesInfo == null)
		{
			NovaLogger.Error(GetType().Name + " 初始行为池不存在，index:" + defaultPoolIndex);
		}
	}

	protected PoolGroupBranchInfo CheckQualifiedPoolBranchInfo()
	{
		if (_currentPoolGroupBranchesInfo == null || _currentPoolGroupBranchesInfo.braches.Count == 0)
		{
			return null;
		}
		PoolGroupBranchInfo result = null;
		foreach (PoolGroupBranchInfo brach in _currentPoolGroupBranchesInfo.braches)
		{
			if (!brach.active)
			{
				continue;
			}
			FP fP = brach.branchCdExpireTime - LockStepManager.time;
			if (fP < 0f)
			{
				fP = 0f;
			}
			if (!(fP > 0f))
			{
				bool flag = true;
				if (brach.operationConditionFunc != null)
				{
					flag = brach.operationConditionFunc();
				}
				if (flag)
				{
					result = brach;
					break;
				}
			}
		}
		return result;
	}

	private void StartCheckQualifiedPoolBranchCoroutine()
	{
		EndCheckQualifiedPoolBranchCoroutine();
		_checkQualifiedPoolBranchCoroutine = StartLogicCoroutine(CheckQualifiedPoolBranch());
	}

	private void EndCheckQualifiedPoolBranchCoroutine()
	{
		if (_checkQualifiedPoolBranchCoroutine != null)
		{
			StopLogicCoroutine(_checkQualifiedPoolBranchCoroutine);
			_checkQualifiedPoolBranchCoroutine = null;
		}
	}

	protected virtual IEnumerator CheckQualifiedPoolBranch()
	{
		if (_delayStartTime > 0)
		{
			while (_delayStartTime > 0)
			{
				_delayStartTime -= LockStepManager.deltaTime;
				yield return null;
			}
		}
		while (true)
		{
			if (_branchRunning)
			{
				yield return null;
				continue;
			}
			PoolGroupBranchInfo poolGroupBranchInfo = CheckQualifiedPoolBranchInfo();
			if (poolGroupBranchInfo != null && poolGroupBranchInfo != _executeGroupBranch && ((_executeGroupBranch != null && poolGroupBranchInfo.priority > (_executeGroupBranch as PoolGroupBranchInfo).priority) || _executeGroupBranch == null))
			{
				_executeGroupBranch = poolGroupBranchInfo;
				StartWaitingOperateCoroutine(poolGroupBranchInfo);
			}
			FP thinkInterval = _thinkInterval;
			while (thinkInterval > 0)
			{
				thinkInterval -= LockStepManager.deltaTime;
				yield return null;
			}
		}
	}

	protected void InitSequenceBranches(int defaultSequenceIndex, List<BaseGroupBranchInfo> sequenceBranches, Dictionary<int, List<int>> sequenceDict)
	{
		if (sequenceDict == null || sequenceDict.Count == 0)
		{
			NovaLogger.Error(GetType().Name + " 请配置行为序列！");
			return;
		}
		if (sequenceBranches == null || sequenceBranches.Count == 0)
		{
			NovaLogger.Error(GetType().Name + " 请配置行为序列内容！");
			return;
		}
		foreach (BaseGroupBranchInfo sequenceBranch in sequenceBranches)
		{
			_sequenceBranchDict.set_Item(sequenceBranch.id, sequenceBranch);
		}
		if (sequenceDict.TryGetValue(defaultSequenceIndex, out var value))
		{
			_currentSequences = value;
			_currentSeqIndex = defaultSequenceIndex;
		}
		else
		{
			NovaLogger.Error(GetType().Name + " 初始行为序列不存在，index:" + defaultSequenceIndex);
		}
		_currentIndex = 0;
		_sequenceDict = sequenceDict;
	}

	private BaseGroupBranchInfo GetSequenceBranchInfo()
	{
		BaseGroupBranchInfo result = null;
		if (_currentSequences != null && _currentSequences.Count > 0)
		{
			int key = _currentSequences.get_Item(_currentIndex);
			if (_sequenceBranchDict.TryGetValue(key, out var value))
			{
				result = value;
			}
			else
			{
				NovaLogger.Error(GetType().Name + " 行为id不存在！branchId:" + key);
			}
		}
		else
		{
			NovaLogger.Error(GetType().Name + " 行为序列为空！");
		}
		return result;
	}

	private void SequenceBranchOperateComplete()
	{
		_currentIndex++;
		if (_currentIndex == _currentSequences.Count)
		{
			_currentIndex = 0;
		}
	}

	private void StartCheckQualifiedSequenceBranchCoroutine()
	{
		EndCheckQualifiedSequenceBranchCoroutine();
		_checkQualifiedSequenceBranchCoroutine = StartLogicCoroutine(CheckQualifiedSequenceBranch());
	}

	private void EndCheckQualifiedSequenceBranchCoroutine()
	{
		if (_checkQualifiedSequenceBranchCoroutine != null)
		{
			StopLogicCoroutine(_checkQualifiedSequenceBranchCoroutine);
			_checkQualifiedSequenceBranchCoroutine = null;
		}
	}

	private IEnumerator CheckQualifiedSequenceBranch()
	{
		if (_delayStartTime > 0)
		{
			while (_delayStartTime > 0)
			{
				_delayStartTime -= LockStepManager.deltaTime;
				yield return null;
			}
		}
		while (true)
		{
			if (_executeGroupBranch != null)
			{
				yield return null;
				continue;
			}
			NovaLogger.Debug("groupController 开始筛选ai分支");
			while (pause)
			{
				yield return null;
			}
			BaseGroupBranchInfo sequenceBranchInfo = GetSequenceBranchInfo();
			if (sequenceBranchInfo != null)
			{
				NovaLogger.Debug("groupController 筛选ai分支成功 " + sequenceBranchInfo.id);
				_executeGroupBranch = sequenceBranchInfo;
				StartWaitingOperateCoroutine(sequenceBranchInfo);
			}
			FP thinkInterval = _thinkInterval;
			while (thinkInterval > 0)
			{
				thinkInterval -= LockStepManager.deltaTime;
				yield return null;
			}
		}
	}

	protected virtual void OnSequenceBranchOperateComplete(int curSeqIndex, int curBranchIndex, bool isSeqEnd)
	{
	}

	protected void EenterPause()
	{
		pause = true;
	}

	protected void ExitPause()
	{
		pause = false;
	}

	protected virtual void SetListenEvents()
	{
	}

	protected void InitListenEvent(GroupEventType type, bool active, Action<IEvent> operation)
	{
		if (_groupEventDict == null)
		{
			_groupEventDict = new Dictionary<GroupEventType, GroupEventParams>();
		}
		if (!_groupEventDict.ContainsKey(type))
		{
			_groupEventDict.set_Item(type, new GroupEventParams(type, active, operation));
			if (active)
			{
				AddListenEvent(_groupEventDict.get_Item(type));
			}
		}
	}

	protected void InitListenEvent(GroupEventType type, bool active, Action<IEvent> operation, params int[] eventParams)
	{
		if (_groupEventDict == null)
		{
			_groupEventDict = new Dictionary<GroupEventType, GroupEventParams>();
		}
		if (!_groupEventDict.ContainsKey(type))
		{
			_groupEventDict.set_Item(type, new GroupEventParams(type, active, operation, eventParams.ToList()));
			if (active)
			{
				AddListenEvent(_groupEventDict.get_Item(type));
			}
		}
	}

	protected void InitListenEvent(GroupEventType type, bool active, Action<IEvent> operation, params string[] eventParams)
	{
		if (_groupEventDict == null)
		{
			_groupEventDict = new Dictionary<GroupEventType, GroupEventParams>();
		}
		if (!_groupEventDict.ContainsKey(type))
		{
			GroupEventParams value = new GroupEventParams(type, active, operation, eventParams.ToList());
			_groupEventDict.set_Item(type, value);
			if (active)
			{
				AddListenEvent(_groupEventDict.get_Item(type));
			}
		}
	}

	private void AddListenEvent(GroupEventParams eventParams)
	{
		if (eventParams.type == GroupEventType.ReceiveDamage)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
		else if (eventParams.type == GroupEventType.MonsterDie)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		}
		else if (eventParams.type == GroupEventType.MonsterSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_ENTER_BATTLE", OnMonsterSpawnFinish);
		}
		else if (eventParams.type == GroupEventType.LostControl)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnMonsterBeControlled);
		}
		else if (eventParams.type == GroupEventType.BulletSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_BORN", OnBulletSpawn);
		}
		else if (eventParams.type == GroupEventType.BulletFinish)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		}
		else if (eventParams.type == GroupEventType.ToughnessBroken)
		{
			AddToughnessStateChangeEventListen();
		}
		else if (eventParams.type == GroupEventType.ExitToughnessBroken)
		{
			AddToughnessStateChangeEventListen();
		}
		else if (eventParams.type == GroupEventType.HpChanged)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		else if (eventParams.type == GroupEventType.DamageToOthers)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		else if (eventParams.type == GroupEventType.BattleLevelChange)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChanged);
		}
		else if (eventParams.type == GroupEventType.ReceiveMonsterOperation)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TO_GROUPCONTROLLER_MESSAGE", OnReceiveMonsterOperationMessage);
		}
	}

	private void RemoveListenEvent(GroupEventParams eventParams)
	{
		if (eventParams.type == GroupEventType.ReceiveDamage)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
		else if (eventParams.type == GroupEventType.MonsterDie)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		}
		else if (eventParams.type == GroupEventType.MonsterSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ENTER_BATTLE", OnMonsterSpawnFinish);
		}
		else if (eventParams.type == GroupEventType.LostControl)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnMonsterBeControlled);
		}
		else if (eventParams.type == GroupEventType.BulletSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletSpawn);
		}
		else if (eventParams.type == GroupEventType.BulletFinish)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		}
		else if (eventParams.type == GroupEventType.ToughnessBroken)
		{
			RemoveToughnessStateChangeEventListen();
		}
		else if (eventParams.type == GroupEventType.ExitToughnessBroken)
		{
			RemoveToughnessStateChangeEventListen();
		}
		else if (eventParams.type == GroupEventType.HpChanged)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		else if (eventParams.type == GroupEventType.DamageToOthers)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		else if (eventParams.type == GroupEventType.BattleLevelChange)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChanged);
		}
		else if (eventParams.type == GroupEventType.ReceiveMonsterOperation)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TO_GROUPCONTROLLER_MESSAGE", OnReceiveMonsterOperationMessage);
		}
	}

	private void AddToughnessStateChangeEventListen()
	{
		_toughnessStateChangeEventListenReferenceCount++;
		if (_toughnessStateChangeEventListenReferenceCount == 1)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		}
	}

	private void RemoveToughnessStateChangeEventListen()
	{
		_toughnessStateChangeEventListenReferenceCount--;
		if (_toughnessStateChangeEventListenReferenceCount == 0)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		}
	}

	private void RemoveListenEvents()
	{
		if (_groupEventDict == null)
		{
			return;
		}
		foreach (GroupEventParams value in _groupEventDict.Values)
		{
			if (value.active)
			{
				RemoveListenEvent(value);
			}
		}
		_groupEventDict.Clear();
		_toughnessStateChangeEventListenReferenceCount = 0;
	}

	private void OnReceiveDamage(IEvent iEvt)
	{
		if (iEvt is AdventureActorReceiveDamageEvent)
		{
			_groupEventDict.get_Item(GroupEventType.ReceiveDamage).operation?.Invoke(iEvt);
		}
	}

	private void OnDamage(IEvent iEvt)
	{
		if (iEvt is AdventureActorReceiveDamageEvent)
		{
			_groupEventDict.get_Item(GroupEventType.DamageToOthers).operation?.Invoke(iEvt);
		}
	}

	private void OnMonsterDie(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterDiedEvent adventureMonsterDiedEvent)
		{
			GroupEventParams groupEventParams = _groupEventDict.get_Item(GroupEventType.MonsterDie);
			if (groupEventParams.intParams != null && groupEventParams.intParams.Contains(adventureMonsterDiedEvent.monsterID))
			{
				groupEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnMonsterSpawnFinish(IEvent iEvt)
	{
		if (iEvt is AdventureActorEnterBattle adventureActorEnterBattle)
		{
			GroupEventParams groupEventParams = _groupEventDict.get_Item(GroupEventType.MonsterSpawn);
			if (groupEventParams.intParams != null && groupEventParams.intParams.Contains((adventureActorEnterBattle.sender as AdventureActor).dataID))
			{
				groupEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnMonsterBeControlled(IEvent iEvt)
	{
		if (iEvt is AdventureActorBeControlledEvent)
		{
			_groupEventDict.get_Item(GroupEventType.LostControl).operation?.Invoke(iEvt);
		}
	}

	private void OnBulletSpawn(IEvent iEvt)
	{
		if (iEvt is AdventureBulletBornEvent adventureBulletBornEvent)
		{
			GroupEventParams groupEventParams = _groupEventDict.get_Item(GroupEventType.BulletSpawn);
			if (groupEventParams.stringParams.Contains(adventureBulletBornEvent.tag))
			{
				groupEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnBulletFinish(IEvent iEvt)
	{
		if (iEvt is AdventureBulletFinishEvent adventureBulletFinishEvent)
		{
			GroupEventParams groupEventParams = _groupEventDict.get_Item(GroupEventType.BulletFinish);
			if (groupEventParams.stringParams.Contains(adventureBulletFinishEvent.tag))
			{
				groupEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnToughnessStateChange(IEvent iEvt)
	{
		if (!(iEvt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent))
		{
			return;
		}
		GroupEventParams value2;
		if (monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			if (_groupEventDict.TryGetValue(GroupEventType.ToughnessBroken, out var value))
			{
				value.operation?.Invoke(iEvt);
			}
		}
		else if (_groupEventDict.TryGetValue(GroupEventType.ExitToughnessBroken, out value2))
		{
			value2.operation?.Invoke(iEvt);
		}
	}

	private void OnHpChange(IEvent iEvt)
	{
		if (iEvt is AdventureActorHpChangedEvent)
		{
			_groupEventDict.get_Item(GroupEventType.HpChanged).operation?.Invoke(iEvt);
		}
	}

	private void OnBattleLevelChanged(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterBattleLevelChangedEvent)
		{
			_groupEventDict.get_Item(GroupEventType.BattleLevelChange).operation?.Invoke(iEvt);
		}
	}

	private void OnReceiveMonsterOperationMessage(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterToGroupControllerMessage)
		{
			_groupEventDict.get_Item(GroupEventType.ReceiveMonsterOperation).operation?.Invoke(iEvt);
		}
	}
}
