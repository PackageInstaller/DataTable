using System.Threading.Tasks;

namespace GameFramework.Network;

public interface INetworkChannelHelper
{
	int PacketHeaderLength { get; }

	void Initialize(INetworkChannel networkChannel);

	Task Encode(IMessage message, BinaryWriter writer);

	Task<IMessage> Decode(BinaryReader reader);

	void Shutdown();
}
