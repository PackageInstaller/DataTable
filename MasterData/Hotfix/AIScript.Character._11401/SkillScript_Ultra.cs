using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11401;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string actionKey1 = "Ultra_TL";

	private const string actionKey2 = "Ultra_NoTL";

	private string evt_search = "evt_search";

	private string evt_shoot = "evt_shoot";

	private string evt_EnterBerserk = "StartRage";

	private string evt_Hide = "evt_hide";

	private string evt_Show = "evt_show";

	private FP searchRange = 30;

	private int buffMark = 11440001;

	private string areaEffect = "AreaEffect_114_Ultra_Boom";

	private const int perkId_43 = 511443;

	private CoroutineNode corMain;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private string actionKey;

	private List<LogicEntity> entities = new List<LogicEntity>();

	public int eventHashCode_EnterBerserk = CommonHelper.StringToHash("EnterBerserk");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		entities.Clear();
	}

	public void OnStart()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: false);
		_playTimeline.Play(_actor, () =>
		{
			actionKey = "Ultra_TL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			DoMainLogic(hasTimeline: true);
		}, () =>
		{
			actionKey = "Ultra_NoTL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			DoMainLogic(hasTimeline: false);
		});
	}

	private void DoMainLogic(bool hasTimeline)
	{
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinishOrInterrupt;
		Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_search))
		{
			CommonUtils.SearchNearTargetsByCircle(_actor, searchRange, isConfront: true, includeSelf: false, entities);
			{
				foreach (LogicEntity entity in entities)
				{
					(entity as MonsterAdventureActor).buffComponent.AddBuff(buffMark, _actor);
				}
				return;
			}
		}
		if (evt.Equals(evt_shoot))
		{
			foreach (LogicEntity entity2 in entities)
			{
				MonsterAdventureActor monsterAdventureActor = entity2 as MonsterAdventureActor;
				if (monsterAdventureActor != null && monsterAdventureActor.actorHealthInfo.isAlive)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, monsterAdventureActor.tsTransform.Position);
					if (!GetPerk(511443))
					{
						monsterAdventureActor?.buffComponent.RemoveBuffByBuffId(buffMark);
					}
				}
			}
			return;
		}
		if (evt.Equals(evt_EnterBerserk))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = eventHashCode_EnterBerserk;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (evt.Equals(evt_Hide))
		{
			_actor.Hide(performanceMode: true);
			_actor.PauseMovementBlock();
		}
		else if (evt.Equals(evt_Show))
		{
			_actor.Visible();
			_actor.ResumeMovementBlock();
		}
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}
}
