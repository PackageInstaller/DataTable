using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.ViewControl;
using ACT.World;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AreaExploreSideGroup : MonoBehaviour
{
	public ExploreRatioSidebar sidebar;

	public LocalizeStringEvent areaNameLocalize;

	public BImage areaImage;

	public ExploreAreaRewardGroup rewardGroup;

	public GameObject subAreaCell;

	public Transform subAreaContent;

	private ImageAssetStation _imageAssetStation;

	private ACT.World.MapArea _mapArea;

	public void Init(ACT.World.MapArea mapArea, ImageAssetStation imageAssetStation)
	{
		_mapArea = mapArea;
		_imageAssetStation = imageAssetStation;
		_imageAssetStation.LoadImage(183, (int)mapArea, areaImage);
		ACT.Config.MapArea data = CoreUtils.GetData((int)mapArea, RuntimeConfigs.data.mapAreas);
		areaNameLocalize.StringReference.TableEntryReference = data.name;
		rewardGroup?.SetParentView(sidebar.view);
		rewardGroup?.Init(mapArea, 1);
		int[] subMapArea = data.subMapArea;
		foreach (int areaId in subMapArea)
		{
			Object.Instantiate(subAreaCell, subAreaContent).GetComponent<ExploreSubAreaCell>().Init((int)mapArea, areaId, sidebar.ToShowSubArea);
		}
		sidebar.view.ViewControlLayers[SubControllerType.mapCollection].SetDefaultSelect(null);
		ExploreRewardStageCell[] array = rewardGroup?.stageContent.GetComponentsInChildren<ExploreRewardStageCell>();
		if (array != null && array.Length != 0)
		{
			sidebar.view.ViewControlLayers[SubControllerType.mapCollection].SetTargetTransform(sidebar.root);
			bool flag = false;
			ExploreRewardStageCell[] array2 = array;
			foreach (ExploreRewardStageCell exploreRewardStageCell in array2)
			{
				if (exploreRewardStageCell.canReward.activeSelf)
				{
					ACT.ViewControl.SelectableEx component = exploreRewardStageCell.previewButton.GetComponent<ACT.ViewControl.SelectableEx>();
					if (component.enabled)
					{
						sidebar.view.ViewControlLayers[SubControllerType.mapCollection].DefaultSelect = component;
						flag = true;
						break;
					}
				}
			}
			if (!flag)
			{
				array2 = array;
				for (int i = 0; i < array2.Length; i++)
				{
					ACT.ViewControl.SelectableEx component2 = array2[i].previewButton.GetComponent<ACT.ViewControl.SelectableEx>();
					if (component2.enabled)
					{
						sidebar.view.ViewControlLayers[SubControllerType.mapCollection].DefaultSelect = component2;
						break;
					}
				}
			}
			sidebar.view.ViewControlLayers[SubControllerType.mapCollection].Focus();
		}
		else
		{
			sidebar.view.ViewControlLayers[SubControllerType.mapCollection].SetTargetTransform(subAreaContent.transform);
			sidebar.view.ViewControlLayers[SubControllerType.mapCollection].Focus();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_MapExploreRewardReceiveEvt, RefreshRewardGroup);
	}

	private void RefreshRewardGroup(BaseEventContent obj)
	{
		rewardGroup?.Refresh(_mapArea, 1);
	}

	public void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_MapExploreRewardReceiveEvt, RefreshRewardGroup);
		rewardGroup?.UnInit();
		DestroyStageGroup();
	}

	private void DestroyStageGroup()
	{
		for (int num = subAreaContent.childCount - 1; num >= 0; num--)
		{
			Object.Destroy(subAreaContent.GetChild(num).gameObject);
		}
	}

	protected void OnDestroy()
	{
		rewardGroup?.UnInit();
		DestroyStageGroup();
	}
}
