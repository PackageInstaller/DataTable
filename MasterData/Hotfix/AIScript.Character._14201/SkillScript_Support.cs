using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14201;

public class SkillScript_Support : SkillAdvancedBase
{
	private int mLoopCount = 2;

	private string key_base = "Skill_Sup_ZhuaJi";

	private string key_P24 = "Skill_Sup_ZhuaJi_P24";

	private string evt_left = "ZhuaJi_Zuo";

	private string evt_right = "ZhuaJi_You";

	private string evt_thump = "ZhuaJi_ZhongJie";

	private string evt_search = "SearchTarget";

	private const int perkId_23 = 514223;

	private int addCount_23 = 1;

	private int buff_23 = 14223011;

	private int count_23 = 4;

	private const int perkId_24 = 514224;

	private int buff_24 = 14224011;

	private int count_24 = 4;

	private string areaEffect_24 = "AreaEffect_142_SkillSup_ZhuaJi_P24_ZhongJie";

	private FP offset_24 = 4;

	private const int perkId_26 = 514226;

	private FP attackRange_26 = 10;

	private const int perkId_27 = 514227;

	private int buff_27 = 14227011;

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private int curLoopCount;

	private CoroutineNode corMain;

	private bool perk_23;

	private bool perk_24;

	private List<LogicEntity> list = new List<LogicEntity>();

	private int curCount;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		curLoopCount = 0;
		curCount = 0;
		perk_23 = GetPerkLv(514223, out var lv);
		perk_24 = GetPerkLv(514224, out lv);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		int count = mLoopCount;
		if (perk_23)
		{
			count += addCount_23;
		}
		string actionTag = (perk_24 ? key_P24 : key_base);
		LogicEntity attackTarget = GetAttackTarget();
		SkillScript_Support skillScript_Support = this;
		Action<string> action = onCustomEvent;
		System.Action action2 = onComboLoop;
		System.Action onInterrupt = SkillInterrupt;
		System.Action onComboFinish = SkillFinish;
		skillScript_Support.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, action, null, fadeOutAnim: false, action2);
		while (curLoopCount < count)
		{
			yield return null;
		}
		_actor.CancelAttack();
	}

	private void onComboLoop()
	{
		curLoopCount++;
	}

	private LogicEntity GetAttackTarget()
	{
		if (GetPerkLv(514226, out var _))
		{
			CommonUtils.SearchNearTargetsByCircle(_actor, _actor.tsTransform.Position, attackRange_26, isConfront: true, includeSelf: false, list);
			if (list.Count > 0)
			{
				return list.get_Item(TSRandom.Range(0, list.Count));
			}
			return null;
		}
		return CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}

	private void onCustomEvent(string evt)
	{
		int lv;
		if (evt.Equals(evt_left))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = castAreaEvent;
			adventureActorCustomEvent.boolParam = true;
			_actor.DispatchEvent(adventureActorCustomEvent);
			CalcCount();
			if (GetPerkLv(514227, out lv))
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.AddBuff(buff_27, _actor);
			}
		}
		else if (evt.Equals(evt_right))
		{
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.eventHashCode = castAreaEvent;
			adventureActorCustomEvent2.boolParam = false;
			_actor.DispatchEvent(adventureActorCustomEvent2);
			CalcCount();
			if (GetPerkLv(514227, out lv))
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.AddBuff(buff_27, _actor);
			}
		}
		else if (evt.Equals(evt_thump))
		{
			if (GetPerkLv(514224, out lv))
			{
				TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * offset_24));
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_24, position);
				foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
				{
					(item as AdventureActor)?.buffComponent.AddBuff(buff_24, _actor);
				}
			}
			if (GetPerkLv(514227, out lv))
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.AddBuff(buff_27, _actor);
			}
		}
		else if (evt.Equals(evt_search))
		{
			_actor.attackTarget = GetAttackTarget();
			if (_actor.attackTarget != null)
			{
				_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
			}
		}
	}

	private void CalcCount()
	{
		curCount++;
		if (perk_23 && curCount % count_23 == 0)
		{
			foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
			{
				(item as AdventureActor)?.buffComponent.AddBuff(buff_23, _actor);
			}
		}
		if (!perk_24 || curCount % count_24 != 0)
		{
			return;
		}
		foreach (LogicEntity item2 in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
		{
			(item2 as AdventureActor)?.buffComponent.AddBuff(buff_24, _actor);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
