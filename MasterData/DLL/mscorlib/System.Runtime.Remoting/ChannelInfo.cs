using System.Runtime.Remoting.Channels;

namespace System.Runtime.Remoting;

[Serializable]
internal class ChannelInfo : IChannelInfo
{
	private object[] channelData;

	public object[] ChannelData => channelData;

	public ChannelInfo()
	{
		channelData = ChannelServices.GetCurrentChannelInfo();
	}

	public ChannelInfo(object remoteChannelData)
	{
		channelData = new object[1] { remoteChannelData };
	}
}
