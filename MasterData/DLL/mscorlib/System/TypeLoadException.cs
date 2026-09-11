using System.Globalization;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[ComVisible(true)]
public class TypeLoadException : SystemException, ISerializable
{
	private string ClassName;

	private string AssemblyName;

	private string MessageArg;

	internal int ResourceId;

	public override string Message
	{
		get
		{
			SetMessageField();
			return _message;
		}
	}

	public TypeLoadException()
		: base(Environment.GetResourceString("Failure has occurred while loading a type."))
	{
		SetErrorCode(-2146233054);
	}

	public TypeLoadException(string message)
		: base(message)
	{
		SetErrorCode(-2146233054);
	}

	private void SetMessageField()
	{
		if (_message != null)
		{
			return;
		}
		if (ClassName == null && ResourceId == 0)
		{
			_message = Environment.GetResourceString("Failure has occurred while loading a type.");
			return;
		}
		if (AssemblyName == null)
		{
			AssemblyName = Environment.GetResourceString("[Unknown]");
		}
		if (ClassName == null)
		{
			ClassName = Environment.GetResourceString("[Unknown]");
		}
		string text = null;
		text = "Could not load type '{0}' from assembly '{1}'.";
		_message = string.Format(CultureInfo.CurrentCulture, text, ClassName, AssemblyName, MessageArg);
	}

	private TypeLoadException(string className, string assemblyName)
		: this(className, assemblyName, null, 0)
	{
	}

	private TypeLoadException(string className, string assemblyName, string messageArg, int resourceId)
		: base(null)
	{
		SetErrorCode(-2146233054);
		ClassName = className;
		AssemblyName = assemblyName;
		MessageArg = messageArg;
		ResourceId = resourceId;
		SetMessageField();
	}

	protected TypeLoadException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		ClassName = info.GetString("TypeLoadClassName");
		AssemblyName = info.GetString("TypeLoadAssemblyName");
		MessageArg = info.GetString("TypeLoadMessageArg");
		ResourceId = info.GetInt32("TypeLoadResourceID");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		base.GetObjectData(info, context);
		info.AddValue("TypeLoadClassName", ClassName, typeof(string));
		info.AddValue("TypeLoadAssemblyName", AssemblyName, typeof(string));
		info.AddValue("TypeLoadMessageArg", MessageArg, typeof(string));
		info.AddValue("TypeLoadResourceID", ResourceId);
	}
}
