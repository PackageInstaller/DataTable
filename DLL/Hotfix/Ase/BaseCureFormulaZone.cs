using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BaseCureFormulaZone : CureFormulaZoneBase<BaseCureFormulaData>
{
	protected List<float> cureAddition;

	protected List<string> propertyAddition;

	protected List<int> healAdditionFrom;

	protected List<int> healAddPropertyType;

	protected float fixedAddition;

	protected float extraCureAddition;

	protected int belongToSkillId;

	protected float maxHp;

	public override bool CheckIsCalcFormulaZone()
	{
		return true;
	}

	protected override void OnCalcFormulaZone()
	{
		if (!dataBase.isFormula)
		{
			CalcExtraHeal();
		}
		else if (dataParams.isCreateByBullet)
		{
			CalcBulletPropertyAddition();
		}
		else
		{
			CalcPropertyAddition();
		}
		CalcFixedAddition();
	}

	protected override void OnInit(FormulaDataParams param)
	{
		base.OnInit(param);
		if (cureFormulaData != null)
		{
			cureAddition = cureFormulaData.cureAddition;
			propertyAddition = cureFormulaData.skillAddition;
			healAdditionFrom = cureFormulaData.healAdditionFrom;
			healAddPropertyType = cureFormulaData.healAddPropertyType;
			fixedAddition = cureFormulaData.fixedAddition;
			extraCureAddition = cureFormulaData.extraCureAddition;
			maxHp = cureFormulaData.maxHp;
			belongToSkillId = cureFormulaData.belongToSkillId;
			dataBase.isFormula = cureFormulaData.isExcuteFormula;
		}
	}

	protected void CalcExtraHeal()
	{
		if (!dataBase.isFormula)
		{
			dataBase.propertyAddition = extraCureAddition * maxHp;
		}
	}

	protected void CalcPropertyAddition()
	{
		if (cureAddition != null && cureAddition.Count == 1 && propertyAddition != null && propertyAddition.Count == 1 && healAddPropertyType != null && healAddPropertyType.Count == 1 && healAdditionFrom != null && healAdditionFrom.Count == 1)
		{
			BaseEntity entityByTeamType = GetEntityByTeamType((EntityTeamType)healAdditionFrom[0]);
			if (entityByTeamType != null)
			{
				string propertyKey = propertyAddition[0];
				PropertyType propertyType = (PropertyType)healAddPropertyType[0];
				float num = cureAddition[0];
				float property = BattleFormulaUtility.GetProperty(entityByTeamType, propertyKey, propertyType);
				dataBase.propertyAddition = property * num;
			}
		}
	}

	protected void CalcBulletPropertyAddition()
	{
		_ = cureAddition.Count;
		_ = propertyAddition.Count;
		_ = cureAddition.Count;
		_ = healAddPropertyType.Count;
		if (healAddPropertyType != null)
		{
			_ = healAddPropertyType.Count;
			_ = healAdditionFrom.Count;
		}
		for (int i = 0; i < cureAddition.Count; i++)
		{
			BaseEntity entity = ((healAdditionFrom[i] == 0) ? doctorEntity : cureEntity);
			PropertyType propertyType = PropertyType.Cur;
			if (healAddPropertyType != null)
			{
				propertyType = ((healAddPropertyType[i] == 0) ? PropertyType.Max : PropertyType.Cur);
			}
			float property = BattleFormulaUtility.GetProperty(entity, propertyAddition[i], propertyType);
			float num = cureAddition[i];
			dataBase.propertyAddition += property * num;
		}
	}

	protected void CalcFixedAddition()
	{
		dataBase.fixedAddition = fixedAddition;
	}

	private BaseEntity GetEntityByTeamType(EntityTeamType teamType)
	{
		return teamType switch
		{
			EntityTeamType.Self => cureEntity, 
			EntityTeamType.Creator => doctorEntity, 
			_ => null, 
		};
	}
}
