using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改绑点激活状态", 0)]
[Category("✫ DragonLost/Entity")]
[Description("修改指定绑点的激活状态。")]
public class ChangeBoneActiveState : ActionTaskBase
{
	[Name("绑点key", 0)]
	[Description("要修改激活状态的绑点名称列表。")]
	public BBParameter<List<string>> boneKey;

	[Name("设置状态", 0)]
	[Description("要设置的激活状态。")]
	public bool isActive;

	[Name("错误返回结果", 0)]
	[Description("指示在出错时是否返回错误结果。")]
	public bool errorBack = true;

	[Name("行为树结束是否重置", 0)]
	[Description("指示在行为树结束时是否重置状态。")]
	public bool isRestore;

	[Name("行为树结束重置的状态", 0)]
	[ShowIf("isRestore", 1)]
	[Description("行为树结束时要重置的状态。")]
	public bool active;

	private EntityBoneComponent boneComponent;

	protected override void OnExecute()
	{
		base.OnExecute();
		boneComponent = ownerEntity.GetComponent<EntityBoneComponent>();
		if (boneComponent == null)
		{
			OnActionEnd(errorBack);
			return;
		}
		foreach (string item in boneKey.value)
		{
			boneComponent.ChangeBoneActiveState(item, isActive);
		}
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (boneComponent == null || !isRestore)
		{
			return;
		}
		foreach (string item in boneKey.value)
		{
			boneComponent.ChangeBoneActiveState(item, active);
		}
	}
}
