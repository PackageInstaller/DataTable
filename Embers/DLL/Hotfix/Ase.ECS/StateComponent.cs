#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase.ECS;

public class StateComponent : BaseComponent
{
	private Dictionary<int, DRState> _cacheStateDataList = new Dictionary<int, DRState>();

	private StateData _currentStateData;

	private int _deadStateId;

	private DRState _normalState;

	private int _rebornStateId;

	private int _nearDeathStateId;

	private int _stateInfliction;

	private float _stateTime;

	private int _dropStateId;

	private bool _dropCheck;

	private List<DRBuffStateConfig> _currentBuffs = new List<DRBuffStateConfig>();

	private List<int> _currentBuffIdList = new List<int>();

	private int _immuneStatePriority;

	private bool _immuneAbnormalState;

	private bool _immuneAbnormalStateIncrease;

	private bool _immuneDamage;

	private bool _immuneCollider;

	private bool _immuneNonHostileHit;

	private bool _immuneHostileHit;

	private bool _immuneLock;

	private bool _immuneHitEffect;

	private bool _lockHp;

	public override void OnStart(object data = null)
	{
		_normalState = GameEntry.DataTable.GetDataRow<DRState>(0);
		AddImmuneBuff(1);
		EnterNormalState();
		_deadStateId = GetData<int>("DeadStateId");
		_rebornStateId = GetData<int>("RebornStateId");
		_nearDeathStateId = GetData<int>("NearDeathStateId");
		_dropStateId = 4006;
	}

	public void AddState(int stateId, int stateInfliction)
	{
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"切换的状态 {stateId}", mBaseEntity);
		}
		_cacheStateDataList.TryGetValue(stateId, out var value);
		if (value == null)
		{
			value = GameEntry.DataTable.GetDataRow<DRState>(stateId);
			if (value == null)
			{
				Log.Error($"没有找到Id = {stateId}的状态配置.");
				return;
			}
			_cacheStateDataList.Add(stateId, value);
		}
		if (value.Priority >= _immuneStatePriority)
		{
			StateData stateData = StateData.Create(value);
			ChangeState(stateData, stateInfliction, _currentStateData != null && _currentStateData.Id == stateId);
		}
	}

	public float GetDownStateDamageAddition()
	{
		if (_currentStateData != null && _currentStateData.StateConfig != null)
		{
			return _currentStateData.StateConfig.DamageRatio;
		}
		return 0f;
	}

	public void RemoveState(int stateId)
	{
		if (_currentStateData != null && _currentStateData.Id == stateId)
		{
			EndCurrentState();
		}
	}

	private void ChangeState(StateData stateData, int stateInfliction, bool force = false)
	{
		_stateInfliction = stateInfliction;
		if (force || CompareStatePriority(stateData.StateConfig))
		{
			if (_currentStateData != null)
			{
				RemoveImmuneBuff(_currentStateData.StateConfig.SubjoinBuffState);
			}
			_currentStateData?.Dispose();
			_currentStateData = stateData;
			mBaseEntity.GetComponent<AIParadoxComponent>().ChangeEntityState(_currentStateData.Id);
			UpdateSkillState(_currentStateData.StateConfig.CanIsReleaseSkill);
			if (!stateData.IsNormal())
			{
				mBaseEntity.GetComponent<NearDeathRescueComponent>()?.DamageBreakRescue();
			}
			if (!_currentStateData.StateConfig.IsCanFrozenFrame)
			{
				mBaseEntity.GetSystem<FrameFrozenSystem>().StateBreakEntityFrozenFrame(mBaseEntity, isStateBreak: true);
			}
			AddImmuneBuff(stateData.StateConfig.SubjoinBuffState);
			SetKnockDown();
			SetEntityIndicateRingShow();
			ObserverChangeStateParams observerChangeStateParams = ReferencePool.Acquire<ObserverChangeStateParams>();
			observerChangeStateParams.Init(mBaseEntity, stateInfliction, stateData);
			mBaseEntity.GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.ChangeState, observerChangeStateParams);
			ReferencePool.Release(observerChangeStateParams);
		}
		else
		{
			stateData.Dispose();
		}
	}

	private void SetKnockDown()
	{
		if (_currentStateData.StateConfig.MonsterKnockDownLevelEnum != MonsterKnockDownLevelEnum.None)
		{
			mBaseEntity.GetComponent<TenacityComponent>().SetMonsterKnockDown();
		}
	}

	private void SetEntityIndicateRingShow()
	{
		if (_currentStateData != null && mBaseEntity != null && mBaseEntity.IsActorEntity)
		{
			mBaseEntity.GetComponent<HeroIndicatorRingComponent>()?.SetIndicateRingShow(!_currentStateData.StateConfig.HideIndicatorRing);
		}
	}

	public StateData GetCurrentState()
	{
		return _currentStateData;
	}

	public int GetStateInfliction()
	{
		return _stateInfliction;
	}

	public bool IsImmuneBuff()
	{
		return _currentStateData.StateConfig.ImmuneBuff;
	}

	public bool IsDeadState()
	{
		return _currentStateData.Id == _deadStateId;
	}

	public bool IsNormalState()
	{
		return _currentStateData.Id == _normalState.Id;
	}

	public bool IsDropState()
	{
		return _currentStateData.Id == _dropStateId;
	}

	public bool CanInteractive()
	{
		if (_currentStateData.Id != _deadStateId && _currentStateData.Id != _dropStateId)
		{
			return _currentStateData.Id != 4005;
		}
		return false;
	}

	private void UpdateSkillState(bool isCanRelease)
	{
		mBaseEntity.GetComponent<SkillComponent>()?.SetStateIsCanReleaseSkill(isCanRelease);
		if (!isCanRelease)
		{
			mBaseEntity.GetSystem<CommandSystem>().ClearLastDownOrDragInput();
		}
	}

	public void UpdateSkillState(bool isCanRelease, List<HeroSkillTypeEnum> skillTypeEnumList)
	{
		if (skillTypeEnumList != null && skillTypeEnumList.Count > 0)
		{
			mBaseEntity.GetComponent<SkillComponent>().SetStateIsCanReleaseSkill(isCanRelease, skillTypeEnumList);
		}
	}

	private void EndCurrentState()
	{
		if (!_currentStateData.IsNormal())
		{
			ChangeState(StateData.Create(_normalState), mBaseEntity.Id, force: true);
		}
	}

	private bool CompareStatePriority(DRState state)
	{
		if (_currentStateData == null)
		{
			return true;
		}
		return state.Priority > _currentStateData.StateConfig.Priority;
	}

	public bool GetMoveEnable()
	{
		return _currentStateData.StateConfig.CanMove;
	}

	public bool GetRotateEnable()
	{
		return _currentStateData.StateConfig.CanRotate;
	}

	public float GetEntityStateDamageRatio()
	{
		return (_currentStateData?.StateConfig?.DamageRatio).GetValueOrDefault();
	}

	public float GetEntityStateTenacityRatio()
	{
		return _currentStateData.StateConfig.TenacityRatio;
	}

	public bool IsDownState()
	{
		if (_currentStateData.StateConfig.MonsterKnockDownLevelEnum == MonsterKnockDownLevelEnum.None)
		{
			return _currentStateData.StateConfig.IsMinionknockdownState;
		}
		return true;
	}

	public bool IsNearDeathState()
	{
		if (_currentStateData.StateConfig.Id != 0)
		{
			return _currentStateData.StateConfig.Id == _nearDeathStateId;
		}
		return false;
	}

	public void EnterDeadState()
	{
		AddState(_deadStateId, mBaseEntity.Id);
	}

	public void EnterRebornState()
	{
		AddState(_rebornStateId, mBaseEntity.Id);
	}

	public void EnterNearDeadState()
	{
		AddState(_nearDeathStateId, mBaseEntity.Id);
	}

	public void EnterNormalState()
	{
		ChangeState(StateData.Create(_normalState), mBaseEntity.Id, force: true);
	}

	public void EnterDropState()
	{
		AddState(_dropStateId, mBaseEntity.Id);
	}

	public void ExitDropState()
	{
		RemoveState(_dropStateId);
	}

	public bool AddImmuneBuff(int buffId)
	{
		if (buffId == 0)
		{
			return false;
		}
		DRBuffStateConfig dataRow = GameEntry.DataTable.GetDataRow<DRBuffStateConfig>(buffId);
		if (dataRow == null)
		{
			Log.Error($"根据免疫状态ID:{buffId} 没有找到对应的配置!");
			return false;
		}
		if (!_currentBuffs.Contains(dataRow))
		{
			_currentBuffs.Add(dataRow);
			_currentBuffIdList.Add(buffId);
		}
		UpdateImmuneData(dataRow);
		if (_currentStateData != null && !_currentStateData.IsNormal() && _currentStateData.Priority <= _immuneStatePriority)
		{
			EndCurrentState();
		}
		return true;
	}

	public bool RemoveImmuneBuff(int buffId)
	{
		DRBuffStateConfig dRBuffStateConfig = null;
		foreach (DRBuffStateConfig currentBuff in _currentBuffs)
		{
			if (currentBuff.Id == buffId)
			{
				dRBuffStateConfig = currentBuff;
				break;
			}
		}
		if (dRBuffStateConfig == null)
		{
			return false;
		}
		_currentBuffs.Remove(dRBuffStateConfig);
		_currentBuffIdList.Remove(buffId);
		ImmuneStatePriority(reset: true);
		ImmuneAbnormalState(reset: true);
		ImmuneAbnormalStateIncrease(reset: true);
		ResetImmuneDamage();
		ImmuneCollider(reset: true);
		ImmuneLock(reset: true);
		ResetImmuneHitEffect();
		LockHp(reset: true);
		return true;
	}

	public bool ContainsImmuneBuff(int immuneId)
	{
		return _currentBuffIdList.Contains(immuneId);
	}

	public List<int> GetImmuneBuffIdList()
	{
		return _currentBuffIdList.ToList();
	}

	private void UpdateImmuneData(DRBuffStateConfig buffInfo)
	{
		if (_immuneStatePriority < buffInfo.ImmuneState)
		{
			_immuneStatePriority = buffInfo.ImmuneState;
		}
		_immuneAbnormalState |= buffInfo.ImmuneAbnormalState;
		_immuneAbnormalStateIncrease |= buffInfo.ImmuneAbnormalStateIncrease;
		_immuneDamage |= buffInfo.ImmuneDamage;
		_immuneCollider |= buffInfo.ImmuneCollider;
		_immuneLock |= buffInfo.ImmuneLock;
		_lockHp |= buffInfo.LockHp;
		_immuneHitEffect |= buffInfo.ImmuneHitSfx;
	}

	private int ImmuneStatePriority(bool reset = false)
	{
		if (reset)
		{
			_immuneStatePriority = 0;
			foreach (DRBuffStateConfig currentBuff in _currentBuffs)
			{
				if (_immuneStatePriority < currentBuff.ImmuneState)
				{
					_immuneStatePriority = currentBuff.ImmuneState;
				}
			}
		}
		return _immuneStatePriority;
	}

	public bool ImmuneAbnormalState(bool reset = false)
	{
		if (reset)
		{
			_immuneAbnormalState = false;
			foreach (DRBuffStateConfig currentBuff in _currentBuffs)
			{
				_immuneAbnormalState |= currentBuff.ImmuneAbnormalState;
			}
		}
		return _immuneAbnormalState;
	}

	public bool IsOpenDropCheck(bool reset = false)
	{
		return true;
	}

	public bool ImmuneAbnormalStateIncrease(bool reset = false)
	{
		if (reset)
		{
			_immuneAbnormalStateIncrease = false;
			foreach (DRBuffStateConfig currentBuff in _currentBuffs)
			{
				_immuneAbnormalStateIncrease |= currentBuff.ImmuneAbnormalStateIncrease;
			}
		}
		return _immuneAbnormalStateIncrease;
	}

	public bool ImmuneDamage(List<int> ignoreImmuneList = null)
	{
		if (ignoreImmuneList == null || ignoreImmuneList.Count == 0)
		{
			return _immuneDamage;
		}
		bool flag = false;
		foreach (DRBuffStateConfig currentBuff in _currentBuffs)
		{
			if (!ignoreImmuneList.Contains(currentBuff.Id))
			{
				flag |= currentBuff.ImmuneDamage;
			}
		}
		return flag;
	}

	public void ResetImmuneDamage()
	{
		_immuneDamage = false;
		foreach (DRBuffStateConfig currentBuff in _currentBuffs)
		{
			_immuneDamage |= currentBuff.ImmuneDamage;
		}
	}

	public bool ImmuneCollider(bool reset = false)
	{
		if (reset)
		{
			_immuneCollider = false;
			foreach (DRBuffStateConfig currentBuff in _currentBuffs)
			{
				_immuneCollider |= currentBuff.ImmuneCollider;
			}
		}
		return _immuneCollider;
	}

	public bool ImmuneRelationCollider(BaseEntity relation1, BaseEntity relation2)
	{
		int relation3 = (int)AIUtility.GetRelation(relation1, relation2);
		foreach (DRBuffStateConfig currentBuff in _currentBuffs)
		{
			if (currentBuff.ImmuneRelationCollider.Contains(relation3))
			{
				return true;
			}
		}
		return false;
	}

	public bool ImmuneHitCollider(BaseEntity relation1, BaseEntity relation2, List<int> ignoreImmuneList)
	{
		RelationTypeEnum relation3 = AIUtility.GetRelation(relation1, relation2);
		return ImmuneHitCollider((int)relation3, ignoreImmuneList);
	}

	public bool ImmuneHitCollider(int relation, List<int> ignoreImmuneList)
	{
		if (relation == 0)
		{
			return true;
		}
		if (!ignoreImmuneList.IsNullOrEmpty())
		{
			foreach (DRBuffStateConfig currentBuff in _currentBuffs)
			{
				if (!ignoreImmuneList.Contains(currentBuff.Id) && currentBuff.ImmuneHit.Contains(relation))
				{
					return true;
				}
			}
		}
		else
		{
			foreach (DRBuffStateConfig currentBuff2 in _currentBuffs)
			{
				if (currentBuff2.ImmuneHit.Contains(relation))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void ResetHitCollider()
	{
	}

	public bool ImmuneLock(bool reset = false)
	{
		if (reset)
		{
			_immuneLock = false;
			foreach (DRBuffStateConfig currentBuff in _currentBuffs)
			{
				_immuneLock |= currentBuff.ImmuneLock;
			}
		}
		return _immuneLock;
	}

	public bool ImmuneHitEffect()
	{
		return _immuneHitEffect;
	}

	private void ResetImmuneHitEffect()
	{
		_immuneHitEffect = false;
		foreach (DRBuffStateConfig currentBuff in _currentBuffs)
		{
			_immuneHitEffect |= currentBuff.ImmuneHitSfx;
		}
	}

	public bool LockHp(bool reset = false)
	{
		if (reset)
		{
			_lockHp = false;
			foreach (DRBuffStateConfig currentBuff in _currentBuffs)
			{
				_lockHp |= currentBuff.LockHp;
			}
		}
		return _lockHp;
	}
}
