using Ase.ECS;

[ClipName("修改运动开关")]
public class OpenMovementClip : TaskClip
{
	[VariableName("移动开关")]
	public bool moveEnable;

	[VariableName("旋转开关")]
	public bool rotateEnable;

	public override void OnRunTimeEnter(BaseEntity context, int fps, int currentFrameID)
	{
		base.OnRunTimeEnter(context, fps, currentFrameID);
		MoveComponent component = context.GetComponent<MoveComponent>();
		if (component != null)
		{
			component.ChangeMovementEnable(moveEnable, rotateEnable);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"行为树开关移动状态 ： {moveEnable} 旋转状态 ：{rotateEnable} ", context);
			}
		}
	}
}
