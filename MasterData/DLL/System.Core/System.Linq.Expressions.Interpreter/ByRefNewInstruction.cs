using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal class ByRefNewInstruction : NewInstruction
{
	private readonly ByRefUpdater[] _byrefArgs;

	public override string InstructionName => "ByRefNew";

	internal ByRefNewInstruction(ConstructorInfo target, int argumentCount, ByRefUpdater[] byrefArgs)
		: base(target, argumentCount)
	{
		_byrefArgs = byrefArgs;
	}

	public sealed override int Run(InterpretedFrame frame)
	{
		int num = frame.StackIndex - _argumentCount;
		object[] args = GetArgs(frame, num);
		try
		{
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
		}
		finally
		{
			ByRefUpdater[] byrefArgs = _byrefArgs;
			foreach (ByRefUpdater byRefUpdater in byrefArgs)
			{
				byRefUpdater.Update(frame, args[byRefUpdater.ArgumentIndex]);
			}
		}
		return 1;
	}
}
