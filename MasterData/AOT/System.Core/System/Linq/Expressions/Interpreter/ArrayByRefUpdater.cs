namespace System.Linq.Expressions.Interpreter;

internal sealed class ArrayByRefUpdater : ByRefUpdater
{
	private readonly LocalDefinition _array;

	private readonly LocalDefinition _index;

	public ArrayByRefUpdater(LocalDefinition array, LocalDefinition index, int argumentIndex)
		: base(argumentIndex)
	{
		_array = array;
		_index = index;
	}

	public override void Update(InterpretedFrame frame, object value)
	{
		object obj = frame.Data[_index.Index];
		((Array)frame.Data[_array.Index]).SetValue(value, (int)obj);
	}

	public override void UndefineTemps(InstructionList instructions, LocalVariables locals)
	{
		locals.UndefineLocal(_array, instructions.Count);
		locals.UndefineLocal(_index, instructions.Count);
	}
}
