using System.Threading.Tasks;
using GameFramework.Network;

namespace Ase;

public class DefaultChannelHelper : INetworkChannelHelper
{
	private INetworkChannel m_NetworkChannel;

	private MemoryPackDecoder decoder = new MemoryPackDecoder();

	private MemoryPackEncoder encoder = new MemoryPackEncoder();

	public int PacketHeaderLength => 4;

	public void Initialize(INetworkChannel networkChannel)
	{
		m_NetworkChannel = networkChannel;
	}

	public async Task Encode(IMessage message, BinaryWriter writer)
	{
		await encoder.Encode(message, writer);
	}

	public async Task<IMessage> Decode(BinaryReader reader)
	{
		return await decoder.Decode(reader);
	}

	public void Shutdown()
	{
		m_NetworkChannel = null;
		decoder = null;
		encoder = null;
	}
}
