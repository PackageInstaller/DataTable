using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214055 : DiscScriptBase
{
	private const int discId = 214055;

	private static readonly FP interval_OnStage = 5;

	private List<int> skillId_s1 = new List<int> { 405501, 405502, 405503, 405504, 405505, 405506 };

	private List<int> buffId_1 = new List<int> { 4055000, 4055000, 4055000, 4055000, 4055000, 4055000 };

	private List<int> debuffId_1 = new List<int> { 4055021, 4055022, 4055023, 4055024, 4055025, 4055026 };

	private List<int> skillId_s2 = new List<int> { 4055101, 4055102, 4055103, 4055104, 4055105 };

	private List<int> debuffId_2 = new List<int> { 4055121, 4055122, 4055123, 4055124, 4055125 };

	private List<int> skillId_s3 = new List<int> { 4055201, 4055202, 4055203, 4055204, 4055205 };

	private List<int> buffId_3_1 = new List<int> { 4055201, 4055202, 4055203, 4055204, 4055205 };

	private List<int> buffId_3_2 = new List<int> { 4055221, 4055222, 4055223, 4055224, 4055225 };

	private List<int> energyPercent_3 = new List<int> { 4055241, 4055242, 4055243, 4055244, 4055245 };

	private List<int> energyCap_3 = new List<int> { 4055246, 4055247, 4055248, 4055249, 4055250 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private Dictionary<long, CoroutineNode> _corDic;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(stage_s1, lv_s1) = GetDiscInfo(214055, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214055, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214055, skillId_s3);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		if (lv_s1 <= 0)
		{
			return;
		}
		_corDic = new Dictionary<long, CoroutineNode>(2);
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (IsWaterAssist(actorL))
			{
				StartActorCoroutine(actorL);
			}
		}
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		if (_corDic == null)
		{
			return;
		}
		foreach (CoroutineNode value in _corDic.Values)
		{
			_actor.StopLogicCoroutine(value);
		}
		_corDic.Clear();
	}

	protected override void OnPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnPlayerActorCastSkill(actor, castSkillEvent);
		if (lv_s1 > 0 && IsWaterAssist(actor) && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			AddWeiWeiToGroup();
		}
	}

	protected override void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
		base.OnActorEnter(evt);
		if (lv_s1 > 0 && IsWaterAssist(evt.player))
		{
			StartActorCoroutine(evt.player);
		}
	}

	protected override void OnActorLeave(AdventurePlayerLeaveEvent evt)
	{
		base.OnActorLeave(evt);
		StopActorCoroutine(evt.player);
	}

	private void StartActorCoroutine(PlayerAdventureActor actor)
	{
		if (!(actor == null) && _corDic != null)
		{
			if (_corDic.ContainsKey(actor.Id))
			{
				_actor.StopLogicCoroutine(_corDic.get_Item(actor.Id));
				_corDic.set_Item(actor.Id, _actor.StartLogicCoroutine(DoOnStageAddWeiWei(actor)));
			}
			else
			{
				_corDic.Add(actor.Id, _actor.StartLogicCoroutine(DoOnStageAddWeiWei(actor)));
			}
		}
	}

	private void StopActorCoroutine(PlayerAdventureActor actor)
	{
		if (!(actor == null) && _corDic != null && _corDic.TryGetValue(actor.Id, out var value))
		{
			_actor.StopLogicCoroutine(value);
			_corDic.Remove(actor.Id);
		}
	}

	private IEnumerator DoOnStageAddWeiWei(PlayerAdventureActor actor)
	{
		while (true)
		{
			yield return _actor.WaitTime(interval_OnStage);
			if (actor.isResident)
			{
				AddWeiWeiToGroup();
			}
		}
	}

	private void AddWeiWeiToGroup()
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL == null || actorL.buffComponent == null)
			{
				continue;
			}
			actorL.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), actorL);
			if (lv_s3 > 0)
			{
				actorL.buffComponent.AddBuff(buffId_3_1.get_Item(stage_s3), actorL);
				if (IsWaterAssist(actorL))
				{
					actorL.buffComponent.AddBuff(buffId_3_2.get_Item(stage_s3), actorL);
				}
			}
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (lv_s1 > 0 && evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Water) && adventureActorGetBuff.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.buffComponent.CheckBuffByBuffID(buffId_1.get_Item(stage_s1)) && adventureActorGetBuff.sender is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.buffComponent.AddBuff(debuffId_1.get_Item(stage_s1), playerAdventureActor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s2 > 0 && evt.elementType == HotfixEnum.elementType.WE && evt.triggerActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.buffComponent.CheckBuffByBuffID(buffId_1.get_Item(stage_s1)) && evt.markActor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.buffComponent.AddBuff(debuffId_2.get_Item(stage_s2), playerAdventureActor);
		}
	}

	protected override void OnPlayerActorCastSkillEnd(PlayerAdventureActor actor, AdventureActorCastSkillEndEvent castSkillEvent)
	{
		base.OnPlayerActorCastSkillEnd(actor, castSkillEvent);
		if (lv_s3 <= 0 || !IsWaterAssist(actor) || castSkillEvent.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.D)
		{
			return;
		}
		int buffNumByID = actor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1));
		if (buffNumByID > 0)
		{
			int totalEnergy = actor.playerSkillCd.GetTotalEnergy();
			FP scriptValue = CommonUtils.GetScriptValue(actor, energyPercent_3.get_Item(stage_s3));
			FP scriptValue2 = CommonUtils.GetScriptValue(actor, energyCap_3.get_Item(stage_s3));
			FP fP = totalEnergy * scriptValue * buffNumByID;
			if (fP > scriptValue2)
			{
				fP = scriptValue2;
			}
			actor.playerSkillCd.AddEnergy(fP);
		}
	}

	private bool IsWaterAssist(AdventureActor actor)
	{
		if (!(actor is PlayerAdventureActor playerAdventureActor))
		{
			return false;
		}
		if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support;
		}
		return false;
	}
}
