namespace Ase;

public class SpecialFormulaZone : DamageFormulaZoneBase<SpecialFormulaData>
{
	public override bool CheckIsCalcFormulaZone()
	{
		if (!base.CheckIsCalcFormulaZone())
		{
			return false;
		}
		EntityType entityType = attacker.GetEntityType();
		EntityType entityType2 = defender.GetEntityType();
		if ((entityType != EntityType.HERO && entityType != EntityType.MONSTER) || entityType2 != EntityType.HERO)
		{
			return entityType2 == EntityType.MONSTER;
		}
		return true;
	}

	protected override void OnCalcFormulaZone()
	{
		CalcLight();
	}

	protected void CalcLight()
	{
		EntityType entityType = attacker.GetEntityType();
		EntityType entityType2 = defender.GetEntityType();
		if (entityType == EntityType.HERO)
		{
			dataBase.needCalcLightKey = "Attack";
			if (!BattleFormulaUtility.GetConstantConfigValue(118, out dataBase.minLight) || !BattleFormulaUtility.GetConstantConfigValue(119, out dataBase.maxLight))
			{
				return;
			}
		}
		else if (entityType2 == EntityType.HERO)
		{
			dataBase.needCalcLightKey = "Hp";
			if (!BattleFormulaUtility.GetConstantConfigValue(120, out dataBase.minLight) || !BattleFormulaUtility.GetConstantConfigValue(121, out dataBase.maxLight))
			{
				return;
			}
		}
		if (string.IsNullOrEmpty(dataBase.needCalcLightKey))
		{
			dataBase.needCalcLightKey = "None";
			return;
		}
		dataBase.attackerLight = dataDamage.GetAttackLight(dataBase.needCalcLightKey);
		dataBase.defenderLight = defender.EntityViewModel?.GetPropertyLight(dataBase.needCalcLightKey) ?? 0f;
		float num = ((dataBase.needCalcLightKey == "Attack") ? dataBase.attackerLight : dataBase.defenderLight);
		if (dataBase.attackerLight == 0f || dataBase.defenderLight == 0f)
		{
			return;
		}
		dataBase.isCalcLight = true;
		if (dataBase.needCalcLightKey == "Attack")
		{
			dataBase.realLight = CalcRealLight(dataBase.attackerLight, dataBase.defenderLight);
			if (dataBase.realLight == 0f)
			{
				dataBase.lightAddition = 1f;
			}
			else
			{
				dataBase.lightAddition = dataBase.realLight / num;
			}
		}
		else if (dataBase.needCalcLightKey == "Hp")
		{
			dataBase.realLight = CalcRealLight(dataBase.defenderLight, dataBase.attackerLight);
			if (dataBase.realLight == 0f)
			{
				dataBase.lightAddition = 1f;
			}
			else
			{
				dataBase.lightAddition = num / dataBase.realLight;
			}
		}
	}

	private float CalcRealLight(float heroLight, float monsterLight)
	{
		if (heroLight / monsterLight > dataBase.minLight)
		{
			return monsterLight * dataBase.minLight + (dataBase.maxLight - dataBase.minLight) * (heroLight - monsterLight * dataBase.minLight) / (heroLight - monsterLight * dataBase.minLight + monsterLight * dataBase.maxLight) * monsterLight;
		}
		return 0f;
	}
}
