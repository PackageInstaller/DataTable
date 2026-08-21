using System.Runtime.Serialization;

namespace System.Reflection;

[CLSCompliant(false)]
public sealed class Pointer : ISerializable
{
	private unsafe readonly void* _ptr;

	private readonly Type _ptrType;

	private unsafe Pointer(void* ptr, Type ptrType)
	{
		_ptr = ptr;
		_ptrType = ptrType;
	}

	public unsafe static object Box(void* ptr, Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (!type.IsPointer)
		{
			throw new ArgumentException("Type must be a Pointer.", "ptr");
		}
		if (!type.IsRuntimeImplemented())
		{
			throw new ArgumentException("Type must be a type provided by the runtime.", "ptr");
		}
		return new Pointer(ptr, type);
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		throw new PlatformNotSupportedException();
	}
}
