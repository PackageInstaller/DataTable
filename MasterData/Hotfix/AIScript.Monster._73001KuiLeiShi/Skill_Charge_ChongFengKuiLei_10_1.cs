using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_Charge_ChongFengKuiLei_10_1 : SkillSimpleBase
{
	private const string combo_Charge = "Charge";

	private const string combo_Die = "Die1_10_1";

	private const string warningAlias = "fx_warning_square_3side_2_5x30";

	private const string combo_Born = "Born";

	private readonly string fx_Alias = "fx_m72013_base_Born";

	private FP dashSpeed = 45;

	private FP dashDistance = 20;

	private FP wanderRadius = 10;

	private FP wanderRadiusInn = 8;

	private FP turnTime = 0.3;

	private FP damageImmuneDuration = 0.1;

	private TSVector2 _chargeDir;

	private FP wanderStopDistance = 0.2;

	private int _deathCount;

	private List<LogicEntity> _entities = new List<LogicEntity>();

	private bool _finalStarted;

	private CoroutineNode AimCor;

	protected override void OnSkillEnable()
	{
		_entities.Clear();
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: true);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		SetLogicTagToggleValue(_actor, "ExecutingCanBreakSkill", value: false);
		StopCor(AimCor);
		StopMove();
		CancelAim();
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("OnCustomEvt"))
		{
			StartCor(DoSomething());
		}
	}

	private IEnumerator DoSomething()
	{
		yield return WaitTime(0.1);
		KillActors(new List<LogicEntity> { _actor });
	}

	private IEnumerator KeepAiming()
	{
		LogicEntity Target = GetAttackTarget();
		AimAtTarget(Target, 120);
		while (true)
		{
			if (!CheckTargetIsValid(Target))
			{
				InterruptSkill();
			}
			if (CalcAngleBetweenSelfAndAttackTarget() > 45)
			{
				CancelAim();
				yield return BeginLookAt(Target, 0, 300);
				AimAtTarget(Target, 120);
			}
			yield return null;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(0.2);
		SetHideModelDisable();
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		_chargeDir = GetEntityPosition(logicEntity) - GetPosition();
		if (_chargeDir.magnitude <= 0)
		{
			_chargeDir = GetForward();
		}
		_chargeDir = _chargeDir.normalized;
		float duration = 1.8f;
		Skill_Charge_ChongFengKuiLei_10_1 skill_Charge_ChongFengKuiLei_10_ = this;
		TSVector2 position = GetPosition();
		FP angle = _chargeDir.GetAngle();
		long warningId = skill_Charge_ChongFengKuiLei_10_.PlayEarlyWarningEffect("fx_warning_square_3side_2_5x30", duration, default, position, angle, 0.9f);
		yield return WaitTime(0.5);
		yield return BeginLookAtByDir(_chargeDir, default, 5000);
		BeginAttack(1, "Charge", flushInputedKeys: true);
		yield return WaitCustomEvent("DashStart");
		StopEffect(warningId);
		BeginDash(1, _chargeDir, dashSpeed, dashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, "Die1_10_1", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetHideModelEnable();
		ClearActors(new List<LogicEntity> { _actor });
	}
}
