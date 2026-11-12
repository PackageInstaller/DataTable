using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Disc;

public class Disc_213017 : DiscScriptBase
{
	private const int discId = 213017;

	private static readonly List<int> skillIds_1 = new List<int> { 3017000, 3017001, 3017002, 3017003, 3017004 };

	private static readonly List<int> buffIdList_1_1 = new List<int> { 4020000, 4020001, 4020002, 4020003, 4020004 };

	private static readonly List<int> hitDamageIdList_1_1 = new List<int> { 4020005, 4020005, 4020005, 4020005, 4020005 };

	private static readonly FP searchRadius_1_1 = 6;

	private const string hittedFx_1_1 = "FX/Perk/fx_perk_base_light_lightning_01";

	private static readonly FP hitRadius_1_3 = 2.5;

	private const string hitFx_1_3 = "FX/Perk/fx_perk_base_light_lightning_01";

	private int _discSkillLevel_1;

	private int _discSkillStage_1;

	private CommomAreaHitConfig _areaHitConfig;

	protected override void OnDiscEnable()
	{
		base.OnDiscEnable();
		(_discSkillStage_1, _discSkillLevel_1) = GetDiscInfo(213017, skillIds_1);
		if (_discSkillLevel_1 <= 0)
		{
			return;
		}
		foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (CheckActorIsLE(actorL))
			{
				actorL.buffComponent.AddBuff(buffIdList_1_1.get_Item(_discSkillStage_1), actorL);
			}
		}
	}

	protected override void OnMainPlayerActorCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnMainPlayerActorCastSkill(actor, castSkillEvent);
		if (castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A && _discSkillLevel_1 > 0 && CheckActorIsLE(actor))
		{
			Hit();
		}
	}

	protected override void OnPerfectDodge(AdventurePerfectDodgeTrigger evt)
	{
		base.OnPerfectDodge(evt);
		if (_discSkillLevel_1 > 1 && CheckActorIsLE(evt.actor as PlayerAdventureActor))
		{
			Hit();
		}
	}

	private void Hit()
	{
		if (_discSkillLevel_1 <= 0)
		{
			return;
		}
		MonsterAdventureActor target = null;
		ILRuntimeAPI.SearchByRange(_actor, searchRadius_1_1, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				target = result.get_Item(TSRandom.Range(0, result.Count)) as MonsterAdventureActor;
			}
		}, isConfront: true);
		if (!(target != null))
		{
			return;
		}
		if (_discSkillLevel_1 > 2)
		{
			if (_areaHitConfig == null)
			{
				_areaHitConfig = new CommomAreaHitConfig
				{
					fxAlias = "FX/Perk/fx_perk_base_light_lightning_01",
					hitDamageId = hitDamageIdList_1_1.get_Item(_discSkillStage_1),
					damageImmuneDuration = -1
				};
			}
			_areaHitConfig.position = target.tsTransform.Position;
			ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, hitRadius_1_3, 0);
		}
		else
		{
			ILRuntimeAPI.HitActor(_actor, target, hitDamageIdList_1_1.get_Item(_discSkillStage_1), "FX/Perk/fx_perk_base_light_lightning_01", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
		}
	}

	private bool CheckActorIsLE(PlayerAdventureActor actor, bool checkAssit = false, bool isAssist = false)
	{
		if (actor == null)
		{
			return false;
		}
		if (actor.actorElementInfo.elementType == HotfixEnum.elementType.LE)
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
		_discSkillLevel_1 = 0;
		_discSkillStage_1 = 0;
	}
}
