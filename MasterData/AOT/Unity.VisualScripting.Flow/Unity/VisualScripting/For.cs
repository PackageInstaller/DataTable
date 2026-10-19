using System;
using System.Collections;

namespace Unity.VisualScripting;

[UnitOrder(9)]
[UnitTitle("For Loop")]
[UnitCategory("Control")]
public sealed class For : LoopUnit
{
	[DoNotSerialize]
	[PortLabel("First")]
	public ValueInput firstIndex { get; private set; }

	[DoNotSerialize]
	[PortLabel("Last")]
	public ValueInput lastIndex { get; private set; }

	[DoNotSerialize]
	public ValueInput step { get; private set; }

	[PortLabel("Index")]
	[DoNotSerialize]
	public ValueOutput currentIndex { get; private set; }

	protected override void Definition()
	{
		firstIndex = ValueInput("firstIndex", 0);
		lastIndex = ValueInput("lastIndex", 10);
		step = ValueInput("step", 1);
		currentIndex = ValueOutput<int>("currentIndex");
		base.Definition();
		Requirement(firstIndex, enter);
		Requirement(lastIndex, enter);
		Requirement(step, enter);
		Assignment(enter, currentIndex);
	}

	private int Start(Flow flow, out int currentIndex, out int lastIndex, out bool ascending)
	{
		int value = flow.GetValue<int>(firstIndex);
		lastIndex = flow.GetValue<int>(this.lastIndex);
		ascending = value <= lastIndex;
		currentIndex = value;
		flow.SetValue(this.currentIndex, currentIndex);
		return flow.EnterLoop();
	}

	private bool CanMoveNext(int currentIndex, int lastIndex, bool ascending)
	{
		if (ascending)
		{
			return currentIndex < lastIndex;
		}
		return currentIndex > lastIndex;
	}

	private void MoveNext(Flow flow, ref int currentIndex)
	{
		currentIndex += flow.GetValue<int>(step);
		flow.SetValue(this.currentIndex, currentIndex);
	}

	protected override ControlOutput Loop(Flow flow)
	{
		int loop = Start(flow, out var num, out var num2, out var ascending);
		if (!IsStepValueZero())
		{
			GraphStack stack = flow.PreserveStack();
			while (flow.LoopIsNotBroken(loop) && CanMoveNext(num, num2, ascending))
			{
				flow.Invoke(body);
				flow.RestoreStack(stack);
				MoveNext(flow, ref num);
			}
			flow.DisposePreservedStack(stack);
		}
		flow.ExitLoop(loop);
		return exit;
	}

	protected override IEnumerator LoopCoroutine(Flow flow)
	{
		int loop = Start(flow, out var currentIndex, out var lastIndex, out var ascending);
		GraphStack stack = flow.PreserveStack();
		while (flow.LoopIsNotBroken(loop) && CanMoveNext(currentIndex, lastIndex, ascending))
		{
			yield return body;
			flow.RestoreStack(stack);
			MoveNext(flow, ref currentIndex);
		}
		flow.DisposePreservedStack(stack);
		flow.ExitLoop(loop);
		yield return exit;
	}

	public bool IsStepValueZero()
	{
		bool num = !step.hasValidConnection && (int)defaultValues[step.key] == 0;
		bool flag = false;
		if (step.hasValidConnection && step.connection.source.unit is Literal literal && Convert.ToInt32(literal.value) == 0)
		{
			flag = true;
		}
		return num | flag;
	}
}
