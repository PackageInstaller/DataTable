using System.Runtime.Serialization;

namespace System;

[Serializable]
public class NotFiniteNumberException : ArithmeticException
{
	private double _offendingNumber;

	public NotFiniteNumberException()
		: base("Arg_NotFiniteNumberException = Number encountered was not a finite quantity.")
	{
		_offendingNumber = 0.0;
		base.HResult = -2146233048;
	}

	protected NotFiniteNumberException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_offendingNumber = info.GetInt32("OffendingNumber");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("OffendingNumber", _offendingNumber, typeof(int));
	}
}
