using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("判断实体属性百分比", 0)]
[Category("✫ DragonLost/Entity")]
[Description("检查实体特定属性的当前值是否超过最大值的指定百分比。")]
public class ChangeEntityPropertyPercent : ConditionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要检查属性的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("属性Key", 0)]
	[Description("要检查的属性的键。")]
	public BBParameter<string> PropertyKey;

	[Name("比例", 0)]
	[Description("要比较的属性当前值与最大值之间的百分比。")]
	public BBParameter<float> Percent;

	protected override bool OnCheck()
	{
		base.OnCheck();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: true);
		if (entity == null)
		{
			return false;
		}
		float property = entity.GetProperty(PropertyKey.value);
		float propertyMax = entity.GetPropertyMax(PropertyKey.value);
		return property / propertyMax > Percent.value;
	}
}
