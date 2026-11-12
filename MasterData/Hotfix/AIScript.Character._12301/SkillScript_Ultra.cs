using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string Ultra_TL = "Ultra_TL";

	private string Ultra_NoTL = "Ultra_NoTL";

	private string Ultra_TLH6 = "Ultra_TLH6";

	private string Ultra_NoTL_H6 = "Ultra_NoTLH6";

	private readonly FP checkDistance = 25;

	private int bullutCount;

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
	}

	public void OnStart()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			DoMainLogic();
		}, () =>
		{
			ParseKey(timeline: false);
			DoMainLogic();
		});
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	private void ParseKey(bool timeline)
	{
		if (timeline)
		{
			actionKey = Ultra_TL;
		}
		else
		{
			actionKey = Ultra_NoTL;
		}
	}

	private void DoMainLogic()
	{
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		string actionTag = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		int perkLevel;
		if (string.Equals(evt, Parallel.evt_clear))
		{
			List<AdventureBulletBase> list = new List<AdventureBulletBase>();
			_actor.QueryEnemyBullets(list);
			bullutCount = 0;
			for (int i = 0; i < list.Count; i++)
			{
				if (list.get_Item(i).canBeBlock && TSVector2.Distance(list.get_Item(i).tsTransform.Position, _actor.tsTransform.Position) < checkDistance)
				{
					bullutCount++;
					list.get_Item(i).Kill();
				}
			}
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null)
			{
				if (bullutCount > 0 && CheckTalentLevel(3))
				{
					playerAdventureActor.buffComponent.AddBuff(12396311, _actor);
				}
				if (GetPerk(Parallel.personalPerkId_43))
				{
					bullutCount = ((bullutCount < Parallel.count_p43) ? bullutCount : Parallel.count_p43);
					playerAdventureActor.playerSkillCd.AddEnergy(CommonUtils.GetScriptValue(_actor, 12343001) * bullutCount);
				}
				if (GetPerk(Parallel.personalPerkId_41))
				{
					playerAdventureActor.actorShield.AddShield(12354101, _actor);
				}
			}
		}
		else if (evt.Equals(Parallel.evt_p42) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, Parallel.personalPerkId_42, out perkLevel))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * Parallel.dis_p42;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_123_Ultra_T42", position, _actor.tsTransform.Rotation);
		}
	}
}
