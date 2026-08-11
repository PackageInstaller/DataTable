namespace Ase.ECS;

public class MonsterPhaseComponent : BaseComponent
{
	private float _breakStateTimer;

	private MonsterPhaseEnum _curMonsterPhaseEnum;

	private bool _isChangerState;

	private float _stateAttackToAngerScale;

	private float _stateRecoverAngerScale;

	private float _attackScale;

	private float _angerMax;

	private DRMonster _monsterConfig;

	private DRMonsterAttr _monsterAttrConfig;

	private BattleSystem _battleSystem;

	private bool angerEnable;

	private bool isDownState;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		_battleSystem = mBaseEntity.GetSystem<BattleSystem>();
		angerEnable = true;
		isDownState = false;
	}

	public override void OnDispose()
	{
		_battleSystem = null;
		base.OnDispose();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_isChangerState = GetData<bool>("MonsterIsChangeAngerState");
		_monsterConfig = GetData<DRMonster>("MonsterConfig");
		_monsterAttrConfig = GetData<DRMonsterAttr>("MonsterAttrConfig");
		_breakStateTimer = _monsterConfig.BreakTime;
		if (_monsterConfig != null)
		{
			_angerMax = _monsterAttrConfig?.AngerMax ?? 0;
			SetMonsterPhase(MonsterPhaseEnum.None);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		TimeIncreaseAnger(deltaTime);
		if (_curMonsterPhaseEnum == MonsterPhaseEnum.Break)
		{
			if (!isDownState)
			{
				_breakStateTimer -= deltaTime;
				_battleSystem.GetBossBreakPercent(((float)_monsterConfig.BreakTime - _breakStateTimer) / (float)_monsterConfig.BreakTime);
			}
		}
		else
		{
			_breakStateTimer = _monsterConfig.BreakTime;
		}
	}

	public void SetMonsterPhase(MonsterPhaseEnum aMonsterPhaseEnum)
	{
		if (_isChangerState || aMonsterPhaseEnum == MonsterPhaseEnum.Normal)
		{
			if (_curMonsterPhaseEnum != aMonsterPhaseEnum)
			{
				ChangeMonsterPhase(aMonsterPhaseEnum);
			}
			_curMonsterPhaseEnum = aMonsterPhaseEnum;
			mBaseEntity.GetSystem<BattleSystem>()?.ChangeBossStage(aMonsterPhaseEnum);
		}
	}

	public void OnHitChangeAnger(float damage, BaseEntity attacker)
	{
		switch (_curMonsterPhaseEnum)
		{
		case MonsterPhaseEnum.Normal:
			AttackIncreaseAnger(damage, attacker);
			break;
		case MonsterPhaseEnum.OverDrive:
			AttackSubAnger(damage, attacker);
			break;
		}
	}

	private void AttackIncreaseAnger(float attackValue, BaseEntity attackerEntity)
	{
		float value = BattleFormulaUtility.DealMonsterAttackIncreaseAnger(attackValue, mBaseEntity, attackerEntity);
		mBaseEntity.ChangeProperty("MonsterAnger", value);
	}

	private void AttackSubAnger(float attackValue, BaseEntity attackerEntity)
	{
		float value = BattleFormulaUtility.DealMonsterAttackSubAnger(attackValue, mBaseEntity, attackerEntity);
		mBaseEntity.ChangeProperty("MonsterAnger", value);
	}

	private void TimeIncreaseAnger(float time)
	{
		if (angerEnable)
		{
			float value = time * _stateRecoverAngerScale * _angerMax;
			mBaseEntity.ChangeProperty("MonsterAnger", value);
		}
	}

	public bool GetMonsterPhaseIsBreak()
	{
		return _curMonsterPhaseEnum == MonsterPhaseEnum.Break;
	}

	public MonsterPhaseEnum GetMonsterPhase()
	{
		return _curMonsterPhaseEnum;
	}

	public bool CheckMonsterPhaseIsOverDrive()
	{
		return _curMonsterPhaseEnum == MonsterPhaseEnum.OverDrive;
	}

	public float GetMonsterPhaseStateAttackScale()
	{
		return _attackScale;
	}

	public float GetMonsterStateAttackToAngerScale()
	{
		return _stateAttackToAngerScale;
	}

	private void ChangeMonsterPhase(MonsterPhaseEnum aMonsterPhaseEnum)
	{
		switch (aMonsterPhaseEnum)
		{
		case MonsterPhaseEnum.Normal:
			_stateAttackToAngerScale = _monsterConfig.NormalStateAttackToAngerScale;
			_stateRecoverAngerScale = _monsterConfig.NormalStateRecoverAngerScale;
			_attackScale = _monsterConfig.NomalAttackFactor;
			break;
		case MonsterPhaseEnum.OverDrive:
			_stateAttackToAngerScale = _monsterConfig.ODStateAttackToAngerScale;
			_stateRecoverAngerScale = _monsterConfig.ODStateRecoverAngerScale;
			_attackScale = _monsterConfig.OverDriverAttackFactor;
			break;
		case MonsterPhaseEnum.Break:
			_stateAttackToAngerScale = 0f;
			_stateRecoverAngerScale = 0f;
			_attackScale = _monsterConfig.BreakAttackFactor;
			break;
		}
	}

	public void SetAngerEnabled(bool enabled)
	{
		angerEnable = enabled;
	}

	public void SetBossDown(bool isDown)
	{
		isDownState = isDown;
	}
}
