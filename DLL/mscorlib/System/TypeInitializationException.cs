using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class TypeInitializationException : SystemException
{
	private string _typeName;

	public string TypeName
	{
		get
		{
			if (_typeName == null)
			{
				return string.Empty;
			}
			return _typeName;
		}
	}

	private TypeInitializationException()
		: base("Type constructor threw an exception.")
	{
		base.HResult = -2146233036;
	}

	public TypeInitializationException(string fullTypeName, Exception innerException)
		: this(fullTypeName, SR.Format("The type initializer for '{0}' threw an exception.", fullTypeName), innerException)
	{
	}

	internal TypeInitializationException(string fullTypeName, string message, Exception innerException)
		: base(message, innerException)
	{
		_typeName = fullTypeName;
		base.HResult = -2146233036;
	}

	internal TypeInitializationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_typeName = info.GetString("TypeName");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("TypeName", TypeName, typeof(string));
	}
}
