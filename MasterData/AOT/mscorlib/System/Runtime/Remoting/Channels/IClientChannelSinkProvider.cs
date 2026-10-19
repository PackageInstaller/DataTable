using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Channels;

[ComVisible(true)]
public interface IClientChannelSinkProvider
{
	IClientChannelSinkProvider Next { set; }
}
