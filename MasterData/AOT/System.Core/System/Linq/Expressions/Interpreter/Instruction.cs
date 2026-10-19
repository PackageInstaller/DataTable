using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal abstract class Instruction
{
	public virtual int ConsumedStack => 0;

	public virtual int ProducedStack => 0;

	public virtual int ConsumedContinuations => 0;

	public virtual int ProducedContinuations => 0;

	public int StackBalance => ProducedStack - ConsumedStack;

	public int ContinuationsBalance => ProducedContinuations - ConsumedContinuations;

	public abstract string InstructionName { get; }

	public abstract int Run(InterpretedFrame frame);

	public override string ToString()
	{
		return InstructionName + "()";
	}

	public virtual string ToDebugString(int instructionIndex, object cookie, Func<int, int> labelIndexer, IReadOnlyList<object> objects)
	{
		return ToString();
	}

	protected static void NullCheck(object o)
	{
		if (o == null)
		{
			o.GetType();
		}
	}
}
