using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改身体碰撞盒半径(弃用)", 0)]
[Description("此操作已弃用，不再使用。")]
[Category("✫ DragonLost/Entity")]
public class ChangeBodyColliderRadiusAction : ActionTaskBase
{
	[Name("半径", 0)]
	[Description("要设置的碰撞盒的半径")]
	public float radius;

	protected override void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
	}
}
