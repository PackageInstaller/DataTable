using System.Diagnostics.CodeAnalysis;

namespace System.Linq.Expressions.Interpreter;

internal sealed class EnterExceptionHandlerInstruction : Instruction
{
	internal static readonly EnterExceptionHandlerInstruction Void = new EnterExceptionHandlerInstruction(hasValue: false);

	internal static readonly EnterExceptionHandlerInstruction NonVoid = new EnterExceptionHandlerInstruction(hasValue: true);

	private readonly bool _hasValue;

	public override string InstructionName => "EnterExceptionHandler";

	public override int ConsumedStack
	{
		get
		{
			if (!_hasValue)
			{
				return 0;
			}
			return 1;
		}
	}

	public override int ProducedStack => 1;

	private EnterExceptionHandlerInstruction(bool hasValue)
	{
		_hasValue = hasValue;
	}

	[ExcludeFromCodeCoverage]
	public override int Run(InterpretedFrame frame)
	{
		return 1;
	}
}
