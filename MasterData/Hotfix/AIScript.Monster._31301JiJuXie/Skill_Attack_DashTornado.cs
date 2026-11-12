using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_DashTornado : SkillSimpleBase
{
	private static readonly string areaFx_Dash = "Area_31301JiJuXie_DashTornado";

	public static readonly string areaFx_IceDash = "Area_31301JiJuXie_IceDashTornado";

	private readonly FP DashTornado_DashSpeed = 16;

	private readonly FP DashTornado_DashDistance = 25;

	private long WarningFX;

	private long TraceTornado_EndFX;

	private bool isBroken;

	private long areaEffectId;

	private bool isAreaPlaying;

	private bool isIced;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isIced = false;
		isBroken = true;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		StopAreaEffect_Safe();
		StopDash();
		_actor.DestroySelf();
	}

	private void OnAreaEffectEnterExit(IEvent evt)
	{
		if (!isIced && evt is AdventureAreaEnterExitEvent { iEnter: not false, sender: AreaEffectEntity sender } adventureAreaEnterExitEvent && sender.CheckTag(Config.areaTag_IceMist) && !(adventureAreaEnterExitEvent.triggerCollider == null) && !(adventureAreaEnterExitEvent.triggerCollider.Entity != _actor))
		{
			if (isAreaPlaying)
			{
				StopAreaEffect(areaEffectId);
				isAreaPlaying = false;
			}
			areaEffectId = PlayAreaEffect(areaFx_IceDash, GetPosition(), GetRotation());
			isAreaPlaying = true;
			isIced = true;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		areaEffectId = PlayAreaEffect(areaFx_Dash, GetPosition(), GetRotation());
		isAreaPlaying = true;
		yield return WaitTime(0.8);
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
		Skill_Attack_DashTornado skill_Attack_DashTornado = this;
		Skill_Attack_DashTornado skill_Attack_DashTornado2 = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Attack_DashTornado.WarningFX = skill_Attack_DashTornado2.PlayEarlyWarningEffect("fx_warning_dash_2x20", 1.2f, default, position, rotation, 2f);
		yield return WaitTime(1.2);
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
