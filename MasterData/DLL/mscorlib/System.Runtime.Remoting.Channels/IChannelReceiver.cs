using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Channels;

[ComVisible(true)]
public interface IChannelReceiver : IChannel
{
	object ChannelData { get; }

	void StartListening(object data);
}
