using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器组件/武器通用_结束时召唤怪物组件(目前仅炸弹可用)")]
[DisallowMultipleComponent]
public class WeaponComponent_SummonWhenFinish : LogicMonoComponent, IBombComponent
{
	public int monsterId;

	public bool useMonsterTeamMate;

	public int monsterTeamMateIndex;

	public SummonAttrType summonAttrType;

	public SummonRelation summonRelation;

	public int attrPercent = 100;

	public FP leftTime = 0;

	public int maxCount;

	public SummonDirType summonDirType;

	protected AdventureWeapon _context;

	protected SummonCfg summonCfg;

	public bool KeepAlive { get; set; } = true;

	public void Setup()
	{
		_context = Entity as AdventureWeapon;
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

	public void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		KeepAlive = true;
	}

	public void Finish()
	{
		KeepAlive = false;
		AdventureActor adventureActor = _context.owner as AdventureActor;
		if (!(adventureActor == null) && (adventureActor.actorHealthInfo.isAlive || !adventureActor.isDead))
		{
			int monsterTeammateId = monsterId;
			if (useMonsterTeamMate && adventureActor is MonsterAdventureActor monsterAdventureActor)
			{
				monsterTeammateId = CommonHelper.GetMonsterTeammateId(monsterAdventureActor.monsterInfo.teamId, monsterTeamMateIndex);
			}
			if (monsterTeammateId > 0)
			{
				TSVector2 position = _context.tsTransform.Position;
				TSVector2 summonDirection = GetSummonDirection(position);
				ILRuntimeAPI.SummonMonster(adventureActor, 0, monsterTeammateId, position, summonDirection, summonCfg);
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
		return (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position - summonPosition).normalized;
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_context = null;
	}
}
