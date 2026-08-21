using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class CureFormulaDataParams : FormulaDataParams
{
	public BaseEntity cureEntity;

	public BaseEntity doctorEntity;

	public bool isLayerEffect;

	public int layer;

	public List<float> cureAddition;

	public List<string> skillAddition;

	public List<int> healAdditionFrom;

	public List<int> healAddPropertyType;

	public float fixedAddition;

	public float extraCureAddition;

	public float maxHp;

	public int belongToSkillId;

	public bool isExcuteFormula;

	public static CureFormulaDataParams Create(BaseEntity cureEntity, BaseEntity doctorEntity, bool isLayerEffect, int layer, List<float> cureAddition, List<string> skillAddition, List<int> healAdditionFrom, List<int> healAddPropertyType, float fixedAddition, float extraCureAddition, float maxHp, int belongToSkillId, bool isExcuteFormula)
	{
		return new CureFormulaDataParams
		{
			cureEntity = cureEntity,
			doctorEntity = doctorEntity,
			isLayerEffect = isLayerEffect,
			layer = layer,
			cureAddition = cureAddition,
			skillAddition = skillAddition,
			healAdditionFrom = healAdditionFrom,
			healAddPropertyType = healAddPropertyType,
			fixedAddition = fixedAddition,
			extraCureAddition = extraCureAddition,
			maxHp = maxHp,
			belongToSkillId = belongToSkillId,
			isExcuteFormula = isExcuteFormula
		};
	}
}
