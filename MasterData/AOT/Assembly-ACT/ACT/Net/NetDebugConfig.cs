using System.Collections.Generic;

namespace ACT.Net;

public class NetDebugConfig : LuminSerializedScriptableObject
{
	public class SwitchInfo
	{
		public NetCommand key;

		public bool value;

		public SwitchInfo(NetCommand k, bool v)
		{
			key = k;
			value = v;
		}
	}

	public const string address = "netdebug";

	public static NetDebugConfig config;

	public bool log;

	public List<SwitchInfo> switches;

	public bool ContainsKey(NetCommand c)
	{
		foreach (SwitchInfo @switch in switches)
		{
			if (@switch.key == c)
			{
				return true;
			}
		}
		return false;
	}

	public bool NeedLog(NetCommand c)
	{
		if (!log)
		{
			return false;
		}
		foreach (SwitchInfo @switch in switches)
		{
			if (@switch.key == c)
			{
				return @switch.value;
			}
		}
		return false;
	}
}
