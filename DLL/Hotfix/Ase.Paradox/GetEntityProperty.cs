using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取实体属性值", 0)]
[Description("从指定的实体获取其指定属性的值，并将结果存储在指定的变量中。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityProperty : ActionTaskBase
{
	[Name("属性键", 0)]
	[Description("要获取的实体属性的键。")]
	public BBParameter<string> propertyKey;

	[Name("属性类型", 0)]
	[Description("要获取的属性值的类型。")]
	public PropertyType PropertyType;

	[Name("返回的属性值", 0)]
	[Description("存储获取到的实体属性值。")]
	public BBParameter<float> returnValue;

	[Name("目标实体", 0)]
	[Description("要获取属性值的目标实体的ID。如果目标实体为空，则默认为执行该任务的实体。")]
	public BBParameter<int> targetEntityId;

	protected override string info => "获取实体属性 : " + propertyKey.value;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = null;
		if (targetEntityId.value == 0)
		{
			baseEntity = ownerEntity;
		}
		else
		{
			baseEntity = GetEntity(targetEntityId.value, isSyncEntity: true);
			if (baseEntity == null || !baseEntity.IsSurvival)
			{
				OnActionFail();
				return;
			}
		}
		switch (PropertyType)
		{
		case PropertyType.FixedValue:
			returnValue.value = BattleFormulaUtility.GetProperty(baseEntity, propertyKey.value);
			break;
		case PropertyType.InitValue:
			returnValue.value = BattleFormulaUtility.GetProperty(baseEntity, propertyKey.value, Ase.PropertyType.Init);
			break;
		case PropertyType.MinValue:
			returnValue.value = BattleFormulaUtility.GetProperty(baseEntity, propertyKey.value, Ase.PropertyType.Min);
			break;
		case PropertyType.MaxValue:
			returnValue.value = BattleFormulaUtility.GetProperty(baseEntity, propertyKey.value, Ase.PropertyType.Max);
			break;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"获取实体属性值 属性键 : {propertyKey.value} 属性类型 : {PropertyType} 返回的属性值 : {returnValue.value}  目标实体 : {targetEntityId.value}", ownerEntity);
		}
		OnActionFinish();
	}
}
