using System.Collections;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_Attack_Whirlwind : SkillSimpleBase
{
	private const string areaAlias_Whirlwind = "";

	private FP dashSpeed = 16;

	private FP dashDistance = 25;

	private FP warningTime = 1;

	private long areaEffectId;

	private bool isAreaPlaying;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isAreaPlaying = false;
	}

	protected override void OnSkillDisable()
	{
		StopAreaEffect_Safe();
		StopDash();
		_actor.DestroySelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		areaEffectId = PlayAreaEffect("", GetPosition(), GetRotation());
		isAreaPlaying = true;
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (logicEntity != null)
		{
			BeginLookAt_NotWait(logicEntity, 0.1, 7200);
		}
		yield return WaitTime(0.1);
		Skill_Attack_Whirlwind skill_Attack_Whirlwind = this;
		float duration = (float)warningTime;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Attack_Whirlwind.PlayEarlyWarningEffect("", duration, default, position, rotation);
		yield return WaitTime(warningTime);
		BeginDashActorForward(1, dashSpeed, dashDistance, 720, comboWithAttack: false, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
		yield return WaitDashFinish();
		StopAreaEffect_Safe();
	}

	private void StopAreaEffect_Safe()
	{
		if (isAreaPlaying)
		{
			StopAreaEffect(areaEffectId);
			isAreaPlaying = false;
			areaEffectId = 0L;
		}
	}
}
