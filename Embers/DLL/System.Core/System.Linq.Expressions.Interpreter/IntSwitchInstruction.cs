using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal sealed class IntSwitchInstruction<T> : Instruction
{
	private readonly Dictionary<T, int> _cases;

	public override string InstructionName => "IntSwitch";

	public override int ConsumedStack => 1;

	internal IntSwitchInstruction(Dictionary<T, int> cases)
	{
		_cases = cases;
	}

	public override int Run(InterpretedFrame frame)
	{
		if (!_cases.TryGetValue((T)frame.Pop(), out var value))
		{
			return 1;
		}
		return value;
	}
}
