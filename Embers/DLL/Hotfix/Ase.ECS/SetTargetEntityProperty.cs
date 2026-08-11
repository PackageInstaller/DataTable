#define ENABLE_LOG
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.ECS;

[Name("设置/获取 目标自定义数据", 0)]
[Category("✫ DragonLost/DataNode")]
[Description("设置和获取目标自定义数据值，支持Int, Float, Vector2, Vector3")]
public class SetTargetEntityProperty : ActionTaskBase
{
	[Name("目标ID", 0)]
	[Description("要设置或获取自定义数据的目标实体的ID。")]
	public BBParameter<int> entityId;

	[Name("设置/获取", 0)]
	[Description("指定要进行的操作，是设置还是获取目标实体的自定义数据。")]
	public BBParameter<GetSetEnum> GetSet;

	[Name("要设置的数据名称", 0)]
	[Description("要设置或获取的目标自定义数据的名称。")]
	public BBParameter<string> PropertyName;

	[Name("设置/获取 的值(float)", 0)]
	[Description("要设置的值（如果类型为float）。")]
	public BBParameter<float> SetfloatValue;

	[Name("设置/获取 的值(整数)", 0)]
	[Description("要设置的值（如果类型为整数）。")]
	public BBParameter<int> SetIntValue;

	[Name("设置/获取 的值(Vector2)", 0)]
	[Description("要设置的值（如果类型为Vector2）。")]
	public BBParameter<Vector2> SetVec2Value;

	[Name("设置/获取 的值(Vector3)", 0)]
	[Description("要设置的值（如果类型为Vector3）。")]
	public BBParameter<Vector3> SetVec3Value;

	[Name("数据类型", 0)]
	[Description("要设置或获取的自定义数据的类型。")]
	public BBParameter<ValueTypeEnum> ValueType;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError($"根据实体Id = {entityId.value}. 没有找到目标实体.");
			EndAction();
			return;
		}
		DataNodeComponent component = entity.GetComponent<DataNodeComponent>();
		if (component == null)
		{
			LogActionError($"根据实体Id = {entityId.value}. 没有找到目标数据节点组件.");
			EndAction();
			return;
		}
		switch (GetSet.value)
		{
		case GetSetEnum.Get:
			GetProperties(component, ValueType.value, PropertyName.value);
			break;
		case GetSetEnum.Set:
			SetProperties(component, ValueType.value, PropertyName.value, SetIntValue.value, SetfloatValue.value, SetVec2Value.value, SetVec3Value.value);
			break;
		}
		EndAction();
	}

	private void SetProperties(DataNodeComponent component, ValueTypeEnum valueTypeEnum, string propertyName, int intValue, float floatValue, Vector2 vec2d, Vector3 vec3d)
	{
		switch (valueTypeEnum)
		{
		case ValueTypeEnum.Int:
		{
			DataNodeInt dataNodeInt = new DataNodeInt();
			dataNodeInt.SetValue(intValue);
			component.AddData(propertyName, dataNodeInt);
			break;
		}
		case ValueTypeEnum.Float:
		{
			DataNodeFloat dataNodeFloat = new DataNodeFloat();
			dataNodeFloat.SetValue(floatValue);
			component.AddData(propertyName, dataNodeFloat);
			break;
		}
		case ValueTypeEnum.Vector2:
		{
			DataNodeVector2 dataNodeVector2 = new DataNodeVector2();
			dataNodeVector2.SetValue(vec2d);
			component.AddData(propertyName, dataNodeVector2);
			break;
		}
		case ValueTypeEnum.Vector3:
		{
			DataNodeVector3 dataNodeVector = new DataNodeVector3();
			dataNodeVector.SetValue(vec3d);
			component.AddData(propertyName, dataNodeVector);
			break;
		}
		}
	}

	private void GetProperties(DataNodeComponent component, ValueTypeEnum valueTypeEnum, string propertyName)
	{
		switch (valueTypeEnum)
		{
		case ValueTypeEnum.Int:
			SetIntValue.value = component.GetData<int>(propertyName);
			break;
		case ValueTypeEnum.Float:
			SetfloatValue.value = component.GetData<float>(propertyName);
			break;
		case ValueTypeEnum.Vector2:
			SetVec2Value.value = component.GetData<Vector2>(propertyName);
			break;
		case ValueTypeEnum.Vector3:
			SetVec3Value.value = component.GetData<Vector3>(propertyName);
			break;
		}
	}
}
