using System.Text;
using ACT.EventTrack;
using ACT.Local;
using UnityEngine.Device;
using UnityEngine.Networking;

namespace ACT.Utility;

public static class UrlUtility
{
	public const string DevFeedbackBaseUrl = "https://lvmeng-feedback.zhuziplay.com";

	private const string DevUserCenterBaseUrl = "https://lvmeng-center-dev.zhuziplay.com/account-info";

	private const string ReleaseUserCenterBaseUrl = "https://lvmeng-center.zhuziplay.com/account-info";

	public static string UserCenterBaseUrl => "https://lvmeng-center.zhuziplay.com/account-info";

	public static string FeedbackUrl { get; private set; }

	public static string UserCenterUrl { get; private set; }

	public static void SetUrls()
	{
		FeedbackUrl = BuildFeedbackUrl(LuminApplication.FeedbackUrl, BuildFeedbackPlainInfo(LuminApplication.RemoteConfig.ServerName, LuminApplication.AppClientVersion));
		UserCenterUrl = BuildUserCenterUrl(BuildFeedbackPlainInfo(LuminApplication.RemoteConfig.ServerName, LuminApplication.AppClientVersion));
	}

	public static string BuildEncryptedInfoUrl(string baseUrl, string plainInfo)
	{
		string text = UnityWebRequest.EscapeURL(LuminApplication.Encrypt(plainInfo ?? string.Empty), Encoding.UTF8);
		return (baseUrl ?? string.Empty).TrimEnd('/') + "/?info=" + text;
	}

	public static string BuildFeedbackUrl(string baseUrl, string plainInfo)
	{
		return BuildEncryptedInfoUrl(baseUrl, plainInfo);
	}

	public static string BuildUserCenterUrl(string plainInfo)
	{
		return BuildEncryptedInfoUrl(UserCenterBaseUrl, plainInfo);
	}

	private static string BuildFeedbackPlainInfo(string serverName, string clientVersion)
	{
		return $"aid={LoginUtility.SdkAid}&uid={LoginUtility.AccountId}&server_name={serverName}&client_version={clientVersion}&region={LuminApplication.AppRegion}&env={LuminApplication.AppEnv}&platform={LuminApplication.GetPlatformName}&vip=0&model={SystemInfo.deviceModel};Cpu={SystemInfo.processorType};Gpu={SystemInfo.graphicsDeviceName}&os={SystemInfo.operatingSystem}&token={EventTrackSolver.m_Token}&channel={LuminApplication.AppChannel}";
	}

	private static string BuildUserCenterPlainInfo(string serverName, string clientVersion)
	{
		return $"aid={LoginUtility.SdkAid}&uid={LoginUtility.AccountId}&server_name={serverName}&client_version={clientVersion}&region={LuminApplication.AppRegion}&env={LuminApplication.AppEnv}&platform={LuminApplication.GetPlatformName}&vip=0&model={SystemInfo.deviceModel};Cpu={SystemInfo.processorType};Gpu={SystemInfo.graphicsDeviceName}&os={SystemInfo.operatingSystem}&token={EventTrackSolver.m_Token}&channel={LuminApplication.AppChannel}";
	}
}
