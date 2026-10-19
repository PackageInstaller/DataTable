using System.Text;
using ACT;
using ACT.Error;
using ACT.LocalLoader;
using AOT.CryptographyCode;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json.Linq;
using UnityEngine;
using UnityEngine.Networking;
using bamboosdk;

namespace AOT.WhiteListCheck;

public static class WhiteListCheckUtil
{
	public static async UniTask<bool> CheckWhiteListFunc()
	{
		WWWForm wWWForm = new WWWForm();
		wWWForm.AddField("token", LuminBambooBridgeListener.UserInfo?.token);
		wWWForm.AddField("env", LuminApplication.AppEnv);
		wWWForm.AddField("region", LuminApplication.AppRegion);
		wWWForm.AddField("target_platform", LuminApplication.GetPlatformName);
		wWWForm.AddField("client_version", LuminApplication.AppClientVersion);
		wWWForm.AddField("device_id", LuminApplication.DeviceId);
		using UnityWebRequest request = BambooSafeHttpRequest.Post("https://bamboo.zhuziplay.com/lvmeng/validate", wWWForm);
		await request.SendWebRequest();
		if (request.result != UnityWebRequest.Result.Success)
		{
			LuminErrorAOT.ReportGameLoadingError("C01-0007", "01", 0, request.responseCode.ToString());
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("[C01-0007] Request WhiteList Network Error: " + request.error);
			}
			WhiteListErrorMessage("C01-0007");
			return false;
		}
		string text = Encoding.UTF8.GetString(request.downloadHandler.data);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[Request WhiteList] Response: " + text);
		}
		if (!(JObject.Parse(text)["data"]?["is_white"] ?? ((JToken)false)).Value<bool>())
		{
			LuminErrorAOT.ReportGameLoadingError("C02-0005", "02", 0, "Cannot Pass WhiteList");
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("[C02-0005] Request WhiteList Network Error: " + request.error);
			}
			WhiteListErrorMessage("C02-0005");
			return false;
		}
		return true;
	}

	internal static void WhiteListErrorMessage(string errorCode)
	{
		MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
		{
			btn1Text = "确认",
			btn1MiniText = "QUEREN",
			titleText = "",
			isShowSingle = true,
			callBack = () =>
			{
				if (!LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
				{
					BamBooSdk.getInstance().logout(isShowWindow: false);
				}
			},
			content = "很抱歉，您的账号暂无测试资格\n敬请留意官方公告获取后续机会\ncode：" + errorCode
		};
		GameStart component = LuminBambooBridgeListener.Default.GetComponent<GameStart>();
		if ((bool)component)
		{
			component.messageBox.Init(uiViewData);
		}
	}
}
