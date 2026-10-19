using System;

namespace Unity.VisualScripting.FullSerializer.Internal;

public struct fsOption<T>
{
	private bool _hasValue;

	private T _value;

	public static fsOption<T> Empty;

	public bool HasValue => _hasValue;

	public bool IsEmpty => !_hasValue;

	public T Value
	{
		get
		{
			if (IsEmpty)
			{
				throw new InvalidOperationException("fsOption is empty");
			}
			return _value;
		}
	}

	public fsOption(T value)
	{
		_hasValue = true;
		_value = value;
	}
}
public static class fsOption
{
	public static fsOption<T> Just<T>(T value)
	{
		return new fsOption<T>(value);
	}
}
