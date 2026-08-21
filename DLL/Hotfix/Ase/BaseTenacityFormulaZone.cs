using Ase.ECS;

namespace Ase;

public class BaseTenacityFormulaZone : TenacityFormulaZoneBase<BaseTenacityFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcTenacity();
	}

	protected void CalcTenacity()
	{
		if (defender is MonsterEntity monsterEntity)
		{
			dataBase.minTenacity = monsterEntity.GetProperty("BaseTough");
			BattleFormulaUtility.GetConstantConfigValue(1010, out dataBase.tenacityConstant);
			dataBase.damage = damage;
		}
	}
}
