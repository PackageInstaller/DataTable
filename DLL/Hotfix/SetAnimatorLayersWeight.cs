using Ase;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

[Name("修改动画层级权重", 0)]
[Category("✫ DragonLost/Animator")]
[Description("用于修改动画层级的权重值")]
public class SetAnimatorLayersWeight : ActionTaskBase
{
	[Name("是否手动选择实体", 0)]
	public bool isChooseEntity;

	[Name("实体ID", 0)]
	[ShowIf("isChooseEntity", true)]
	public BBParameter<int> entityId;

	[Name("层数", 0)]
	[Description("要修改的动画层级的索引")]
	public BBParameter<int> index;

	[Name("设置值", 0)]
	[Description("要设置的权重值")]
	public BBParameter<float> SetValue;

	private float _initWeight;

	[Name("是否跟随行为树结束还原", 0)]
	[Description("指示在行为树结束时是否还原权重值")]
	public bool followTreeDispose;

	private BaseEntity target;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (isChooseEntity)
		{
			target = ownerEntity?.GetSystem<EntitySystem>()?.GetEntity(entityId.value);
		}
		else
		{
			target = ownerEntity;
		}
		if (target == null)
		{
			OnActionFail($"选择实体失败，实体为空。Id:{entityId.value}");
			return;
		}
		AnimatorComponent component = target.GetComponent<AnimatorComponent>();
		_initWeight = component.GetLayerWeight(index.value);
		component.SetLayersWeight(index.value, SetValue.value);
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (target != null)
		{
			if (followTreeDispose)
			{
				target.GetComponent<AnimatorComponent>()?.SetLayersWeight(index.value, _initWeight);
			}
			target = null;
		}
	}
}
