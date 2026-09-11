using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Contexts;

[ComVisible(true)]
public interface IContributeObjectSink
{
	IMessageSink GetObjectSink(MarshalByRefObject obj, IMessageSink nextSink);
}
