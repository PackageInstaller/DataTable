using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Channels;

[ComVisible(true)]
public interface IChannelSender : IChannel
{
	IMessageSink CreateMessageSink(string url, object remoteChannelData, out string objectURI);
}
