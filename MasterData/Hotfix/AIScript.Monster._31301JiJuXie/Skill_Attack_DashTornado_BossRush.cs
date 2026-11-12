using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_DashTornado_BossRush : SkillSimpleBase
{
	private static readonly string areaFx_Dash = "Area_31301JiJuXie_DashTornado_BossRush";

	public static readonly string areaFx_IceDash = "Area_31301JiJuXie_IceDashTornado_BossRush";

	private readonly FP DashTornado_DashSpeed = 30;

	private readonly FP DashTornado_DashDistance = 25;

	private long WarningFX;

	private long TraceTornado_EndFX;

	private bool isBroken;

	private int phase;

	private long areaEffectId;

	private bool isAreaPlaying;

	private bool isIced;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(0);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			phase = GetLogicTagFpValue(targetByTeammateIndex.get_Item(0), "Phase").AsInt();
		}
		isIced = false;
		isBroken = true;
	}

	protected override void OnSkillDisable()
	{
		StopAreaEffect_Safe();
		StopDash();
		_actor.DestroySelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (phase >= 2)
		{
			isIced = true;
			areaEffectId = PlayAreaEffect(areaFx_IceDash, GetPosition(), GetRotation());
		}
		else
		{
			areaEffectId = PlayAreaEffect(areaFx_Dash, GetPosition(), GetRotation());
		}
		isAreaPlaying = true;
		yield return WaitTime(1.1);
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
		Skill_Attack_DashTornado_BossRush skill_Attack_DashTornado_BossRush = this;
		Skill_Attack_DashTornado_BossRush skill_Attack_DashTornado_BossRush2 = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Attack_DashTornado_BossRush.WarningFX = skill_Attack_DashTornado_BossRush2.PlayEarlyWarningEffect("fx_warning_dash_2x20", 0.9f, default, position, rotation, 2f);
		yield return WaitTime(0.9);
		BeginDashActorForward(1, DashTornado_DashSpeed, DashTornado_DashDistance, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
		yield return WaitDashFinish();
		if (!isIced)
		{
			StopAreaEffect(areaEffectId);
			TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_water_end", 1f, 0, GetPosition(), 0);
		}
		else
		{
			StopAreaEffect(areaEffectId);
			TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_ice_end", 1f, 0, GetPosition(), 0);
		}
		isBroken = false;
		yield return WaitTime(6);
	}

	private void StopAreaEffect_Safe()
	{
		if (isAreaPlaying)
		{
			StopAreaEffect(areaEffectId);
			isAreaPlaying = false;
			areaEffectId = 0L;
		}
		if (isBroken)
		{
			if (!isIced)
			{
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_water_end", 1f, 0, GetPosition(), 0);
			}
			else
			{
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_ice_end", 1f, 0, GetPosition(), 0);
			}
		}
	}
}
