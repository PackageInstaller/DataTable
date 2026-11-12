using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_DiffusePollen_02_2rd : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };

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

	protected override IEnumerator DoMainLogic()
	{
		_actor.buffComponent.AddBuff(505210310, _actor);
		_actor.buffComponent.AddBuff(990010030, _actor);
		BeginAttack(startKeyIndex1, startKey1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginLookAtByPos(new TSVector2(0, 0), 0.2, 2000, 0);
		yield return WaitTime(1);
		BeginDashActorForward(1, 60, TargetDis, 360, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		BeginLookAt_NotWait(AttackTarget, 1, 540);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		ShowBlood(isShow: true);
		_actor.buffComponent.RemoveBuffByBuffId(505210310);
		_actor.buffComponent.RemoveBuffByBuffId(990010030);
	}
}
