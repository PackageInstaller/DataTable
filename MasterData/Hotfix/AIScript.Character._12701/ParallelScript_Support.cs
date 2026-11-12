#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12701;

public class ParallelScript_Support : ParallelScript
{
	private int areaTag = CommonHelper.StringToHash("127_water");

	private string areaEffect_water = "AreaEffect_12701_B2_Skill_WaterArea";

	private FP areaEffect_offset = 2.2;

	private string areaEffect_water_p24 = "AreaEffect_12701_B2_Skill_WaterArea_Perk24";

	private int shieldEvent = CommonHelper.StringToHash("127SupportAddShield");

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private const int perkId_21 = 512721;

	private int addTime_21 = 4;

	private int buffId_21 = 12752111;

	private FP cd_22 = 0.5;

	private const int perkId_22 = 512722;

	private string areaEfffect_22 = "AreaEffect_12701_B2_Skill_Wave_Perk22";

	private const int perkId_23 = 512723;

	private FP leftTime_23 = 10;

	private const int perkId_24 = 512724;

	private int once_24 = 12752411;

	private const int perkId_25 = 512725;

	private int buffId_25 = 12752511;

	private const int buffId_25_2 = 12752512;

	private const int perkId_26 = 512726;

	private FP cd_26 = 4;

	private FP cdReduce_26 = 1;

	private int buffId_26 = 12752611;

	private const int perkId_27 = 512727;

	private int buffId_27 = 12752711;

	private const int perkId_28 = 512728;

	private FP hitInterval_28 = 0.5f;

	private int buffId_28 = 12752811;

	private FP cd_28 = 0.5f;

	private const int perkId_29 = 512729;

	private FP interval_29 = 1;

	private int buffId_29 = 12752911;

	private const int perkId_30 = 512730;

	private int prob_30 = 50;

	private FP cd_30 = 1;

	private string areaEffect_30 = "AreaEffect_12701_Perk30_Fountain";

	private const int perkId_31 = 512731;

	private int buff_31 = 12731011;

	private const int perkId_33 = 512733;

	private const int buffId_33 = 12753311;

	private Dictionary<long, CoroutineNode> dicPlayerCor = new Dictionary<long, CoroutineNode>();

	private long areaId;

	private AreaEffectEntity areaEntity;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		areaId = 0L;
		areaEntity = null;
		dicPlayerCor.Clear();
		if (!GetPerkLv(512733, out var _))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				playerAdventureActor.buffComponent.AddBuff(12753311, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		foreach (KeyValuePair<long, CoroutineNode> item in dicPlayerCor)
		{
			StopCoroutine(item.Value);
		}
		dicPlayerCor.Clear();
	}

	public override void OnAssistCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnAssistCastSkill(evt);
		_ = evt.sender is PlayerAdventureActor;
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerkLv(512724, out var _) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Water_P24))
		{
			AdventureActor.AddFromAttr(once_24, _actor);
		}
	}

	public override void OnAssistBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnAssistBeforeHit(evt, monster);
	}

	public override void OnOtherHitPost(AdventureActorReceiveDamageEvent evt, PlayerAdventureActor player, MonsterAdventureActor monster)
	{
		base.OnOtherHitPost(evt, player, monster);
		if (evt.from.Id != mainCtrActor.Id)
		{
			return;
		}
		if (GetPerkLv(512722, out var _) && mainCtrActor.actorShield.CheckShieldByTag(shieldTag) && CheckCd(512722, cd_22))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEfffect_22, mainCtrActor.tsTransform.Position);
		}
		if (GetPerkLv(512730, out var lv2) && areaEntity != null)
		{
			List<DeterministicCollider> list = new List<DeterministicCollider>();
			areaEntity.DeterministicCollision(list, 256);
			if (list.Count > 0 && list.Contains(mainCtrActor.dtCollider) && TSRandom.Range(0, 100) < prob_30 && CheckCd(512730, cd_30))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_30, monster.tsTransform.Position);
				NovaLogger.Debug("触发喷泉");
			}
		}
		if (GetPerkLv(512726, out lv2) && CheckCd(512726, cd_26))
		{
			skillMgr.ModifyResumeTimeAbs(-cdReduce_26, ActionKey.B);
		}
	}

	public override void OnOtherHurt(AdventureActorReceiveDamageEvent evt, PlayerAdventureActor player)
	{
		base.OnOtherHurt(evt, player);
		if (GetPerkLv(512726, out var _) && player.actorShield.CheckShieldByTag(shieldTag) && CheckCd(512726, cd_26))
		{
			skillMgr.ModifyResumeTimeAbs(-cdReduce_26, ActionKey.B);
		}
	}

	public override void OnShieldAdd(IEvent evt)
	{
		base.OnShieldAdd(evt);
		if (_actor != null && evt is AdventureActorAddShield adventureActorAddShield && adventureActorAddShield.shieldTags.Contains(shieldTag))
		{
			if (GetPerkLv(512721, out var lv) && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				mainCtrActor.buffComponent.AddBuff(buffId_21, _actor);
			}
			if (GetPerkLv(512725, out lv) && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				mainCtrActor.buffComponent.AddBuff(buffId_25, _actor);
				mainCtrActor.buffComponent.AddBuff(12752512, _actor);
			}
			if (GetPerkLv(512726, out lv))
			{
				mainCtrActor.buffComponent.AddBuff(buffId_26, _actor);
			}
			if (GetPerkLv(512727, out lv))
			{
				mainCtrActor.buffComponent.AddBuff(buffId_27, _actor);
			}
		}
	}

	public override void OnShieldChange(AdventureActorRemoveShield evt)
	{
		base.OnShieldChange(evt);
		if (evt.shieldTags.Contains(shieldTag))
		{
			if (GetPerkLv(512721, out var lv) && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				mainCtrActor.buffComponent.RemoveBuffByBuffId(buffId_21);
			}
			if (GetPerkLv(512725, out lv) && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
			{
				mainCtrActor.buffComponent.RemoveBuffByBuffId(buffId_25);
				mainCtrActor.buffComponent.RemoveBuffByBuffId(12752512);
			}
			if (GetPerkLv(512726, out lv))
			{
				mainCtrActor.buffComponent.RemoveBuffByBuffId(buffId_26);
			}
			if (GetPerkLv(512727, out lv))
			{
				mainCtrActor.buffComponent.RemoveBuffByBuffId(buffId_27);
			}
		}
	}

	public override void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
		base.OnAreaEffectFinish(evt);
		if (areaEntity != null && evt.entityID == areaEntity.Id)
		{
			areaId = 0L;
			areaEntity = null;
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Water) && GetPerkLv(512728, out var _) && CheckCd(512728, cd_28))
		{
			mainCtrActor.buffComponent.AddBuff(buffId_28, _actor);
		}
	}

	private void OnActorEnter(IEvent _evt)
	{
		if (_evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent && adventurePlayerEnterEvent.player == _actor && GetPerkLv(512731, out var _))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_31, _actor);
		}
	}

	private void OnActorLeave(IEvent _evt)
	{
		if (_evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent && adventurePlayerLeaveEvent.player == _actor && GetPerkLv(512731, out var _))
		{
			Singleton<BuffManager>.Instance.RemoveBufftoGroup(buff_31);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == shieldEvent)
		{
			OnAddShield();
		}
		else if (evt.eventHashCode == castAreaEvent)
		{
			TSVector2 position = _actor.tsTransform.Position;
			position += _actor.tsTransform.Forward * areaEffect_offset;
			OnCastWaterArea(position);
		}
	}

	private void OnCastWaterArea(TSVector2 pos)
	{
		if (areaId != 0L)
		{
			ILRuntimeAPI.StopAreaEffect(areaId);
			areaId = 0L;
			areaEntity = null;
		}
		string fxAlias = areaEffect_water;
		if (GetPerkLv(512724, out var lv))
		{
			fxAlias = areaEffect_water_p24;
		}
		areaId = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, pos, _actor.tsTransform.Rotation, (AreaEffectEntity entity) =>
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
			if (GetPerkLv(512728, out lv))
			{
				entity.GetLogicComponent<AreaEffect_AttackComponent>().hitInterval = hitInterval_28;
			}
			entity.AddChildTag(areaTag);
		});
		areaEntity = ILRuntimeAPI.GetAreaEffect(areaId);
		if (GetPerkLv(512723, out var _))
		{
			ILRuntimeAPI.ModifyAreaEffectLeftTime(areaId, leftTime_23);
		}
	}

	private void OnAddShield()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		activedPlayerActor.actorShield.AddShield(shielId, _actor);
		if (GetPerkLv(512721, out var _))
		{
			activedPlayerActor.actorShield.AjustShieldTime_Value(shielId, addTime_21);
		}
	}

	private void OnAreaEffectEnterExit(IEvent evt)
	{
		if (evt is AdventureAreaEnterExitEvent { sender: AreaEffectEntity sender } adventureAreaEnterExitEvent && sender.CheckChildTag(areaTag) && GetPerkLv(512729, out var _) && adventureAreaEnterExitEvent.triggerCollider != null && adventureAreaEnterExitEvent.triggerCollider.Entity is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			CoroutineNode value2;
			if (adventureAreaEnterExitEvent.iEnter && !dicPlayerCor.ContainsKey(playerAdventureActor.Id))
			{
				CoroutineNode value = StartCoroutine(DoAddBuff(playerAdventureActor));
				dicPlayerCor.Add(playerAdventureActor.Id, value);
			}
			else if (dicPlayerCor.TryGetValue(playerAdventureActor.Id, out value2))
			{
				StopCoroutine(value2);
				dicPlayerCor.Remove(playerAdventureActor.Id);
			}
		}
	}

	private IEnumerator DoAddBuff(PlayerAdventureActor actor)
	{
		actor.buffComponent.AddBuff(buffId_29, _actor);
		FP timer = 0;
		while (true)
		{
			if (timer >= interval_29)
			{
				actor.buffComponent.AddBuff(buffId_29, _actor);
				timer = 0;
			}
			yield return null;
			timer += _actor.LogicDeltaTime;
		}
	}
}
