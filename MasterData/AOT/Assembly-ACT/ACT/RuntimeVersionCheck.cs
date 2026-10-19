using System;
using ACT.Error;
using ACT.LocalLoader;
using ACT.Net;
using UnityEngine;

namespace ACT;

public static class RuntimeVersionCheck
{
	public static void CheckVersion(VersionCheckOption option)
	{
		switch (option.State)
		{
		case VersionCheckState.Forbidden:
			throw new LuminErrorException(CodeType.CLIENT, CodeModule.RESOURCE, 1, null, "提示", LuminApplication.RemoteConfig.UpdateNoticeContent);
		case VersionCheckState.Full:
		case VersionCheckState.HotUpdate:
		case VersionCheckState.HotUpdateWithPatch:
			throw CreateUpdateRequiredException();
		case VersionCheckState.Patch:
			throw CreateUpdateRequiredException();
		case VersionCheckState.RefreshFail:
			break;
		}
	}

	public static bool IsVersionError(LuminErrorException exception)
	{
		if (exception != null && exception.CodeType == CodeType.CLIENT && exception.CodeModule == CodeModule.RESOURCE)
		{
			if (exception.SubCode != 1)
			{
				return exception.SubCode == 2;
			}
			return true;
		}
		return false;
	}

	private static LuminErrorException CreateUpdateRequiredException()
	{
		return new LuminErrorException(CodeType.CLIENT, CodeModule.RESOURCE, 2, null, "更新提示", "检测到资源有更新，请重新启动游戏");
	}

	public static void RestartGame()
	{
		using AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
		AndroidJavaObject androidJavaObject = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
		AndroidJavaObject androidJavaObject2 = androidJavaObject.Call<AndroidJavaObject>("getPackageManager", Array.Empty<object>()).Call<AndroidJavaObject>("getLaunchIntentForPackage", new object[1] { Application.identifier });
		if (androidJavaObject2 != null)
		{
			androidJavaObject2.Call<AndroidJavaObject>("setFlags", new object[1] { 268468224 });
			androidJavaObject.Call("startActivity", androidJavaObject2);
			androidJavaObject.Call("finish");
			AndroidJavaClass androidJavaClass2 = new AndroidJavaClass("android.os.Process");
			int num = androidJavaClass2.CallStatic<int>("myPid", Array.Empty<object>());
			androidJavaClass2.CallStatic("killProcess", num);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("当前程序的意图对象为空,无法重启应用程序");
		}
	}
}
