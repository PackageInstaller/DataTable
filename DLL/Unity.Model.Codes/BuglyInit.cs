using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class BuglyInit : MonoBehaviour
{
	private const string BuglyAppID = "b550e9bebd";

	private const string BuglyAppKey = "a9ecbb72-5f7f-473a-8e38-e4e77d439450";

	private static string[] PluginArray = new string[6] { "looper_metric", "looper_stack", "launch_metric", "memory_quantile", "activity_leak", "big_bitmap" };

	private void Awake()
	{
		BuglyAgent.ConfigPluginArray(PluginArray);
		BuglyAgent.ConfigDefault(null, null, null, null, null);
		BuglyAgent.ConfigAutoReportLogLevel(LogSeverity.LogError);
		BuglyAgent.ConfigAutoQuitApplication(autoQuit: false);
		BuglyAgent.RegisterLogCallback(null);
		BuglyAgent.InitWithAppId("b550e9bebd", "a9ecbb72-5f7f-473a-8e38-e4e77d439450");
		BuglyAgent.EnableExceptionHandler();
		BuglyAgent.SetLogCallbackExtrasHandler(MyLogCallbackExtrasHandler);
		string path = "myFile.txt";
		string value = "Hello, world!";
		string text = Path.Combine(Application.persistentDataPath, path);
		using (StreamWriter streamWriter = new StreamWriter(new FileStream(text, FileMode.Create)))
		{
			streamWriter.Write(value);
		}
		BuglyAgent.SetCrashAttachmentPaths(new string[1] { text });
		BuglyAgent.SetDeviceId("test_deviceID");
		BuglyAgent.SetUserId("test_userID");
		BuglyAgent.ReportException("TestName", "TestMsg", "TestTrace");
		Object.Destroy(this);
	}

	private static Dictionary<string, string> MyLogCallbackExtrasHandler()
	{
		BuglyAgent.PrintLog(LogSeverity.Log, "extra handler");
		Dictionary<string, string> result = new Dictionary<string, string>
		{
			{
				"ScreenSolution",
				$"{Screen.width}x{Screen.height}"
			},
			{
				"deviceModel",
				SystemInfo.deviceModel
			},
			{
				"deviceName",
				SystemInfo.deviceName
			},
			{
				"deviceType",
				SystemInfo.deviceType.ToString()
			},
			{
				"deviceUId",
				SystemInfo.deviceUniqueIdentifier
			},
			{
				"gDId",
				$"{SystemInfo.graphicsDeviceID}"
			},
			{
				"gDName",
				SystemInfo.graphicsDeviceName
			},
			{
				"gDVdr",
				SystemInfo.graphicsDeviceVendor
			},
			{
				"gDVer",
				SystemInfo.graphicsDeviceVersion
			},
			{
				"gDVdrID",
				$"{SystemInfo.graphicsDeviceVendorID}"
			},
			{
				"graphicsMemorySize",
				$"{SystemInfo.graphicsMemorySize}"
			},
			{
				"systemMemorySize",
				$"{SystemInfo.systemMemorySize}"
			},
			{
				"UnityVersion",
				Application.unityVersion
			}
		};
		BuglyAgent.PrintLog(LogSeverity.LogInfo, "Package extra data");
		return result;
	}
}
