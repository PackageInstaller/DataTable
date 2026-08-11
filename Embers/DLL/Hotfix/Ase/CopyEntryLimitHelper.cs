namespace Ase;

public static class CopyEntryLimitHelper
{
	private const string DownloadNotFinishedToast = "资源未下载完成，请在完成后重试";

	private static bool IsDownloadReady()
	{
		if (Singleton<SubrequestResHelper>.Instance == null)
		{
			return true;
		}
		return Singleton<SubrequestResHelper>.Instance.GetCurrentStatus() == SubrequestResHelper.DownloadStatus.Success;
	}

	public static bool TryBlockEntry(CopyData copyData, bool isMulti)
	{
		if (copyData == null)
		{
			return false;
		}
		if (IsDownloadReady())
		{
			return false;
		}
		int copyMainId = copyData.CopyMainId;
		int copyType = copyData.CopyType;
		if (isMulti)
		{
			if (ShouldBlockMulti(copyMainId, copyType))
			{
				Toast.ShowInfo("资源未下载完成，请在完成后重试");
				return true;
			}
		}
		else if (ShouldBlockSingle(copyMainId, copyType))
		{
			Toast.ShowInfo("资源未下载完成，请在完成后重试");
			return true;
		}
		return false;
	}

	private static bool ShouldBlockSingle(int copyMainId, int copyType)
	{
		if (copyMainId == 2 && copyType >= 32000 && copyType <= 38000)
		{
			return true;
		}
		switch (copyMainId)
		{
		case 3:
		case 4:
		case 5:
			return true;
		case 7:
			if (copyType == 70000)
			{
				return true;
			}
			break;
		}
		return false;
	}

	private static bool ShouldBlockMulti(int copyMainId, int copyType)
	{
		if (copyMainId == 2 && copyType >= 32000 && copyType <= 38000)
		{
			return true;
		}
		if (copyMainId == 3 || copyMainId == 6 || copyMainId == 8)
		{
			return true;
		}
		return false;
	}
}
