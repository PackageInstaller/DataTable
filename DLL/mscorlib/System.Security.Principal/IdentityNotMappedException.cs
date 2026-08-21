using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Security.Principal;

[Serializable]
[ComVisible(false)]
public sealed class IdentityNotMappedException : SystemException
{
	public IdentityNotMappedException()
		: base(Locale.GetText("Couldn't translate some identities."))
	{
	}

	public IdentityNotMappedException(string message)
		: base(message)
	{
	}

	[MonoTODO("not implemented")]
	public override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
	}
}
