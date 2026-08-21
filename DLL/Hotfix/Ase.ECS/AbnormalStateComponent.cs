using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class AbnormalStateComponent : BaseComponent
{
	private Dictionary<int, AbnormalState> _currentAbnormalStateDic = new Dictionary<int, AbnormalState>();

	private List<int> _activeAbStateId = new List<int>();

	private List<AbnormalState> activateList = new List<AbnormalState>();

	private AbnormalState _currentCtrlAbnormalState;

	private AIParadoxComponent _aiParadoxComponent;

	private StateComponent _stateComponent;

	private SkillComponent _skillComponent;

	private List<int> waitDeadStateId = CollectionPool<List<int>, int>.Get();

	private List<AbnormalState> abnormalStates = CollectionPool<List<AbnormalState>, AbnormalState>.Get();

	private int canIsImmunizationCount;

	public bool IsCanMove { get; private set; }

	public bool IsCanRotate { get; private set; }

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_aiParadoxComponent = mBaseEntity.GetComponent<AIParadoxComponent>();
		_stateComponent = mBaseEntity.GetComponent<StateComponent>();
		_skillComponent = mBaseEntity.GetComponent<SkillComponent>();
		IsCanMove = true;
		IsCanRotate = true;
	}

	public float GetAbnormalStateProgress(int stateId)
	{
		if (_stateComponent.ImmuneAbnormalState())
		{
			return 0f;
		}
		_currentAbnormalStateDic.TryGetValue(stateId, out var value);
		return value?.CurrentProgress ?? 0f;
	}

	public float GetAbnormalStateConfigDuration(int stateId)
	{
		_currentAbnormalStateDic.TryGetValue(stateId, out var value);
		return (value?.Config?.Duration).GetValueOrDefault();
	}

	public float GetAbnormalStateDuration(int stateId)
	{
		_currentAbnormalStateDic.TryGetValue(stateId, out var value);
		return value?.CoolingTime ?? 0f;
	}

	public void AddAbnormalStateForce(int stateId, int fromId = 0)
	{
		if (_stateComponent.ImmuneAbnormalState() || IsNoCoexist(stateId))
		{
			return;
		}
		BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(fromId);
		if (!_currentAbnormalStateDic.TryGetValue(stateId, out var value))
		{
			DRAbnormalState dataRow = GameEntry.DataTable.GetDataRow<DRAbnormalState>(stateId);
			if (dataRow == null)
			{
				return;
			}
			value = AbnormalState.CreateAbnormalState(dataRow, mBaseEntity, entity);
			_currentAbnormalStateDic.Add(dataRow.Id, value);
			mBaseEntity.EntityViewModel.AddAbnormalState(value);
		}
		value.AddConfigProgress(entity);
		UpdateLimitState();
	}

	public void AddAbnormalState(int stateId, int fromId, float progress)
	{
		if (_stateComponent.ImmuneAbnormalState() || IsNoCoexist(stateId))
		{
			return;
		}
		BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(fromId);
		if (!_currentAbnormalStateDic.TryGetValue(stateId, out var value))
		{
			DRAbnormalState dataRow = GameEntry.DataTable.GetDataRow<DRAbnormalState>(stateId);
			if (dataRow == null)
			{
				return;
			}
			value = AbnormalState.CreateAbnormalState(dataRow, mBaseEntity, entity);
			_currentAbnormalStateDic.Add(dataRow.Id, value);
			mBaseEntity.EntityViewModel.AddAbnormalState(value);
		}
		value.AddProgress(entity, progress);
		UpdateLimitState();
	}

	public void SetAbnormalStateProgress(int stateId, int fromId, float progress)
	{
		if (_stateComponent.ImmuneAbnormalState() || IsNoCoexist(stateId))
		{
			return;
		}
		if (!_currentAbnormalStateDic.TryGetValue(stateId, out var value))
		{
			DRAbnormalState dataRow = GameEntry.DataTable.GetDataRow<DRAbnormalState>(stateId);
			if (dataRow == null)
			{
				return;
			}
			BaseEntity entity = mBaseEntity.GetSystem<EntitySystem>().GetEntity(fromId);
			value = AbnormalState.CreateAbnormalState(dataRow, mBaseEntity, entity);
			_currentAbnormalStateDic.Add(dataRow.Id, value);
			mBaseEntity.EntityViewModel.AddAbnormalState(value);
		}
		value.SetProgress(progress);
	}

	public void AddAbnormalStateDuration(int stateId, float duration)
	{
		if (!_stateComponent.ImmuneAbnormalState() && _currentAbnormalStateDic.TryGetValue(stateId, out var value))
		{
			value.AddCoolingTime(duration);
			mBaseEntity.EntityViewModel.AbnormalStateRemoveTimeChanged(value);
		}
	}

	public void SetAbnormalStateDuration(int stateId, float duration)
	{
		if (!_stateComponent.ImmuneAbnormalState() && _currentAbnormalStateDic.TryGetValue(stateId, out var value))
		{
			value.SetCoolingTime(duration);
			mBaseEntity.EntityViewModel.AbnormalStateRemoveTimeChanged(value);
		}
	}

	private void SetPropSKillBreakState(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		HeroSkillData skillData = _skillComponent.GetSkillData(heroSkillTypeEnum);
		if (skillData == null || skillData.SkillCoolingData.AbnormalStateCanReleaseSkill)
		{
			return;
		}
		foreach (AbnormalState activate in activateList)
		{
			foreach (string skillLabel in skillData.GetSkillLabelList())
			{
				if (activate.Config.NotReleaseDesignateSkill.Contains(skillLabel) && !_skillComponent.GetPropSkillCanBreakState(heroSkillTypeEnum, activate.Config.Id))
				{
					return;
				}
			}
		}
		_skillComponent.SetAbnormalStateCanRelease(heroSkillTypeEnum);
	}

	public void RemoveAbnormalState(int stateId)
	{
		if (_currentAbnormalStateDic.Remove(stateId, out var value))
		{
			RemoveAbnormalState(value);
		}
	}

	private void RemoveAbnormalState(AbnormalState abnormalState)
	{
		if (abnormalState != null)
		{
			if (_currentCtrlAbnormalState?.Config.Id == abnormalState.Config.Id)
			{
				_currentCtrlAbnormalState = null;
			}
			activateList.Remove(abnormalState);
			if (mBaseEntity.IsActorEntity && abnormalState.Config.CanIsImmunization)
			{
				CanImmunizationSet(isReduce: true);
			}
			RemoveStateBuff(abnormalState);
			mBaseEntity.EntityViewModel.RemoveAbnormalState(abnormalState);
			ReferencePool.Release(abnormalState);
			UpdateLimitState();
		}
	}

	private void CanImmunizationSet(bool isReduce)
	{
		if (isReduce)
		{
			canIsImmunizationCount--;
		}
		else
		{
			canIsImmunizationCount++;
		}
		mBaseEntity.GetSystem<TouchSystem>().CanImmunizationExcute(canIsImmunizationCount > 0);
	}

	public void ExecuteCommand(MsgPlayerInput playerInput)
	{
		if (playerInput.inputUV == Vector2.zero)
		{
			return;
		}
		foreach (AbnormalState value in _currentAbnormalStateDic.Values)
		{
			value.ExecuteCommand(playerInput, out var isExcute);
			if (isExcute)
			{
				mBaseEntity.EntityViewModel.AbnormalStateRecudeRemoveTime(value);
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (_activeAbStateId.Count != 0)
		{
			_activeAbStateId.Clear();
		}
		waitDeadStateId.Clear();
		abnormalStates.Clear();
		foreach (AbnormalState value in _currentAbnormalStateDic.Values)
		{
			value.Update(deltaTime);
			if (value.IsDead)
			{
				waitDeadStateId.Add(value.Config.Id);
			}
			if (value.IsWaitExecute)
			{
				abnormalStates.Add(value);
				_activeAbStateId.Add(value.Config.Id);
			}
		}
		mBaseEntity.EntityViewModel.UpdateAbnormalState(deltaTime);
		for (int i = 0; i < waitDeadStateId.Count; i++)
		{
			RemoveAbnormalState(waitDeadStateId[i]);
		}
		for (int j = 0; j < abnormalStates.Count; j++)
		{
			ActivateAbnormalState(abnormalStates[j]);
		}
		SetAiParamValue();
	}

	private void UpdateLimitState()
	{
		IsCanMove = true;
		IsCanRotate = true;
		List<string> list = CollectionPool<List<string>, string>.Get();
		foreach (AbnormalState activate in activateList)
		{
			foreach (string item in activate.Config.NotReleaseDesignateSkill)
			{
				if (!list.Contains(item))
				{
					list.Add(item);
				}
			}
			IsCanMove &= activate.Config.CanMove;
			IsCanRotate &= activate.Config.CanRotate;
		}
		if (_skillComponent != null)
		{
			_skillComponent.SetAbStateIsCanReleaseSkill(list);
			SetPropSKillBreakState(HeroSkillTypeEnum.PropSkill);
			SetPropSKillBreakState(HeroSkillTypeEnum.DeputyPropSkill);
			CollectionPool<List<string>, string>.Release(list);
		}
	}

	private void SetAiParamValue()
	{
		if (_activeAbStateId.Count != 0)
		{
			_aiParadoxComponent.SetVariableValues("s_EntityAbnormalState", _activeAbStateId);
		}
	}

	private void ActivateAbnormalState(AbnormalState abnormalState)
	{
		if (abnormalState.IsControlAbnormalType())
		{
			if (_currentCtrlAbnormalState != null)
			{
				if (_currentCtrlAbnormalState.Priority <= abnormalState.Priority)
				{
					_currentCtrlAbnormalState = abnormalState;
				}
			}
			else
			{
				_currentCtrlAbnormalState = abnormalState;
			}
			_aiParadoxComponent.SetVariableValues("s_EntityCtrlAbnormalState", _currentCtrlAbnormalState.Config.Id);
		}
		abnormalState.OnActivate();
		AddStateBuff(abnormalState);
		AddStateBullet(abnormalState);
		activateList.Add(abnormalState);
		if (mBaseEntity.IsActorEntity && abnormalState.Config.CanIsImmunization)
		{
			CanImmunizationSet(isReduce: false);
		}
		UpdateLimitState();
	}

	private void AddStateBuff(AbnormalState abnormalState)
	{
		BuffSystem system = mBaseEntity.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		BaseEntity fromEntity = abnormalState.FromEntity;
		if (fromEntity == null)
		{
			fromEntity = mBaseEntity;
		}
		foreach (int item in abnormalState.Config.AbnormalStateBuff)
		{
			DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(item);
			if (dataRow != null && !dataRow.Operations.IsNullOrEmpty())
			{
				system.AcquireBuff(fromEntity, mBaseEntity, dataRow);
			}
		}
	}

	private void RemoveStateBuff(AbnormalState abnormalState)
	{
		BuffSystem system = mBaseEntity.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		foreach (int item in abnormalState.Config.AbnormalStateBuff)
		{
			system.FinishEntityBuff(mBaseEntity.Id, item);
		}
	}

	private void AddStateBullet(AbnormalState abnormalState)
	{
		BulletSystem system = mBaseEntity.GetSystem<BulletSystem>();
		if (system == null)
		{
			return;
		}
		foreach (int item in abnormalState.Config.AbnormalStateBullet)
		{
			system.CreateConfigBulletEntity(abnormalState.TargetEntity, abnormalState.FromEntity, item);
		}
	}

	public bool CheckAbnormalState(int stateId)
	{
		if (!_currentAbnormalStateDic.ContainsKey(stateId))
		{
			AbnormalState currentCtrlAbnormalState = _currentCtrlAbnormalState;
			if (currentCtrlAbnormalState == null || currentCtrlAbnormalState.Config.Id != stateId)
			{
				return false;
			}
		}
		return true;
	}

	public bool HasAnyAbnormalState()
	{
		return _currentAbnormalStateDic.Count > 0;
	}

	public bool IsNoCoexist(int stateId)
	{
		foreach (AbnormalState value in _currentAbnormalStateDic.Values)
		{
			if (value.IsNoCoexist(stateId))
			{
				return true;
			}
		}
		return false;
	}

	public bool IsNoCoexistCurrent(int stateId)
	{
		return false;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_aiParadoxComponent = null;
		_stateComponent = null;
		_skillComponent = null;
		foreach (AbnormalState value in _currentAbnormalStateDic.Values)
		{
			ReferencePool.Release(value);
		}
		_currentAbnormalStateDic.Clear();
		_currentAbnormalStateDic = null;
		CollectionPool<List<int>, int>.Release(waitDeadStateId);
		CollectionPool<List<AbnormalState>, AbnormalState>.Release(abnormalStates);
	}
}
