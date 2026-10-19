using System;
using System.Diagnostics;
using System.IO;
using ACT;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

public class GameRestart : Singleton<GameRestart>
{
	public void ResterGameWhenAndroid()
	{
		TextPanel.Param param = new TextPanel.Param();
		param.texts = new string[1] { "出现错误，请重新启动游戏" };
		param.OnConfirm = () =>
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
		};
		TextPanel.Param uiData = param;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, uiData);
	}

	public void ExitGameWhenIOS()
	{
		TextPanel.Param param = new TextPanel.Param();
		param.texts = new string[1] { "出现错误，请退出游戏重新启动" };
		param.OnConfirm = () =>
		{
			Application.Quit();
		};
		TextPanel.Param uiData = param;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, uiData);
	}

	public void PcExitGame()
	{
		TextPanel.Param param = new TextPanel.Param();
		param.onlyConfirm = true;
		param.texts = new string[1] { "出现错误，即将退出游戏" };
		param.OnConfirm = () =>
		{
			Application.Quit();
		};
		TextPanel.Param uiData = param;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, uiData);
	}

	[Obsolete("通过操作系统重启游戏行不通，不象安卓有原生的接口，再需要重启功能 应该通过启动器去做，先暂时废弃")]
	public void ResterGameWhenPC()
	{
		string gamePath = Path.GetFullPath(Path.Combine(Application.dataPath, "../", Application.productName + ".exe"));
		bool pathIsValid = !string.IsNullOrEmpty(gamePath) && File.Exists(gamePath);
		string text = ((!pathIsValid) ? "即将退出游戏，无法找到游戏的可执行文件路径，请检查游戏安装是否正确。" : "出现错误，即将重新启动游戏");
		TextPanel.Param param = new TextPanel.Param();
		param.onlyConfirm = true;
		param.texts = new string[1] { text };
		param.OnConfirm = async () =>
		{
			if (!pathIsValid)
			{
				Application.Quit();
			}
			else
			{
				try
				{
					System.Diagnostics.Process.Start(new ProcessStartInfo(gamePath)
					{
						UseShellExecute = true
					});
				}
				catch (Exception ex)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError("无法重启进程:" + ex.Message);
					}
				}
				finally
				{
					await UniTask.Delay(TimeSpan.FromSeconds(3.0));
					Application.Quit();
				}
			}
		};
		TextPanel.Param uiData = param;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, uiData);
	}
}
