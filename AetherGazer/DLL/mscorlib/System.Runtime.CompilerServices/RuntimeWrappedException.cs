using System.Runtime.Serialization;
using Unity;

namespace System.Runtime.CompilerServices;

[Serializable]
public sealed class RuntimeWrappedException : Exception
{
	private object _wrappedException;

	public object WrappedException => _wrappedException;

	public RuntimeWrappedException(object thrownObject)
		: base("An object that does not derive from System.Exception has been wrapped in a RuntimeWrappedException.")
	{
		base.HResult = -2146233026;
		_wrappedException = thrownObject;
	}

	private RuntimeWrappedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_wrappedException = info.GetValue("WrappedException", typeof(object));
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("WrappedException", _wrappedException, typeof(object));
	}

	internal RuntimeWrappedException()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
