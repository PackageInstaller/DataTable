using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改动画参数", 0)]
[Category("✫ DragonLost/Animator")]
[Description("修改Animator动画参数")]
public class ChangeAnimationParam : ActionTaskBase
{
	[RequiredField]
	[Name("动画参数名", 0)]
	[Description("动画参数名(变量描述)")]
	public BBParameter<string> paramKey;

	[RequiredField]
	[Name("参数类型", 0)]
	[Description("int,float,bool,trigger")]
	public AnimatorParamType paramType;

	[ShowIf("paramType", 0)]
	[Name("int参数值", 0)]
	[Description("int参数值(变量描述)")]
	public BBParameter<int> intValue;

	[ShowIf("paramType", 1)]
	[Name("float参数值", 0)]
	[Description("float参数值(变量描述)")]
	public BBParameter<float> floatValue;

	[ShowIf("paramType", 2)]
	[Name("bool参数值", 0)]
	[Description("bool参数值(变量描述)")]
	public BBParameter<bool> boolValue;

	[Name("改变自身", 0)]
	[Description("是否改变当前实体Id为目标Id")]
	public bool changeOthers = true;

	[Name("目标实体Id", 0)]
	[Description("目标实体Id(变量描述)")]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (changeOthers)
		{
			entityId.value = ownerEntity.Id;
		}
		AnimatorComponent animatorComponent = GetEntity(entityId.value, isSyncEntity: false)?.GetComponent<AnimatorComponent>();
		if (animatorComponent == null)
		{
			OnActionFail();
			return;
		}
		switch (paramType)
		{
		case AnimatorParamType.Int:
			animatorComponent.SetInteger(paramKey.value, intValue.value);
			break;
		case AnimatorParamType.Float:
			animatorComponent.SetFloat(paramKey.value, floatValue.value);
			break;
		case AnimatorParamType.Bool:
			animatorComponent.SetBool(paramKey.value, boolValue.value);
			break;
		case AnimatorParamType.Trigger:
			animatorComponent.SetTrigger(paramKey.value);
			break;
		}
		OnActionFinish();
	}
}
