using System;

namespace GameFramework.Runtime;

public class GenericConverter<TFrom, TTo> : AbstractConverter<TFrom, TTo>
{
	private Func<TFrom, TTo> handler;

	private Func<TTo, TFrom> backHandler;

	public GenericConverter(Func<TFrom, TTo> handler, Func<TTo, TFrom> backHandler)
	{
		this.handler = handler;
		this.backHandler = backHandler;
	}

	public override TTo Convert(TFrom value)
	{
		if (handler != null)
		{
			return handler(value);
		}
		return default(TTo);
	}

	public override TFrom ConvertBack(TTo value)
	{
		if (backHandler != null)
		{
			return backHandler(value);
		}
		return default(TFrom);
	}
}
