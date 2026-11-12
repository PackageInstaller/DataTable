using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214056 : DiscScriptBase
{
	private const int discId = 214056;

	private static readonly FP interval_OnStage = 5;

	private List<int> skillId_s1 = new List<int> { 405601, 405602, 405603, 405604, 405605, 405606 };

	private List<int> buffId_1_1 = new List<int> { 4056001, 4056002, 4056003, 4056004, 4056005, 4056006 };

	private List<int> buffId_1_2 = new List<int> { 4056011, 4056012, 4056013, 4056014, 4056015, 4056016 };

	private List<int> skillId_s2 = new List<int> { 4056101, 4056102, 4056103, 4056104, 4056105 };

	private List<int> buffId_2 = new List<int> { 4056121, 4056122, 4056123, 4056124, 4056125 };

	private List<int> skillId_s3 = new List<int> { 4056201, 4056202, 4056203, 4056204, 4056205 };

	private List<int> attrId_3 = new List<int> { 4056211, 4056212, 4056213, 4056214, 4056215 };

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
		(stage_s1, lv_s1) = GetDiscInfo(214056, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214056, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214056, skillId_s3);
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
			AddLuoLuoToGroup();
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
				_corDic.set_Item(actor.Id, _actor.StartLogicCoroutine(DoOnStageAddLuoLuo(actor)));
			}
			else
			{
				_corDic.Add(actor.Id, _actor.StartLogicCoroutine(DoOnStageAddLuoLuo(actor)));
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

	private IEnumerator DoOnStageAddLuoLuo(PlayerAdventureActor actor)
	{
		while (true)
		{
			yield return _actor.WaitTime(interval_OnStage);
			if (actor.isResident)
			{
				AddLuoLuoToGroup();
			}
		}
	}

	private void AddLuoLuoToGroup()
	{
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (!(actorL == null) && !(actorL.buffComponent == null))
			{
				actorL.buffComponent.AddBuff(buffId_1_1.get_Item(stage_s1), actorL);
				if (lv_s2 > 0)
				{
					actorL.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), actorL);
				}
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s1 > 0 && evt.elementType == HotfixEnum.elementType.WE && evt.triggerActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.buffComponent.CheckBuffByBuffID(buffId_1_1.get_Item(stage_s1)))
		{
			playerAdventureActor.buffComponent.AddBuff(buffId_1_2.get_Item(stage_s1), playerAdventureActor);
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s3 > 0 && damageEvent.skillSlotType == HotfixEnum.skillSlotType.B && actor.buffComponent.HaveBuffNumMax(buffId_1_1.get_Item(stage_s1)))
		{
			AdventureActor.AddFromAttr(attrId_3.get_Item(stage_s3), actor);
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
