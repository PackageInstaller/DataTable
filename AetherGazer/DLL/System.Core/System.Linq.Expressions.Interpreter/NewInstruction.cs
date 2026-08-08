using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal class NewInstruction : Instruction
{
	protected readonly ConstructorInfo _constructor;

	protected readonly int _argumentCount;

	public override int ConsumedStack => _argumentCount;

	public override int ProducedStack => 1;

	public override string InstructionName => "New";

	public NewInstruction(ConstructorInfo constructor, int argumentCount)
	{
		_constructor = constructor;
		_argumentCount = argumentCount;
	}

	public override int Run(InterpretedFrame frame)
	{
		int num = frame.StackIndex - _argumentCount;
		object[] args = GetArgs(frame, num);
		object obj;
		try
		{
			obj = _constructor.Invoke(args);
		}
		catch (TargetInvocationException exception)
		{
			ExceptionHelpers.UnwrapAndRethrow(exception);
			throw ContractUtils.Unreachable;
		}
		frame.Data[num] = obj;
		frame.StackIndex = num + 1;
		return 1;
	}

	protected object[] GetArgs(InterpretedFrame frame, int first)
	{
		if (_argumentCount > 0)
		{
			object[] array = new object[_argumentCount];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = frame.Data[first + i];
			}
			return array;
		}
		return Array.Empty<object>();
	}

	public override string ToString()
	{
		return "New " + _constructor.DeclaringType.Name + "(" + _constructor?.ToString() + ")";
	}
}
