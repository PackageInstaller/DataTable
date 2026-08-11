using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal class MethodInfoCallInstruction : CallInstruction
{
	protected readonly MethodInfo _target;

	protected readonly int _argumentCount;

	public override int ArgumentCount => _argumentCount;

	public override int ProducedStack
	{
		get
		{
			if (!(_target.ReturnType == typeof(void)))
			{
				return 1;
			}
			return 0;
		}
	}

	internal MethodInfoCallInstruction(MethodInfo target, int argumentCount)
	{
		_target = target;
		_argumentCount = argumentCount;
	}

	public override int Run(InterpretedFrame frame)
	{
		int num = frame.StackIndex - _argumentCount;
		object obj;
		if (_target.IsStatic)
		{
			object[] args = GetArgs(frame, num, 0);
			try
			{
				obj = _target.Invoke(null, args);
			}
			catch (TargetInvocationException exception)
			{
				ExceptionHelpers.UnwrapAndRethrow(exception);
				throw ContractUtils.Unreachable;
			}
		}
		else
		{
			object obj2 = frame.Data[num];
			Instruction.NullCheck(obj2);
			object[] args2 = GetArgs(frame, num, 1);
			if (CallInstruction.TryGetLightLambdaTarget(obj2, out var lightLambda))
			{
				obj = InterpretLambdaInvoke(lightLambda, args2);
			}
			else
			{
				try
				{
					obj = _target.Invoke(obj2, args2);
				}
				catch (TargetInvocationException exception2)
				{
					ExceptionHelpers.UnwrapAndRethrow(exception2);
					throw ContractUtils.Unreachable;
				}
			}
		}
		if (_target.ReturnType != typeof(void))
		{
			frame.Data[num] = obj;
			frame.StackIndex = num + 1;
		}
		else
		{
			frame.StackIndex = num;
		}
		return 1;
	}

	protected object[] GetArgs(InterpretedFrame frame, int first, int skip)
	{
		int num = _argumentCount - skip;
		if (num > 0)
		{
			object[] array = new object[num];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = frame.Data[first + i + skip];
			}
			return array;
		}
		return Array.Empty<object>();
	}

	public override string ToString()
	{
		return "Call(" + _target?.ToString() + ")";
	}
}
