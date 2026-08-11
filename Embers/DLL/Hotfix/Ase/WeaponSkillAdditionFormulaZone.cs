using Ase.ECS;

namespace Ase;

public class WeaponSkillAdditionFormulaZone : DamageFormulaZoneBase<WeaponSkillAdditionFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcWeaponAddition();
		CalcSkillAddition();
	}

	protected void CalcWeaponAddition()
	{
		BaseEntity parent = attacker;
		if (parent.GetEntityType() == EntityType.SummonedEntity)
		{
			if (parent.Parent == null)
			{
				return;
			}
			parent = parent.Parent;
		}
		WeaponMechanismBase weaponMechanism = parent.GetWeaponMechanism();
		if (weaponMechanism != null && weaponMechanism.WeaponMechanismData != null)
		{
			string weaponDamageAdditionPropertyKey = BattleFormulaUtility.GetWeaponDamageAdditionPropertyKey(weaponMechanism.WeaponMechanismData.WeaponEnum);
			dataBase.weaponAddition = dataDamage.GetAttackerProperty(weaponDamageAdditionPropertyKey);
			if (weaponDamageAdditionPropertyKey == "SwordDamageAdditon")
			{
				dataBase.weaponAddition += dataDamage.GetAttackerProperty("SwordDamageAddition");
			}
		}
	}

	protected void CalcSkillAddition()
	{
		dataBase.skillGlobalAddition = dataDamage.GetAttackerProperty("DamageAddition");
	}
}
