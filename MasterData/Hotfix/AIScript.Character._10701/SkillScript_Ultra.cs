using System;
using AdventureBehaviour;

namespace AIScript.Character._10701;

public class SkillScript_Ultra : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys_Timeline = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.U };

	protected readonly ComboInputBuffer.ActionKey[] actionKeys_NoTimeline = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };

	private const string playAreaEffectEvent = "107_HeartStone_06";

	private const string areaEffectKey = "AreaEffect_107_Ultra_HeartStone_06";

	protected PlayTimeline _playTimeline;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.EnableCloseBlock();
		if (!GetPerk(Parallel.perk_43))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (!playerAdventureActor.isDead)
			{
				playerAdventureActor.buffComponent?.AddBuff(10743011, _actor);
			}
		}
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	protected void OnPlayTimeLineFinish()
	{
		LockDirection();
		ComboInputBuffer.ActionKey[] keys = actionKeys_Timeline;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnNotPlayTimeLine()
	{
		LockDirection();
		ComboInputBuffer.ActionKey[] keys = actionKeys_NoTimeline;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "107_HeartStone_06"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_107_Ultra_HeartStone_06", _actor.tsTransform.Position);
		}
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
	}
}
