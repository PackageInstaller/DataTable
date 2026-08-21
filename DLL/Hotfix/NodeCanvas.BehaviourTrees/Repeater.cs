using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[Name("Repeat", 0)]
[Category("Decorators")]
[Description("Repeats the child either x times or until it returns the specified status, or forever.")]
[Icon("Repeat", false, "")]
public class Repeater : BTDecorator
{
	public enum RepeaterMode
	{
		RepeatTimes,
		RepeatUntil,
		RepeatForever
	}

	public enum RepeatUntilStatus
	{
		Failure,
		Success
	}

	public RepeaterMode repeaterMode;

	[ShowIf("repeaterMode", 0)]
	public BBParameter<int> repeatTimes = 1;

	[ShowIf("repeaterMode", 1)]
	public RepeatUntilStatus repeatUntilStatus = RepeatUntilStatus.Success;

	[Name("是否忽略时间缩放", 0)]
	public bool IgnoreTimeScale = true;

	private int currentIteration = 1;

	private float _tickTime = 0.033f;

	protected override Status OnExecute(Component agent, IBlackboard blackboard)
	{
		if (base.graph != null)
		{
			if (base.graph.FrozenFrameIsPauseTree)
			{
				if (!IgnoreTimeScale)
				{
					_tickTime -= base.graph.deltaTime;
				}
				else
				{
					_tickTime = 0f;
				}
			}
			else
			{
				_tickTime = 0f;
			}
		}
		else
		{
			_tickTime = 0f;
		}
		if (_tickTime <= 0f)
		{
			_tickTime = 0.033f;
			if (base.decoratedConnection == null)
			{
				return Status.Optional;
			}
			if (base.decoratedConnection.status != Status.Running)
			{
				base.decoratedConnection.Reset();
			}
			base.status = base.decoratedConnection.Execute(agent, blackboard);
			switch (base.status)
			{
			case Status.Resting:
				return Status.Running;
			case Status.Running:
				return Status.Running;
			default:
				switch (repeaterMode)
				{
				case RepeaterMode.RepeatTimes:
					if (currentIteration >= repeatTimes.value)
					{
						return base.status;
					}
					currentIteration++;
					break;
				case RepeaterMode.RepeatUntil:
					if (base.status == (Status)repeatUntilStatus)
					{
						return base.status;
					}
					break;
				}
				return Status.Running;
			}
		}
		return Status.Running;
	}

	protected override void OnReset()
	{
		currentIteration = 1;
		_tickTime = 0.033f;
	}
}
