using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_TraceTornado_BossRush : SkillSimpleBase
{
	private static readonly string areaFx_Trace = "Area_31301JiJuXie_TraceTornado_BossRush";

	private static readonly string areaFx_IceTrace = "Area_31301JiJuXie_IceTraceTornado_BossRush";

	private readonly FP TraceTornado_Duration = 8;

	private long TraceTornado_EndFX;

	private int phase;

	private long areaEffectId;

	private bool isIced;

	private bool isBroken;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isBroken = true;
		isIced = false;
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(0);
		if (targetByTeammateIndex != null && targetByTeammateIndex.Count > 0)
		{
			phase = GetLogicTagFpValue(targetByTeammateIndex.get_Item(0), "Phase").AsInt();
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
	}

	protected override void OnSkillDisable()
	{
		StopAreaEffect_Safe();
		StopMove();
		_actor.DestroySelf();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnActorReceiveDamage);
	}

	private void OnActorReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor))
		{
			StopAreaEffect_Safe();
			StopMove();
			_actor.DestroySelf();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (phase >= 2)
		{
			isIced = true;
			areaEffectId = PlayAreaEffect(areaFx_IceTrace, GetPosition(), GetRotation());
		}
		else
		{
			areaEffectId = PlayAreaEffect(areaFx_Trace, GetPosition(), GetRotation());
		}
		yield return WaitTime(1.1);
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
