using System.Runtime.InteropServices;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public interface IChannelInfo
{
	object[] ChannelData { get; }
}
