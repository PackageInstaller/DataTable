namespace Ase;

public class CampaignTeamRoomContext
{
	public int CopyId;

	public int PointId;

	public int PlayId;

	public CampaignAreaType AreaType;

	public CopyData CopyData;

	public static CampaignTeamRoomContext Create(CampaignAreaData data, CopyData copyData)
	{
		return new CampaignTeamRoomContext
		{
			CopyId = data.CopyId,
			PointId = data.PositionId,
			AreaType = data.Type,
			PlayId = data.PlayId,
			CopyData = copyData
		};
	}
}
