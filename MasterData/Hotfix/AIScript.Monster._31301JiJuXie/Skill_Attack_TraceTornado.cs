using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_TraceTornado : SkillSimpleBase
{
	private static readonly string areaFx_Trace = "Area_31301JiJuXie_TraceTornado";

	private static readonly string areaFx_IceTrace = "Area_31301JiJuXie_IceTraceTornado";

	private readonly FP TraceTornado_Duration = 8;

	private long TraceTornado_EndFX;

	private long areaEffectId;

	private bool isIced;

	private bool isBroken;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isBroken = true;
		isIced = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		StopAreaEffect_Safe();
		StopMove();
	}

	private void OnAreaEffectEnterExit(IEvent evt)
	{
		if (!isIced && evt is AdventureAreaEnterExitEvent { iEnter: not false, sender: AreaEffectEntity sender } adventureAreaEnterExitEvent && sender.CheckTag(Config.areaTag_IceMist) && !(adventureAreaEnterExitEvent.triggerCollider == null) && !(adventureAreaEnterExitEvent.triggerCollider.Entity != _actor))
		{
			StopAreaEffect(areaEffectId);
			areaEffectId = PlayAreaEffect(areaFx_IceTrace, GetPosition(), GetRotation());
			isIced = true;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		areaEffectId = PlayAreaEffect(areaFx_Trace, GetPosition(), GetRotation());
		yield return WaitTime(0.8);
		LogicEntity target = GetAttackTarget();
		if (target == null)
		{
			target = GetCurrentPlayer();
		}
		if (target != null)
		{
			yield return WaitTime(0.8);
			for (FP remain = TraceTornado_Duration; remain >= 0.5; remain -= (FP)0.5)
			{
				BeginTrace(target, 0, -1, 0.5);
				yield return WaitTime(0.5);
			}
		}
		else
		{
			yield return WaitTime(TraceTornado_Duration);
		}
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
		yield return WaitTime(1);
		_actor.DestroySelf();
	}

	private void StopAreaEffect_Safe()
	{
		if (isBroken)
		{
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
		}
		areaEffectId = 0L;
	}
}
