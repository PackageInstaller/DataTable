using System.Runtime.Serialization;

namespace System.Runtime.Remoting.Messaging;

internal class ObjRefSurrogate : ISerializationSurrogate
{
	public virtual void GetObjectData(object obj, SerializationInfo si, StreamingContext sc)
	{
		if (obj == null || si == null)
		{
			throw new ArgumentNullException();
		}
		((ObjRef)obj).GetObjectData(si, sc);
		si.AddValue("fIsMarshalled", 0);
	}

	public virtual object SetObjectData(object obj, SerializationInfo si, StreamingContext sc, ISurrogateSelector selector)
	{
		throw new NotSupportedException("Do not use RemotingSurrogateSelector when deserializating");
	}
}
