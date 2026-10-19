using System;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.World;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ExploreSubAreaCell : MonoBehaviour
{
	public LocalizeStringEvent subAreaName;

	public TextMeshProUGUI explorePercent;

	public ActButton subAreaButton;

	public RedDotItem redDotItem;

	public void Init(int area, int areaId, Action<int, int> callback = null)
	{
		AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData((ACT.World.MapArea)area);
		gameObject.SetActive(value: true);
		explorePercent.text = "0";
		if (areaGroupExploreData != null && areaGroupExploreData.GetSubAreaData().TryGetValue(areaId, out var value))
		{
			explorePercent.SetText("{0:0}", Mathf.FloorToInt(value.GetAreaExploreRatio()));
		}
		SubMapArea data = CoreUtils.GetData(areaId, RuntimeConfigs.data.subMapAreas);
		subAreaName.StringReference.TableEntryReference = data.name;
		subAreaButton.OnClick.RemoveAllListeners();
		subAreaButton.OnClick.AddListener(() =>
		{
			callback?.Invoke(area, areaId);
		});
		string text = string.Format(RedDotPathDefine.MapExploreReward + "|{1}|IsNew", area, areaId);
		redDotItem.redDotType = RedDotType.Dot;
		redDotItem.fullPath = text.Split("|").ToList();
		redDotItem.BindTrieNode();
		redDotItem.UpdateDisplay();
	}

	public void OnDestroy()
	{
		subAreaButton.OnClick.RemoveAllListeners();
	}
}
