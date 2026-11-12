using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_Level._16510FengCao;

public class Skill_Change_Easy : SkillSimpleBase
{
	private static readonly string StartChange_Event = "Change";

	private static readonly string StopNext_Event = "StopNext";

	private static readonly string AddBuff_Event1 = "AddBuffEvent_01";

	private static readonly string AddBuff_Event2 = "AddBuffEvent_02";

	private static readonly string MoveBuff_Event = "movebuff";

	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private FP TargetDis;

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		TargetDis = Distance(GetPosition(), new TSVector2(0, 0));
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 505210310);
		RemoveBuffFromTarget(_actor, 990010030);
	}

	protected override IEnumerator DoMainLogic()
	{
		AddBuffToTarget(_actor, 505210310);
		AddBuffToTarget(_actor, 990010030);
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		SetLockToughnessEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Fire"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Water"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Wind"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Light"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Dark"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Earth"));
		BeginLookAtByPos(new TSVector2(0, 0), 0.2, 2000, 0);
		yield return WaitTime(1);
		BeginDashActorForward(1, 60, TargetDis, 360, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginLookAtByPos(new TSVector2(0, -10), 0.2, 2000, 0);
		yield return WaitTime(1);
		CancelAttack();
		yield return WaitCustomEvent(StartChange_Event);
		ReplaceAnimationGroup();
		yield return WaitCustomEvent(MoveBuff_Event);
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 505210310);
		RemoveBuffFromTarget(_actor, 990010030);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int startKeyIndex1, string eventName)
	{
		if (eventName.Equals(AddBuff_Event1))
		{
			AddBuffToTarget(_actor, 160510110);
		}
		else if (eventName.Equals(AddBuff_Event2))
		{
			AddBuffToTarget(_actor, 160510120);
		}
	}
}
