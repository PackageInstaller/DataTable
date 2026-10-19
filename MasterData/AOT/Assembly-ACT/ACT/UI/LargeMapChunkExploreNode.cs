using System.Collections.Generic;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.World;
using TMPro;

namespace ACT.UI;

public class LargeMapChunkExploreNode : MapIconBase
{
	public TextMeshProUGUI chunkExplorePercent;

	private float _targetScale;

	private bool _forbidShow;

	public void Init(MapArea area, int chunkId, float standScale)
	{
		AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData(area);
		_targetScale = standScale;
		if (areaGroupExploreData != null && MapUtility.GetAreaCanExplore(area) && areaGroupExploreData.GetSubAreaData() != null)
		{
			foreach (SubAreaExploreData value in areaGroupExploreData.GetSubAreaData().Values)
			{
				MapChunkExplore chunkExploreByChunkId = value.GetChunkExploreByChunkId(chunkId);
				MapModel.AreaExploreInfo areaExploreInfo = Model<MapModel>.Interface.GetAreaExploreInfo(area);
				if (chunkExploreByChunkId != null && areaExploreInfo != null && areaExploreInfo.GetChunkExploreInfo(chunkId) != null)
				{
					_forbidShow = false;
					IList<object> list = new List<object>();
					list.Add(chunkExploreByChunkId.TotalExplore);
					chunkExplorePercent.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2790, list);
					return;
				}
			}
		}
		_forbidShow = true;
		chunkExplorePercent.text = "";
	}

	public override void UnInit()
	{
		base.UnInit();
	}

	public override void UpdateScale(float val)
	{
		SetScale(1f / val);
		SetIsFade(val <= _targetScale);
	}

	public override void SetIsFade(bool fade)
	{
		base.SetIsFade(fade);
		if (_forbidShow)
		{
			transform.gameObject.SetActive(value: false);
		}
		else
		{
			transform.gameObject.SetActive(!fade);
		}
	}
}
