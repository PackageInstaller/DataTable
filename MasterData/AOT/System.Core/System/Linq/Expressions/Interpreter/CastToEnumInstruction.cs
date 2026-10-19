namespace System.Linq.Expressions.Interpreter;

internal sealed class CastToEnumInstruction : CastInstruction
{
	private readonly Type _t;

	public CastToEnumInstruction(Type t)
	{
		_t = t;
	}

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		frame.Push((obj == null) ? null : Enum.ToObject(_t, obj));
		return 1;
	}
}
