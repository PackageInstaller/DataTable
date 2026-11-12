using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214051 : DiscScriptBase
{
	private const int discId = 214051;

	private List<int> skillId_s1 = new List<int> { 405101, 405102, 405103, 405104, 405105, 405106 };

	private List<int> buffId_1 = new List<int> { 4051001, 4051002, 4051003, 4051004, 4051005, 4051006 };

	private List<int> debuffId_1 = new List<int> { 4051021, 4051022, 4051023, 4051024, 4051025, 4051026 };

	private List<int> skillId_s2 = new List<int> { 4051101, 4051102, 4051103, 4051104, 4051105 };

	private List<int> buffId_2 = new List<int> { 4051121, 4051122, 4051123, 4051124, 4051125 };

	private List<int> skillId_s3 = new List<int> { 4051201, 4051202, 4051203, 4051204, 4051205 };

	private List<int> buffId_3_1 = new List<int> { 4051201, 4051202, 4051203, 4051204, 4051205 };

	private List<int> buffId_3_2 = new List<int> { 4051221, 4051222, 4051223, 4051224, 4051225 };

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
		(stage_s1, lv_s1) = GetDiscInfo(214051, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214051, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214051, skillId_s3);
		if (lv_s1 > 0)
		{
			_corDic = new Dictionary<long, CoroutineNode>(2);
			if (IsLightBalance(_actor))
			{
				StartActorCoroutine(_actor as PlayerAdventureActor);
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
		if (lv_s1 > 0 && IsLightBalance(evt.player))
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
				_corDic.set_Item(actor.Id, _actor.StartLogicCoroutine(DoAddStarBuff(actor)));
			}
			else
			{
				_corDic.Add(actor.Id, _actor.StartLogicCoroutine(DoAddStarBuff(actor)));
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

	private IEnumerator DoAddStarBuff(PlayerAdventureActor actor)
	{
		while (true)
		{
			yield return _actor.WaitTime(1);
			actor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), actor);
			if (lv_s2 > 0)
			{
				actor.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && IsLightBalance(actor) && actor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1)))
		{
			target.buffComponent.AddBuff(debuffId_1.get_Item(stage_s1), actor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s3 <= 0 || lv_s1 <= 0 || evt.triggerActor != _actor || _actor.actorElementInfo.elementType != HotfixEnum.elementType.LE)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = evt.markActor as MonsterAdventureActor;
		if (!(monsterAdventureActor == null) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(debuffId_1.get_Item(stage_s1)))
		{
			if (evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType1)
			{
				_actor.buffComponent.AddBuff(buffId_3_1.get_Item(stage_s3), _actor);
			}
			else if (evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType2)
			{
				_actor.buffComponent.AddBuff(buffId_3_2.get_Item(stage_s3), _actor);
			}
		}
	}

	private bool IsLightBalance(AdventureActor actor)
	{
		if (actor == null)
		{
			return false;
		}
		PlayerAdventureActor playerAdventureActor = actor as PlayerAdventureActor;
		if (playerAdventureActor == null)
		{
			return false;
		}
		if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance;
		}
		return false;
	}
}
