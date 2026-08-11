using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查实体属性值", 0)]
[Category("✫ DragonLost/Movement")]
[Description("检查指定实体的属性值是否满足指定条件。")]
public class CheckEntityPropertyValue : ConditionTaskBase
{
	[Name("属性键", 0)]
	[Description("要检查的属性键。")]
	public BBParameter<string> propertyKey;

	[Name("是否获取自身的属性", 0)]
	[Description("是否检查自身实体的属性值，如果不勾选，则需要指定目标实体。")]
	public bool isSelf = true;

	[Name("目标实体", 0)]
	[ShowIf("isSelf", 0)]
	[Description("要检查属性值的目标实体的ID。")]
	public BBParameter<int> targetEntityId;

	[Name("比较方法", 0)]
	[Description("要使用的比较方法。")]
	public CompareMethod checkType;

	[Name("是否百分比", 0)]
	[Description("指示属性值是否以百分比形式进行比较。")]
	public bool isPercentage;

	[Name("比较值", 0)]
	[Description("用于比较的值。")]
	public BBParameter<float> valueB;

	[Name("阈值", 0)]
	[SliderField(0f, 0.1f)]
	[Description("数值比较的阈值。")]
	public float differenceThreshold = 0.05f;

	protected override string info => $"属性【{propertyKey.value}】 {OperationTools.GetCompareString(checkType)} {GetValue()}{GetSuffix()}";

	private string GetSuffix()
	{
		if (!isPercentage)
		{
			return "";
		}
		return "%";
	}

	private float GetValue()
	{
		if (!isPercentage)
		{
			return valueB.value;
		}
		return valueB.value * 100f;
	}

	protected override bool OnCheck()
	{
		base.OnCheck();
		float num = 0f;
		if (isSelf)
		{
			num = ((!isPercentage) ? ownerEntity.GetProperty(propertyKey.value) : (ownerEntity.GetProperty(propertyKey.value) / ownerEntity.GetPropertyMax(propertyKey.value)));
		}
		else
		{
			BaseEntity entity = GetEntity(targetEntityId.value, isSyncEntity: false);
			if (entity == null || !entity.IsSurvival)
			{
				return false;
			}
			num = ((!isPercentage) ? entity.GetProperty(propertyKey.value) : (entity.GetProperty(propertyKey.value) / entity.GetPropertyMax(propertyKey.value)));
		}
		return OperationTools.Compare(num, valueB.value, checkType, differenceThreshold);
	}
}
