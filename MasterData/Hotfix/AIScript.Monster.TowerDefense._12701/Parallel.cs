using System.Collections.Generic;
using AIScript.DynamicLevel;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12701;

public class Parallel : TowerCharacterParalletBase
{
	private string areaEffect_water = "AreaEffect_Skill_WaterArea";

	private FP areaEffect_offset = 0;

	private FP cd_Wave = 0.5;

	private int buffId_Area = 801270210;

	private string areaEfffect_Wave = "AreaEffect_Wave";

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private int perkId_1 = 1270101;

	private int buffId_1 = 801270220;

	private int perkId_2 = 1270102;

	private int prob_2 = 25;

	private FP cd_2 = 3;

	private string areaEffect_2 = "AreaEffect_Fountain";

	private int perkId_3 = 1270103;

	private FP leftTime_3 = 5;

	private int perkId_4 = 1270104;

	private string areaEffect_4 = "AreaEffect_Wave_Plus";

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int>
	{
		[1270106] = 25,
		[1270107] = 25
	};

	private FP curTime;

	private long areaId;

	private List<DeterministicCollider> result = new List<DeterministicCollider>();

	private List<AdventureActor> buffAdds = new List<AdventureActor>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		curTime = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		buffAdds.Clear();
		result.Clear();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B || !GetPerk(perkId_1))
		{
			return;
		}
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.levelInstance.dynamicActors;
		for (int i = 0; i < dynamicActors.Count; i++)
		{
			if (dynamicActors.get_Item(i) is TowerDefenseCharacterActor towerDefenseCharacterActor && towerDefenseCharacterActor.Id != _actor.Id)
			{
				towerDefenseCharacterActor.buffComponent.AddBuff(buffId_1, _actor);
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B || !GetPerk(perkId_1))
		{
			return;
		}
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.levelInstance.dynamicActors;
		for (int i = 0; i < dynamicActors.Count; i++)
		{
			if (dynamicActors.get_Item(i) is TowerDefenseCharacterActor towerDefenseCharacterActor && towerDefenseCharacterActor.Id != _actor.Id)
			{
				towerDefenseCharacterActor.buffComponent.RemoveBuffByBuffId(buffId_1);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		if (evt.from is TowerDefenseCharacterActor towerDefenseCharacterActor && !isSelf && towerDefenseCharacterActor.buffComponent.CheckBuffByBuffID(buffId_Area))
		{
			if (curTime <= 0 || _actor.LogicTime - curTime > cd_Wave)
			{
				curTime = _actor.LogicTime;
				string fxAlias = (GetPerk(perkId_4) ? areaEffect_4 : areaEfffect_Wave);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, towerDefenseCharacterActor.tsTransform.Position);
			}
			if (GetPerk(perkId_2) && TSRandom.Range(0, 100) < prob_2 && CheckPerkCd(perkId_2, cd_2))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_2, monster.tsTransform.Position);
			}
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == castAreaEvent)
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
		}
		areaId = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_water, pos, _actor.tsTransform.Rotation);
		if (GetPerk(perkId_3))
		{
			ILRuntimeAPI.AddAreaEffectLeftTime(areaId, leftTime_3);
		}
	}

	private void OnAreaEnterOrExit(IEvent evt)
	{
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = evt as AdventureAreaEnterExitEvent;
		if (_actor != null && _actor.Id == adventureAreaEnterExitEvent.owner.Id && adventureAreaEnterExitEvent.triggerCollider?.Entity != null && adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.Id == areaId && adventureAreaEnterExitEvent.iEnter && adventureAreaEnterExitEvent.triggerCollider.Entity is TowerDefenseCharacterActor towerDefenseCharacterActor && towerDefenseCharacterActor.Id != _actor.Id)
		{
			towerDefenseCharacterActor.buffComponent.AddBuff(buffId_Area, _actor);
			buffAdds.Add(towerDefenseCharacterActor);
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id && adventureAreaEffectFinishEvent.entityID == areaId)
		{
			areaId = 0L;
			for (int i = 0; i < buffAdds.Count; i++)
			{
				buffAdds.get_Item(i).buffComponent.RemoveBuffByBuffId(buffId_Area);
			}
			buffAdds.Clear();
		}
	}
}
