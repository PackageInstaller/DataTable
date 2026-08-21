#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public static class ActivityVersionConfig
{
	public static bool IsActivityVersionWindow(string windowName)
	{
		if (!"ActivityVersion1Window".Equals(windowName) && !"ActivityVersion2Window".Equals(windowName) && !"ActivityVersion3Window".Equals(windowName))
		{
			return "ActivityVersion4Window".Equals(windowName);
		}
		return true;
	}

	public static string GetConfigWindowPath(int activityTypeId)
	{
		switch (activityTypeId)
		{
		case 10:
			return "OperatingActivity/Version1/ActivityVersion1Window";
		case 19:
			return "OperatingActivity/Version2/ActivityVersion2Window";
		case 1301:
			return "OperatingActivity/Version3/ActivityVersion3Window";
		case 1302:
			return "OperatingActivity/Version1/ActivityVersion1Window";
		case 1327:
			return "OperatingActivity/Version2/ActivityVersion2Window";
		case 1550:
			return "OperatingActivity/Version4/ActivityVersion4Window";
		default:
			Log.Error($"{activityTypeId} 找不到对应的版本活动配置");
			return null;
		}
	}

	public static string GetConfigRewardPath(int activityTypeId)
	{
		switch (activityTypeId)
		{
		case 10:
			return "OperatingActivity/Version1/ActivityVersionRewardWindow";
		case 19:
			return "OperatingActivity/Version2/ActivityVersion2RewardWindow";
		case 1301:
			return "OperatingActivity/Version3/ActivityVersion3RewardWindow";
		case 1302:
			return "OperatingActivity/Version1/ActivityVersionRewardWindow";
		case 1327:
			return "OperatingActivity/Version2/ActivityVersion2RewardWindow";
		case 1550:
			return "OperatingActivity/Version4/ActivityVersion4RewardWindow";
		default:
			Log.Error($"{activityTypeId} 找不到对应的版本活动配置");
			return null;
		}
	}

	public static string GetConfigActivityPointsPath(int activityTypeId)
	{
		switch (activityTypeId)
		{
		case 10:
			return "OperatingActivity/Common/ActivityPointsWindow1";
		case 19:
			return "OperatingActivity/Version2/ActivityPointsWindow2";
		case 1301:
			return "OperatingActivity/Version3/ActivityPointsWindow3";
		case 1302:
			return "OperatingActivity/Common/ActivityPointsWindow1";
		case 1327:
			return "OperatingActivity/Version2/ActivityPointsWindow2";
		case 1550:
			return "OperatingActivity/Version4/ActivityPointsWindow4";
		default:
			Log.Error($"{activityTypeId} 找不到对应的版本活动配置");
			return null;
		}
	}
}
