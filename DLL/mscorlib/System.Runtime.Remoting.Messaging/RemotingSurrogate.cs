using System.Runtime.Serialization;

namespace System.Runtime.Remoting.Messaging;

internal class RemotingSurrogate : ISerializationSurrogate
{
	public virtual void GetObjectData(object obj, SerializationInfo si, StreamingContext sc)
	{
		if (obj == null || si == null)
		{
			throw new ArgumentNullException();
		}
		if (RemotingServices.IsTransparentProxy(obj))
		{
			RemotingServices.GetRealProxy(obj).GetObjectData(si, sc);
		}
		else
		{
			RemotingServices.GetObjectData(obj, si, sc);
		}
	}

	public virtual object SetObjectData(object obj, SerializationInfo si, StreamingContext sc, ISurrogateSelector selector)
	{
		throw new NotSupportedException();
	}
}
