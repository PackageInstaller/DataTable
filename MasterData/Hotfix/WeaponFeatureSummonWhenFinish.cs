using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/完结时召唤怪物")]
public class WeaponFeatureSummonWhenFinish : WeaponFeature
{
	[Space]
	public int monsterId;

	public bool useMonsterTeamMate;

	public int monsterTeamMateIndex;

	public SummonAttrType summonAttrType;

	public SummonRelation summonRelation;

	public int attrPercent = 100;

	public FP leftTime = 0;

	public int maxCount;

	public SummonDirType summonDirType;

	private SummonCfg summonCfg;

	public override void OnStart()
	{
		base.OnStart();
		if (summonCfg == null)
		{
			summonCfg = new SummonCfg();
		}
		summonCfg.summonAttrType = summonAttrType;
		summonCfg.summonRelation = summonRelation;
		summonCfg.attrPercent = attrPercent;
		summonCfg.leftTime = leftTime;
		summonCfg.maxCount = maxCount;
	}

	public override bool OnEnd()
	{
		OnExceute();
		return base.OnEnd();
	}

	private void OnExceute()
	{
		AdventureActor component = attachedWeapon.owner.GetComponent<AdventureActor>();
		if (!(component == null) && (component.actorHealthInfo.isAlive || !component.isDead))
		{
			int monsterTeammateId = monsterId;
			if (useMonsterTeamMate && component is MonsterAdventureActor monsterAdventureActor)
			{
				monsterTeammateId = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, monsterTeamMateIndex);
			}
			if (monsterTeammateId > 0)
			{
				TSVector2 position = attachedWeapon.tsTransform.Position;
				TSVector2 summonDirection = GetSummonDirection(position);
				ILRuntimeAPI.SummonMonster(component, 0, monsterTeammateId, position, summonDirection, summonCfg);
			}
		}
	}

	private TSVector2 GetSummonDirection(TSVector2 summonPosition)
	{
		SummonDirType summonDirType = this.summonDirType;
		if (summonDirType != SummonDirType.Default && summonDirType == SummonDirType.Random)
		{
			FP value = MonoSingleton<GameController>.Instance.Random_Roguelike(FP.Zero, 360) * FP.Deg2Rad;
			return new TSVector2(TSMath.Cos(value), TSMath.Sin(value));
		}
		TSVector2 result = attachedWeapon.owner.tsTransform.Forward;
		if (attachedWeapon.owner is MonsterAdventureActor)
		{
			result = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - summonPosition).normalized;
		}
		return result;
	}
}
