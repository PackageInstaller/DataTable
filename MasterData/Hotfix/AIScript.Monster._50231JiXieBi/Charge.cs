#define LOG_DEBUG
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50231JiXieBi;

public class Charge : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly FP dash_spd = 18.5f;

	protected readonly FP dash_angleLimit = 60;

	protected readonly string fx_dash = "fx_m50231_loop_Skill1_crush";

	protected FP dis;

	private PlayFX _playFx;

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
		BeginLookAt_NotWait(target, 0.6, 180);
		yield return WaitTime(1.6);
		FP fP = _actor.DistanceWithRadius(target);
		if (fP <= 6f)
		{
			dis = fP + 8f;
		}
		else
		{
			dis = fP + 5f;
		}
		NovaLogger.Debug($"距离值: {dis}");
		doDash(dis);
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
