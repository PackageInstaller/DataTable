using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Parallel_JuXingMoXiang : Parallel
{
	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && !(adventureBulletFinishEvent.owner != _actor))
		{
			string text = _actor.logicVariable?.GetLogicTagStringValue(Config_JuXingMoXiang.BombardFinalBulletIdTag);
			if (!string.IsNullOrEmpty(text) && long.TryParse(text, out var result) && adventureBulletFinishEvent.id == result)
			{
				_actor.logicVariable?.SetLogicTagStringValue(Config_JuXingMoXiang.BombardFinalBulletIdTag, string.Empty);
				TryHitBoss(adventureBulletFinishEvent.bulletPosition);
			}
		}
	}

	private void TryHitBoss(TSVector2 lockPos)
	{
		int num = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(_actor, Config_JuXingMoXiang.PartnerDataIdTag);
		List<LogicEntity> targetByDataID = CommonUtils_MonsterAPI.GetTargetByDataID(num);
		if (targetByDataID.Count <= 0)
		{
			return;
		}
		AdventureActor adventureActor = targetByDataID.get_Item(0) as AdventureActor;
		if (!(adventureActor == null) && adventureActor.dataID == num && !(TSVector2.DistanceSquared(lockPos, adventureActor.tsTransform.Position) > Skill_Bombard_JuXingMoXiang.BombardFinalHitRadius * Skill_Bombard_JuXingMoXiang.BombardFinalHitRadius))
		{
			MonsterAdventureActor monsterAdventureActor = adventureActor as MonsterAdventureActor;
			if (!(monsterAdventureActor == null))
			{
				monsterAdventureActor.monsterToughnessInfo.DamageToToughness(_actor, 10L);
				int level = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(adventureActor, Common_73001.SummonLevel_Tag);
				int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.damageReductionBuffIds);
				int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.vulnerableBuffIds);
				Common_73001.TryRemoveBuffOrAddBuff(monsterAdventureActor, monsterIdByLevel, monsterIdByLevel2);
			}
		}
	}
}
