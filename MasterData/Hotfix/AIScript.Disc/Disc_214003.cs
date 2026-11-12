using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214003 : DiscScriptBase
{
	private const int discId = 214003;

	private List<int> skillId_s1 = new List<int> { 400301, 400302, 400303, 400304, 400305, 400306 };

	private List<int> buffId_1 = new List<int> { 4003001, 4003002, 4003003, 4003004, 4003005, 4003006 };

	private List<int> buffId_1_extra = new List<int> { 4003021, 4003022, 4003023, 4003024, 4003025, 4003026 };

	private List<int> skillId_s2 = new List<int> { 4003101, 4003102, 4003103, 4003104, 4003105 };

	private List<int> buffId_2 = new List<int> { 4003121, 4003122, 4003123, 4003124, 4003125 };

	private List<int> skillId_s3 = new List<int> { 4003201, 4003202, 4003203, 4003204, 4003205 };

	private List<int> buffId_3_1 = new List<int> { 4003201, 4003202, 4003203, 4003204, 4003205 };

	private List<int> buffId_3_2 = new List<int> { 4003221, 4003222, 4003223, 4003224, 4003225 };

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
		(stage_s1, lv_s1) = GetDiscInfo(214003, skillId_s1);
		(stage_s2, lv_s2) = GetDiscInfo(214003, skillId_s2);
		(stage_s3, lv_s3) = GetDiscInfo(214003, skillId_s3);
		if (lv_s1 <= 0)
		{
			return;
		}
		_corDic = new Dictionary<long, CoroutineNode>(2);
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (IsLightBalance(playerAdventureActor) && playerAdventureActor.isResident)
			{
				StartActorCoroutine(playerAdventureActor);
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
				_corDic.set_Item(actor.Id, _actor.StartLogicCoroutine(DoAddSimilarBuff(actor)));
			}
			else
			{
				_corDic.Add(actor.Id, _actor.StartLogicCoroutine(DoAddSimilarBuff(actor)));
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

	private IEnumerator DoAddSimilarBuff(PlayerAdventureActor actor)
	{
		while (true)
		{
			yield return _actor.WaitTime(1);
			if (!actor.isResident)
			{
				continue;
			}
			actor.buffComponent.AddBuff(buffId_1.get_Item(stage_s1), actor);
			if (lv_s2 > 0)
			{
				actor.buffComponent.AddBuff(buffId_2.get_Item(stage_s2), actor);
			}
			if (actor.buffComponent.HaveBuffNumMax(buffId_1.get_Item(stage_s1)))
			{
				PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
				if (activedPlayerActor != null && activedPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
				{
					activedPlayerActor.buffComponent.AddBuff(buffId_1_extra.get_Item(stage_s1), activedPlayerActor);
				}
			}
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (lv_s3 > 0 && lv_s1 > 0 && !(evt.triggerActor != _actor) && _actor.actorElementInfo.elementType == HotfixEnum.elementType.LE && _actor.buffComponent.CheckBuffByBuffID(buffId_1_extra.get_Item(stage_s1)))
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
