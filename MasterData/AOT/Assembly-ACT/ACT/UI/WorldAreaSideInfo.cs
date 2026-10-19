using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.World;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class WorldAreaSideInfo : MonoBehaviour
{
	public LargeMapView largeMapView;

	public GameObject areaCellPrefab;

	public Transform container;

	public BImage curWorldIcon;

	public BetterAnimation betterAnimation;

	private void Init()
	{
		if (gameObject.activeSelf)
		{
			return;
		}
		List<ACT.Config.MapArea> list = new List<ACT.Config.MapArea>();
		foreach (KeyValuePair<ACT.World.MapArea, EnterAreaMapBtn> item in largeMapView.enterAreaBtnDic)
		{
			item.Deconstruct(out var key, out var _);
			ACT.Config.MapArea data = CoreUtils.GetData((int)key, RuntimeConfigs.data.mapAreas);
			if (data != null)
			{
				list.Add(data);
			}
		}
		list.Sort((ACT.Config.MapArea x, ACT.Config.MapArea y) => x.mapSequence - y.mapSequence);
		foreach (ACT.Config.MapArea item2 in list)
		{
			ACT.World.MapArea area = (ACT.World.MapArea)item2.id;
			if (!MapUtility.AreaUnlock(area))
			{
				continue;
			}
			bool flag = false;
			foreach (MissionArrowData currentTrackMissionData in Model<BattleMainMarkModel>.Interface.GetCurrentTrackMissionDatas())
			{
				if (currentTrackMissionData.missionPointData.MapArea == area)
				{
					flag = true;
					break;
				}
			}
			AreaCell component = Object.Instantiate(areaCellPrefab, container).GetComponent<AreaCell>();
			component.gameObject.SetActive(value: true);
			bool missionHere = flag;
			bool playerHere = MapUtility.playerMapArea == area;
			MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
			component.Init(missionHere, playerHere, currentTraceMapPoint != null && currentTraceMapPoint.mapArea == area, Model<TrackModel>.Interface.TrackingPointArea() == area, largeMapView.Station, () =>
			{
				Hide();
				largeMapView.EnterAreaMap(area);
			}, area);
		}
	}

	public void Show()
	{
		Init();
		gameObject.SetActive(value: true);
		largeMapView.ChangeToGamePadInputState(SubControllerType.worldAreaSideBar);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Open");
		betterAnimation.GetSequence("Show").Play();
	}

	public void Hide()
	{
		if (gameObject != null && gameObject.activeSelf)
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				gameObject.SetActive(value: false);
			}).Play();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
			largeMapView.ChangeToGamePadInputState(SubControllerType.worldMap);
		}
		DestroyAreaList();
	}

	private void DestroyAreaList()
	{
		for (int num = container.childCount - 1; num >= 0; num--)
		{
			container.GetChild(num).gameObject.GetComponent<AreaCell>()?.UnInit();
			Object.Destroy(container.GetChild(num).gameObject);
		}
	}
}
