using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Runtime.Remoting.Messaging;

[ComVisible(true)]
public class RemotingSurrogateSelector : ISurrogateSelector
{
	private static Type s_cachedTypeObjRef = typeof(ObjRef);

	private static ObjRefSurrogate _objRefSurrogate = new ObjRefSurrogate();

	private static RemotingSurrogate _objRemotingSurrogate = new RemotingSurrogate();

	private ISurrogateSelector _next;

	public virtual ISerializationSurrogate GetSurrogate(Type type, StreamingContext context, out ISurrogateSelector ssout)
	{
		if (type.IsMarshalByRef)
		{
			ssout = this;
			return _objRemotingSurrogate;
		}
		if (s_cachedTypeObjRef.IsAssignableFrom(type))
		{
			ssout = this;
			return _objRefSurrogate;
		}
		if (_next != null)
		{
			return _next.GetSurrogate(type, context, out ssout);
		}
		ssout = null;
		return null;
	}
}
