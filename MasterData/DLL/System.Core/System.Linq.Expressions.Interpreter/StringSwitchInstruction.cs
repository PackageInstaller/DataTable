using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class StringSwitchInstruction : Instruction
{
	private readonly Dictionary<string, int> _cases;

	private readonly StrongBox<int> _nullCase;

	public override string InstructionName => "StringSwitch";

	public override int ConsumedStack => 1;

	internal StringSwitchInstruction(Dictionary<string, int> cases, StrongBox<int> nullCase)
	{
		_cases = cases;
		_nullCase = nullCase;
	}

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		if (obj == null)
		{
			return _nullCase.Value;
		}
		if (!_cases.TryGetValue((string)obj, out var value))
		{
			return 1;
		}
		return value;
	}
}
