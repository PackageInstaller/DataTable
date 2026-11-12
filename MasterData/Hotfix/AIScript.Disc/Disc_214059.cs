using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214059 : DiscScriptBase
{
	private const int discId = 214059;

	private const int xiJiThreshold_5 = 5;

	private const int xiJiThreshold_10 = 10;

	private List<int> skillId_s1 = new List<int> { 405901, 405902, 405903, 405904, 405905, 405906 };

	private List<int> buffId_1 = new List<int> { 4059000, 4059000, 4059000, 4059000, 4059000, 4059000 };

	private List<int> debuffId_1_normal = new List<int> { 4059011, 4059012, 4059013, 4059014, 4059015, 4059016 };

	private List<int> debuffId_1_all = new List<int> { 4059021, 4059022, 4059023, 4059024, 4059025, 4059026 };

	private List<int> skillId_s2 = new List<int> { 4059101, 4059102, 4059103, 4059104, 4059105 };

	private List<int> onceId_2_1 = new List<int> { 4059111, 4059112, 4059113, 4059114, 4059115 };

	private List<int> onceId_2_2 = new List<int> { 4059121, 4059122, 4059123, 4059124, 4059125 };

	private List<int> skillId_s3 = new List<int> { 4059201, 4059202, 4059203, 4059204, 4059205 };

	private List<int> buffId_3_1 = new List<int> { 4059211, 4059212, 4059213, 4059214, 4059215 };

	private List<int> buffId_3_2 = new List<int> { 4059221, 4059222, 4059223, 4059224, 4059225 };

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
		(stage_s1, lv_s1) = GetDiscInfo(214059, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214059, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214059, skillId_s3);
		if (lv_s1 <= 0)
		{
			return;
		}
		_corDic = new Dictionary<long, CoroutineNode>(2);
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (IsWindBalance(actorL))
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

	protected override void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
		base.OnActorEnter(evt);
		if (lv_s1 > 0 && IsWindBalance(evt.player))
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
				_corDic.set_Item(actor.Id, _actor.StartLogicCoroutine(DoAddXiJi(actor)));
			}
			else
			{
				_corDic.Add(actor.Id, _actor.StartLogicCoroutine(DoAddXiJi(actor)));
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

	private IEnumerator DoAddXiJi(PlayerAdventureActor actor)
	{
		while (true)
		{
			yield return _actor.WaitTime(1);
			if (actor.isResident)
			{
				_actor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), _actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0)
		{
			int buffNumByID = actor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1));
			if (buffNumByID >= 5)
			{
				target.buffComponent.AddBuff(debuffId_1_normal.get_Item(stage_s1), actor);
			}
			if (buffNumByID >= 10)
			{
				target.buffComponent.AddBuff(debuffId_1_all.get_Item(stage_s1), actor);
			}
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s2 <= 0)
		{
			return;
		}
		if (IsWindBalance(actor) && (damageEvent.damageType == HotfixEnum.damageType.NORMAL || damageEvent.damageType == HotfixEnum.damageType.SKILL))
		{
			AdventureActor.AddFromAttr(onceId_2_1.get_Item(stage_s2), actor);
		}
		if (damageEvent.damageType == HotfixEnum.damageType.SKILL)
		{
			int buffNumByID = actor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1));
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(onceId_2_2.get_Item(stage_s2), actor, buffNumByID);
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s3 <= 0 || evt.elementType != HotfixEnum.elementType.AE)
		{
			return;
		}
		AdventureActor triggerActor = evt.triggerActor;
		if ((object)triggerActor != null && !(triggerActor.buffComponent == null) && triggerActor.buffComponent.GetBuffNumByID(buffId_1.get_Item(stage_s1)) > 0)
		{
			if (evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType1)
			{
				AddBuffToGroup(buffId_3_1.get_Item(stage_s3));
			}
			else if (evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType2)
			{
				AddBuffToGroup(buffId_3_2.get_Item(stage_s3));
			}
		}
	}

	private bool IsWindBalance(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance;
		}
		return false;
	}
}
