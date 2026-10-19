using ACT.Core;
using ACT.Model;
using ACT.World;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class LargeMapAreaExploreNode : MapIconBase
{
	public LocalizeStringEvent areaName;

	public TextMeshProUGUI areaExplorePercent;

	public GameObject exploreGroup;

	private float _targetScale;

	public void Init(MapArea area, int areaBlockId, float standScale)
	{
		_targetScale = standScale;
		exploreGroup.SetActive(value: false);
		areaName.StringReference.TableEntryReference = CoreUtils.GetData(areaBlockId, RuntimeConfigs.data.subMapAreas).name;
		AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData(area);
		if (areaGroupExploreData != null && MapUtility.GetAreaCanExplore(area))
		{
			if (areaGroupExploreData.GetSubAreaData().TryGetValue(areaBlockId, out var value))
			{
				exploreGroup.SetActive(value: true);
				areaExplorePercent.text = value.GetAreaExploreRatio().ToString();
			}
		}
		else
		{
			areaExplorePercent.text = "";
		}
	}

	public override void UnInit()
	{
		base.UnInit();
	}

	public override void UpdateScale(float val)
	{
		SetScale(1f / val);
		SetIsFade(val > _targetScale);
	}

	public override void SetIsFade(bool fade)
	{
		base.SetIsFade(fade);
		transform.gameObject.SetActive(!fade);
	}
}
