using Ase;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

[Name("忽略碰撞闪现到目标位置", 0)]
[Description("立即将实体移动到指定的目标位置。忽略地形和怪物碰撞")]
[Category("✫ DragonLost/Transform")]
public class IgnoreColliderHasteMovePositionAction : ActionTaskBase
{
	[Name("目标位置", 0)]
	[Description("要移动到的目标位置。")]
	public BBParameter<Vector3> targetBBP;

	private int waitFrameCount;

	protected override void OnExecute()
	{
		base.OnExecute();
		Vector3 value = targetBBP.value;
		ownerEntity.GetComponent<KinematicMoveComponent>().Teleport(value);
		OnActionFinish();
		waitFrameCount = 0;
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
		if (waitFrameCount++ == 1)
		{
			OnActionFinish();
		}
	}
}
