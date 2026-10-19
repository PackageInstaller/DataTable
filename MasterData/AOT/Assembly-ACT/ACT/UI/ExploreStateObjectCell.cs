using System;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.World;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ExploreStateObjectCell : MonoBehaviour
{
	public LocalizeStringEvent groupName;

	public TextMeshProUGUI explorePercent;

	public BImage iconType;

	public ActButton btn;

	public GameObject select;

	private int _groupId;

	private int _mapArea;

	private ImageAssetStation _imageAssetStation;

	public int GroupId => _groupId;

	public void Init(int groupId, int mapArea, Action<int> buttonAction = null)
	{
		_imageAssetStation = this.GetImageStation();
		gameObject.SetActive(value: true);
		_groupId = groupId;
		_mapArea = mapArea;
		StateObjectGroup data = CoreUtils.GetData(groupId, RuntimeConfigs.data.stateObjectGroups);
		if (data != null)
		{
			groupName.StringReference.TableEntryReference = data.groupName;
			if (data.id == 4)
			{
				ACT.Config.MapArea data2 = CoreUtils.GetData(_mapArea, RuntimeConfigs.data.mapAreas);
				if (data2 != null)
				{
					ExploreType data3 = CoreUtils.GetData(data2.exploreType, RuntimeConfigs.data.exploreTypes);
					if (data3 != null)
					{
						groupName.StringReference.TableEntryReference = data3.name;
					}
				}
			}
			_imageAssetStation.LoadImage(184, groupId, iconType);
		}
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(() =>
		{
			buttonAction?.Invoke(_groupId);
		});
	}

	public void SetSelected(bool selected)
	{
		if (select != null)
		{
			select.SetActive(selected);
		}
	}

	public void Init(MapExploreGroupProgress groupProgress, ACT.World.MapArea mapArea, ImageAssetStation imageAssetStation)
	{
		_imageAssetStation = imageAssetStation;
		gameObject.SetActive(value: true);
		_groupId = groupProgress.GroupId;
		_mapArea = (int)mapArea;
		if (_groupId == 11)
		{
			int num = ((groupProgress.Total > 0) ? Mathf.FloorToInt((float)groupProgress.Progress * 100f / (float)groupProgress.Total) : 0);
			explorePercent.SetText("{0:0}%", num);
		}
		else
		{
			explorePercent.SetText("{0:0}/{1:0}", groupProgress.Progress, groupProgress.Total);
		}
		StateObjectGroup data = CoreUtils.GetData(groupProgress.GroupId, RuntimeConfigs.data.stateObjectGroups);
		if (data != null)
		{
			groupName.StringReference.TableEntryReference = data.groupName;
			if (data.id == 4)
			{
				ACT.Config.MapArea data2 = CoreUtils.GetData(_mapArea, RuntimeConfigs.data.mapAreas);
				if (data2 != null)
				{
					ExploreType data3 = CoreUtils.GetData(data2.exploreType, RuntimeConfigs.data.exploreTypes);
					if (data3 != null)
					{
						groupName.StringReference.TableEntryReference = data3.name;
					}
				}
			}
			_imageAssetStation.LoadImage(184, groupProgress.GroupId, iconType);
		}
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(OpenIntroductionView);
	}

	private void OpenIntroductionView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPSTATEOBJECTINTRO, new PopupStateObjectIntroViewData
		{
			groupId = _groupId,
			mapArea = _mapArea
		});
	}
}
