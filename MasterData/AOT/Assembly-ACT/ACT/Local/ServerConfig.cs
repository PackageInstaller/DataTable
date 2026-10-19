using System;

namespace ACT.Local;

[Serializable]
public struct ServerConfig
{
	public string name;

	public string loginUrl;

	[Obsolete("登录服已改用 loginUrl")]
	public string ip;

	[Obsolete("登录服已改用 loginUrl")]
	public int port;

	public bool isNewWorldGen;
}
