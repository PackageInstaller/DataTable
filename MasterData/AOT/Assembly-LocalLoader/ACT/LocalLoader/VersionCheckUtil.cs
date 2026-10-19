using UnityEngine;

namespace ACT.LocalLoader;

public static class VersionCheckUtil
{
	public static VersionCheckOption CheckVersionWithUpdateConfig(MonoBehaviour mono)
	{
		VersionCheckOption versionCheckOption = new VersionCheckOption();
		versionCheckOption.Check(mono);
		return versionCheckOption;
	}

	public static VersionCheckOption CheckVersion()
	{
		VersionCheckOption versionCheckOption = new VersionCheckOption();
		versionCheckOption.CheckWithoutRefresh();
		return versionCheckOption;
	}
}
