using System.Linq;
using ACT.Core;
using ACT.MissionSystem;
using ACT.Model;
using ACT.World;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class BackToWorldMapBtn : MonoBehaviour
{
	public LargeMapView view;

	public RedDotItem redDotItem;

	public ActButton btn;

	public GameObject missionInOtherArea;

	public BImage trackMissionTypeImage;

	private UnityAction backToWorldMapAction;

	public void Init(MapArea area, bool missionInOtherArea)
	{
		gameObject.SetActive(value: true);
		MapExploreRewardOnTab displayAction = new MapExploreRewardOnTab
		{
			areaId = (int)area
		};
		string map = RedDotPathDefine.Map;
		redDotItem.redDotType = RedDotType.Dot;
		redDotItem.fullPath = map.Split("|").ToList();
		redDotItem.displayAction = displayAction;
		redDotItem.BindTrieNode();
		redDotItem.UpdateDisplay();
		this.missionInOtherArea.SetActive(missionInOtherArea);
		if (!missionInOtherArea)
		{
			return;
		}
		foreach (MissionArrowData currentTrackMissionData in Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas())
		{
			if (currentTrackMissionData.missionPointData.MapArea != view.CurShowArea)
			{
				CoreUtils.GetData(currentTrackMissionData.missionPointData.MissionId, RuntimeConfigs.data.missionBases);
				MissionConfig missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(currentTrackMissionData.missionPointData.MissionId);
				this.GetImageStation().LoadImage(200, missionConfig.MissionType, trackMissionTypeImage);
				break;
			}
		}
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
		trackMissionTypeImage.UnLoad();
	}
}
