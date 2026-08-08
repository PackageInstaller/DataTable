using System.Globalization;
using System.Runtime.Serialization;

namespace System.ComponentModel;

[Serializable]
public class InvalidEnumArgumentException : ArgumentException
{
	public InvalidEnumArgumentException()
		: this(null)
	{
	}

	public InvalidEnumArgumentException(string message)
		: base(message)
	{
	}

	public InvalidEnumArgumentException(string argumentName, int invalidValue, Type enumClass)
		: base(global::SR.Format("The value of argument '{0}' ({1}) is invalid for Enum type '{2}'.", argumentName, invalidValue.ToString(CultureInfo.CurrentCulture), enumClass.Name), argumentName)
	{
	}

	protected InvalidEnumArgumentException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
