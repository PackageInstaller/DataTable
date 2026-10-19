using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/Group")]
[TaskDescription("判断这个Entity是否为空,不为空返回True，为空返回False")]
public class CheckEntityIsNotNull : Action
{
	public SharedEntity outResultEntity;

	public bool inverser;

	public override void OnStart()
	{
	}

	public override void OnEnd()
	{
	}

	public override TaskStatus OnUpdate()
	{
		if (outResultEntity.Value != null)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
