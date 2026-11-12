using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._14201;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private int mLoopCount = 2;

	private string key_base = "Skill_Sup_ZhuaJi";

	private string key_P3 = "Skill_Sup_ZhuaJi_P24";

	private string evt_left = "ZhuaJi_Zuo";

	private string evt_right = "ZhuaJi_You";

	private string evt_thump = "ZhuaJi_ZhongJie";

	private string evt_search = "SearchTarget";

	private int perkId_3 = 1420103;

	private int addCount_3 = 4;

	private string areaEffect_3_thump = "AreaEffect_142_SkillSup_ZhuaJi_P24_ZhongJie";

	private FP offset_3_thump = 4;

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private FP searchRange = 7.5;

	private readonly List<LogicEntity> entities = new List<LogicEntity>();

	private int curLoopCount;

	private int curCount;

	private bool perk_3;

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		curLoopCount = 0;
		curCount = 0;
		perk_3 = GetPerk(perkId_3);
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
		if (perk_3)
		{
			count += addCount_3;
		}
		string actionTag = (perk_3 ? key_P3 : key_base);
		LogicEntity attackTarget = SearchNearestTarget();
		_actor.attackTarget = attackTarget;
		SkillScript_Skill skillScript_Skill = this;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboLoop = OnComboLoop;
		System.Action onInterrupt = SkillInterrupt;
		System.Action onComboFinish = SkillFinish;
		skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
		while (curLoopCount < count)
		{
			yield return null;
		}
		_actor.CancelAttack();
	}

	private void OnComboLoop()
	{
		curLoopCount++;
	}

	private LogicEntity SearchNearestTarget()
	{
		CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, searchRange, entities, isConfront: true);
		if (entities.Count <= 0)
		{
			return null;
		}
		return entities.get_Item(0);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals(evt_left))
		{
			CalcCount();
			DispatchCastArea(isLeft: true);
		}
		else if (evt.Equals(evt_right))
		{
			CalcCount();
			DispatchCastArea(isLeft: false);
		}
		else if (evt.Equals(evt_thump))
		{
			if (perk_3)
			{
				TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * offset_3_thump));
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_3_thump, position);
			}
		}
		else if (evt.Equals(evt_search))
		{
			_actor.attackTarget = SearchNearestTarget();
			if (_actor.attackTarget != null)
			{
				_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
			}
		}
	}

	private void DispatchCastArea(bool isLeft)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = castAreaEvent;
		adventureActorCustomEvent.boolParam = isLeft;
		adventureActorCustomEvent.intParam = curCount;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private void CalcCount()
	{
		curCount++;
	}

	private void AddBuffToTeam(int buffId)
	{
		List<LogicEntity> list = ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true);
		for (int i = 0; i < list.Count; i++)
		{
			(list.get_Item(i) as AdventureActor)?.buffComponent.AddBuff(buffId, _actor);
		}
	}
}
