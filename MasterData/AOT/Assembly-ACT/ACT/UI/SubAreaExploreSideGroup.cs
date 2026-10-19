using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.ViewControl;
using ACT.World;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SubAreaExploreSideGroup : MonoBehaviour
{
	public ExploreRatioSidebar sidebar;

	public LocalizeStringEvent subAreaNameLocalize;

	public ExploreAreaRewardGroup rewardGroup;

	public GameObject stateObjectTypeCell;

	public Transform typeContent;

	public ActButton changeSubAreaButton;

	public RedDotItem redDotItem;

	private int _areaId;

	private ACT.World.MapArea _mapArea;

	public void Init(ACT.World.MapArea mapArea, int areaId, ImageAssetStation imageAssetStation)
	{
		_areaId = areaId;
		_mapArea = mapArea;
		SubMapArea data = CoreUtils.GetData(areaId, RuntimeConfigs.data.subMapAreas);
		subAreaNameLocalize.StringReference.TableEntryReference = data.name;
		rewardGroup?.SetParentView(sidebar.view);
		rewardGroup?.Init(mapArea, 2, areaId);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_MapExploreRewardReceiveEvt, RefreshRewardGroup);
		changeSubAreaButton.OnClick.RemoveAllListeners();
		changeSubAreaButton.OnClick.AddListener(() =>
		{
			sidebar.ToShowArea();
		});
		AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData(mapArea);
		if (areaGroupExploreData != null && areaGroupExploreData.GetSubAreaData().TryGetValue(areaId, out var value))
		{
			foreach (KeyValuePair<int, MapExploreGroupProgress> item in from item in value.GetGroupExploreRatio()
				orderby CoreUtils.GetData(item.Value.GroupId, RuntimeConfigs.data.stateObjectGroups).Sequence
				select item)
			{
				int groupId = item.Value.GroupId;
				if (CoreUtils.GetData(groupId, RuntimeConfigs.data.stateObjectGroups).weight != 0 && (!GameLoader.meta.mapConfig.IsDefaultUnlockSubArea((MapSubArea)areaId) || groupId != 11))
				{
					Object.Instantiate(stateObjectTypeCell, typeContent).GetComponent<ExploreStateObjectCell>().Init(item.Value, mapArea, imageAssetStation);
				}
			}
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
				for (int num = 0; num < array2.Length; num++)
				{
					ACT.ViewControl.SelectableEx component2 = array2[num].previewButton.GetComponent<ACT.ViewControl.SelectableEx>();
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
			sidebar.view.ViewControlLayers[SubControllerType.mapCollection].SetTargetTransform(typeContent.transform);
			sidebar.view.ViewControlLayers[SubControllerType.mapCollection].Focus();
		}
		MapExploreRewardOnSubAreaPanel displayAction = new MapExploreRewardOnSubAreaPanel
		{
			subAreaId = areaId
		};
		string map = RedDotPathDefine.Map;
		redDotItem.redDotType = RedDotType.Dot;
		redDotItem.fullPath = map.Split("|").ToList();
		redDotItem.displayAction = displayAction;
		redDotItem.BindTrieNode();
		redDotItem.UpdateDisplay();
	}

	private void RefreshRewardGroup(BaseEventContent obj)
	{
		rewardGroup?.Refresh(_mapArea, 2, _areaId);
	}

	public void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_MapExploreRewardReceiveEvt, RefreshRewardGroup);
		rewardGroup?.UnInit();
		changeSubAreaButton.OnClick.RemoveAllListeners();
		DestroyStageGroup();
	}

	private void DestroyStageGroup()
	{
		for (int num = typeContent.childCount - 1; num >= 0; num--)
		{
			Object.Destroy(typeContent.GetChild(num).gameObject);
		}
	}

	protected void OnDestroy()
	{
		rewardGroup?.UnInit();
		DestroyStageGroup();
	}
}
