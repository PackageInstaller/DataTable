using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
public class RemoveAICommand : Action
{
	public SharedAICommandList aiCommandList;

	public override void OnStart()
	{
		if (aiCommandList.Value != null && aiCommandList.Value.Count != 0)
		{
			aiCommandList.Value.Dequeue()?.Release();
		}
	}
}
