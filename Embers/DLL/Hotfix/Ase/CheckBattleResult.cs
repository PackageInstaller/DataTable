using Ase.ECS;

namespace Ase;

public class CheckBattleResult
{
	private WorldBase world;

	private long roomId;

	public CheckBattleResult(WorldBase world, long roomId)
	{
		this.world = world;
		this.roomId = roomId;
	}

	public BattleVerificationSettleInfo Check(int recodeTeamDeads)
	{
		if (world == null)
		{
			return null;
		}
		int num = 0;
		int num2 = 0;
		float bossHpLeft = 0f;
		SingleBattleDamage realMaxDamage = SingleBattleDamage.Create();
		foreach (BaseEntity item in world.GetSystem<EntitySystem>().FindAllTargetEntities())
		{
			if (item is HeroEntity heroEntity)
			{
				if (heroEntity.IsSurvival)
				{
					num++;
				}
			}
			else if (item is MonsterEntity { IsBoss: not false, IsSurvival: not false } monsterEntity)
			{
				num2++;
				float property = BattleFormulaUtility.GetProperty(monsterEntity, "Hp");
				float property2 = BattleFormulaUtility.GetProperty(monsterEntity, "Hp", PropertyType.Max);
				bossHpLeft = 1f * property / property2;
			}
		}
		return new BattleVerificationSettleInfo
		{
			passTime = world.GetSystem<BattleSystem>().GetCheckPassTime(),
			deaths = recodeTeamDeads,
			bossHpLeft = bossHpLeft,
			result = (num2 <= 0 && num > 0),
			roomId = roomId,
			realMaxDamage = realMaxDamage
		};
	}
}
