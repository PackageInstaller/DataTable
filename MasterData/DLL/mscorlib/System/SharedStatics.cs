using System.Runtime.CompilerServices;
using System.Security.Util;
using System.Threading;

namespace System;

internal sealed class SharedStatics
{
	private static readonly SharedStatics _sharedStatics = new SharedStatics();

	private Tokenizer.StringMaker _maker;

	private SharedStatics()
	{
	}

	public static Tokenizer.StringMaker GetSharedStringMaker()
	{
		Tokenizer.StringMaker stringMaker = null;
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(_sharedStatics, ref lockTaken);
			if (_sharedStatics._maker != null)
			{
				stringMaker = _sharedStatics._maker;
				_sharedStatics._maker = null;
			}
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(_sharedStatics);
			}
		}
		if (stringMaker == null)
		{
			stringMaker = new Tokenizer.StringMaker();
		}
		return stringMaker;
	}

	public static void ReleaseSharedStringMaker(ref Tokenizer.StringMaker maker)
	{
		bool lockTaken = false;
		RuntimeHelpers.PrepareConstrainedRegions();
		try
		{
			Monitor.Enter(_sharedStatics, ref lockTaken);
			_sharedStatics._maker = maker;
			maker = null;
		}
		finally
		{
			if (lockTaken)
			{
				Monitor.Exit(_sharedStatics);
			}
		}
	}
}
