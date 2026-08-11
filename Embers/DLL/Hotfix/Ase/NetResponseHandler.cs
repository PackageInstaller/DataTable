#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Network;

namespace Ase;

public class NetResponseHandler : Singleton<NetResponseHandler>
{
	public string GetErrorCodeInfo(int errorCode, string errorMsg)
	{
		DRErrorCode dataRow = GameEntry.DataTable.GetDataTable<DRErrorCode>().GetDataRow(errorCode);
		if (dataRow == null)
		{
			Log.Error($"DRErrorCode表，未找到ID【{errorCode}】");
		}
		else
		{
			errorMsg = dataRow.Tips;
		}
		return errorMsg;
	}

	public bool ValidateResponse(IResponse message, string requestErrorMsg, string errorMsg, bool showToast = true)
	{
		if (ValidateResponse(message, requestErrorMsg, showToast: false))
		{
			return ValidateErrorCode(message.Error, errorMsg, showToast);
		}
		return false;
	}

	public bool ValidateErrorCode(int errorCode, string errorMsg, bool showToast = true)
	{
		if (errorCode == 0)
		{
			return true;
		}
		string text = GetErrorCodeInfo(errorCode, "");
		if (string.IsNullOrEmpty(text))
		{
			Log.Error($"【{errorMsg}】ErrorCode：{errorCode}，未知错误【{errorCode}】");
		}
		else
		{
			Log.Error($"【{errorMsg}】ErrorCode：{errorCode}，{text}");
		}
		if (showToast)
		{
			if (string.IsNullOrEmpty(text))
			{
				text = errorMsg;
			}
			Toast.ShowInfo(text);
		}
		return false;
	}

	public bool ValidateResponse(IResponse response, string errorMsg, bool showToast = true)
	{
		if (response == null)
		{
			Log.Error("【" + errorMsg + "】请求服务器失败，Response为空！");
			if (showToast)
			{
				Toast.ShowError("请求服务器失败，请重试", errorMsg);
			}
			return false;
		}
		return true;
	}
}
