using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class AbnormalState : IReference
{
	private DRAbnormalState _abnormalState;

	private BaseEntity _entity;

	private BaseEntity fromEntity;

	private StateComponent stateComponent;

	public bool IsDead;

	private float _delayRecessionTime;

	public float MaxProgress;

	public float CurrentProgress;

	public int Priority;

	public bool IsWaitExecute;

	public bool IsActive;

	public int AbnormalType;

	private Vector2 _oldTickInputUv;

	private float _immunizationCoolTime;

	public BaseEntity TargetEntity => _entity;

	public BaseEntity FromEntity => fromEntity;

	public DRAbnormalState Config => _abnormalState;

	public float CoolingTime { get; private set; }

	public static AbnormalState CreateAbnormalState(DRAbnormalState abnormalState, BaseEntity entity, BaseEntity fromEntity)
	{
		AbnormalState abnormalState2 = ReferencePool.Acquire<AbnormalState>();
		abnormalState2._abnormalState = abnormalState;
		abnormalState2.MaxProgress = abnormalState.Progress;
		abnormalState2._delayRecessionTime = abnormalState.DelayRecessionTime;
		abnormalState2.Priority = abnormalState.Priority;
		abnormalState2.AbnormalType = abnormalState.AbnormalStateType;
		abnormalState2._immunizationCoolTime = 0f;
		abnormalState2._entity = entity;
		abnormalState2.fromEntity = fromEntity;
		abnormalState2.stateComponent = entity.GetComponent<StateComponent>();
		return abnormalState2;
	}

	private void RefreshDelayRecessionTime()
	{
		_delayRecessionTime = _abnormalState.DelayRecessionTime;
	}

	public void AddProgress(BaseEntity fromEntity, float progress)
	{
		if (IsActive)
		{
			return;
		}
		StateComponent obj = stateComponent;
		if (obj == null || !obj.ImmuneAbnormalStateIncrease())
		{
			CurrentProgress += progress;
			if (CurrentProgress >= MaxProgress)
			{
				IsWaitExecute = true;
			}
			else
			{
				RefreshDelayRecessionTime();
			}
		}
	}

	public void SetProgress(float progress)
	{
		if (!IsActive)
		{
			CurrentProgress = progress;
			if (CurrentProgress >= MaxProgress)
			{
				IsWaitExecute = true;
			}
			else
			{
				RefreshDelayRecessionTime();
			}
		}
	}

	public void AddConfigProgress(BaseEntity from)
	{
		AddProgress(from, _abnormalState.Progress);
	}

	public void AddCoolingTime(float time)
	{
		CoolingTime += time;
	}

	public void SetCoolingTime(float time)
	{
		CoolingTime = time;
	}

	public bool IsNoCoexist(int stateId)
	{
		return Config.NotCoexistStateId.Contains(stateId);
	}

	public bool IsControlAbnormalType()
	{
		return AbnormalType == 2;
	}

	public void OnActivate()
	{
		IsActive = true;
		IsWaitExecute = false;
		CoolingTime = Config.Duration;
	}

	public void Update(float deltaTime)
	{
		if (IsDead)
		{
			return;
		}
		_immunizationCoolTime = Mathf.Clamp(_immunizationCoolTime - deltaTime, 0f, _immunizationCoolTime);
		if (!IsActive)
		{
			_delayRecessionTime -= deltaTime;
			if (_delayRecessionTime <= 0f)
			{
				CurrentProgress = Mathf.Clamp(CurrentProgress -= _abnormalState.RecessionSpeed, 0f, MaxProgress);
				if (CurrentProgress == 0f)
				{
					IsDead = true;
				}
			}
		}
		else
		{
			CoolingTime -= deltaTime;
			if (CoolingTime <= 0f)
			{
				IsDead = true;
			}
		}
	}

	public void ExecuteCommand(MsgPlayerInput playerInput, out bool isExcute)
	{
		isExcute = false;
		if (IsActive && Config.CanIsImmunization && _immunizationCoolTime == 0f)
		{
			if (_oldTickInputUv.x * playerInput.inputUV.x < 0f || _oldTickInputUv.y * playerInput.inputUV.y < 0f)
			{
				CoolingTime = Mathf.Clamp(CoolingTime - Config.ImmunizationTime, 0f, CoolingTime);
				_immunizationCoolTime = Config.CoolDownTime;
				isExcute = true;
				PlayDecreaseAbStateTimeEffect();
			}
			_oldTickInputUv = playerInput.inputUV;
		}
	}

	private void PlayDecreaseAbStateTimeEffect()
	{
		_entity.GetSystem<EffectSystem>().PlayEffect(_entity, _entity, EffectType.FOLLOW_BONE, Config.EffectId, Config.SfxPoint, Vector3.zero, Vector3.zero, Vector3.zero, Vector3.zero, followParentDispose: true);
	}

	public void Clear()
	{
		CurrentProgress = 0f;
		CoolingTime = 0f;
		IsDead = false;
		IsWaitExecute = false;
		AbnormalType = 0;
		IsActive = false;
		_immunizationCoolTime = 0f;
		_entity = null;
		fromEntity = null;
		stateComponent = null;
	}
}
