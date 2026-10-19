using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using ACT.Model;
using ACT.World;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AreaExploreInfo : MonoBehaviour
{
	public LargeMapView view;

	public GameObject exploreInfoRoot;

	public GameObject subExploreInfoRoot;

	public TextMeshProUGUI exploreProgressText;

	public TextMeshProUGUI subExploreProgressText;

	public LocalizeStringEvent subAreaNameLocalize;

	public ActButton openSideBarBtn;

	public RedDotItem areaRedDotItem;

	public RedDotItem subAreaRedDotItem;

	public void Init(MapArea mapArea)
	{
		gameObject.SetActive(value: true);
		subExploreInfoRoot.SetActive(value: false);
		bool areaCanExplore = MapUtility.GetAreaCanExplore(mapArea);
		float areaExploreRatio = MapUtility.GetAreaExploreRatio(mapArea);
		exploreInfoRoot.SetActive(areaCanExplore);
		openSideBarBtn.interactable = areaCanExplore;
		string text = string.Format(RedDotPathDefine.MapExploreReward, (int)mapArea);
		areaRedDotItem.redDotType = RedDotType.Dot;
		areaRedDotItem.fullPath = text.Split("|").ToList();
		areaRedDotItem.BindTrieNode();
		areaRedDotItem.UpdateDisplay();
		int[] subMapArea = CoreUtils.GetData((int)mapArea, RuntimeConfigs.data.mapAreas).subMapArea;
		int activeAreaId = Singleton<GameManager>.instance.worldManager.ActiveAreaId;
		bool flag = false;
		if (activeAreaId != 0)
		{
			int[] array = subMapArea;
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i] == activeAreaId)
				{
					flag = true;
					break;
				}
			}
			subAreaNameLocalize.StringReference.TableEntryReference = CoreUtils.GetData(activeAreaId, RuntimeConfigs.data.subMapAreas).name;
		}
		if (areaCanExplore && Model<MapModel>.Interface.GetAreaGroupExploreData(mapArea) != null)
		{
			exploreProgressText.SetText("{0:0}", Mathf.FloorToInt(areaExploreRatio));
			Dictionary<int, SubAreaExploreData> subAreaData = Model<MapModel>.Interface.GetAreaGroupExploreData(mapArea).GetSubAreaData();
			subExploreInfoRoot.SetActive((subAreaData != null && subAreaData.Count > 0) & flag);
			if (subExploreInfoRoot.activeSelf && subAreaData != null && subAreaData.TryGetValue(activeAreaId, out var value))
			{
				subExploreProgressText.SetText("{0:0}", Mathf.FloorToInt(value.GetAreaExploreRatio()));
				string text2 = string.Format(RedDotPathDefine.MapExploreReward + "|{1}|IsNew", (int)mapArea, activeAreaId);
				subAreaRedDotItem.redDotType = RedDotType.Dot;
				subAreaRedDotItem.fullPath = text2.Split("|").ToList();
				subAreaRedDotItem.BindTrieNode();
				subAreaRedDotItem.UpdateDisplay();
			}
		}
		else
		{
			exploreProgressText.text = "0";
			subExploreProgressText.text = "0";
		}
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
	}
}
