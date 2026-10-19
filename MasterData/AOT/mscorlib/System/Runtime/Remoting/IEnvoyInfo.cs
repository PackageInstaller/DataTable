using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public interface IEnvoyInfo
{
	IMessageSink EnvoySinks { get; }
}
