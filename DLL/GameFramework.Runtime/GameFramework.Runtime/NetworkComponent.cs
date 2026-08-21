#define ENABLE_FATAL_AND_ABOVE_LOG
using System.Net.Sockets;
using GameFramework.Network;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
public sealed class NetworkComponent : GameFrameworkComponent
{
	private INetworkManager m_NetworkManager = null;

	[SerializeField]
	private bool isBigEndian;

	[SerializeField]
	private AddressFamily family = AddressFamily.InterNetwork;

	private INetworkChannel mainChannel = null;

	public int NetworkChannelCount => m_NetworkManager.NetworkChannelCount;

	public bool IsBigEndian => isBigEndian;

	protected override void Awake()
	{
		base.Awake();
		m_NetworkManager = GameFrameworkEntry.GetModule<INetworkManager>();
		if (m_NetworkManager == null)
		{
			Log.Fatal("Network manager is invalid.");
			return;
		}
		m_NetworkManager.IsBigEndian = isBigEndian;
		m_NetworkManager.Family = family;
	}

	public INetworkChannel[] GetAllNetworkChannels()
	{
		return m_NetworkManager.GetAllNetworkChannels();
	}

	public bool HasNetworkChannel(string name)
	{
		return m_NetworkManager.HasNetworkChannel(name);
	}

	public INetworkChannel GetNetworkChannel(string name)
	{
		return m_NetworkManager.GetNetworkChannel(name);
	}

	public INetworkChannel CreateNetworkChannel(string name, ServiceType serviceType, INetworkChannelHelper networkChannelHelper)
	{
		return m_NetworkManager.CreateNetworkChannel(name, serviceType, networkChannelHelper);
	}

	public bool DestroyNetworkChannel(string name)
	{
		return m_NetworkManager.DestroyNetworkChannel(name);
	}
}
