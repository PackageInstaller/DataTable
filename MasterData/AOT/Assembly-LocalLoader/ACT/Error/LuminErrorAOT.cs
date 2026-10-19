using System;
using ACT.LocalLoader;
using Newtonsoft.Json.Linq;
using UnityEngine;
using bamboosdk;

namespace ACT.Error;

public class LuminErrorAOT
{
	public static void ReportGameLoadingError(string errorCode, string systemModule, int rank, string detailMessage = "", bool retry = false, Action onConfirm = null, bool showDialog = true)
	{
		JObject jObject = new JObject
		{
			["error_code"] = errorCode,
			["system_module"] = systemModule,
			["rank"] = rank,
			["message"] = detailMessage
		};
		BamBooSdk.getInstance().taEvent("client_error_code", jObject.ToString());
		if (showDialog)
		{
			string text = GameLoadingErrorCodes.GetErrorMessage(errorCode);
			if (!string.IsNullOrEmpty(detailMessage))
			{
				text = text + "\n详情: " + detailMessage;
			}
			if (!retry)
			{
				ShowDialog(errorCode, "系统提示", text + "\n请尝试重启游戏");
			}
			else
			{
				ShowDialog(errorCode, "系统提示", text + "\n请点击确认重试", onConfirm);
			}
		}
	}

	public static void ShowDialog(string errorCode, string title, string message)
	{
		GameStart gameStart = UnityEngine.Object.FindObjectOfType<GameStart>();
		if (gameStart != null)
		{
			MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
			{
				btn1Text = "确认",
				callBack = Quit,
				isShowSingle = true,
				content = message + "\ncode：" + errorCode,
				titleText = title
			};
			gameStart.messageBox.Init(uiViewData);
		}
	}

	public static void ShowDialog(string errorCode, string title, string message, Action onConfirm = null)
	{
		GameStart gameStart = UnityEngine.Object.FindObjectOfType<GameStart>();
		if (gameStart != null)
		{
			MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
			{
				btn1Text = "确认",
				btn2Text = "取消",
				callBack = onConfirm,
				callBack2 = Quit,
				content = message + "\ncode：" + errorCode,
				titleText = title
			};
			gameStart.messageBox.Init(uiViewData);
		}
	}

	private static void Quit()
	{
		Application.Quit();
	}
}
