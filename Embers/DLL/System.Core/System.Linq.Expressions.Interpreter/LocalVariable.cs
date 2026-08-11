using System.Globalization;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LocalVariable
{
	public readonly int Index;

	private int _flags;

	public bool IsBoxed
	{
		get
		{
			return (_flags & 1) != 0;
		}
		set
		{
			if (value)
			{
				_flags |= 1;
			}
			else
			{
				_flags &= -2;
			}
		}
	}

	public bool InClosure => (_flags & 2) != 0;

	internal LocalVariable(int index, bool closure)
	{
		Index = index;
		_flags = (closure ? 2 : 0);
	}

	public override string ToString()
	{
		return string.Format(CultureInfo.InvariantCulture, "{0}: {1} {2}", Index, IsBoxed ? "boxed" : null, InClosure ? "in closure" : null);
	}
}
