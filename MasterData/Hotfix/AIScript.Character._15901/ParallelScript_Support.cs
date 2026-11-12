using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15901;

public class ParallelScript_Support : ParallelScript
{
	private int hitTag_A = CommonHelper.StringToHash("159_Sup_Rose");

	private int hitTag_A_P22 = CommonHelper.StringToHash("159_Sup_Rose_P22");

	private int hitTag_B = CommonHelper.StringToHash("159_Sup_Withered");

	private int hitTag_B_Once = CommonHelper.StringToHash("159_Sup_Withered_DMG");

	private int hitTag_B_P30_Once = CommonHelper.StringToHash("159_Sup_P30");

	private int hitTag_AddMask = CommonHelper.StringToHash("159_LandTagAdd");

	private int buff_Mask = 6011;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private int maxSummonCount = 1;

	private int buff_B = 15991012;

	private int hitDmg_B = 159320004;

	private int buff_MaxHitFX = 15991013;

	private int buffMaxCount_B = 5;

	private const int perkId_21 = 515921;

	private string areaEffect_21 = "AreaEffect_15901_SkillSup_RoseEndExtra_Perk21";

	private int buff_21 = 15921011;

	private int once_21 = 15921011;

	public int perkId_22 = 515922;

	public string areaEffect_A_22 = "AreaEffect_15901_SkillSup_Rose_Perk22";

	private int once_22_passive = 15922013;

	private int once_22 = 15922011;

	private int once_22_24 = 15922012;

	public int perkId_23 = 515923;

	public string areaEffect_B_23 = "AreaEffect_15901_SkillSup_Infect_Perk23";

	private int once_23 = 15923011;

	public int perkId_24 = 515924;

	public FP leftTime_24 = 9.2;

	private const int perkId_25 = 515925;

	private int once_25 = 15925001;

	private const int perkId_26 = 515926;

	private int buff_26 = 15926011;

	private const int perkId_27 = 515927;

	private int buff_27 = 15927011;

	private int hitDmg_27 = 159327101;

	private const string hittedFx_27 = "fx_15901_base_Skill_sup_rose_hit_perk27";

	private const int perkId_28 = 515928;

	private int once_28 = 15928001;

	private const int perkId_29 = 515929;

	private int once_29 = 15929001;

	private const int perkId_30 = 515930;

	private int hitDmg_30 = 159330101;

	private const string hittedFx_30 = "fx_15901_base_skill_sup_withered_hit_perk30";

	private int buff_30 = 15930011;

	private int once_30 = 15930001;

	private const int perkId_32 = 515932;

	private int buff_32 = 6011;

	private const int perkId_33 = 515933;

	private int buff_33 = 15933011;

	private int totleCount;

	private int roseCount;

	private bool isAdd;

	private List<ShootRose> roseList = new List<ShootRose>();

	private ShootRose curShootRose;

	private bool allSEFriend;

	private int seFriendCount;

	private long uid;

	public override void OnEnable()
	{
		base.OnEnable();
		totleCount = 0;
		roseCount = 0;
		uid = 0L;
		isAdd = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		seFriendCount = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				seFriendCount++;
			}
		}
		allSEFriend = seFriendCount >= 3;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		for (int i = 0; i < roseList.Count; i++)
		{
			roseList.get_Item(i).Finish();
		}
		roseList.Clear();
		curShootRose = null;
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerk(515921))
		{
			_actor.buffComponent.AddBuff(buff_21, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (isSelf)
		{
			if (GetPerk(515921) && _actor.buffComponent.CheckBuffByBuffID(buff_21) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_A))
			{
				AdventureActor.AddFromAttr(once_21, adventureActor);
			}
			if (GetPerk(perkId_22))
			{
				if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_A))
				{
					AdventureActor.AddFromAttr(once_22_passive, _actor, seFriendCount);
				}
				if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_A_P22))
				{
					AdventureActor.AddFromAttr(GetPerk(perkId_24) ? once_22_24 : once_22, _actor);
				}
			}
			if (GetPerk(perkId_23) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_B_Once))
			{
				AdventureActor.AddFromAttr(once_23, _actor, seFriendCount);
			}
			if (GetPerk(515925) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_A))
			{
				AdventureActor.AddFromAttr(once_25, _actor, curShootRose?.RoseCount ?? 1);
			}
			if (GetPerk(515928) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_B_Once))
			{
				int num = totleCount - roseCount;
				if (num > 0)
				{
					AdventureActor.AddFromAttr(once_28, _actor, num);
				}
			}
			if (GetPerk(515930) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_B_P30_Once))
			{
				int buffNumByID = monster.buffComponent.GetBuffNumByID(buff_B);
				if (buffNumByID > 0)
				{
					AdventureActor.AddFromAttr(once_30, _actor, buffNumByID);
				}
			}
		}
		if (GetPerk(515929) && adventureActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE && totleCount > 0)
		{
			AdventureActor.AddFromAttr(once_29, adventureActor);
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPre(evt, monster, isSelf);
		_ = evt.from;
		if (isSelf && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_AddMask))
		{
			monster.buffComponent.AddBuff(buff_Mask, _actor);
			if (GetPerk(515926) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_A))
			{
				monster.buffComponent.AddBuff(buff_26, _actor);
			}
			if (GetPerk(515927) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_A))
			{
				monster.buffComponent.AddBuff(buff_27, _actor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		_ = evt.from;
		if (!isSelf)
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_B))
		{
			if (monster.buffComponent.GetBuffNumByID(buff_B) + 1 >= buffMaxCount_B)
			{
				monster.buffComponent.AddBuff(buff_B, _actor);
				monster.buffComponent.AddBuff(buff_MaxHitFX, _actor);
				ILRuntimeAPI.HitActor(_actor, monster, hitDmg_B);
				monster.buffComponent.RemoveBuffByBuffId(buff_B);
			}
			else
			{
				monster.buffComponent.AddBuff(buff_B, _actor);
				if (GetPerk(515930))
				{
					monster.buffComponent.AddBuff(buff_30, _actor);
					ILRuntimeAPI.HitActor(_actor, monster, hitDmg_30);
				}
			}
		}
		if (GetPerk(515932) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra))
		{
			monster.buffComponent.AddBuff(buff_32, _actor);
		}
		if (GetPerk(515933) && allSEFriend && evt.damageType == HotfixEnum.damageType.SKILL && roseCount > 0)
		{
			monster.buffComponent.RemoveBuffByBuffId(buff_33);
			monster.buffComponent.AddBuffNum(buff_33, roseCount, _actor);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == summonEvt)
		{
			if (roseList.Count >= maxSummonCount)
			{
				roseList.get_Item(0).Finish();
				roseList.RemoveAt(0);
			}
			ShootRose shootRose = new ShootRose();
			shootRose.uid = GetUid();
			shootRose.Shoot(this, _actor);
			curShootRose = shootRose;
			roseList.Add(shootRose);
		}
	}

	public override void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
		base.OnAreaEffectBegin(evt);
		if (evt.sender is AreaEffectEntity areaEffectEntity && (areaEffectEntity.areaTag == Conifg_Support.areaTag_A || areaEffectEntity.areaTag == Conifg_Support.areaTag_B))
		{
			totleCount++;
			if (areaEffectEntity.areaTag == Conifg_Support.areaTag_A)
			{
				roseCount++;
			}
			OnCountChange();
		}
	}

	public override void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
		base.OnAreaEffectFinish(evt);
		if (evt.sender is AreaEffectEntity areaEffectEntity && (areaEffectEntity.areaTag == Conifg_Support.areaTag_A || areaEffectEntity.areaTag == Conifg_Support.areaTag_B))
		{
			totleCount--;
			if (areaEffectEntity.areaTag == Conifg_Support.areaTag_A)
			{
				roseCount--;
			}
			OnCountChange();
			if (GetPerk(515921) && areaEffectEntity.areaTag == Conifg_Support.areaTag_A)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_21, areaEffectEntity.tsTransform.Position);
			}
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		if (GetPerk(515927) && adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.SE && adventureElementMarkTriggerEvent.markActor.buffComponent.CheckBuffByBuffID(buff_27))
		{
			ILRuntimeAPI.HitActor(_actor, adventureElementMarkTriggerEvent.markActor, hitDmg_27, "fx_15901_base_Skill_sup_rose_hit_perk27");
		}
	}

	private void OnCountChange()
	{
	}

	public bool GetPerkByShoot(int perkId)
	{
		return GetPerk(perkId);
	}

	private long GetUid()
	{
		return ++uid;
	}
}
