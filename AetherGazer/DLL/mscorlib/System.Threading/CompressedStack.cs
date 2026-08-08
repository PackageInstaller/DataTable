using System.Runtime.Serialization;
using Unity;

namespace System.Threading;

[Serializable]
public sealed class CompressedStack : ISerializable
{
	[MonoTODO("incomplete")]
	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
	}

	internal CompressedStack()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
