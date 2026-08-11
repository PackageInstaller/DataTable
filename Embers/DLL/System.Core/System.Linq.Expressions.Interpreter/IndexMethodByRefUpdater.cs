using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal sealed class IndexMethodByRefUpdater : ByRefUpdater
{
	private readonly MethodInfo _indexer;

	private readonly LocalDefinition? _obj;

	private readonly LocalDefinition[] _args;

	public IndexMethodByRefUpdater(LocalDefinition? obj, LocalDefinition[] args, MethodInfo indexer, int argumentIndex)
		: base(argumentIndex)
	{
		_obj = obj;
		_args = args;
		_indexer = indexer;
	}

	public override void Update(InterpretedFrame frame, object value)
	{
		object[] array = new object[_args.Length + 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array[i] = frame.Data[_args[i].Index];
		}
		array[array.Length - 1] = value;
		object obj = ((!_obj.HasValue) ? null : frame.Data[_obj.GetValueOrDefault().Index]);
		try
		{
			_indexer.Invoke(obj, array);
		}
		catch (TargetInvocationException exception)
		{
			ExceptionHelpers.UnwrapAndRethrow(exception);
			throw ContractUtils.Unreachable;
		}
	}

	public override void UndefineTemps(InstructionList instructions, LocalVariables locals)
	{
		if (_obj.HasValue)
		{
			locals.UndefineLocal(_obj.GetValueOrDefault(), instructions.Count);
		}
		for (int i = 0; i < _args.Length; i++)
		{
			locals.UndefineLocal(_args[i], instructions.Count);
		}
	}
}
