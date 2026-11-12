using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10301;

public class ActionBehaviour : ActorActionBase
{
	private const int perkId_3 = 510303;

	protected PlayerSkillCd _skillManage;

	protected int _reloadLoading;

	private ActorSearchTarget actorSearchInfo;

	private AmmoInfo ammoInfo;

	private IState curState;

	private readonly AimState aimState = new AimState();

	private readonly NormalAttackState normalAttackState = new NormalAttackState();

	private readonly AimTarget _aimTarget = new AimTarget();

	private VisualSmooth smooth;

	private ClassObjectPool<SkillState> skillPool;

	protected override void OnActionEnable()
	{
		smooth = _actor.GetLogicComponent<VisualSmooth>();
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		ammoInfo = ActorHelper.GetFlowAmmoInfo(_actor.gameObject);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		aimState.Init(_actor, _skillManage, _aimTarget);
		normalAttackState.Init(_actor, _skillManage, _aimTarget);
		skillPool = new ClassObjectPool<SkillState>(() => new SkillState(_actor, _skillManage, _aimTarget), 4);
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		_actor.logicVariable.SetLogicTagValue("lastSkillPhase", 0);
		skillPool.Clear(clearUsed: true);
		Clear();
	}

	public override void OnStart()
	{
		base.OnStart();
		DoMainLogic();
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	public override void OnStop()
	{
		base.OnStop();
		Clear();
	}

	private void Clear()
	{
		_aimTarget.Cancel();
		_actor.movementMode = AdventureActor.MovementMode.Run;
	}

	private void OnActorBeControlled(IEvent evt)
	{
		if (!(_actor != null) || !(evt is AdventureActorBeControlledEvent adventureActorBeControlledEvent) || !(_actor == adventureActorBeControlledEvent.actor))
		{
			return;
		}
		if (_actor.logicVariable.GetLogicTagValue("lastSkillPhase") != 0)
		{
			_skillManage.SetSkillBeginResume(Parallel_B1.skillId_S1);
			if (GetPerkLv(510303, out var _))
			{
				AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
				adventurRebindSkill.sender = _actor;
				adventurRebindSkill.slotKey = ActionKey.B;
				adventurRebindSkill.skillId = Parallel_B1.skillId_S2;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
			}
		}
		_actor.logicVariable.SetLogicTagValue("lastSkillPhase", 0);
	}

	protected override void OnButtonAPress()
	{
		CastSkill(ActionKey.A, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		CastSkill(ActionKey.B, SkillPhaseFeatureFlag.Skill1);
		_actor.logicVariable.ToggleLogicTag("HoldingKeyD", value: true);
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable?.ToggleLogicTag("HoldingKeyD", value: false);
	}

	protected override bool CastIndependentRushSkill()
	{
		return CastSkill(ActionKey.C, SkillPhaseFeatureFlag.Skill2, 0, isInterruptAttack: true, isRushJoinDodge: false);
	}

	protected override void OnButtonDPress()
	{
		CastSkill(ActionKey.D, SkillPhaseFeatureFlag.Ultimate);
	}

	private void OnTrCastSkill(IEvent _evt)
	{
		if (_evt is ActorTryCastSkill actorTryCastSkill && actorTryCastSkill.sender as AdventureActor == _actor)
		{
			CastSkill(ActionKey.None, actorTryCastSkill.flag, actorTryCastSkill.skillId, actorTryCastSkill.isInterruptAttack);
		}
	}

	private bool CastSkill(ActionKey key, SkillPhaseFeatureFlag skillPhaseFeatureFlag, int skillId = 0, bool isInterruptAttack = true, bool isRushJoinDodge = true)
	{
		SkillState skillState = SkillPop();
		skillState.SetSkill(key, skillPhaseFeatureFlag, skillId, isInterruptAttack, ingoreCDAndEnergy: false, isRushJoinDodge);
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("lastSkillPhase");
		if (key == ActionKey.D || skillPhaseFeatureFlag == SkillPhaseFeatureFlag.Skill2 || key == ActionKey.C)
		{
			_actor.logicVariable.SetLogicTagValue("lastSkillPhase", 0);
		}
		skillState.Enter();
		if (skillState.CanCast)
		{
			if ((key == ActionKey.D || skillPhaseFeatureFlag == SkillPhaseFeatureFlag.Skill2 || key == ActionKey.C) && logicTagValue > 0)
			{
				_skillManage.SetSkillBeginResume(Parallel_B1.skillId_S1);
				if (GetPerkLv(510303, out var _))
				{
					AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
					adventurRebindSkill.sender = _actor;
					adventurRebindSkill.slotKey = ActionKey.B;
					adventurRebindSkill.skillId = Parallel_B1.skillId_S2;
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
				}
			}
			curState?.Exit();
			curState = skillState;
		}
		else
		{
			skillPool.Return(skillState);
			if (key == ActionKey.D || skillPhaseFeatureFlag == SkillPhaseFeatureFlag.Skill2 || key == ActionKey.C)
			{
				_actor.logicVariable.SetLogicTagValue("lastSkillPhase", logicTagValue);
			}
		}
		return skillState.CanCast;
	}

	private void DoMainLogic()
	{
	}

	private void MainLoop()
	{
		_actor.attackTarget = actorSearchInfo.GetLockingConfrontActor(useInputDirection: true);
		if (curState == null || curState.IsEnd)
		{
			if (curState is SkillState instance)
			{
				skillPool.Return(instance);
			}
			curState = GetNextState();
			curState?.Enter();
		}
		else
		{
			curState.Update();
		}
	}

	private IState GetNextState()
	{
		if (curState is SkillState skillState && _actor.logicVariable.GetLogicTagValue("lastSkillPhase").AsInt() > 0 && (skillState.actionKey == ActionKey.A || skillState.actionKey == ActionKey.B))
		{
			SkillState skillState2 = SkillPop();
			skillState2.SetSkill(ActionKey.B, SkillPhaseFeatureFlag.Skill1, 0, isInterruptAttack: true, ingoreCDAndEnergy: true);
			return skillState2;
		}
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			bool isObstacleBetweenActorAndTargetAndPreventNormalAttack = IsObstacleBetweenActorAndTargetAndPreventNormalAttack;
			bool flag = fP <= CommonUtils.GetAimRange(_actor);
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
			{
				if (isObstacleBetweenActorAndTargetAndPreventNormalAttack || !flag)
				{
					_aimTarget.Cancel();
				}
			}
			else if (flag && !(_actor as PlayerAdventureActor).dodgeButtonHold && !isObstacleBetweenActorAndTargetAndPreventNormalAttack && !_actor.forceControl)
			{
				_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
				smooth?.SyncDeterministicTransform();
			}
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && ammoInfo.ammoCount > 0 && CommonUtils.GetAttackRange(_actor) > fP)
			{
				return normalAttackState;
			}
		}
		else if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			_aimTarget.Cancel();
		}
		return null;
	}

	private SkillState SkillPop()
	{
		SkillState skillState = skillPool.Rent();
		skillState.SetSkill(ActionKey.None, SkillPhaseFeatureFlag.None, 0, isInterruptAttack: false);
		return skillState;
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
