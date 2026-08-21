using Ase.ECS;

namespace Ase;

public class WeaponMechanismFormulaZone : DamageFormulaZoneBase<WeaponMechanismFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcWeaponMechanism();
		CalcWeaponMechanismRatio();
		CalcGlobalMechanism();
		CalcTreeAndBuffAddition();
	}

	protected void CalcWeaponMechanism()
	{
		dataBase.weaponMechanism = dataDamage.GetAttackerProperty("WeaponFrame");
	}

	protected void CalcWeaponMechanismRatio()
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
		if (weaponMechanism == null || weaponMechanism.WeaponMechanismData == null)
		{
			return;
		}
		string weaponMechanismPropertyKey = BattleFormulaUtility.GetWeaponMechanismPropertyKey(weaponMechanism.WeaponMechanismData.WeaponEnum);
		if (!string.IsNullOrEmpty(weaponMechanismPropertyKey))
		{
			dataBase.weaponMechanismRatio = dataDamage.GetAttackerProperty(weaponMechanismPropertyKey);
			if (weaponMechanismPropertyKey == "SwordFrameAdditon")
			{
				dataBase.weaponMechanismRatio += dataDamage.GetAttackerProperty("SwordFrameAddition");
			}
		}
	}

	protected void CalcGlobalMechanism()
	{
		dataBase.skillAddition = dataDamage.GetAttackerProperty("SkillDamageAddition");
	}

	protected void CalcTreeAndBuffAddition()
	{
		SkillAdditionData skillAdditionData = attacker.GetComponent<SkillComponent>()?.GetSkillAddition(dataDamage.BelongToSkillId);
		if (skillAdditionData != null)
		{
			dataBase.treeAndBuffAddition = skillAdditionData.SkillSpecialDamage;
		}
		if (attacker.GetEntityType() == EntityType.SummonedEntity)
		{
			dataBase.extraTreeAndBuffAddition = (dataDamage.bulletAttackData?.BulletParentPropertyData?.SkillSpecialDamage).GetValueOrDefault();
		}
	}
}
