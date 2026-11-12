using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214005 : DiscScriptBase
{
	private const int discId = 214005;

	private static readonly List<int> skillIds_1 = new List<int> { 4005000, 4005001, 4005002, 4005003, 4005004 };

	private static readonly List<int> buffIdList_1_1_1 = new List<int> { 4005000, 4005001, 4005002, 4005003, 4005004 };

	private const int buffId_1_1_2 = 4005009;

	private static readonly List<int> parameterIdList_1_1_1 = new List<int> { 4005003, 4005003, 4005003, 4005003, 4005003 };

	private static readonly List<int> parameterIdList_1_1_2 = new List<int> { 4005004, 4005004, 4005004, 4005004, 4005004 };

	private const int buffId_1_2 = 4005005;

	private const int buffId_1_3 = 4005006;

	private const int parameterId_1_4 = 4005001;

	private const int buffId_1_4 = 4005007;

	private const int parameterId_1_5 = 4005002;

	private const int buffId_1_5 = 4005008;

	private static readonly List<int> skillIds_2 = new List<int> { 40051, 0, 0, 0, 0 };

	private const int buffId_2 = 4005100;

	private const int parameterId_2 = 4005005;

	private static readonly List<int> skillIds_3 = new List<int> { 40052, 0, 0, 0, 0 };

	private const int additionalAttrId_3 = 4005200;

	private int _discSkillLevel_1;

	private int _discSkillStage_1;

	private int _discSkillLevel_2;

	private int _discSkillLevel_3;

	private int _hitCount_1_4;

	private Dictionary<long, CoroutineNode> _discLogicCorDic_1_5;

	private FP _lastTriggerTime_2;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(int, int) discInfo = GetDiscInfo(214005, skillIds_1);
		_discSkillStage_1 = discInfo.Item1;
		_discSkillLevel_1 = discInfo.Item2;
		_discSkillLevel_2 = GetDiscInfo(214005, skillIds_2).Item2;
		_discSkillLevel_3 = GetDiscInfo(214005, skillIds_3).Item2;
		_hitCount_1_4 = 0;
		_lastTriggerTime_2 = 0;
		if (_discSkillLevel_1 <= 0)
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (CheckActorIsWE(actorL))
			{
				actorL.buffComponent.AddBuff(buffIdList_1_1_1.get_Item(_discSkillStage_1), actorL);
			}
		}
	}

	protected override void OnCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnCastSkill(castSkillEvent);
		if (!(castSkillEvent.sender is PlayerAdventureActor playerAdventureActor))
		{
			return;
		}
		if (CheckActorIsWE(playerAdventureActor, checkAssit: true) && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			if (_discSkillLevel_1 > 1)
			{
				playerAdventureActor.buffComponent.AddBuff(4005005, playerAdventureActor);
			}
			if (_discSkillLevel_1 > 2)
			{
				playerAdventureActor.buffComponent.AddBuff(4005006, playerAdventureActor);
			}
		}
		else if (CheckActorIsWE(playerAdventureActor, checkAssit: true, isAssist: true) && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_hitCount_1_4 = 0;
		}
	}

	protected override void OnCastEndSkill(AdventureActorCastSkillEndEvent castSkillEvent)
	{
		base.OnCastEndSkill(castSkillEvent);
		if (castSkillEvent.sender is PlayerAdventureActor actor && CheckActorIsWE(actor, checkAssit: true, isAssist: true) && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_hitCount_1_4 = 0;
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (_discSkillLevel_3 > 0 && CheckActorIsWE(actor) && (damageEvent.skillSlotType == HotfixEnum.skillSlotType.B || damageEvent.skillSlotType == HotfixEnum.skillSlotType.D) && target.actorInfo.moveSpeedRatio < target.actorInfo.originMoveSpeedRatio)
		{
			AdventureActor.AddFromAttr(4005200, actor);
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (_discSkillLevel_1 > 0 && CheckActorIsWE(actor, checkAssit: true))
		{
			if (damageEvent.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
			{
				FP scriptValue = CommonUtils.GetScriptValue(actor, parameterIdList_1_1_1.get_Item(_discSkillStage_1));
				if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
				{
					target.buffComponent.AddBuff(4005009, actor);
				}
			}
			else if (damageEvent.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				FP scriptValue2 = CommonUtils.GetScriptValue(actor, parameterIdList_1_1_2.get_Item(_discSkillStage_1));
				if (TSRandom.Range(FP.Zero, 100) <= scriptValue2)
				{
					target.buffComponent.AddBuff(4005009, actor);
				}
			}
		}
		if (_discSkillLevel_1 <= 3 || !CheckActorIsWE(actor, checkAssit: true, isAssist: true) || damageEvent.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		if (target == playerAdventureActor.attackTarget)
		{
			_hitCount_1_4++;
			int num = CommonUtils.GetScriptValue(actor, 4005001).AsInt();
			if (_hitCount_1_4 >= num)
			{
				actor.buffComponent.AddBuff(4005007, actor);
				_hitCount_1_4 = 0;
			}
		}
	}

	protected override void OnMainPlayerActorReceiveDamage(AdventureActor damageSource, PlayerAdventureActor mainActor, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorReceiveDamage(damageSource, mainActor, damageEvent);
		if (_discSkillLevel_2 <= 0)
		{
			return;
		}
		FP scriptValue = CommonUtils.GetScriptValue(mainActor, 4005005);
		if (!(_lastTriggerTime_2 <= 0) && !(mainActor.LogicTime - _lastTriggerTime_2 > scriptValue))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (CheckActorIsWE(actorL))
			{
				actorL.buffComponent.AddBuff(4005100, actorL);
			}
		}
		_lastTriggerTime_2 = mainActor.LogicTime;
	}

	protected override void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
		base.OnActorEnter(evt);
		if (_discSkillLevel_1 <= 4)
		{
			return;
		}
		PlayerAdventureActor player = evt.player;
		if (CheckActorIsWE(player, checkAssit: true, isAssist: true))
		{
			if (_discLogicCorDic_1_5 == null)
			{
				_discLogicCorDic_1_5 = new Dictionary<long, CoroutineNode>(2);
			}
			if (_discLogicCorDic_1_5.ContainsKey(player.Id))
			{
				player.StopLogicCoroutine(_discLogicCorDic_1_5.get_Item(player.Id));
				_discLogicCorDic_1_5.set_Item(player.Id, _actor.StartLogicCoroutine(DiscLogic_1_5(player)));
			}
			else
			{
				_discLogicCorDic_1_5.Add(player.Id, _actor.StartLogicCoroutine(DiscLogic_1_5(player)));
			}
		}
	}

	private IEnumerator DiscLogic_1_5(PlayerAdventureActor actor)
	{
		FP time = 0;
		FP interval = CommonUtils.GetScriptValue(actor, 4005002);
		while (true)
		{
			if (time < interval)
			{
				time += actor.LogicDeltaTime;
			}
			else
			{
				actor.buffComponent.AddBuff(4005008, actor);
				time = 0;
			}
			yield return null;
		}
	}

	protected override void OnActorLeave(AdventurePlayerLeaveEvent evt)
	{
		base.OnActorLeave(evt);
		PlayerAdventureActor player = evt.player;
		if (CheckActorIsWE(player, checkAssit: true, isAssist: true) && _discLogicCorDic_1_5 != null && _discLogicCorDic_1_5.ContainsKey(player.Id))
		{
			_actor.StopLogicCoroutine(_discLogicCorDic_1_5.get_Item(player.Id));
		}
	}

	private bool CheckActorIsWE(PlayerAdventureActor actor, bool checkAssit = false, bool isAssist = false)
	{
		if (actor == null)
		{
			return false;
		}
		if (actor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			if (checkAssit)
			{
				return actor.isAssist == isAssist;
			}
			return true;
		}
		return false;
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		_hitCount_1_4 = 0;
		if (_discLogicCorDic_1_5 != null)
		{
			foreach (CoroutineNode value in _discLogicCorDic_1_5.Values)
			{
				_actor.StopLogicCoroutine(value);
			}
			_discLogicCorDic_1_5.Clear();
		}
		_lastTriggerTime_2 = 0;
		_discSkillLevel_1 = 0;
		_discSkillLevel_2 = 0;
		_discSkillLevel_3 = 0;
	}
}
