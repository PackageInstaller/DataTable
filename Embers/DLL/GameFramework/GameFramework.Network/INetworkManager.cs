using System.Net.Sockets;

namespace GameFramework.Network;

public interface INetworkManager
{
	int NetworkChannelCount { get; }

	bool IsBigEndian { get; set; }

	AddressFamily Family { get; set; }

	bool HasNetworkChannel(string name);

	INetworkChannel GetNetworkChannel(string name);

	INetworkChannel[] GetAllNetworkChannels();

	INetworkChannel CreateNetworkChannel(string name, ServiceType serviceType, INetworkChannelHelper networkChannelHelper);

	bool DestroyNetworkChannel(string name);
}
