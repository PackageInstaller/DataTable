using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14701;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string key_1 = "Ultra_TimelineOn";

	private string key_2 = "Ultra_TimelineOff";

	private string evt_castUltra = "147UltraAtk_Begin";

	private string evt_castUltra2 = "147UltraAtk_Begin2";

	private string evt_castSound = "147UltraAtk_P43_OneHit";

	private string evt_Input = "147Turn";

	private CoroutineNode corMain;

	private CoroutineNode corSupport;

	private string actionKey;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private int castUltra = CommonHelper.StringToHash("CastUltra");

	private int castUltra2 = CommonHelper.StringToHash("CastUltra2");

	private const int perkId_8 = 514708;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		(_actor as PlayerAdventureActor).searchType = PlayerActorSearchType.Melee;
		(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Melee;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		StopCoroutine(ref corMain);
		StopCoroutine(ref corSupport);
		(_actor as PlayerAdventureActor).searchType = PlayerActorSearchType.Range;
		(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Range;
	}

	public void OnStart()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			DoSupportSkill();
		}
		else
		{
			DoMainSkill();
		}
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainSkill()
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

	private void ParseKey(bool timeline)
	{
		actionKey = (timeline ? key_1 : key_2);
	}

	private void DoMainLogic()
	{
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = onFinishOrInterrupt;
		System.Action onInterrupt = onFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void DoSupportSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			DoSupportLogic();
		}, () =>
		{
			ParseKey(timeline: false);
			DoSupportLogic();
		});
	}

	private void DoSupportLogic()
	{
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = onFinishOrInterrupt;
		System.Action onInterrupt = onFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string eventName)
	{
		int lv;
		if (eventName.Equals(evt_castUltra))
		{
			if (GetPerkLv(514708, out lv))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.eventHashCode = castUltra;
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
		else if (eventName.Equals(evt_castUltra2))
		{
			if (GetPerkLv(514708, out lv))
			{
				AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent2.eventHashCode = castUltra2;
				_actor.DispatchEvent(adventureActorCustomEvent2);
			}
		}
		else if (eventName.Equals(evt_Input))
		{
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				_actor.LookAtDir(movementInputDirection, 0);
			}
			else if (_actor.attackTarget != null)
			{
				movementInputDirection = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				_actor.LookAtDir(movementInputDirection, 0);
			}
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
