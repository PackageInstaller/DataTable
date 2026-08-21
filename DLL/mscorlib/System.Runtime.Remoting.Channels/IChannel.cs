using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Channels;

[ComVisible(true)]
public interface IChannel
{
	string ChannelName { get; }

	int ChannelPriority { get; }
}
