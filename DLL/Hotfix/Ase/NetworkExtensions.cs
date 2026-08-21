using GameFramework.Network;

namespace Ase;

public static class NetworkExtensions
{
	public static bool Validate(this IResponse response)
	{
		if (response == null)
		{
			return false;
		}
		return response.Error == 0;
	}

	public static bool Validate(this IResponse response, string msg)
	{
		if (response == null)
		{
			return false;
		}
		if (response.Error == 0)
		{
			return true;
		}
		DRErrorCode dataRow = GameEntry.DataTable.GetDataTable<DRErrorCode>().GetDataRow(response.Error);
		msg = ((dataRow != null) ? Utility.Text.Format("{0} - {1}", msg, dataRow.Tips) : Utility.Text.Format("未知错误【{0}】", response.Error));
		Toast.ShowError(msg);
		return false;
	}
}
