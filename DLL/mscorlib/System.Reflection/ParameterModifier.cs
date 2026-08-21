namespace System.Reflection;

public readonly struct ParameterModifier
{
	private readonly bool[] _byRef;

	public bool this[int index]
	{
		get
		{
			return _byRef[index];
		}
		set
		{
			_byRef[index] = value;
		}
	}

	public ParameterModifier(int parameterCount)
	{
		if (parameterCount <= 0)
		{
			throw new ArgumentException("Must specify one or more parameters.");
		}
		_byRef = new bool[parameterCount];
	}
}
