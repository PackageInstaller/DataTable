using System.Collections;
using TrueSync;

namespace AIScript.Monster._50121DunWei;

internal class Skill_Defense_Earth : SkillSimpleBase
{
	private static readonly FP DefenseTime = 3;

	private static readonly int DefenseBuffID = 990010300;

	private static readonly int BuffID2 = 990020010;

	private static readonly string CustomEventName_StartLookAt = "StartLookAt";

	private static readonly string CustomEventName_StopLookAt = "StopLookAt";

	private static readonly string CustomEventName_Attack = "Attack";

	private static readonly string DefenseFX = "fx_50121dunwei_hit_dun_behit_Earth";

	private static readonly string AttackAreaEffect = "50121DunWei_Attack_earth";

	private static readonly string AttackAreaEffectFX = "fx_50121dunwei_base_attack_Earth";

	private static readonly ComboInputBuffer.ActionKey[] ActionKey_Defense = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] ActionKey_Break = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private LogicEntity AttackTarget;

	private FP RotateSpeed;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget();
		RotateSpeed = GetRotSpdInSkill();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		_actor.buffComponent.RemoveBuffByBuffId(DefenseBuffID);
		_actor.buffComponent.RemoveBuffByBuffId(BuffID2);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, ActionKey_Defense);
		yield return WaitCustomEvent(CustomEventName_StartLookAt);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		if (AttackTarget != null)
		{
			BeginLookAt(AttackTarget, 3, RotateSpeed);
		}
		AddBuffToTarget(_actor, DefenseBuffID);
		yield return WaitTime(DefenseTime);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		CancelAttack();
		yield return WaitCustomEvent(CustomEventName_Attack);
		PlayEffect(AttackAreaEffectFX, 1f, 1, GetPosition(), GetRotation(), 1f, actorScale: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (eventName == CustomEventName_StopLookAt)
		{
			StopWaitLookAt();
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		AdventureActor adventureActor = adventureActorReceiveDamageBeforeHitEvent.to as AdventureActor;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor && adventureActor == _actor)
		{
			_actor.monsterTarget = adventureActorReceiveDamageBeforeHitEvent.from;
			BeHitBreak();
		}
	}

	private void BeHitBreak()
	{
		if (CalcAngleBetweenSelfAndAttackTarget() >= 90)
		{
			InterruptSkill();
			BeginAttack(2, ActionKey_Break);
		}
		else
		{
			PlayEffect(DefenseFX, 1f, 0, GetPosition(), GetRotation());
		}
	}
}
