using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_GuangXian_P1_JuXingMoXiang : SkillSimpleBase
{
	private const string combo_Approach = "JuXingApproach";

	private const string combo_NLQPhase2 = "NLQPhase2";

	private static readonly string[] fromPositionHolders = new string[1] { "JuXingApproach_From_Up" };

	private static readonly string[] toPositionHolders = new string[1] { "JuXingApproach_To_Up" };

	private FP approachMoveSpeed = 8;

	private string fx_pull = "fx_m72012_loop_skill05_gravitational_field_30x30";

	private long playfx_pull;

	private bool CancelLine;

	private bool finished;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		CancelLine = false;
		finished = false;
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
	}

	protected override void OnSkillDisable()
	{
		SetHideOutEnable(autoDisableWhenSkillDisable: false);
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
		if (!finished)
		{
			ClearOwnerBullet();
			AddBuffToTarget(_actor, 720130108);
			RemoveBuffFromTarget(_actor, 720130107);
		}
		base.OnSkillDisable();
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("StopEnergyLine"))
		{
			CancelLine = true;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		int num = 0;
		TSVector2 fromPos = GetPlaceHolderPosition(fromPositionHolders[num]);
		TSVector2 toPos = GetPlaceHolderPosition(toPositionHolders[num]);
		Teleport(fromPos, checkPositionReachable: false);
		BeginLookAtByPos(new TSVector2(0, 0), default, 1000);
		yield return WaitTime(0.1);
		AddBuffToTarget(_actor, 720130109);
		AddBuffToTarget(_actor, 720130107);
		FP origSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(toPos, 0.2f);
		PlayWwiseSound("mon_72012_move");
		yield return WaitMoveStatus();
		_actor.actorInfo.runSpeed = origSpeed;
		_actor.actorInfo.walkSpeed = origSpeed;
		BeginAttack(1, "NLQPhase2", flushInputedKeys: true);
		yield return WaitTime(0.5f);
		while (!CancelLine)
		{
			yield return WaitTime(0.1f);
		}
		CancelAttack();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
		AimAtPosition(TSVector2.zero, 1000);
		FP retSpeed = _actor.actorInfo.runSpeed;
		_actor.actorInfo.runSpeed = approachMoveSpeed;
		_actor.actorInfo.walkSpeed = approachMoveSpeed;
		MoveToPosition(fromPos, 0.2f);
		yield return WaitMoveStatus();
		AddBuffToTarget(_actor, 720130108);
		RemoveBuffFromTarget(_actor, 720130107);
		_actor.actorInfo.runSpeed = retSpeed;
		_actor.actorInfo.walkSpeed = retSpeed;
		CancelAim();
	}
}
