using Ase;
using Ase.ECS;
using ParadoxNotion.Design;

[Name("修改实体游戏物体的插值速度", 0)]
[Description("修改逻辑层到表现层的插值速度。")]
[Category("✫ DragonLost/Transform")]
public class EntityMovementInterpolationSpeedAction : ActionTaskBase
{
	[Name("是否开启插值运动", 0)]
	public bool IsOpenInterpolationMovement;

	[Name("运动锐度", 0)]
	[ShowIf("IsOpenInterpolationMovement", 1)]
	public float MoveSharpness = 15f;

	[Name("旋转锐度", 0)]
	[ShowIf("IsOpenInterpolationMovement", 1)]
	public float RotationSharpness = 0.033f;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (IsOpenInterpolationMovement)
		{
			ownerEntity.GetComponent<EntityViewComponent>().ChangeEntityMovementInterpolationSpeed(MoveSharpness, RotationSharpness);
			ownerEntity.GetComponent<EntityViewComponent>().IsOpenInterpolationMovement(openInterpolation: true);
		}
		else
		{
			ownerEntity.GetComponent<EntityViewComponent>().IsOpenInterpolationMovement(openInterpolation: false);
		}
		EndAction();
	}
}
