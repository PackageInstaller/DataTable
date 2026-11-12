using System.Collections;
using TrueSync;

namespace AIScript.Monster._15011ZhongZhuangZhongYe;

public class Skill2_Charge : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected readonly FP dash_spd = 10.5f;

	protected readonly FP dash_angleLimit = 60;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 300);
		yield return WaitTime(0.4);
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		FP fP = _actor.DistanceWithRadius(target);
		FP dis = fP + 5f;
		yield return WaitTime(2);
		doDash(dis);
		BeginLookAt_NotWait(target, 1.5, 60);
		yield return WaitTime(dis / dash_spd);
		CancelAttack();
		yield return WaitTime(1.3);
		BeginLookAt_NotWait(target, 0.8, 300);
		yield return WaitTime(1);
	}

	private void doDash(FP dis)
	{
		BeginDashActorForward(1, dash_spd, dis, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}
}
