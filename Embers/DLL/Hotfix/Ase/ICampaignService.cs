using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface ICampaignService
{
	UniTask<CampaignServiceData.MainInfo> RequestCampaignMainInfo();

	UniTask<CampaignServiceData.DetailInfo> RequestCampaignDetailInfo();

	UniTask<List<CampaignServiceData.WorldBossInfo>> RequestSearchBoss();

	UniTask<List<CampaignServiceData.BuildingInfo>> RequestUpgradeBuilding(int pointId);

	void ResetBuildingUpgradeMark();

	bool GetCampaignOpenState();

	UniTask<CampaignTeamRoomCheckResult> CheckCampaignTeamRoom(CampaignTeamRoomContext context, CampaignTeamRoomCheckScene scene);

	CampaignServiceData.MainInfo GetMainInfo();

	CampaignServiceData.DetailInfo GetDetailInfo();

	void Dispose();
}
