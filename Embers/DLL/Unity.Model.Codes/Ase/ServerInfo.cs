using System;

namespace Ase;

[Serializable]
public class ServerInfo
{
	public string ip;

	public int port;

	public string name;

	public int httpport;

	public bool active;

	public bool Equals(ServerInfo serverInfo)
	{
		if (serverInfo != null && serverInfo.ip == ip && serverInfo.port == port && serverInfo.name == name && serverInfo.httpport == httpport)
		{
			return serverInfo.active == active;
		}
		return false;
	}
}
