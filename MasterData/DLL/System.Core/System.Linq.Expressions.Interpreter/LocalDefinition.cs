namespace System.Linq.Expressions.Interpreter;

internal readonly struct LocalDefinition
{
	public int Index { get; }

	public ParameterExpression Parameter { get; }

	internal LocalDefinition(int localIndex, ParameterExpression parameter)
	{
		Index = localIndex;
		Parameter = parameter;
	}

	public override bool Equals(object obj)
	{
		if (obj is LocalDefinition localDefinition)
		{
			if (localDefinition.Index == Index)
			{
				return localDefinition.Parameter == Parameter;
			}
			return false;
		}
		return false;
	}

	public override int GetHashCode()
	{
		if (Parameter == null)
		{
			return 0;
		}
		return Parameter.GetHashCode() ^ Index.GetHashCode();
	}
}
