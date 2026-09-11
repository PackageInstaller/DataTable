using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Security;

[Serializable]
[ComVisible(true)]
public class SecurityException : SystemException
{
	private string permissionState;

	public SecurityException()
		: this(Locale.GetText("A security error has been detected."))
	{
	}

	public SecurityException(string message)
		: base(message)
	{
		base.HResult = -2146233078;
	}

	protected SecurityException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		base.HResult = -2146233078;
		SerializationInfoEnumerator enumerator = info.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (enumerator.Name == "PermissionState")
			{
				permissionState = (string)enumerator.Value;
				break;
			}
		}
	}

	public SecurityException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2146233078;
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		try
		{
			info.AddValue("PermissionState", permissionState);
		}
		catch (SecurityException)
		{
		}
	}

	public override string ToString()
	{
		return base.ToString();
	}
}
