#define ENABLE_LOG
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("修改绑点上的动画参数", 0)]
[Category("✫ DragonLost/Animator")]
[Description("用于修改绑定在特定绑点上的动画参数")]
public class ChangePointAnimationParam : ActionTaskBase
{
	[RequiredField]
	[Name("参数名", 0)]
	[Description("要修改的动画参数的名称")]
	public BBParameter<string> paramKey;

	[RequiredField]
	[Name("绑点", 0)]
	[Description("要修改的动画参数所在的绑定点的名称")]
	public string PointKey;

	[RequiredField]
	[Name("参数类型", 0)]
	[Description("要修改的动画参数的类型")]
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

	[Name("改变自身", 0)]
	[Description("指示是否要修改自身绑点上的动画参数")]
	public bool changeOthers = true;

	[Name("目标实体Id", 0)]
	[Description("要修改动画参数的目标实体的ID")]
	public BBParameter<int> entityId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (changeOthers)
		{
			entityId.value = ownerEntity.Id;
		}
		EntityBoneComponent entityBoneComponent = GetEntity(entityId.value, isSyncEntity: false)?.GetComponent<EntityBoneComponent>();
		if (entityBoneComponent == null)
		{
			OnActionFail();
			return;
		}
		Transform boneRoot = entityBoneComponent.GetBoneRoot(PointKey);
		if (boneRoot == null)
		{
			LogActionError("修改绑点上的动画参数错误：未找到绑点 " + PointKey);
			EndAction();
			return;
		}
		if (!boneRoot.TryGetComponent<Animator>(out var component))
		{
			LogActionError("修改绑点上的动画参数错误：绑点 " + PointKey + " 没有动画机组件");
			EndAction();
			return;
		}
		switch (paramType)
		{
		case AnimatorParamType.Int:
			component.SetInteger(paramKey.value, intValue.value);
			break;
		case AnimatorParamType.Float:
			component.SetFloat(paramKey.value, floatValue.value);
			break;
		case AnimatorParamType.Bool:
			component.SetBool(paramKey.value, boolValue.value);
			break;
		case AnimatorParamType.Trigger:
			component.SetTrigger(paramKey.value);
			break;
		}
		OnActionFinish();
	}
}
