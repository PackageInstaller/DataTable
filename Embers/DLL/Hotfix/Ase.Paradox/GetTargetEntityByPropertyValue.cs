using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获得列表中满足指定属性条件的单位", 0)]
[Description("从给定的实体列表中获取满足指定属性条件的单位，可以选择获取属性值最高或最低的单位。")]
[Category("✫ DragonLost/Entity")]
public class GetTargetEntityByPropertyValue : ActionTaskBase
{
	[PopupField(new object[] { "Hp", "Attack", "Tenacity", "Defence", "Energy", "XpEnergy", "MonsterAnger", "HeroAnger" })]
	[Name("属性类型", 0)]
	[Description("指定用于筛选单位的属性类型。")]
	public string propertyKey;

	[Name("获取条件_1", 0)]
	[Description("指定获取单位的条件之一，可以是属性值的最大或最小值。")]
	public BBParameter<HpValueEnum> hpValueEnum;

	[Name("获取条件_2", 0)]
	[Description("指定获取单位的条件之一，可以是固定数值或百分比数值。")]
	public BBParameter<HpTypeEnum> hpTypeEnum;

	[Name("筛选列表", 0)]
	[Description("存储需要筛选的实体的ID列表。")]
	public BBParameter<List<int>> selectList;

	[Name("_返回的单位", 0)]
	[Description("存储获取到的满足条件的单位的ID。")]
	public BBParameter<int> returnEntity;

	protected override string info => "获取属性 " + propertyKey + " " + ((hpTypeEnum.value == HpTypeEnum.FixedValue) ? "数值" : "百分比数值") + ((hpValueEnum.value == HpValueEnum.Max) ? " 最大" : " 最小") + "的目标";

	protected override void OnExecute()
	{
		base.OnExecute();
		_ = selectList.value.Count;
		_ = 0;
		switch (hpValueEnum.value)
		{
		case HpValueEnum.Max:
			returnEntity.value = FindMaxHpEntity();
			break;
		case HpValueEnum.Min:
			returnEntity.value = FindMinHpEntity();
			break;
		}
		EndAction();
	}

	private int FindMaxHpEntity()
	{
		float num = float.MinValue;
		int result = 0;
		foreach (int item in selectList.value)
		{
			BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(item);
			if (entity != null)
			{
				float num2 = ((hpTypeEnum.value == HpTypeEnum.FixedValue) ? entity.GetProperty(propertyKey, float.MinValue) : entity.GetPropertyPercentage(propertyKey, float.MinValue));
				if (num < num2)
				{
					num = num2;
					result = item;
				}
			}
		}
		return result;
	}

	private int FindMinHpEntity()
	{
		float num = float.MaxValue;
		int result = 0;
		foreach (int item in selectList.value)
		{
			BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(item);
			if (entity != null)
			{
				float num2 = ((hpTypeEnum.value == HpTypeEnum.FixedValue) ? entity.GetProperty(propertyKey, float.MaxValue) : entity.GetPropertyPercentage(propertyKey, float.MaxValue));
				if (num > num2)
				{
					num = num2;
					result = item;
				}
			}
		}
		return result;
	}
}
