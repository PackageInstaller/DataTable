using System.Runtime.Serialization;

namespace System.Security.AccessControl;

[Serializable]
public sealed class PrivilegeNotHeldException : UnauthorizedAccessException, ISerializable
{
	private readonly string _privilegeName;

	public PrivilegeNotHeldException()
		: base("The process does not possess some privilege required for this operation.")
	{
	}

	private PrivilegeNotHeldException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_privilegeName = info.GetString("PrivilegeName");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("PrivilegeName", _privilegeName, typeof(string));
	}
}
