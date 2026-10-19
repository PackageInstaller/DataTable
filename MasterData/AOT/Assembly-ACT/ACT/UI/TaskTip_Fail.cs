using Bamboo.ImageCenter;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskTip_Fail : TaskTip_Base
{
	public BImage missionTypeImage;

	public LocalizeStringEvent missionName;

	public LocalizeStringEvent missionContent;

	public void Play(MissionStateAdapter missionInfoAdapter)
	{
		ImageAssetStation imageStation = GetImageStation();
		int missionType = missionInfoAdapter.GetMissionType();
		string arg = missionInfoAdapter.GetMissionName();
		missionInfoAdapter.GetMissionTitle();
		imageStation?.LoadImage(200, missionType, missionTypeImage);
		missionName.OnUpdateString?.Invoke(arg);
		Manager.animationController.SetTrigger(TaskTip_Base.Fail);
	}
}
