using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._13500010BigHeadGhost;

public class Parallel : ParallelBase
{
	private int hitTag_Skill = CommonHelper.StringToHash("BigHeadGhostAtk");

	private int hitTag_Dark = CommonHelper.StringToHash("135DarkTagBoom");

	private int buffId_Dark = 13590000;

	private string hitEffect_Dark = "FX/ActorCommon/fx_common_base_DarkTirgger_AnZhuo";

	private int hitDmgId_Dark = 135000000;

	private const string tipsKey_TriggerMark = "DarkMark_Trigger_Effect_03";

	private const int perkId_8 = 513508;

	private FP cd_8 = 1.5f;

	private const int parameterId_8 = 13550811;

	private int buff_8 = 13550811;

	private int once_8 = 13550801;

	private string effect_8 = "fx_13501_base_T8_SpHit";

	private FP weight_8 = 0;

	private int perkId_9 = 513509;

	private const int once_9 = 13550901;

	private const int perkId_10 = 513510;

	private const int buffId_10 = 13551011;

	private int buffId_fate2_1 = 13591011;

	private int buffId_fate2_2 = 13591012;

	public int paramId_cd_fate = 13550001;

	public int paramId_prob_fate = 13550002;

	private FP fateCD;

	private PlayerAdventureActor summoner;

	private PlayFX playFx = new PlayFX();

	private Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public override void OnEnable()
	{
		base.OnEnable();
		summoner = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor as PlayerAdventureActor;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnHitPre);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		fateCD = 0;
		if (GetPerkLv(513510, out var _))
		{
			_actor.buffComponent.AddBuff(13551011, _actor);
		}
		_actor.EnableSearchedImmunity();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnHitPre);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		_actor.DisableSearchedImmunity();
		if (GetPerkLv(513510, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13551011);
		}
		summoner = null;
	}

	private void OnBeforeHit(IEvent _evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = _evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(_actor != null) || adventureActorReceiveDamageBeforeHitEvent.from.Id != _actor.Id)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor != null && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_Skill))
		{
			if (GetPerkLv(513508, out var lv) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 13550811) && CheckCd(513508, cd_8))
			{
				monsterAdventureActor.buffComponent.AddBuff(buff_8, _actor);
				AdventureActor.AddFromAttr(once_8, _actor);
				TSVector2 position = _actor.tsTransform.Position * weight_8 + monsterAdventureActor.tsTransform.Position * (1 - weight_8);
				playFx.Play(_actor, effect_8, 1f, 0, position, _actor.transform.rotation);
			}
			if (GetPerkLv(perkId_9, out lv) && TSVector2.Distance(_actor.tsTransform.Position, summoner.tsTransform.Position) < summoner.actorSearchTargetInfo.attackRange)
			{
				AdventureActor.AddFromAttr(13550901, _actor);
			}
		}
	}

	private void OnHitPre(IEvent _evt)
	{
	}

	private void OnDamage(IEvent _evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = _evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from?.Id && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitTag_Dark) && CommonUtils.CheckElementMark(CommonDefine.Dark, monsterAdventureActor) && CommonUtils.CheckTriggerElementMarkCD(summoner, monsterAdventureActor))
		{
			monsterAdventureActor.buffComponent.RemoveBuffByTag(CommonDefine.Dark);
			monsterAdventureActor.buffComponent.AddBuff(buffId_Dark, summoner);
			ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, hitDmgId_Dark, hitEffect_Dark);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Dark, HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1, summoner, monsterAdventureActor, "DarkMark_Trigger_Effect_03");
		}
	}

	public bool CheckCd(int perkId, FP Cd)
	{
		if (Cd <= 0)
		{
			return true;
		}
		bool result = false;
		if (perkCd.TryGetValue(perkId, out var value))
		{
			if (summoner.LogicTime - value > Cd)
			{
				result = true;
				perkCd.set_Item(perkId, summoner.LogicTime);
			}
		}
		else
		{
			perkCd.Add(perkId, summoner.LogicTime);
			result = true;
		}
		return result;
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(summoner.dataID, perkId, out lv);
	}
}
