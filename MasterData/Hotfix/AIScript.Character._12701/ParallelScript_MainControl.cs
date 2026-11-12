using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Character._12701;

public class ParallelScript_MainControl : ParallelScript
{
	public int skillId_S1 = 12731000;

	public int skillId_S2 = 12731001;

	private string areaEffect_base = "AreaEffect_12701_B2_Skill_WaterArea";

	private FP areaEffect_offset = 0;

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private int once_S2;

	private int perkId_1 = 512701;

	private int once_1 = 12750111;

	private const int perkId_2 = 512702;

	private const int perkId_3 = 512703;

	private string areaEffect_3 = "AreaEffect_12701_B1_Skill_Wave_Perk03";

	private const int perkId_4 = 512704;

	private int prob_4 = 50;

	private int paramId_4_energy = 12750411;

	private const int perkId_5 = 512705;

	private int buffId_5 = 12750511;

	private const int perkId_6 = 512706;

	private const int buff_6 = 12750611;

	private const int buff_6_2 = 12750612;

	private const int perkId_7 = 512707;

	private const int buff_7 = 12750711;

	private const int perkId_8 = 512708;

	private const int buff_8 = 12750811;

	private const int perkId_9 = 512709;

	private const int prob_9 = 100;

	private const int parameterId_9_skillCd = 12750911;

	private FP maxCd = 3;

	private const int parameterId_9_cd = 12750912;

	private const int perkId_10 = 512710;

	private const int shield_10 = 12751001;

	private const int perkId_11 = 512711;

	private const int buff_11 = 12751111;

	private const int perkId_12 = 512712;

	private const int buffId_12 = 12751211;

	private const int parameterId_12 = 12751201;

	private const int perkId_13 = 512713;

	private const int buffId_13 = 12751311;

	private FP lastHitTime;

	private CoroutineNode corRebind;

	private FP resetSkillTime;

	private long areaId;

	public override void OnEnable()
	{
		base.OnEnable();
		areaId = 0L;
		lastHitTime = 0;
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId_S2);
		resetSkillTime = FP.FromMyriad(skill.UseTimeHint);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_PERSONAL_PERK_UPDATE", OnPersonalPerkUpdate);
		if (GetPerkLv(512713, out var _))
		{
			HandlePerk13();
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_PERSONAL_PERK_UPDATE", OnPersonalPerkUpdate);
	}

	private void OnPersonalPerkUpdate(IEvent evt)
	{
		if (evt is AdventureActorPersonalPerkUpdateEvent adventureActorPersonalPerkUpdateEvent && adventureActorPersonalPerkUpdateEvent.actorDataId == _actor.dataID && adventureActorPersonalPerkUpdateEvent.perkId == 512713 && adventureActorPersonalPerkUpdateEvent.isNew)
		{
			HandlePerk13();
		}
	}

	private void HandlePerk13()
	{
		int num = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				num++;
			}
		}
		if (num > 0)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(12751311, _actor, num);
		}
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (GetPerkLv(512702, out var _) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && evt.skillEventInfo.skillId == skillId_S2)
		{
			StopCoroutine(ref corRebind);
			skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1);
		}
	}

	public override void OnAssistCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnAssistCastSkill(evt);
		if ((evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B || evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D) && GetPerkLv(512710, out var _))
		{
			_actor.actorShield.AddShield(12751001, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerkLv(perkId_1, out var _) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MainSkill))
		{
			AdventureActor.AddFromAttr(once_1, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MainSkill);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_WaterTag1);
		int lv;
		if (flag)
		{
			if (GetPerkLv(512704, out lv) && flag2 && TSRandom.Range(0, 100) < prob_4)
			{
				List<PlayerAdventureActor> list = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.FindAll((PlayerAdventureActor a) => a.Id != _actor.Id && a.actorElementInfo.elementType == HotfixEnum.elementType.WE);
				if (list.Count > 0)
				{
					int index = TSRandom.Range(0, list.Count);
					PlayerSkillCd playerSkillCd = list.get_Item(index).playerSkillCd;
					int num = (int)(long)(playerSkillCd.GetTotalEnergy() * CommonUtils.GetScriptValue(_actor, paramId_4_energy));
					playerSkillCd.AddEnergy(num);
				}
			}
			if (GetPerkLv(512705, out lv))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_5, _actor);
			}
			if (GetPerkLv(512706, out lv))
			{
				if (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster())
				{
					monster.buffComponent.AddBuff(12750612, _actor);
				}
				else
				{
					monster.buffComponent.AddBuff(12750611, _actor);
				}
			}
			if (GetPerkLv(512707, out lv) && lastHitTime < _actor.LogicTime)
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(12750711, _actor);
				lastHitTime = _actor.LogicTime;
			}
		}
		if (GetPerkLv(512712, out lv) && CheckCd(512712, CommonUtils.GetScriptValue(_actor, 12751201)))
		{
			monster.buffComponent.AddBuff(12751211, _actor);
		}
	}

	public override void OnAssistHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnAssistHitPre(evt, monster);
		if (GetPerkLv(512709, out var _) && CommonUtils.CheckElementMark(CommonDefine.WaterMark1, monster) && TSRandom.Range(0, 100) < 100 && CheckCd(512709, CommonUtils.GetScriptValue(_actor, 12750912)))
		{
			FP fP = TSMath.Min(maxCd, CommonUtils.GetScriptValue(_actor, 12750911));
			skillMgr.ModifyResumeTimeAbs(-fP, ActionKey.B);
		}
	}

	public override void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
		base.OnCrit(evt);
		_ = evt.to as MonsterAdventureActor != null;
	}

	public override void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHurt(evt);
	}

	public override void OnShieldAdd(IEvent evt)
	{
		base.OnShieldAdd(evt);
		if (_actor != null && evt is AdventureActorAddShield adventureActorAddShield && adventureActorAddShield.shieldTags.Contains(shieldTag))
		{
			if (GetPerkLv(512703, out var lv))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_3, _actor.tsTransform.Position);
			}
			if (GetPerkLv(512708, out lv))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(12750811, _actor);
			}
			if (GetPerkLv(512711, out lv))
			{
				_actor.buffComponent.AddBuff(12751111, _actor);
			}
		}
	}

	public override void OnRebindSkill(AdventurRebindSkill evt)
	{
		base.OnRebindSkill(evt);
		skillMgr.BindSkillIdToButton(evt.slotKey, evt.skillId);
		if (evt.skillId == skillId_S2)
		{
			StartCoroutine(ref corRebind, ResetSkill());
			_actor.logicVariable.SetLogicTagValue("SetSkillTime", _actor.LogicTime);
		}
	}

	private IEnumerator ResetSkill()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(resetSkillTime));
		skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1);
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == castAreaEvent)
		{
			OnCastWaterArea();
		}
	}

	public void OnCastWaterArea()
	{
		if (areaId != 0L)
		{
			ILRuntimeAPI.StopAreaEffect(areaId);
			areaId = 0L;
		}
		TSVector2 position = mainCtrActor.tsTransform.Position + mainCtrActor.tsTransform.Forward * areaEffect_offset;
		areaId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_base, position, mainCtrActor.tsTransform.Rotation, (AreaEffectEntity entity) =>
		{
			AreaEffect_BuffComponent[] components = entity.GetComponents<AreaEffect_BuffComponent>();
			for (int i = 0; i < components.Length; i++)
			{
				components[i].executeImmediately = false;
				components[i].enabled = false;
				components[i].addBuffIdList.Clear();
				components[i].removeBuffIdList.Clear();
				components[i].addInterval = 0;
				components[i].removeInterval = 0;
				components[i].triggerEnter = false;
				components[i].triggerEnterCriteriaInfo = new TargetFilterCriteriaInfo
				{
					filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
					{
						new TargetFilterCriteriaInfo.TargetFilterCriteria
						{
							targetType = TargetFilterCriteriaInfo.TargetTypeMapping.None,
							elementType = TargetFilterCriteriaInfo.ElementTypeMapping.None
						}
					}
				};
				components[i].triggerExit = false;
				components[i].triggerExitCriteriaInfo = new TargetFilterCriteriaInfo
				{
					filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
					{
						new TargetFilterCriteriaInfo.TargetFilterCriteria
						{
							targetType = TargetFilterCriteriaInfo.TargetTypeMapping.None,
							elementType = TargetFilterCriteriaInfo.ElementTypeMapping.None
						}
					}
				};
			}
		});
	}
}
