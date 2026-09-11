using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ObjectDisposedException : InvalidOperationException
{
	private string _objectName;

	public override string Message
	{
		get
		{
			string objectName = ObjectName;
			if (objectName == null || objectName.Length == 0)
			{
				return base.Message;
			}
			string text = SR.Format("Object name: '{0}'.", objectName);
			return base.Message + Environment.NewLine + text;
		}
	}

	public string ObjectName
	{
		get
		{
			if (_objectName == null)
			{
				return string.Empty;
			}
			return _objectName;
		}
	}

	private ObjectDisposedException()
		: this(null, "Cannot access a disposed object.")
	{
	}

	public ObjectDisposedException(string objectName)
		: this(objectName, "Cannot access a disposed object.")
	{
	}

	public ObjectDisposedException(string objectName, string message)
		: base(message)
	{
		base.HResult = -2146232798;
		_objectName = objectName;
	}

	protected ObjectDisposedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_objectName = info.GetString("ObjectName");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("ObjectName", ObjectName, typeof(string));
	}
}
