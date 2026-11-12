using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._14501;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string key_1_TLON = "Ultra_1_TimelineOn";

	private string key_1_TLOFF = "Ultra_1_TimelineOff";

	private string key_2 = "Ultra_2";

	private string evt_Shoot = "HuaSan";

	private string evt_Boom = "YinBaoHuaSan";

	private string fromUmbrellaPath = "145_Sp_Um_Out";

	private string toUmbrellaPath = "145_Sp_Um_In";

	private FP toTime = 0.3f;

	private const int perkId_41 = 514541;

	private string fromUmbrellaPath_41 = "145_Sp_Um_Out_P41";

	private CoroutineNode corMain;

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private UmbrellaEntity fromUmbrella;

	private UmbrellaEntity toUmbrella;

	private int castAreaEffect = CommonHelper.StringToHash("castAreaEffect");

	private bool isAim;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		isAim = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		DoMainSkill();
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void ParseKey(bool timeline)
	{
		actionKey = (timeline ? key_1_TLON : key_1_TLOFF);
	}

	private void DoMainSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			StartCoroutine(ref corMain, DoMainLogic());
		}, () =>
		{
			ParseKey(timeline: false);
			StartCoroutine(ref corMain, DoMainLogic());
		});
	}

	private IEnumerator DoMainLogic()
	{
		_actor.attackTarget = (((PlayerAdventureActor)_actor).isAssist ? CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true) : _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true, dontLostTarget: true));
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		RequestComboAttack req = skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, null, null, action);
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		SkillScript_Ultra skillScript_Ultra2 = this;
		string actionTag2 = key_2;
		action = onCustomEvent;
		System.Action onComboFinish = onFinishOrInterrupt;
		System.Action onInterrupt = onFinishOrInterrupt;
		skillScript_Ultra2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action, null, fadeOutAnim: true);
		while (isAim)
		{
			if (fromUmbrella != null)
			{
				TSVector2 normalized = (fromUmbrella.tsTransform.Position - _actor.tsTransform.Position).normalized;
				_actor.LookAtDir(normalized, 0);
			}
			yield return null;
		}
		_actor.CancelAttack();
	}

	private void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_Shoot))
		{
			string alias = (GetPerk(514541) ? fromUmbrellaPath_41 : fromUmbrellaPath);
			GameObject fXByAlias = _actor.comboGroup.relatedResourceConfig.GetFXByAlias(alias);
			fromUmbrella = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias, _actor.transform.position, _actor.transform.rotation) as UmbrellaEntity;
			fromUmbrella?.Shoot(_actor.tsTransform.Forward, default, _actor.tsTransform.Position);
		}
		else
		{
			if (!eventName.Equals(evt_Boom))
			{
				return;
			}
			isAim = false;
			if (!(fromUmbrella == null))
			{
				TSVector2 position = fromUmbrella.tsTransform.Position;
				fromUmbrella.Finish();
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.eventHashCode = castAreaEffect;
				if (adventureActorCustomEvent.tsVector2ParamList != null)
				{
					adventureActorCustomEvent.tsVector2ParamList.Add(position);
				}
				else
				{
					adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2> { position };
				}
				_actor.DispatchEvent(adventureActorCustomEvent);
				TSVector2 normalized = (_actor.tsTransform.Position - position).normalized;
				FP magnitude = (_actor.tsTransform.Position - position).magnitude;
				GameObject fXByAlias2 = _actor.comboGroup.relatedResourceConfig.GetFXByAlias(toUmbrellaPath);
				toUmbrella = SceneSingleton<SpecialEntityManager>.Instance.PlaySpecialProcess(_actor, fXByAlias2, _actor.transform.position, _actor.transform.rotation) as UmbrellaEntity;
				toUmbrella.Shoot(normalized, default, position);
				toUmbrella.SetSpeedAndLeftTime(magnitude / toTime, toTime);
			}
		}
	}
}
