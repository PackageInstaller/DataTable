namespace Ase;

public class CampaignTeamRoomCheckResult
{
	public bool Success;

	public string ToastText;

	public static CampaignTeamRoomCheckResult Ok()
	{
		return new CampaignTeamRoomCheckResult
		{
			Success = true,
			ToastText = string.Empty
		};
	}

	public static CampaignTeamRoomCheckResult Fail(string toastText)
	{
		return new CampaignTeamRoomCheckResult
		{
			Success = false,
			ToastText = toastText
		};
	}
}
