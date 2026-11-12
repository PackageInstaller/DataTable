using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14201;

public class ParallelScript_Support : ParallelScript
{
	private string areaEffect_base = "AreaEffect_142_SkillSup_ZhuaJi";

	private string areaEffect_P21 = "AreaEffect_142_SkillSup_ZhuaJi_P21";

	private FP fixRot_left = -45;

	private FP fixRot_right = 45;

	private int buff_base = 14293015;

	private FP castOffset = 4;

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private const int perkId_21 = 514221;

	private const int buff_21 = 14221011;

	private const int perkId_22 = 514222;

	private const int buff_22 = 14222011;

	private const int perkId_25 = 514225;

	private int buff_25 = 14225011;

	private const int perkId_26 = 514226;

	private int buff_26 = 14226011;

	private const int perkId_28 = 514228;

	private int buff_28_stuff = 14228011;

	private int buff_28_group = 14228012;

	private int paramId_28_pro = 14228011;

	private const int perkId_29 = 514229;

	private int paramId_29_percent = 14229002;

	private int paramId_29_pro = 14229011;

	private FP cd_29 = 1;

	private const int perkId_30 = 514230;

	private int buff_30 = 14230011;

	private const int perkId_31 = 514231;

	private int buff_31 = 14231011;

	private const int perkId_32 = 514232;

	private int buff_32 = 14232011;

	private const int perkId_33 = 514233;

	private int buff_33 = 14233011;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		if (!GetPerkLv(514233, out var _))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_33, _actor);
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		int lv;
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (!GetPerkLv(514232, out lv))
			{
				return;
			}
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.Id != _actor.Id)
				{
					playerAdventureActor.buffComponent.AddBuff(buff_32, _actor);
				}
			}
		}
		else
		{
			if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.D || !GetPerkLv(514232, out lv))
			{
				return;
			}
			for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
			{
				PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
				if (playerAdventureActor2.Id != _actor.Id)
				{
					playerAdventureActor2.buffComponent.AddBuff(buff_32, _actor);
				}
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		int lv;
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (!GetPerkLv(514232, out lv))
			{
				return;
			}
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.Id != _actor.Id)
				{
					playerAdventureActor.buffComponent.RemoveBuffByBuffId(buff_32);
				}
			}
		}
		else
		{
			if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.D || !GetPerkLv(514232, out lv))
			{
				return;
			}
			for (int j = 0; j < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; j++)
			{
				PlayerAdventureActor playerAdventureActor2 = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(j);
				if (playerAdventureActor2.Id != _actor.Id)
				{
					playerAdventureActor2.buffComponent.RemoveBuffByBuffId(buff_32);
				}
			}
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (!isSelf)
		{
			return;
		}
		int lv;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SupportSkill))
		{
			monster.buffComponent.AddBuff(buff_base, _actor);
			if (GetPerkLv(514225, out lv))
			{
				monster.buffComponent.AddBuff(buff_25, _actor);
			}
			if (GetPerkLv(514228, out lv) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, paramId_28_pro).AsInt())
			{
				monster.buffComponent.AddBuff(buff_28_stuff, _actor);
				foreach (LogicEntity item in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
				{
					(item as AdventureActor)?.buffComponent.AddBuff(buff_28_group, _actor);
				}
			}
			if (GetPerkLv(514229, out lv) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, paramId_29_pro).AsInt() && CheckCd(514229, cd_29))
			{
				long damage = (long)(CommonUtils.GetScriptValue(_actor, paramId_29_percent) * monster.monsterToughnessInfo.toughnessMax);
				monster.monsterToughnessInfo.DamageToToughness(_actor, damage);
			}
		}
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_AddDark))
		{
			return;
		}
		if (GetPerkLv(514226, out lv) && !CommonUtils.CheckElementMark(CommonDefine.Dark, monster))
		{
			foreach (LogicEntity item2 in ILRuntimeAPI.SearchAllFriendActors(_actor, includeSelf: true))
			{
				(item2 as AdventureActor)?.buffComponent.AddBuff(buff_26, _actor);
			}
		}
		if (GetPerkLv(514230, out lv) && CommonUtils.CheckElementMark(CommonDefine.Dark, monster))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.Id != _actor.Id && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
				{
					playerAdventureActor.buffComponent.AddBuff(buff_30, _actor);
				}
			}
		}
		monster.buffComponent.AddBuff(buff_Dark, _actor);
	}

	private void OnActorEnter(IEvent _evt)
	{
		if (_evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent && adventurePlayerEnterEvent.player == _actor && GetPerkLv(514231, out var _))
		{
			mainCtrActor.buffComponent.AddBuff(buff_31, _actor);
		}
	}

	private void OnActorLeave(IEvent _evt)
	{
		if (_evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent && adventurePlayerLeaveEvent.player == _actor && GetPerkLv(514231, out var _))
		{
			mainCtrActor.buffComponent.RemoveBuffByBuffId(buff_31);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventHashCode == castAreaEvent)
		{
			OnCastDarkArea(evt.boolParam);
		}
	}

	private void OnCastDarkArea(bool isLeft)
	{
		TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * castOffset));
		FP rotation = _actor.tsTransform.Rotation + ((!isLeft) ? 180 : 0) + (isLeft ? fixRot_left : fixRot_right);
		string fxAlias = (GetPerkLv(514221, out var _) ? areaEffect_P21 : areaEffect_base);
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, rotation, (AreaEffectEntity entity) =>
		{
			AreaEffect_PullComponent logicComponent = entity.GetLogicComponent<AreaEffect_PullComponent>();
			AreaEffect_BuffComponent[] components = entity.GetComponents<AreaEffect_BuffComponent>();
			logicComponent.enabled = false;
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
			if (GetPerkLv(514221, out var lv2))
			{
				AreaEffect_BuffComponent obj = components[0];
				obj.enabled = true;
				obj.executeImmediately = true;
				obj.addBuffIdList = new List<int> { 14221011 };
				obj.addCriteriaInfo = new TargetFilterCriteriaInfo
				{
					filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
					{
						new TargetFilterCriteriaInfo.TargetFilterCriteria
						{
							targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
						}
					}
				};
				obj.triggerEnter = true;
				obj.triggerEnterCriteriaInfo = new TargetFilterCriteriaInfo
				{
					filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
					{
						new TargetFilterCriteriaInfo.TargetFilterCriteria
						{
							targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
						}
					}
				};
			}
			if (GetPerkLv(514222, out lv2))
			{
				AreaEffect_BuffComponent obj2 = components[1];
				obj2.enabled = true;
				obj2.executeImmediately = true;
				obj2.addBuffIdList = new List<int> { 14222011 };
				obj2.addCriteriaInfo = new TargetFilterCriteriaInfo
				{
					filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
					{
						new TargetFilterCriteriaInfo.TargetFilterCriteria
						{
							targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
						}
					}
				};
				obj2.triggerEnter = true;
				obj2.triggerEnterCriteriaInfo = new TargetFilterCriteriaInfo
				{
					filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
					{
						new TargetFilterCriteriaInfo.TargetFilterCriteria
						{
							targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Enemy
						}
					}
				};
				logicComponent.enabled = true;
				logicComponent.pullInterval = 0.1f;
				logicComponent.pullSpeed = 3f;
				logicComponent.pullLevel = 99;
				logicComponent.strength = 4;
				logicComponent.pullWithRadius = false;
				logicComponent.changeTargetDirection = true;
			}
		});
	}
}
