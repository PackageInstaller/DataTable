using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改特效动画机参数", 0)]
[Category("✫ DragonLost/Effect")]
[Description("用于修改特效动画机中的参数")]
public class ChangeEffectAnimtorParam : ActionTaskBase
{
	[RequiredField]
	[Name("参数名", 0)]
	[Description("要修改的动画机参数的名称")]
	public BBParameter<string> paramKey;

	[RequiredField]
	[Name("参数类型", 0)]
	[Description("要修改的动画机参数的类型")]
	public AnimatorParamType paramType;

	[ShowIf("paramType", 0)]
	[Name("int值", 0)]
	[Description("要设置的整数类型参数的值")]
	public BBParameter<int> intValue;

	[ShowIf("paramType", 1)]
	[Name("float值", 0)]
	[Description("要设置的浮点数类型参数的值")]
	public BBParameter<float> floatValue;

	[ShowIf("paramType", 2)]
	[Name("bool值", 0)]
	[Description("要设置的布尔类型参数的值")]
	public BBParameter<bool> boolValue;

	[Name("特效实体Id", 0)]
	[Description("要修改动画参数的特效实体的ID")]
	public BBParameter<int> entityId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		Animator val = GetEntity(entityId.value, isSyncEntity: false)?.GetEntityObject()?.GetComponent<Animator>();
		if ((Object)(object)val == null)
		{
			OnActionFail();
			return;
		}
		switch (paramType)
		{
		case AnimatorParamType.Int:
			val.SetInteger(paramKey.value, intValue.value);
			break;
		case AnimatorParamType.Float:
			val.SetFloat(paramKey.value, floatValue.value);
			break;
		case AnimatorParamType.Bool:
			val.SetBool(paramKey.value, boolValue.value);
			break;
		case AnimatorParamType.Trigger:
			val.SetTrigger(paramKey.value);
			break;
		}
		OnActionFinish();
	}
}
