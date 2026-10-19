using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT")]
public class OnAICommandEvent : Action
{
	public SharedAICommandList aiCommandList;

	public SharedAICommand AICommand;

	public override void OnAwake()
	{
		base.OnAwake();
		if (aiCommandList.Value == null)
		{
			aiCommandList.Value = new Queue<AICommandData>();
		}
	}

	public override void OnStart()
	{
		if (AICommand.Value != null)
		{
			if (aiCommandList.Value == null)
			{
				aiCommandList.Value = new Queue<AICommandData>();
			}
			aiCommandList.Value.Enqueue(AICommand.Value);
		}
	}
}
