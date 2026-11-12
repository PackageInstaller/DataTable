using System;
using System.Collections.Generic;
using AdventureBehaviour;

namespace AIScript.Character._14901;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		if (GetPerk(514943))
		{
			ILRuntimeAPI.SearchByRange(_actor, 10, (List<LogicEntity> enemys) =>
			{
				if (enemys != null && enemys.Count >= 1)
				{
					for (int i = 0; i < enemys.Count; i++)
					{
						MonsterAdventureActor monsterAdventureActor = enemys.get_Item(i) as MonsterAdventureActor;
						if (monsterAdventureActor != null)
						{
							monsterAdventureActor.buffComponent.AddBuff(14943011, _actor);
							if (monsterAdventureActor.monsterInfo.epicType == Config.monsterEventType)
							{
								monsterAdventureActor.buffComponent.AddBuff(14943012, _actor);
							}
						}
					}
				}
			}, isConfront: true);
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	private void OnPlayTimeLineFinish()
	{
		string text = "149_Ultra_TL";
		if (GetPerk(514941))
		{
			text = "149_Ultra_P41_TL";
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnNotPlayTimeLine()
	{
		string text = "149_Ultra_NoTL";
		if (GetPerk(514941))
		{
			text = "149_Ultra_P41_NoTL";
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
	}
}
