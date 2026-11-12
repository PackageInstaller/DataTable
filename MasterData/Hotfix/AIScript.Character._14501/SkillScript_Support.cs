using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14501;

public class SkillScript_Support : SkillAdvancedBase
{
	private string key_Base = "Skill_Sup";

	private string evt_shoot = "SteelRain";

	private string areaEffect_Kuwu = "AreaEffect_145_SkilSup_SteelRain";

	private string areaEffect_Kuwu_P24 = "AreaEffect_145_SkilSup_SteelRain_P24";

	private FP offset = 2;

	private int perkId_24 = 514524;

	private FP delayTime_24 = 2;

	private const int perkId_28 = 514528;

	private int paramId_2_speedPercent = 14528001;

	private CoroutineNode corShoot;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corShoot);
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		string actionTag = key_Base;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, assistantAttackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (!evt.Equals(evt_shoot))
		{
			return;
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Kuwu, _actor.tsTransform.Position + _actor.tsTransform.Forward * offset, _actor.tsTransform.Rotation, null, null, (AreaEffectEntity entity) =>
		{
			if (GetPerk(514528))
			{
				AreaEffect_MoveComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_MoveComponent>();
				if (areaEffectComponent != null)
				{
					FP fP = 1 - CommonUtils.GetScriptValue(_actor, paramId_2_speedPercent);
					areaEffectComponent.Speed *= fP;
				}
			}
		});
		if (!GetPerk(perkId_24))
		{
			return;
		}
		bool flag = true;
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL.actorElementInfo.elementType != HotfixEnum.elementType.DE)
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			StartCoroutine(ref corShoot, DelayShoot(delayTime_24, _actor.tsTransform.Position + _actor.tsTransform.Forward * offset, _actor.tsTransform.Forward));
		}
	}

	private IEnumerator DelayShoot(FP delayTime, TSVector2 pos, TSVector2 forward)
	{
		yield return _actor.WaitTime(delayTime);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_Kuwu_P24, pos, _actor.tsTransform.Rotation, null, null, (AreaEffectEntity entity) =>
		{
			if (GetPerk(514528))
			{
				AreaEffect_MoveComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_MoveComponent>();
				if (areaEffectComponent != null)
				{
					FP fP = 1 - CommonUtils.GetScriptValue(_actor, paramId_2_speedPercent);
					areaEffectComponent.Speed *= fP;
				}
			}
		});
	}
}
