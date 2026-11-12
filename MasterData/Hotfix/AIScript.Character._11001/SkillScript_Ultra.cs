using System;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._11001;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string Ultra_TL = "110_Ultra_TL";

	private string Ultra_NoTL = "110_Ultra_NoTL";

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		AimDirec();
		_actor.EnableCloseBlock();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void AimDirec()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
	}

	public void OnStart()
	{
		if (GetPerk(511041))
		{
			int count = Parallel.fsEntitys.Count;
			if (count > 0)
			{
				_actor.buffComponent.AddBuffNum(11054111, count, _actor);
			}
			if (Parallel.fsEntitys.Count > 0)
			{
				for (int i = 0; i < Parallel.fsEntitys.Count; i++)
				{
					_actor.PlayMovableFx("fx_11001_bullet_T41_EnergyAbsorb", Parallel.fsEntitys.get_Item(i).transform.position, _actor.transform.position, 5f);
					(Parallel.fsEntitys.get_Item(i) as AdventureActor).DestroySelf();
				}
			}
		}
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

	private void Clear()
	{
		_playTimeline?.Clear();
		_actor.DisableInvincible();
		_actor.DisableCloseBlock();
		if (GetPerk(511041))
		{
			_actor.buffComponent?.RemoveBuffByBuffId(11054111);
		}
		if (GetPerk(511043))
		{
			_actor.buffComponent?.RemoveBuffByBuffId(11043011);
		}
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
		string actionTag = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
	}
}
