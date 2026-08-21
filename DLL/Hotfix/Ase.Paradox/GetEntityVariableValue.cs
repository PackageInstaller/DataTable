#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace Ase.Paradox;

[Name("获取黑板参数", 0)]
[Description("获取实体的黑板参数值")]
[Category("✫ DragonLost/Operation")]
[Preserve]
public class GetEntityVariableValue<T> : ActionTaskBase
{
	[Name("返回值", 0)]
	[Description("存储获取的黑板参数值")]
	public BBParameter<T> returnValue;

	[RequiredField]
	[Name("实体ID", 0)]
	[Description("要获取黑板参数值的实体ID")]
	public BBParameter<int> EntityId;

	[RequiredField]
	[Name("变量名", 0)]
	[Description("要获取的黑板参数的名称")]
	public BBParameter<string> valueName;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			LogActionError("获取实体变量值:实体为空!");
			EndAction();
			return;
		}
		T variableValue = entity.GetComponent<AIParadoxComponent>().GetVariableValue<T>(valueName.value);
		if (typeof(T).Name != variableValue.GetType().Name)
		{
			EndAction();
			return;
		}
		returnValue.value = variableValue;
		EndAction();
	}
}
