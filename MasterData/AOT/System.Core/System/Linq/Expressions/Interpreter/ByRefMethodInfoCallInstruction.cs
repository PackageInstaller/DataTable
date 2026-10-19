using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal class ByRefMethodInfoCallInstruction : MethodInfoCallInstruction
{
	private readonly ByRefUpdater[] _byrefArgs;

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

	internal ByRefMethodInfoCallInstruction(MethodInfo target, int argumentCount, ByRefUpdater[] byrefArgs)
		: base(target, argumentCount)
	{
		_byrefArgs = byrefArgs;
	}

	public sealed override int Run(InterpretedFrame frame)
	{
		int num = frame.StackIndex - _argumentCount;
		object[] array = null;
		object obj = null;
		try
		{
			object obj2;
			if (_target.IsStatic)
			{
				array = GetArgs(frame, num, 0);
				try
				{
					obj2 = _target.Invoke(null, array);
				}
				catch (TargetInvocationException exception)
				{
					ExceptionHelpers.UnwrapAndRethrow(exception);
					throw ContractUtils.Unreachable;
				}
			}
			else
			{
				obj = frame.Data[num];
				Instruction.NullCheck(obj);
				array = GetArgs(frame, num, 1);
				if (CallInstruction.TryGetLightLambdaTarget(obj, out var lightLambda))
				{
					obj2 = InterpretLambdaInvoke(lightLambda, array);
				}
				else
				{
					try
					{
						obj2 = _target.Invoke(obj, array);
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
				frame.Data[num] = obj2;
				frame.StackIndex = num + 1;
			}
			else
			{
				frame.StackIndex = num;
			}
		}
		finally
		{
			if (array != null)
			{
				ByRefUpdater[] byrefArgs = _byrefArgs;
				foreach (ByRefUpdater byRefUpdater in byrefArgs)
				{
					byRefUpdater.Update(frame, (byRefUpdater.ArgumentIndex == -1) ? obj : array[byRefUpdater.ArgumentIndex]);
				}
			}
		}
		return 1;
	}
}
