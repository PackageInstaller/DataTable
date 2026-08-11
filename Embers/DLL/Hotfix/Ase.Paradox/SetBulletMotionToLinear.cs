using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改直线运动子弹参数", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于修改直线运动类子弹的参数，如速度和角度")]
public class SetBulletMotionToLinear : ActionTaskBase
{
	[Name("子弹实体Id", 0)]
	[Description("要修改参数的子弹实体的ID")]
	public BBParameter<int> bulletId;

	[Name("子弹实体Id数组", 0)]
	public BBParameter<List<int>> bulletIdList;

	[Name("是否为绝对角度", 0)]
	[Description("设置子弹运动角度是否为绝对角度")]
	public bool isAbsolutely;

	[Name("水平角度", 0)]
	[Description("设置子弹运动的水平角度")]
	public BBParameter<float> angle;

	[Name("速度", 0)]
	[Description("设置子弹的速度")]
	public BBParameter<float> velocity;

	protected override void OnExecute()
	{
		base.OnExecute();
		EntitySystem system = ownerEntity.GetSystem<EntitySystem>();
		if (bulletId.value != 0)
		{
			system.GetEntity(bulletId.value)?.GetComponent<BulletMoveComponent>().SetToLinearMove(velocity.value, angle.value, isAbsolutely);
		}
		if (bulletIdList != null && !bulletIdList.value.IsNullOrEmpty())
		{
			foreach (int item in bulletIdList.value)
			{
				system.GetEntity(item)?.GetComponent<BulletMoveComponent>().SetToLinearMove(velocity.value, angle.value, isAbsolutely);
			}
		}
		EndAction();
	}
}
