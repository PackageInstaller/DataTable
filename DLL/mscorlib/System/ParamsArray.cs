namespace System;

internal readonly struct ParamsArray
{
	private static readonly object[] s_oneArgArray = new object[1];

	private static readonly object[] s_twoArgArray = new object[2];

	private static readonly object[] s_threeArgArray = new object[3];

	private readonly object _arg0;

	private readonly object _arg1;

	private readonly object _arg2;

	private readonly object[] _args;

	public int Length => _args.Length;

	public object this[int index]
	{
		get
		{
			if (index != 0)
			{
				return GetAtSlow(index);
			}
			return _arg0;
		}
	}

	public ParamsArray(object arg0)
	{
		_arg0 = arg0;
		_arg1 = null;
		_arg2 = null;
		_args = s_oneArgArray;
	}

	public ParamsArray(object arg0, object arg1)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = null;
		_args = s_twoArgArray;
	}

	public ParamsArray(object arg0, object arg1, object arg2)
	{
		_arg0 = arg0;
		_arg1 = arg1;
		_arg2 = arg2;
		_args = s_threeArgArray;
	}

	public ParamsArray(object[] args)
	{
		int num = args.Length;
		_arg0 = ((num > 0) ? args[0] : null);
		_arg1 = ((num > 1) ? args[1] : null);
		_arg2 = ((num > 2) ? args[2] : null);
		_args = args;
	}

	private object GetAtSlow(int index)
	{
		return index switch
		{
			1 => _arg1, 
			2 => _arg2, 
			_ => _args[index], 
		};
	}
}
