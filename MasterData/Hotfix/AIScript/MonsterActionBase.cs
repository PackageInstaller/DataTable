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

namespace AIScript;

public class MonsterActionBase : AIBase
{
	public delegate IEnumerator OperateDelegate();

	private Dictionary<SpecialState, int> _specialStateDict = new Dictionary<SpecialState, int>();

	private int _monsterAIIDForReset;

	private CoroutineNode _waitingForSkillFinishNode;

	private bool _skillFinish;

	private Dictionary<int, FP> skillCDDict = new Dictionary<int, FP>();

	private List<int> summonMonsterIds;

	protected MonsterAIType _monsterAIType;

	protected FP _thinkInterval = 0.1;

	private TraceTarget _traceTarget;

	private LookAtTarget _lookAtTarget;

	private CoroutineNode _checkQualifiedPoolBranchCoroutine;

	private CoroutineNode _checkQualifiedSequenceBranchCoroutine;

	private CoroutineNode _checkTraceInterruptCoroutine;

	private CoroutineNode _waitingOperateCoroutine;

	private CoroutineNode _operateCoroutine;

	protected bool _branchRunning;

	protected BaseBranchInfo _executeBranch;

	protected LogicEntity target;

	private List<CoroutineNode> apiCoroutineNodeList = new List<CoroutineNode>();

	private bool _inSwitchStateProtect;

	private CoroutineNode _setBranchCdByConfigCoroutine;

	protected FP _delayStartTime = 0.1;

	private CoroutineNode _changeModelScaleCor;

	private readonly Dictionary<int, PoolBranchesInfo> _poolBranchDict = new Dictionary<int, PoolBranchesInfo>();

	private PoolBranchesInfo _currentPoolBranchesInfo;

	private Dictionary<int, List<int>> _sequenceDict;

	private readonly Dictionary<int, BaseBranchInfo> _sequenceBranchDict = new Dictionary<int, BaseBranchInfo>();

	private List<int> _currentSequences;

	private int _currentIndex;

	private int _currentSeqIndex;

	private int _customEventListenReferenceCount;

	private Dictionary<MonsterEventType, MonsterEventParams> _monsterEventDict;

	public int CurrentSeqIndex => _currentSeqIndex;

	public int CurrentIndex => _currentIndex;

	public bool skillFinsh => _skillFinish;

	protected void DirectDamage(LogicEntity toActor, int damage, string tag, bool showHud = true)
	{
		if (toActor is AdventureActor adventureActor)
		{
			ILRuntimeAPI.DirectDamage(_actor, adventureActor, damage, tag, null, showHud);
		}
	}

	protected void DirectHeal(LogicEntity toActor, int value, bool showHud = false)
	{
		if (toActor is AdventureActor adventureActor)
		{
			adventureActor.DirectHeal(value, showHud);
		}
	}

	protected void AddBuffToTarget(LogicEntity target, int buffID)
	{
		CommonUtils_MonsterAPI.AddBuffToTarget(target, buffID, _actor);
	}

	protected void RemoveBuffFromTarget(LogicEntity target, int buffID = 0, int buffGroupID = 0, int buffTag = 0)
	{
		CommonUtils_MonsterAPI.RemoveBuffFromTarget(target, buffID, buffGroupID, buffTag);
	}

	protected void RemoveBuffByNumFromTarget(LogicEntity target, int buffId, int removeNum)
	{
		CommonUtils_MonsterAPI.RemoveBuffByNumFromTarget(target, buffId, removeNum);
	}

	protected int GetBuffNum(LogicEntity target, int buffID)
	{
		return CommonUtils_MonsterAPI.GetBuffNum(target, buffID);
	}

	protected void AddShieldToTarget(LogicEntity target, int shieldId)
	{
		CommonUtils_MonsterAPI.AddShieldToTarget(target, shieldId, _actor);
	}

	protected void SummonMonster(int summonActorID, int summonGroupID, TSVector2 spawnPosition, TSVector2 spawnDirection)
	{
		if (summonActorID > 0)
		{
			ILRuntimeAPI.SummonMonster(_actor, 0, summonActorID, spawnPosition, spawnDirection);
		}
		else
		{
			ILRuntimeAPI.SummonMonster(_actor, summonGroupID, summonActorID, spawnPosition, spawnDirection);
		}
	}

	protected void SummonTeammate(int index, TSVector2 spawnPosition, TSVector2 spawnDirection, int maxAmount = 0)
	{
		CommonUtils_MonsterAPI.SummonTeammate(_actor as MonsterAdventureActor, index, spawnPosition, spawnDirection, maxAmount);
	}

	protected void KillActors(List<LogicEntity> entities)
	{
		CommonUtils_MonsterAPI.KillActors(entities);
	}

	protected void ClearActors(List<LogicEntity> entities)
	{
		CommonUtils_MonsterAPI.ClearActors(entities);
	}

	protected void UseMonsterCloneActorCastSkill(int skillId)
	{
		ModuleController<AdventureModuleController>.Instance.UseMonsterCloneActorCastSkill((MonsterAdventureActor)_actor, skillId);
	}

	protected void ClearOwnerBullet()
	{
		List<AdventureBulletBase> list = new List<AdventureBulletBase>();
		_actor.QueryOwnedAliveBullets(list);
		for (int i = 0; i < list.Count; i++)
		{
			list.get_Item(i).Finish();
		}
	}

	protected void ClearOwnerWeapon()
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (adventureWeapon != null && adventureWeapon.owner == _actor && adventureWeapon.ownerId == _actor.Id)
			{
				adventureWeapon.Finish();
			}
		}
	}

	protected void FinishBullet(long bulletId)
	{
		AdventureBulletBase adventureBulletBase = _actor.QueryOwnedBullet(bulletId);
		if (adventureBulletBase != null)
		{
			adventureBulletBase.Finish();
		}
	}

	protected void FinishWeapon(long weaponId)
	{
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (adventureWeapon != null && adventureWeapon.owner == _actor && adventureWeapon.ownerId == _actor.Id && adventureWeapon.Id == weaponId)
			{
				adventureWeapon.Finish();
				break;
			}
		}
	}

	private void EnableSpecialState(SpecialState state)
	{
		if (_specialStateDict.ContainsKey(state))
		{
			_specialStateDict.get_Item(state)++;
		}
		else
		{
			_specialStateDict.set_Item(state, 1);
		}
	}

	private void DisableSpecialState(SpecialState state)
	{
		if (_specialStateDict.ContainsKey(state))
		{
			_specialStateDict.get_Item(state)--;
		}
	}

	private void ClearSpecialState()
	{
		if (_specialStateDict.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<SpecialState, int> item in _specialStateDict)
		{
			switch (item.Key)
			{
			case SpecialState.Armor:
			{
				for (int num = 0; num < item.Value; num++)
				{
					SetSuperArmorDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.ImmuneControl:
			{
				for (int i = 0; i < item.Value; i++)
				{
					SetImmuneControlDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.Invincible:
			{
				for (int k = 0; k < item.Value; k++)
				{
					SetInvincibleDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.SearchedImmunity:
			{
				for (int num3 = 0; num3 < item.Value; num3++)
				{
					SetSearchedImmunityDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.CloseBlock:
			{
				for (int m = 0; m < item.Value; m++)
				{
					SetCloseBlockDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.HideMode:
			{
				for (int j = 0; j < item.Value; j++)
				{
					SetHideModelDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.Sneak:
			{
				for (int num4 = 0; num4 < item.Value; num4++)
				{
					SetSneakDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.HideOut:
			{
				for (int num2 = 0; num2 < item.Value; num2++)
				{
					SetHideOutDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.BattleOut:
			{
				for (int n = 0; n < item.Value; n++)
				{
					SetBattleOutDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.Unparalleled:
			{
				for (int l = 0; l < item.Value; l++)
				{
					SetUnparalleledDisable(resetCount: false);
				}
				break;
			}
			case SpecialState.LockHp:
				if (item.Value > 0)
				{
					SetLockHpDisable(resetCount: false);
				}
				break;
			case SpecialState.LockToughness:
				if (item.Value > 0)
				{
					SetLockToughnessDisable(resetCount: false);
				}
				break;
			case SpecialState.BlockPriorityToStatic:
				if (item.Value > 0)
				{
					ResetBlockPriority(resetCount: false);
				}
				break;
			}
		}
		_specialStateDict.Clear();
	}

	protected void SetSuperArmorEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetSuperArmorEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Armor);
		}
	}

	protected void SetSuperArmorDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetSuperArmorDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Armor);
		}
	}

	protected void InterruptSuperArmor()
	{
		CommonUtils_MonsterAPI.InterruptSuperArmor(_actor);
	}

	protected void SetImmuneControlEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetImmuneControlEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.ImmuneControl);
		}
	}

	protected void SetImmuneControlDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetImmuneControlDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.ImmuneControl);
		}
	}

	public void InterruptImmuneControl()
	{
		CommonUtils_MonsterAPI.InterruptImmuneControl(_actor);
	}

	protected void SetInvincibleEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetInvincibleEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Invincible);
		}
	}

	protected void SetInvincibleDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetInvincibleDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Invincible);
		}
	}

	public void InterruptInvincible()
	{
		CommonUtils_MonsterAPI.InterruptInvincible(_actor);
	}

	protected void SetSearchedImmunityEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetSearchedImmunityEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.SearchedImmunity);
		}
	}

	protected void SetSearchedImmunityDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetSearchedImmunityDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.SearchedImmunity);
		}
	}

	public void InterruptSearchedImmunity()
	{
		CommonUtils_MonsterAPI.InterruptSearchedImmunity(_actor);
	}

	protected void SetCloseBlockEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetCloseBlockEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.CloseBlock);
		}
	}

	protected void SetCloseBlockDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetCloseBlockDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.CloseBlock);
		}
	}

	protected void InterruptCloseBlock()
	{
		CommonUtils_MonsterAPI.InterruptCloseBlock(_actor);
	}

	protected void SetHideModelEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetHideModelEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.HideMode);
		}
	}

	protected void SetHideModelDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetHideModelDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.HideMode);
		}
	}

	protected void InterruptHideModel()
	{
		CommonUtils_MonsterAPI.InterruptHideModel(_actor);
	}

	protected void SetSneakEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetSneakEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Sneak);
		}
	}

	protected void SetSneakDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetSneakDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Sneak);
		}
	}

	protected void InterruptSneak()
	{
		CommonUtils_MonsterAPI.InterruptSneak(_actor);
	}

	protected void SetHideOutEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetHideOutEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.HideOut);
		}
	}

	protected void SetHideOutDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetHideOutDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.HideOut);
		}
	}

	protected void InterruptHideOut()
	{
		CommonUtils_MonsterAPI.InterruptHideOut(_actor);
	}

	protected void SetBattleOutEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetBattleOutEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.BattleOut);
		}
	}

	protected void SetBattleOutDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetBattleOutDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.BattleOut);
		}
	}

	protected void InterruptBattleOut()
	{
		CommonUtils_MonsterAPI.InterruptBattleOut(_actor);
	}

	protected void SetUnparalleledEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.Unparalleled);
		}
	}

	protected void SetUnparalleledDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetUnparalleledDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.Unparalleled);
		}
	}

	protected void InterruptUnparalleled()
	{
		CommonUtils_MonsterAPI.InterruptUnparalleled(_actor);
	}

	protected void SetLockHpAbsEnable(bool isAbs, FP hp, bool autoDisableWhenSkillDisable = true)
	{
		if (isAbs)
		{
			CommonUtils_MonsterAPI.SetLockHpAbsEnable(_actor, hp.AsInt());
		}
		else
		{
			CommonUtils_MonsterAPI.SetLockHpPercentEnable(_actor, hp);
		}
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.LockHp);
		}
	}

	protected void SetLockHpDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetLockHpDisable(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.LockHp);
		}
	}

	protected void SetLockToughnessEnable(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetLockToughnessState(_actor as MonsterAdventureActor, iEnable: true);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.LockToughness);
		}
	}

	protected void SetLockToughnessDisable(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.SetLockToughnessState(_actor as MonsterAdventureActor, iEnable: false);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.LockToughness);
		}
	}

	protected void InterruptLockToughness()
	{
		CommonUtils_MonsterAPI.SetLockToughnessState(_actor as MonsterAdventureActor, iEnable: false);
	}

	protected void SetBlockPriorityToStatic(bool autoDisableWhenSkillDisable = true)
	{
		CommonUtils_MonsterAPI.SetBlockPriorityToStatic(_actor);
		if (autoDisableWhenSkillDisable)
		{
			EnableSpecialState(SpecialState.BlockPriorityToStatic);
		}
	}

	protected void ResetBlockPriority(bool resetCount = true)
	{
		CommonUtils_MonsterAPI.ResetBlockPriority(_actor);
		if (resetCount)
		{
			DisableSpecialState(SpecialState.BlockPriorityToStatic);
		}
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

	protected TSVector2 GetTSVector2(FP x, FP y)
	{
		return CommonUtils_MonsterAPI.GetTSVector2(x, y);
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

	protected void SendMessageToGroupController(long monsterId, string operationType)
	{
		AdventureMonsterToGroupControllerMessage adventureMonsterToGroupControllerMessage = AdventureMonsterToGroupControllerMessage.Generate();
		adventureMonsterToGroupControllerMessage.monsterId = monsterId;
		adventureMonsterToGroupControllerMessage.operationType = operationType;
		ModuleController<AdventureModuleController>.Instance?.DispatchEvent(adventureMonsterToGroupControllerMessage);
	}

	protected void SwitchPool(int index)
	{
		if (_poolBranchDict.TryGetValue(index, out var value))
		{
			_currentPoolBranchesInfo = value;
			_currentPoolBranchesInfo.ResetBranchCdExpireTime();
		}
		else
		{
			NovaLogger.Error(_actor.name + " 切换的行为池不存在，index:" + index);
		}
	}

	protected void SetPoolBranchActive(int id, bool active)
	{
		if (_currentPoolBranchesInfo?.braches == null || _currentPoolBranchesInfo.braches.Count == 0)
		{
			return;
		}
		foreach (PoolBranchInfo brach in _currentPoolBranchesInfo.braches)
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
		if (_currentPoolBranchesInfo?.braches == null || _currentPoolBranchesInfo.braches.Count == 0)
		{
			return;
		}
		foreach (PoolBranchInfo brach in _currentPoolBranchesInfo.braches)
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
		if (_currentPoolBranchesInfo?.braches == null || _currentPoolBranchesInfo.braches.Count == 0)
		{
			return fP;
		}
		foreach (PoolBranchInfo brach in _currentPoolBranchesInfo.braches)
		{
			if (brach.id == id)
			{
				fP = brach.branchCdExpireTime - _actor.LogicTime;
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
			NovaLogger.Error(_actor.name + " 切换的行为序列不存在，index:" + index);
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
			if (_currentSequences == null)
			{
				return 0;
			}
			return _currentSequences.Count - 1;
		}
		return _currentIndex;
	}

	protected void CastSkill(int skillId)
	{
		_skillFinish = false;
		ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
		{
			_skillFinish = true;
		}, (FP cd) =>
		{
			skillCDDict.set_Item(skillId, cd + _actor.LogicTime);
		});
	}

	protected bool CheckSkillOnCD(int skillId)
	{
		if (skillCDDict.TryGetValue(skillId, out var value) && _actor.LogicTime < value)
		{
			return true;
		}
		return false;
	}

	protected CoroutineNode WaitSkillFinish()
	{
		CoroutineNode coroutineNode = _actor.StartLogicCoroutine(WaitingSkillFinish());
		apiCoroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	private IEnumerator WaitingSkillFinish()
	{
		while (!_skillFinish)
		{
			yield return null;
		}
	}

	protected void SetMonsterListenEventActive(MonsterEventType type, bool active)
	{
		if (_monsterEventDict == null)
		{
			return;
		}
		if (!_monsterEventDict.TryGetValue(type, out var value))
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

	protected void ResetMonsterAI(int monsterAIId, bool interruptSkill)
	{
		_monsterAIIDForReset = monsterAIId;
		if (interruptSkill)
		{
			_actor.actorSkillManage.DestoryAllSkill();
			(_actor as MonsterAdventureActor)?.ResetPrimeFSMAI(monsterAIId);
		}
		else if (!_actor.actorSkillManage.HaveRunningSkill())
		{
			(_actor as MonsterAdventureActor)?.ResetPrimeFSMAI(monsterAIId);
		}
		else
		{
			StartCor(ref _waitingForSkillFinishNode, WaitingForSkillFinish());
		}
	}

	private IEnumerator WaitingForSkillFinish()
	{
		while (_actor.actorSkillManage.HaveRunningSkill())
		{
			yield return null;
		}
		(_actor as MonsterAdventureActor)?.ResetPrimeFSMAI(_monsterAIIDForReset);
	}

	protected CoroutineNode StartCor(IEnumerator enumerator)
	{
		CoroutineNode coroutineNode = StartCoroutine(enumerator);
		apiCoroutineNodeList.Add(coroutineNode);
		return coroutineNode;
	}

	protected void StartCor(ref CoroutineNode cor, IEnumerator enumerator)
	{
		if (cor != null)
		{
			StopCoroutine(cor);
		}
		cor = StartCoroutine(enumerator);
		apiCoroutineNodeList.Add(cor);
	}

	protected void StopCor(CoroutineNode cor)
	{
		if (cor != null)
		{
			StopCoroutine(cor);
			apiCoroutineNodeList.Remove(cor);
		}
	}

	protected void StopCor(ref CoroutineNode cor)
	{
		if (cor != null)
		{
			StopCoroutine(cor);
			apiCoroutineNodeList.Remove(cor);
			cor = null;
		}
	}

	protected void InterruptSkill()
	{
		_actor.actorSkillManage?.DestoryAllSkill();
	}

	protected void PlayWwiseSound(string _event, LogicEntity _owner = null)
	{
		CommonUtils_MonsterAPI.PlayWwiseSound(_actor, _event, _owner);
	}

	protected void TriggerOpLisener(string _triggerOpIDN)
	{
		CommonUtils_MonsterAPI.TriggerOpLisener(_triggerOpIDN);
	}

	protected bool MonsterInState(int state)
	{
		string[] array = _actor.logicVariable.GetLogicTagStringValue("Monster_In_State").Split(',');
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

	protected void DispatchCustomEvent(string eventName, bool isSelfEvent = true)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventName = eventName;
		if (isSelfEvent)
		{
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		}
	}

	protected void BossEnergyValueChage(int value, LogicEntity target)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("BossEnergyValueChange", target.Id, value);
	}

	protected void EnergyHudShow(bool isShow, long showId, int initValue, int initState)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("EnergyHudShow", isShow, showId, initValue, initState);
	}

	protected CoroutineNode WaitTime(FP waitSeconds)
	{
		return StartCoroutine(_actor.WaitForSeconds(waitSeconds));
	}

	protected CoroutineNode WaitFrame(int frameCount)
	{
		FP seconds = (float)frameCount * 0.033f;
		return StartCoroutine(_actor.WaitForSeconds(seconds));
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

	protected void ReplaceAnimationGroup(int index = 0)
	{
		_actor.ReplaceAnimationGroup(index);
	}

	protected void FireStateValueChange(int state)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("HotStateChange", _actor.Id, state);
	}

	protected void FireHotValueChange(int value)
	{
		MonoSingleton<LuaManager>.Instance?.FireEntityEvent("HotValueChange", _actor.Id, value);
	}

	protected void FireHudShow(bool isShow, long showId, int initValue, int initState)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("SpecialHudShow", isShow, showId, initValue, initState);
	}

	protected void ShowCenterHpBar()
	{
		if (_actor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.ShowCenterHpBar(isShow: true);
		}
	}

	protected void RefreshCenterHpBar()
	{
		ModuleController<AdventureModuleController>.Instance?.RefreshCenterHpBar();
	}

	protected void ShowBlood(bool isShow)
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			monsterAdventureActor.ShowBlood(isShow);
		}
	}

	protected void ChangeModelScale(bool setAbsValue = false, FP value = default(FP), FP duration = default(FP))
	{
		if (_changeModelScaleCor != null)
		{
			StopCor(_changeModelScaleCor);
		}
		FP modelScale = _actor.actorScaleInfo.modelScale;
		FP fP = ((!setAbsValue) ? (modelScale + value) : value);
		fP = ((fP >= 0) ? fP : ((FP)0));
		if (duration > 0)
		{
			_changeModelScaleCor = StartCor(ChangeModelScale(fP, duration));
		}
		else
		{
			_actor.actorScaleInfo.modelScale = fP;
		}
	}

	protected void TransformByModelName(string modelName, bool changeColliderScale = false, FP colliderScale = default(FP), bool changeAnimationGroup = false, int animationGroupIndex = 0)
	{
		_actor.ActiveVariantModelGroup(modelName);
		if (changeColliderScale)
		{
			_actor.actorScaleInfo.colliderScale = colliderScale;
		}
		if (changeAnimationGroup)
		{
			ReplaceAnimationGroup(animationGroupIndex);
		}
	}

	protected void ReturnToDefaultModel()
	{
		_actor.ActiveDefaultModelGroup();
		_actor.actorScaleInfo.colliderScale = _actor.actorScaleInfo.originColliderScale;
		_actor.ResumeAnimationGroup();
	}

	protected void SetStrengthOverride(FP overrideValue)
	{
		_actor.strengthOverride = overrideValue;
	}

	protected bool AreaCheckObstacle(DeterministicShape shape, bool checkHeight = false, HeightClass heightClass = HeightClass.Medium)
	{
		return CommonUtils_MonsterAPI.AreaCheckObstacle(shape, checkHeight, heightClass);
	}

	protected bool IsAttackTargetInArea(DeterministicShape shape)
	{
		return CommonUtils_MonsterAPI.IsAttackTargetInArea(_actor, shape);
	}

	protected bool CheckTargetIsValid(LogicEntity target)
	{
		return CommonUtils_MonsterAPI.CheckTargetIsValid(target);
	}

	protected bool AreaCheckMonsterTarget(DeterministicShape shape)
	{
		return CommonUtils_MonsterAPI.AreaCheckMonsterTarget(_actor, shape);
	}

	protected bool CheckBossTag(LogicEntity target, string tag)
	{
		if (target is MonsterAdventureActor monsterAdventureActor)
		{
			return monsterAdventureActor.CheckTag(tag);
		}
		return false;
	}

	protected long GetTargetID(LogicEntity actor = null)
	{
		return CommonUtils_MonsterAPI.GetTargetID(actor);
	}

	[Obsolete("请使用GetEntityPosition(LogicEntity entity)")]
	protected TSVector2 GetEntityPositionObsoleted(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityPosition(entity);
	}

	protected TSVector2 GetEntityPosition(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityPosition(entity, _actor);
	}

	protected TSVector2 GetEntityForward(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityForward(entity);
	}

	protected FP GetEntityAngle(LogicEntity entity)
	{
		return CommonUtils_MonsterAPI.GetEntityAngle(entity);
	}

	protected FP GetRotSpdInSkill()
	{
		return CommonUtils_MonsterAPI.GetRotSpdInSkill(_actor);
	}

	protected TSVector2 GetPosition()
	{
		return CommonUtils_MonsterAPI.GetPosition(_actor);
	}

	protected TSVector2 GetForward()
	{
		return CommonUtils_MonsterAPI.GetForward(_actor);
	}

	protected FP GetRotation()
	{
		return CommonUtils_MonsterAPI.GetRotation(_actor);
	}

	protected LogicEntity GetCurrentPlayer()
	{
		return CommonUtils_MonsterAPI.GetCurrentPlayer();
	}

	protected int GetMonsterSummonNum(LogicEntity actor, int monsterID = -1, bool iAlive = true)
	{
		return CommonUtils_MonsterAPI.GetMonsterSummonNum(actor, monsterID, iAlive);
	}

	protected FP GetDistanceWithTarget(bool calcDistanceWithoutEntityRadius)
	{
		return CommonUtils_MonsterAPI.GetDistanceWithTarget(_actor, calcDistanceWithoutEntityRadius);
	}

	protected LogicEntity GetAttackTarget(bool isUpToDate = false)
	{
		return CommonUtils_MonsterAPI.GetAttackTarget(_actor, isUpToDate);
	}

	protected LogicEntity GetAttackTargetWithOwnerTauntFrom(long ownerId)
	{
		return CommonUtils_MonsterAPI.GetAttackTargetWithOwnerTauntFrom(ownerId);
	}

	protected FP CalcAngleBetweenSelfAndAttackTarget(bool isSingleAngle = false)
	{
		return CommonUtils_MonsterAPI.CalcAngleBetweenSelfAndAttackTarget(_actor, isSingleAngle);
	}

	protected TSVector2 GetPlaceHolderPosition(string name)
	{
		return CommonUtils_MonsterAPI.GetPlaceHolderPosition(name);
	}

	protected int GetMonsterSummonNumWithTeammateIndex(LogicEntity actor, int teammateIndex = -1, bool iAlive = true)
	{
		int monsterID = teammateIndex;
		if (teammateIndex != -1)
		{
			monsterID = GetTeammateIdByIndex(teammateIndex);
		}
		return CommonUtils_MonsterAPI.GetMonsterSummonNum(actor, monsterID, iAlive);
	}

	protected int GetTeammateIdByIndex(int index)
	{
		return CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, index);
	}

	protected int GetPlayerJobType(AdventureActor player)
	{
		if (player is PlayerAdventureActor)
		{
			return (int)player.actorInfo.attackType;
		}
		return 0;
	}

	protected string GetMonsterTagValue(AdventureActor actor, int tagIndex)
	{
		if (actor is MonsterAdventureActor monsterAdventureActor)
		{
			return tagIndex switch
			{
				1 => monsterAdventureActor.monsterInfo.Tag1, 
				2 => monsterAdventureActor.monsterInfo.Tag2, 
				3 => monsterAdventureActor.monsterInfo.Tag3, 
				4 => monsterAdventureActor.monsterInfo.Tag4, 
				5 => monsterAdventureActor.monsterInfo.Tag5, 
				_ => "", 
			};
		}
		return "";
	}

	protected bool EntityInSkill(LogicEntity entity = null, int skillId = 0)
	{
		return CommonUtils_MonsterAPI.EntityInSkill((entity != null) ? entity : _actor, skillId);
	}

	protected List<LogicEntity> GetTargetsByLogicTag(LogicTagType logicType, string logicStr, List<LogicEntity> entities = null, bool value1 = false, FP value2 = default(FP), string value3 = null, TSVector2 value4 = default(TSVector2))
	{
		return CommonUtils_MonsterAPI.GetTargetByLogicTag(logicType, logicStr, entities, value1, value2, value3, value4);
	}

	protected List<LogicEntity> GetTargetsFromShape(DeterministicShape shape, List<LogicEntity> entities = null, bool includeSelf = false, LogicEntity targetEntity = null)
	{
		return CommonUtils_MonsterAPI.GetTargetsFromShape(_actor, shape, entities, includeSelf, targetEntity);
	}

	protected LogicEntity GetTargetNearOrFar(bool iNear, List<LogicEntity> entities)
	{
		return CommonUtils_MonsterAPI.GetTargetNearOrFar(_actor, iNear, entities);
	}

	protected List<LogicEntity> GetTargetsByFaction(bool isFriend)
	{
		return CommonUtils_MonsterAPI.GetTargetsByFaction(_actor, isFriend);
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

	protected List<LogicEntity> GetTargetByTeammateIndex(int index, List<LogicEntity> entities = null)
	{
		int dataID = 0;
		if (_actor != null && _actor is MonsterAdventureActor monsterAdventureActor)
		{
			dataID = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, index);
		}
		return GetTargetByDataID(dataID, entities);
	}

	protected List<LogicEntity> GetTargetByTeammateIndexes(List<int> indexes, List<LogicEntity> entities = null)
	{
		if (summonMonsterIds == null)
		{
			summonMonsterIds = new List<int>();
		}
		summonMonsterIds.Clear();
		if (_actor != null && _actor is MonsterAdventureActor monsterAdventureActor)
		{
			for (int i = 0; i < indexes.Count; i++)
			{
				int monsterTeammateId = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, indexes.get_Item(i));
				if (monsterTeammateId > 0)
				{
					summonMonsterIds.Add(monsterTeammateId);
				}
			}
		}
		return CommonUtils_MonsterAPI.GetTargetByDataIDs(summonMonsterIds, entities);
	}

	public void OnEnable()
	{
		_currentPoolBranchesInfo?.ResetBranchCdExpireTime();
		OnActionEnable();
	}

	protected virtual void OnActionEnable()
	{
	}

	public void OnDisable()
	{
		OnActionDisable();
	}

	protected virtual void OnActionDisable()
	{
	}

	public void OnSpecialEnable()
	{
		NovaLogger.Debug("MonsterActionBase OnSpecialEnable");
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TARGET_CHANGED", OnMonsterTargetChange);
		SetListenEvents();
		SetConfig();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_SWITCH_CUSTOM_STATE", OnSwitchState);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_MONSTER_ID_AILIST", GetMonsterAIInfo);
	}

	public void OnSpecialDisable()
	{
		NovaLogger.Debug("MonsterActionBase OnSpecialDisable");
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TARGET_CHANGED", OnMonsterTargetChange);
		_lookAtTarget?.Clear();
		_traceTarget?.Clear();
		skillCDDict.Clear();
		if (_monsterAIType == MonsterAIType.POOL)
		{
			_poolBranchDict.Clear();
			_currentPoolBranchesInfo = null;
		}
		else if (_monsterAIType == MonsterAIType.SEQUENCE)
		{
			_currentIndex = 0;
			_sequenceDict.Clear();
			_sequenceBranchDict.Clear();
			_currentSequences.Clear();
			_currentSequences = null;
		}
		RemoveListenEvents();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_SWITCH_CUSTOM_STATE", OnSwitchState);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_MONSTER_ID_AILIST", GetMonsterAIInfo);
		_inSwitchStateProtect = false;
	}

	public void OnStart()
	{
		if (_monsterAIType == MonsterAIType.POOL)
		{
			StartCheckQualifiedPoolBranchCoroutine();
		}
		else if (_monsterAIType == MonsterAIType.SEQUENCE)
		{
			StartCheckQualifiedSequenceBranchCoroutine();
		}
		OnActionStart();
	}

	protected virtual void OnActionStart()
	{
	}

	public void OnStop()
	{
		EndCheckQualifiedPoolBranchCoroutine();
		EndCheckQualifiedSequenceBranchCoroutine();
		EndWaitingOperateCoroutine();
		EndOperateCoroutine();
		EndCheckTraceInterruptCoroutine();
		foreach (CoroutineNode apiCoroutineNode in apiCoroutineNodeList)
		{
			StopCoroutine(apiCoroutineNode);
		}
		apiCoroutineNodeList.Clear();
		_branchRunning = false;
		_executeBranch = null;
		_traceTarget?.CancelTrace();
		_lookAtTarget?.StopLookAt();
		if (_inSwitchStateProtect)
		{
			_inSwitchStateProtect = false;
			_actor.DisableImmuneControl();
			(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
		}
		EndProcessBranchCdByConfig();
		OnActionStop();
		ClearSpecialState();
	}

	protected virtual void OnActionStop()
	{
	}

	private void OnSwitchState(IEvent evt)
	{
		if (evt == null)
		{
			return;
		}
		AdventureMonsterSwitchCustomStateEvent adventureMonsterSwitchCustomStateEvent = (AdventureMonsterSwitchCustomStateEvent)evt;
		if (evt.sender as AdventureActor != _actor)
		{
			return;
		}
		if (adventureMonsterSwitchCustomStateEvent.commonHandle)
		{
			if (_branchRunning)
			{
				if (adventureMonsterSwitchCustomStateEvent.breakCurrentAction)
				{
					_actor.actorSkillManage.DestoryAllSkill();
					EndWaitingOperateCoroutine();
					EndOperateCoroutine();
					_branchRunning = false;
					_executeBranch = null;
				}
				else if (!_inSwitchStateProtect)
				{
					_inSwitchStateProtect = true;
					_actor.EnableImmuneControl();
					(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = true;
				}
			}
			else
			{
				_traceTarget?.CancelTrace();
				_lookAtTarget?.StopLookAt();
			}
		}
		if (adventureMonsterSwitchCustomStateEvent.customHandle)
		{
			OnHandleCustomSwitchState();
		}
	}

	protected virtual void OnHandleCustomSwitchState()
	{
	}

	private void OnMonsterTargetChange(IEvent evt)
	{
		if (evt is AdventureMonsterTargetChangedEvent adventureMonsterTargetChangedEvent && adventureMonsterTargetChangedEvent.sender as AdventureActor == _actor && _executeBranch != null && !_branchRunning)
		{
			_traceTarget?.CancelTrace();
			_lookAtTarget?.StopLookAt();
		}
	}

	protected virtual void SetConfig()
	{
	}

	private void StartCheckTraceInterruptCoroutine(BaseBranchInfo branchInfo)
	{
		OnStartTrace();
		if (branchInfo.finishTraceConditionFunc != null)
		{
			_checkTraceInterruptCoroutine = _actor.StartLogicCoroutine(CheckTraceInterrupt(branchInfo), runImmediately: true);
		}
	}

	protected virtual void OnStartTrace()
	{
	}

	private void EndCheckTraceInterruptCoroutine()
	{
		if (_checkTraceInterruptCoroutine != null)
		{
			_actor.StopLogicCoroutine(_checkTraceInterruptCoroutine);
			_checkTraceInterruptCoroutine = null;
		}
	}

	private IEnumerator CheckTraceInterrupt(BaseBranchInfo branchInfo)
	{
		while (true)
		{
			if (branchInfo.finishTraceConditionFunc())
			{
				_traceTarget?.CancelTrace(isDie: false, isInterrupt: true);
			}
			yield return null;
		}
	}

	protected void StartWaitingOperateCoroutine(BaseBranchInfo branchInfo)
	{
		EndWaitingOperateCoroutine();
		_waitingOperateCoroutine = _actor.StartLogicCoroutine(OperateBranch(branchInfo), runImmediately: true);
	}

	protected void EndWaitingOperateCoroutine()
	{
		if (_waitingOperateCoroutine != null)
		{
			_actor.StopLogicCoroutine(_waitingOperateCoroutine);
			_waitingOperateCoroutine = null;
		}
	}

	private IEnumerator OperateBranch(BaseBranchInfo branchInfo)
	{
		if (branchInfo.operateIEnumerator != null)
		{
			_branchRunning = true;
			if (branchInfo is PoolBranchInfo poolBranchInfo)
			{
				StartProcessBranchCdByConfig(poolBranchInfo);
			}
			if (_monsterAIType == MonsterAIType.SEQUENCE)
			{
				SequenceBranchOperateComplete();
			}
			yield return StartOperateCoroutine(branchInfo);
			EndProcessBranchCdByConfig();
			_branchRunning = false;
			_executeBranch = null;
			branchInfo.operateCompleteCallback?.Invoke();
			OnSequenceBranchOperateComplete(_currentSeqIndex, _currentIndex, _currentIndex == 0);
			if (_inSwitchStateProtect)
			{
				_inSwitchStateProtect = false;
				_actor.DisableImmuneControl();
				(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
			}
		}
		else
		{
			_executeBranch = null;
			branchInfo.operateCompleteCallback?.Invoke();
		}
	}

	private void StartProcessBranchCdByConfig(PoolBranchInfo poolBranchInfo)
	{
		if (poolBranchInfo.startCdTime == 0 || poolBranchInfo.startCdTime == default(FP))
		{
			poolBranchInfo.SetBranchCdExpireTime(poolBranchInfo.cd);
		}
		else
		{
			_setBranchCdByConfigCoroutine = _actor.StartLogicCoroutine(ProcessBranchCdByConfig(poolBranchInfo));
		}
	}

	private void EndProcessBranchCdByConfig()
	{
		if (_setBranchCdByConfigCoroutine != null)
		{
			_actor.StopLogicCoroutine(_setBranchCdByConfigCoroutine);
			_setBranchCdByConfigCoroutine = null;
		}
	}

	private IEnumerator ProcessBranchCdByConfig(PoolBranchInfo poolBranchInfo)
	{
		FP currentTime = 0;
		while (true)
		{
			currentTime += _actor.LogicDeltaTime;
			if (currentTime >= poolBranchInfo.startCdTime)
			{
				break;
			}
			yield return null;
		}
		poolBranchInfo.SetBranchCdExpireTime(poolBranchInfo.cd);
	}

	private CoroutineNode StartOperateCoroutine(BaseBranchInfo branchInfo)
	{
		EndOperateCoroutine();
		_operateCoroutine = _actor.StartLogicCoroutine(branchInfo.operateIEnumerator(), runImmediately: true);
		return _operateCoroutine;
	}

	private void EndOperateCoroutine()
	{
		if (_operateCoroutine != null)
		{
			if (!_operateCoroutine.finished && _executeBranch != null)
			{
				_executeBranch.operateInterruptCallback?.Invoke();
			}
			_actor.StopLogicCoroutine(_operateCoroutine);
			_operateCoroutine = null;
		}
	}

	private IEnumerator ChangeModelScale(FP targetValue, FP duration)
	{
		if (duration <= 0)
		{
			_actor.actorScaleInfo.modelScale = targetValue;
			yield break;
		}
		FP fP = targetValue - _actor.actorScaleInfo.modelScale;
		FP changeSpeed = fP / duration;
		while (duration > 0)
		{
			_actor.actorScaleInfo.modelScale += changeSpeed * _actor.LogicDeltaTime;
			duration -= _actor.LogicDeltaTime;
			yield return null;
		}
		_actor.actorScaleInfo.modelScale = targetValue;
	}

	protected void InitPoolBranches(int defaultPoolIndex, List<PoolBranchesInfo> poolBranches)
	{
		if (poolBranches == null || poolBranches.Count == 0)
		{
			NovaLogger.Error(_actor.name + " 请配置行为池！");
			return;
		}
		foreach (PoolBranchesInfo poolBranch in poolBranches)
		{
			poolBranch.braches = poolBranch.braches.OrderByDescending((PoolBranchInfo item) => item.priority).ToList();
			_poolBranchDict.set_Item(poolBranch.index, poolBranch);
			if (poolBranch.index == defaultPoolIndex)
			{
				_currentPoolBranchesInfo = poolBranch;
			}
		}
		if (_currentPoolBranchesInfo == null)
		{
			NovaLogger.Error(_actor.name + " 初始行为池不存在，index:" + defaultPoolIndex);
		}
	}

	protected PoolBranchInfo CheckQualifiedPoolBranchInfo()
	{
		if (_currentPoolBranchesInfo == null || _currentPoolBranchesInfo.braches.Count == 0)
		{
			return null;
		}
		PoolBranchInfo result = null;
		foreach (PoolBranchInfo brach in _currentPoolBranchesInfo.braches)
		{
			if (!brach.active)
			{
				continue;
			}
			FP fP = brach.branchCdExpireTime - _actor.LogicTime;
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
		_checkQualifiedPoolBranchCoroutine = _actor.StartLogicCoroutine(CheckQualifiedPoolBranch(), runImmediately: true);
	}

	private void EndCheckQualifiedPoolBranchCoroutine()
	{
		if (_checkQualifiedPoolBranchCoroutine != null)
		{
			_actor.StopLogicCoroutine(_checkQualifiedPoolBranchCoroutine);
			_checkQualifiedPoolBranchCoroutine = null;
		}
	}

	protected virtual IEnumerator CheckQualifiedPoolBranch()
	{
		if (_delayStartTime > 0)
		{
			yield return WaitTime(_delayStartTime);
		}
		while (true)
		{
			while (_branchRunning)
			{
				LogicVariable logicVariable = _actor.logicVariable;
				if (logicVariable == null || logicVariable.GetLogicTagToggle("ExecutingCanBreakBranch"))
				{
					break;
				}
				yield return null;
			}
			if (_executeBranch == null)
			{
				MonsterActionBase monsterActionBase = this;
				LogicEntity logicEntity = (_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget());
				monsterActionBase.target = logicEntity;
				if (target == null)
				{
					break;
				}
			}
			FP fP = _actor.DistanceWithRadius(target);
			PoolBranchInfo qualifiedBranch = CheckQualifiedPoolBranchInfo();
			if (qualifiedBranch != null && qualifiedBranch != _executeBranch && ((_executeBranch != null && qualifiedBranch.priority > (_executeBranch as PoolBranchInfo).priority) || _executeBranch == null))
			{
				if (_actor.logicVariable?.GetLogicTagToggle("ExecutingCanBreakBranch") ?? false)
				{
					EndWaitingOperateCoroutine();
					EndOperateCoroutine();
					_actor.actorSkillManage.DestoryAllSkill();
					_branchRunning = false;
					if (_inSwitchStateProtect)
					{
						_inSwitchStateProtect = false;
						_actor.DisableImmuneControl();
						(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
					}
					_actor.logicVariable?.ToggleLogicTag("ExecutingCanBreakBranch", value: false);
				}
				_traceTarget?.CancelTrace();
				_lookAtTarget?.StopLookAt();
				_executeBranch = qualifiedBranch;
				if (_actor.actorInfo.moveType == HotfixEnum.actorMovType.STATIC || fP <= qualifiedBranch.releaseDistance)
				{
					if (_actor.actorInfo.moveType != HotfixEnum.actorMovType.STATIC)
					{
						TSVector2 a = target.tsTransform.Position - _actor.tsTransform.Position;
						TSVector2 forward = _actor.tsTransform.Forward;
						if (TSVector2.Angle(a, forward) > qualifiedBranch.releaseAngle)
						{
							if (_lookAtTarget == null)
							{
								_lookAtTarget = new LookAtTarget();
							}
							_lookAtTarget.BeginLookAt(_actor, target, 0, 0, () =>
							{
								StartWaitingOperateCoroutine(qualifiedBranch);
							}, ignoreActorTimeScale: false, () =>
							{
								_executeBranch = null;
							});
						}
						else
						{
							StartWaitingOperateCoroutine(qualifiedBranch);
						}
					}
					else
					{
						StartWaitingOperateCoroutine(qualifiedBranch);
					}
				}
				else
				{
					if (_traceTarget == null)
					{
						_traceTarget = new TraceTarget();
					}
					StartCheckTraceInterruptCoroutine(qualifiedBranch);
					_traceTarget.BeginTrace(_actor, target, qualifiedBranch.releaseDistance, -1, qualifiedBranch.traceDuration, () =>
					{
						EndCheckTraceInterruptCoroutine();
						StartWaitingOperateCoroutine(qualifiedBranch);
					}, (bool isdie, bool isInterrupt, bool _, bool _) =>
					{
						EndCheckTraceInterruptCoroutine();
						if (isInterrupt)
						{
							StartWaitingOperateCoroutine(qualifiedBranch);
						}
						else
						{
							_executeBranch = null;
						}
					});
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
		}
		_actor.Idle();
	}

	protected void InitSequenceBranches(int defaultSequenceIndex, List<BaseBranchInfo> sequenceBranches, Dictionary<int, List<int>> sequenceDict)
	{
		if (sequenceDict == null || sequenceDict.Count == 0)
		{
			NovaLogger.Error(_actor.name + " 请配置行为序列！");
			return;
		}
		if (sequenceBranches == null || sequenceBranches.Count == 0)
		{
			NovaLogger.Error(_actor.name + " 请配置行为序列内容！");
			return;
		}
		foreach (BaseBranchInfo sequenceBranch in sequenceBranches)
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
			NovaLogger.Error(_actor.name + " 初始行为序列不存在，index:" + defaultSequenceIndex);
		}
		_currentIndex = 0;
		_sequenceDict = sequenceDict;
	}

	protected BaseBranchInfo GetSequenceBranchInfo()
	{
		BaseBranchInfo result = null;
		if (_currentSequences != null && _currentSequences.Count > 0)
		{
			int key = _currentSequences.get_Item(_currentIndex);
			if (_sequenceBranchDict.TryGetValue(key, out var value))
			{
				result = value;
			}
			else
			{
				NovaLogger.Error(_actor.name + " 行为id不存在！branchId:" + key);
			}
		}
		else
		{
			NovaLogger.Error(_actor.name + " 行为序列为空！");
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
		_checkQualifiedSequenceBranchCoroutine = _actor.StartLogicCoroutine(CheckQualifiedSequenceBranch(), runImmediately: true);
	}

	private void EndCheckQualifiedSequenceBranchCoroutine()
	{
		if (_checkQualifiedSequenceBranchCoroutine != null)
		{
			_actor.StopLogicCoroutine(_checkQualifiedSequenceBranchCoroutine);
			_checkQualifiedSequenceBranchCoroutine = null;
		}
	}

	protected virtual IEnumerator CheckQualifiedSequenceBranch()
	{
		if (_delayStartTime > 0)
		{
			yield return WaitTime(_delayStartTime);
		}
		while (true)
		{
			while (_executeBranch != null)
			{
				yield return null;
			}
			NovaLogger.Debug("monsterAIAction 开始筛选ai分支");
			MonsterActionBase monsterActionBase = this;
			LogicEntity logicEntity = (_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget());
			monsterActionBase.target = logicEntity;
			if (target == null)
			{
				break;
			}
			FP fP = _actor.DistanceWithRadius(target);
			BaseBranchInfo qualifiedBranch = GetSequenceBranchInfo();
			if (qualifiedBranch != null)
			{
				NovaLogger.Debug("monsterAIAction " + _actor.name + " 筛选ai分支成功 " + qualifiedBranch.id);
				_executeBranch = qualifiedBranch;
				if (_actor.actorInfo.moveType == HotfixEnum.actorMovType.STATIC || fP <= qualifiedBranch.releaseDistance)
				{
					if (_actor.actorInfo.moveType != HotfixEnum.actorMovType.STATIC)
					{
						TSVector2 a = target.tsTransform.Position - _actor.tsTransform.Position;
						TSVector2 forward = _actor.tsTransform.Forward;
						if (TSVector2.Angle(a, forward) > qualifiedBranch.releaseAngle)
						{
							if (_lookAtTarget == null)
							{
								_lookAtTarget = new LookAtTarget();
							}
							_lookAtTarget.BeginLookAt(_actor, target, 0, 0, () =>
							{
								NovaLogger.Debug("monsterAIAction 转向目标完成");
								StartWaitingOperateCoroutine(qualifiedBranch);
							}, ignoreActorTimeScale: false, () =>
							{
								NovaLogger.Debug("monsterAIAction 转向被中断");
								_executeBranch = null;
							});
						}
						else
						{
							StartWaitingOperateCoroutine(qualifiedBranch);
						}
					}
					else
					{
						StartWaitingOperateCoroutine(qualifiedBranch);
					}
				}
				else
				{
					if (_traceTarget == null)
					{
						_traceTarget = new TraceTarget();
					}
					StartCheckTraceInterruptCoroutine(qualifiedBranch);
					_traceTarget.BeginTrace(_actor, target, qualifiedBranch.releaseDistance, -1, qualifiedBranch.traceDuration, () =>
					{
						EndCheckTraceInterruptCoroutine();
						StartWaitingOperateCoroutine(qualifiedBranch);
					}, (bool isdie, bool isInterrupt, bool isTimeout, bool isDistanceOut) =>
					{
						EndCheckTraceInterruptCoroutine();
						if (isInterrupt | isTimeout)
						{
							StartWaitingOperateCoroutine(qualifiedBranch);
						}
						else
						{
							_executeBranch = null;
						}
					});
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
		}
		_actor.Idle();
		NovaLogger.Debug("monsterAIAction 无目标");
	}

	protected virtual void OnSequenceBranchOperateComplete(int curSeqIndex, int curBranchIndex, bool isSeqEnd)
	{
	}

	public void GetMonsterAIInfo(IEvent evt)
	{
		if (evt == null || ((AdventureMonsterIDAIListEvent)evt).monsterId != _actor.Id)
		{
			return;
		}
		AdventureActorAIListInfoEvent adventureActorAIListInfoEvent = AdventureActorAIListInfoEvent.Generate();
		adventureActorAIListInfoEvent.monsterId = _actor.Id;
		if (_monsterAIType == MonsterAIType.SEQUENCE)
		{
			adventureActorAIListInfoEvent.sequenceDict = _sequenceDict;
		}
		else
		{
			Dictionary<int, List<Dictionary<int, bool>>> dictionary = new Dictionary<int, List<Dictionary<int, bool>>>();
			foreach (KeyValuePair<int, PoolBranchesInfo> item in _poolBranchDict)
			{
				List<Dictionary<int, bool>> list = new List<Dictionary<int, bool>>();
				for (int i = 0; i < item.Value.braches.Count; i++)
				{
					Dictionary<int, bool> dictionary2 = new Dictionary<int, bool>();
					dictionary2.set_Item(item.Value.braches.get_Item(i).id, item.Value.braches.get_Item(i).active);
					list.Add(dictionary2);
				}
				dictionary.set_Item(item.Value.index, list);
			}
			adventureActorAIListInfoEvent.poolBranchDict = dictionary;
		}
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorAIListInfoEvent);
	}

	protected virtual void SetListenEvents()
	{
	}

	protected void InitListenEvent(MonsterEventType type, bool active, Action<IEvent> operation)
	{
		if (_monsterEventDict == null)
		{
			_monsterEventDict = new Dictionary<MonsterEventType, MonsterEventParams>();
		}
		if (!_monsterEventDict.ContainsKey(type))
		{
			_monsterEventDict.set_Item(type, new MonsterEventParams(type, active, operation));
			if (active)
			{
				AddListenEvent(_monsterEventDict.get_Item(type));
			}
		}
	}

	protected void InitListenEvent(MonsterEventType type, bool active, Action<IEvent> operation, params int[] eventParams)
	{
		if (_monsterEventDict == null)
		{
			_monsterEventDict = new Dictionary<MonsterEventType, MonsterEventParams>();
		}
		if (!_monsterEventDict.ContainsKey(type))
		{
			_monsterEventDict.set_Item(type, new MonsterEventParams(type, active, operation, eventParams.ToList()));
			if (active)
			{
				AddListenEvent(_monsterEventDict.get_Item(type));
			}
		}
	}

	protected void InitListenEvent(MonsterEventType type, bool active, Action<IEvent> operation, params string[] eventParams)
	{
		if (_monsterEventDict == null)
		{
			_monsterEventDict = new Dictionary<MonsterEventType, MonsterEventParams>();
		}
		if (!_monsterEventDict.ContainsKey(type))
		{
			MonsterEventParams value = new MonsterEventParams(type, active, operation, eventParams.ToList());
			_monsterEventDict.set_Item(type, value);
			if (active)
			{
				AddListenEvent(_monsterEventDict.get_Item(type));
			}
		}
	}

	private void AddListenEvent(MonsterEventParams eventParams)
	{
		if (eventParams.type == MonsterEventType.SelfReceiveDamage)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
		else if (eventParams.type == MonsterEventType.MonsterDie)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		}
		else if (eventParams.type == MonsterEventType.MonsterSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_ENTER_BATTLE", OnMonsterSpawnFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfLostControl)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnMonsterBeControlled);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_BORN", OnBulletSpawn);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletFinish)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfToughnessBroken)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		}
		else if (eventParams.type == MonsterEventType.SelfHpChanged)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		else if (eventParams.type == MonsterEventType.DamageToOthers)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		else if (eventParams.type == MonsterEventType.BattleLevelChange)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChanged);
		}
		else if (eventParams.type == MonsterEventType.CustomEvent || eventParams.type == MonsterEventType.CustomEventOnlySelfOrSummoner)
		{
			AddCustomEventListen();
		}
		else if (eventParams.type == MonsterEventType.GroupController)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("GROUPCONTROLLER_TO_MONSTER_MESSAGE", OnReceiveGroupControllerMessage);
		}
	}

	private void RemoveListenEvent(MonsterEventParams eventParams)
	{
		if (eventParams.type == MonsterEventType.SelfReceiveDamage)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
		else if (eventParams.type == MonsterEventType.MonsterDie)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDie);
		}
		else if (eventParams.type == MonsterEventType.MonsterSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ENTER_BATTLE", OnMonsterSpawnFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfLostControl)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnMonsterBeControlled);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletSpawn)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletSpawn);
		}
		else if (eventParams.type == MonsterEventType.SelfBulletFinish)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		}
		else if (eventParams.type == MonsterEventType.SelfToughnessBroken)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		}
		else if (eventParams.type == MonsterEventType.SelfHpChanged)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChange);
		}
		else if (eventParams.type == MonsterEventType.DamageToOthers)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
		else if (eventParams.type == MonsterEventType.BattleLevelChange)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_BATTLELEVEL_CHANGED", OnBattleLevelChanged);
		}
		else if (eventParams.type == MonsterEventType.CustomEvent || eventParams.type == MonsterEventType.CustomEventOnlySelfOrSummoner)
		{
			RemoveCustomEventListen();
		}
		else if (eventParams.type == MonsterEventType.GroupController)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("GROUPCONTROLLER_TO_MONSTER_MESSAGE", OnReceiveGroupControllerMessage);
		}
	}

	private void AddCustomEventListen()
	{
		_customEventListenReferenceCount++;
		if (_customEventListenReferenceCount == 1)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		}
	}

	private void RemoveCustomEventListen()
	{
		_customEventListenReferenceCount--;
		if (_customEventListenReferenceCount == 0)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		}
	}

	private void RemoveListenEvents()
	{
		if (_monsterEventDict == null)
		{
			return;
		}
		foreach (MonsterEventParams value in _monsterEventDict.Values)
		{
			if (value.active)
			{
				RemoveListenEvent(value);
			}
		}
		_monsterEventDict.Clear();
		_customEventListenReferenceCount = 0;
	}

	private void OnReceiveDamage(IEvent iEvt)
	{
		if (iEvt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.to.Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfReceiveDamage).operation?.Invoke(iEvt);
		}
	}

	private void OnDamage(IEvent iEvt)
	{
		if (iEvt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.from.Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.DamageToOthers).operation?.Invoke(iEvt);
		}
	}

	private void OnMonsterDie(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterDiedEvent adventureMonsterDiedEvent)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.MonsterDie);
			if (monsterEventParams.intParams != null && monsterEventParams.intParams.Contains(adventureMonsterDiedEvent.monsterID))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnMonsterSpawnFinish(IEvent iEvt)
	{
		if (iEvt is AdventureActorEnterBattle adventureActorEnterBattle)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.MonsterSpawn);
			if (monsterEventParams.intParams != null && monsterEventParams.intParams.Contains((adventureActorEnterBattle.sender as AdventureActor).dataID))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnMonsterBeControlled(IEvent iEvt)
	{
		if (iEvt is AdventureActorBeControlledEvent adventureActorBeControlledEvent && adventureActorBeControlledEvent.actor.Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfLostControl).operation?.Invoke(iEvt);
		}
	}

	private void OnBulletSpawn(IEvent iEvt)
	{
		if (iEvt is AdventureBulletBornEvent adventureBulletBornEvent && adventureBulletBornEvent.owner.Id == _actor.Id)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.SelfBulletSpawn);
			if (monsterEventParams.stringParams.Contains(adventureBulletBornEvent.tag))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnBulletFinish(IEvent iEvt)
	{
		if (iEvt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.owner.Id == _actor.Id)
		{
			MonsterEventParams monsterEventParams = _monsterEventDict.get_Item(MonsterEventType.SelfBulletFinish);
			if (monsterEventParams.stringParams.Contains(adventureBulletFinishEvent.tag))
			{
				monsterEventParams.operation?.Invoke(iEvt);
			}
		}
	}

	private void OnToughnessStateChange(IEvent iEvt)
	{
		if (iEvt is MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent && monsterToughnessStateChangeEvent.actor.Id == _actor.Id && monsterToughnessStateChangeEvent.isToughnessBroken)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfToughnessBroken).operation?.Invoke(iEvt);
		}
	}

	private void OnHpChange(IEvent iEvt)
	{
		if (iEvt is AdventureActorHpChangedEvent adventureActorHpChangedEvent && (adventureActorHpChangedEvent.sender as AdventureActor).Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.SelfHpChanged).operation?.Invoke(iEvt);
		}
	}

	private void OnBattleLevelChanged(IEvent iEvt)
	{
		if (iEvt is AdventureMonsterBattleLevelChangedEvent adventureMonsterBattleLevelChangedEvent && (adventureMonsterBattleLevelChangedEvent.sender as AdventureActor).Id == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.BattleLevelChange).operation?.Invoke(iEvt);
		}
	}

	private void OnCustomEvent(IEvent iEvt)
	{
		if (!(iEvt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		if (_monsterEventDict.TryGetValue(MonsterEventType.CustomEvent, out var value))
		{
			value.operation?.Invoke(iEvt);
		}
		if (!_monsterEventDict.TryGetValue(MonsterEventType.CustomEventOnlySelfOrSummoner, out value))
		{
			return;
		}
		long summonActorId = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActorId;
		AdventureActor adventureActor = adventureActorCustomEvent.sender as AdventureActor;
		if (adventureActor == _actor)
		{
			value.operation?.Invoke(iEvt);
		}
		else if (adventureActor is MonsterAdventureActor monsterAdventureActor)
		{
			if (monsterAdventureActor.Id == summonActorId)
			{
				value.operation?.Invoke(iEvt);
			}
		}
		else if (adventureActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.Id == summonActorId)
		{
			value.operation?.Invoke(iEvt);
		}
	}

	private void OnReceiveGroupControllerMessage(IEvent iEvt)
	{
		if (iEvt is AdventureGroupControllerToMonsterMessage adventureGroupControllerToMonsterMessage && adventureGroupControllerToMonsterMessage.monsterId == _actor.Id)
		{
			_monsterEventDict.get_Item(MonsterEventType.GroupController).operation?.Invoke(iEvt);
		}
	}
}
