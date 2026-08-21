using System.Collections.Generic;

public class RegionServerInfo
{
	public string serverId;

	public string serverName;

	public string env;

	public string ip;

	public int port;

	public int newServerFlag;

	public bool maintain;

	public string maintainReason;

	public Dictionary<string, string> configS;

	public List<RegionServerUserInfo> gameUserInfoList;
}
