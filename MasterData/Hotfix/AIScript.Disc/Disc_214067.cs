using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Disc;

public class Disc_214067 : DiscScriptBase
{
	private const int discId = 214067;

	private int hitCountThreshold = 5;

	private FP inSceneInterval = 5;

	private List<int> skillId_s1 = new List<int> { 406701, 406702, 406703, 406704, 406705, 406706 };

	private List<int> buffId_1_eternal10 = new List<int> { 4067001, 4067002, 4067003, 4067004, 4067005, 4067006 };

	private List<int> buffId_1_eternal20 = new List<int> { 4067011, 4067012, 4067013, 4067014, 4067015, 4067016 };

	private List<int> onceId_1_teamLightDmg = new List<int> { 4067011, 4067012, 4067013, 4067014, 4067015, 4067016 };

	private List<int> skillId_s2 = new List<int> { 4067101, 4067102, 4067103, 4067104, 4067105 };

	private List<int> buffId_2_eternalExtra = new List<int> { 4067101, 4067102, 4067103, 4067104, 4067105 };

	private List<int> skillId_s3 = new List<int> { 4067201, 4067202, 4067203, 4067204, 4067205 };

	private List<int> buffId_3_full = new List<int> { 4067201, 4067202, 4067203, 4067204, 4067205 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private int _eternalBuffId;

	private int _hitCount;

	private Dictionary<long, CoroutineNode> _corDic;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(int, int) discInfo = GetDiscInfo(214067, skillId_s1);
		stage_s1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		discInfo = GetDiscInfo(214067, skillId_s2);
		stage_s2 = discInfo.Item1;
		lv_s2 = discInfo.Item2;
		discInfo = GetDiscInfo(214067, skillId_s3);
		stage_s3 = discInfo.Item1;
		lv_s3 = discInfo.Item2;
		_hitCount = 0;
		_eternalBuffId = ((lv_s3 > 0) ? buffId_1_eternal20.get_Item(stage_s1) : buffId_1_eternal10.get_Item(stage_s1));
		if (lv_s2 > 0)
		{
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
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
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

	private void AddEternal()
	{
		_actor.buffComponent.AddBuff(_eternalBuffId, _actor);
		if (lv_s2 > 0)
		{
			_actor.buffComponent.AddBuff(buffId_2_eternalExtra.get_Item(stage_s2), _actor);
		}
		if (lv_s3 > 0 && _actor.buffComponent.HaveBuffNumMax(_eternalBuffId))
		{
			_actor.buffComponent.AddBuff(buffId_3_full.get_Item(stage_s3), _actor);
		}
	}

	protected override void OnMainPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnMainPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 <= 0 || !IsLight(actor))
		{
			return;
		}
		bool flag = damageEvent.damageType == HotfixEnum.damageType.NORMAL;
		bool flag2 = damageEvent.damageType == HotfixEnum.damageType.SKILL;
		if (flag || flag2)
		{
			_hitCount++;
			if (_hitCount >= hitCountThreshold)
			{
				_hitCount = 0;
				AddEternal();
			}
		}
	}

	protected override void OnBeforePlayerActorHit(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageBeforeHitEvent damageEvent)
	{
		base.OnBeforePlayerActorHit(actor, target, damageEvent);
		if (lv_s1 > 0 && IsLight(actor) && _actor.buffComponent.CheckBuffByBuffID(_eternalBuffId))
		{
			AdventureActor.AddFromAttr(onceId_1_teamLightDmg.get_Item(stage_s1), actor);
		}
	}

	protected override void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
		base.OnActorEnter(evt);
		if (lv_s2 > 0 && IsLightBalance(evt.player))
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
				_corDic.set_Item(actor.Id, _actor.StartLogicCoroutine(DoInSceneTick(actor)));
			}
			else
			{
				_corDic.Add(actor.Id, _actor.StartLogicCoroutine(DoInSceneTick(actor)));
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

	private IEnumerator DoInSceneTick(PlayerAdventureActor actor)
	{
		while (true)
		{
			yield return _actor.WaitTime(inSceneInterval);
			if (actor.isResident)
			{
				AddEternal();
			}
		}
	}

	protected override void OnPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnPlayerActorCastSkill(actor, castSkillEvent);
		if (lv_s3 > 0 && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && IsLightSupport(actor))
		{
			AddEternal();
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (!(evt is AdventureActorRemoveBuff adventureActorRemoveBuff) || adventureActorRemoveBuff.eventInfo.buffId != _eternalBuffId || !(adventureActorRemoveBuff.sender is PlayerAdventureActor playerAdventureActor) || playerAdventureActor != _actor)
		{
			return;
		}
		int buffNumByID = _actor.buffComponent.GetBuffNumByID(_eternalBuffId);
		if (lv_s2 > 0)
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId_2_eternalExtra.get_Item(stage_s2));
			if (buffNumByID > 0)
			{
				_actor.buffComponent.AddBuffNum(buffId_2_eternalExtra.get_Item(stage_s2), buffNumByID, _actor);
			}
		}
	}

	private bool IsLight(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor)
		{
			return playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE;
		}
		return false;
	}

	private bool IsLightBalance(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance;
		}
		return false;
	}

	private bool IsLightSupport(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support;
		}
		return false;
	}
}
