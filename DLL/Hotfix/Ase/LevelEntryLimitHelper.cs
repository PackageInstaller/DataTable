namespace Ase;

public static class LevelEntryLimitHelper
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

	public static bool TryBlockEntry(int levelId)
	{
		if (levelId <= 0)
		{
			return false;
		}
		if (IsDownloadReady())
		{
			return false;
		}
		DRMap dataRow = GameEntry.DataTable.GetDataRow<DRMap>(levelId);
		if (dataRow == null)
		{
			return false;
		}
		return dataRow.MapId >= 2;
	}
}
