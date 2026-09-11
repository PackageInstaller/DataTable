using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Channels;

[ComVisible(true)]
public interface IServerChannelSinkProvider
{
	IServerChannelSinkProvider Next { set; }
}
