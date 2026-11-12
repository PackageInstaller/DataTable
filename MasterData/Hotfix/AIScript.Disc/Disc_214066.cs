using System.Collections.Generic;

namespace AIScript.Disc;

public class Disc_214066 : DiscScriptBase
{
	private const int discId = 214066;

	private List<int> skillId_s1 = new List<int> { 406601, 406602, 406603, 406604, 406605, 406606 };

	private List<int> buffId_1_hp = new List<int> { 4066001, 4066002, 4066003, 4066004, 4066005, 4066006 };

	private List<int> buffId_1_star = new List<int> { 4066000, 4066000, 4066000, 4066000, 4066000, 4066000 };

	private List<int> debuffId_1_lightSkillDmg = new List<int> { 4066011, 4066012, 4066013, 4066014, 4066015, 4066016 };

	private List<int> buffId_1_crit = new List<int> { 4066021, 4066022, 4066023, 4066024, 4066025, 4066026 };

	private List<int> skillId_s2 = new List<int> { 4066101, 4066102, 4066103, 4066104, 4066105 };

	private List<int> debuffId_2_lightNormalDmg = new List<int> { 4066101, 4066102, 4066103, 4066104, 4066105 };

	private List<int> buffId_2_starExtra = new List<int> { 4066111, 4066112, 4066113, 4066114, 4066115 };

	private List<int> skillId_s3 = new List<int> { 4066201, 4066202, 4066203, 4066204, 4066205 };

	private List<int> buffId_3_critDmg = new List<int> { 4066201, 4066202, 4066203, 4066204, 4066205 };

	private List<int> buffId_3_starExtra = new List<int> { 4066211, 4066212, 4066213, 4066214, 4066215 };

	private int lv_s1;

	private int lv_s2;

	private int lv_s3;

	private int stage_s1;

	private int stage_s2;

	private int stage_s3;

	private bool _firstTrigger_main;

	private bool _firstApply_balance;

	private bool _firstApply_support;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(int, int) discInfo = GetDiscInfo(214066, skillId_s1);
		stage_s1 = discInfo.Item1;
		lv_s1 = discInfo.Item2;
		discInfo = GetDiscInfo(214066, skillId_s2);
		stage_s2 = discInfo.Item1;
		lv_s2 = discInfo.Item2;
		discInfo = GetDiscInfo(214066, skillId_s3);
		stage_s3 = discInfo.Item1;
		lv_s3 = discInfo.Item2;
		_firstTrigger_main = false;
		_firstApply_balance = false;
		_firstApply_support = false;
		if (lv_s1 > 0)
		{
			AddBuffToGroup(buffId_1_hp.get_Item(stage_s1));
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	protected override void OnDiscDisable()
	{
		base.OnDiscDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void AddStarWish()
	{
		_actor.buffComponent.AddBuff(buffId_1_star.get_Item(stage_s1), _actor);
		if (lv_s2 > 0)
		{
			_actor.buffComponent.AddBuff(buffId_2_starExtra.get_Item(stage_s2), _actor);
		}
		if (lv_s3 > 0 && IsLight(_actor))
		{
			_actor.buffComponent.AddBuff(buffId_3_starExtra.get_Item(stage_s3), _actor);
		}
	}

	protected override void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
		base.OnElementMarkTrigger(evt);
		if (evt != null && evt.elementType == HotfixEnum.elementType.LE)
		{
			if (lv_s1 > 0 && !_firstTrigger_main && evt.triggerActor == _actor)
			{
				_firstTrigger_main = true;
				AddStarWish();
			}
			if (lv_s1 > 0 && evt.triggerActor == _actor && IsLight(_actor) && evt.markTriggerType == HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType2)
			{
				_actor.buffComponent.AddBuff(buffId_1_crit.get_Item(stage_s1), _actor);
			}
		}
	}

	protected override void OnPlayerActorDamaged(PlayerAdventureActor actor, MonsterAdventureActor target, AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnPlayerActorDamaged(actor, target, damageEvent);
		if (lv_s1 > 0 && actor.buffComponent.CheckBuffByBuffID(buffId_1_star.get_Item(stage_s1)))
		{
			if (damageEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				target.buffComponent.AddBuff(debuffId_1_lightSkillDmg.get_Item(stage_s1), actor);
			}
			if (lv_s2 > 0 && damageEvent.damageType == HotfixEnum.damageType.NORMAL)
			{
				target.buffComponent.AddBuff(debuffId_2_lightNormalDmg.get_Item(stage_s2), actor);
			}
		}
	}

	protected override void OnPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnPlayerActorCastSkill(actor, castSkillEvent);
		if (lv_s3 > 0 && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && IsLight(actor) && IsLight(_actor))
		{
			_actor.buffComponent.AddBuff(buffId_3_critDmg.get_Item(stage_s3), _actor);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Light) && adventureActorGetBuff.from is PlayerAdventureActor actor)
		{
			if (lv_s2 > 0 && !_firstApply_balance && IsBalance(actor))
			{
				_firstApply_balance = true;
				AddStarWish();
			}
			if (lv_s3 > 0 && !_firstApply_support && IsSupport(actor))
			{
				_firstApply_support = true;
				AddStarWish();
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

	private bool IsBalance(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Balance;
		}
		return false;
	}

	private bool IsSupport(AdventureActor actor)
	{
		if (actor is PlayerAdventureActor playerAdventureActor)
		{
			return playerAdventureActor.actorInfo.jobClass == HotfixEnum.characterJobClass.Support;
		}
		return false;
	}
}
