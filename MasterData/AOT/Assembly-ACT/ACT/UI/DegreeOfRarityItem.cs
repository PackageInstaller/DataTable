using ACT.Model;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class DegreeOfRarityItem : LoopScrollBaseItem
{
	[SerializeField]
	private BImage icon;

	[SerializeField]
	private TextMeshProUGUI _processText;

	private ImageAssetStation station;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		if (station == null)
		{
			station = GetComponentInParent<IBaseUIView>().Station;
		}
		station.LoadImage(204, idx + 1, icon);
		AccomplishmentModel accomplishmentModel = Model<AccomplishmentModel>.Interface;
		if (accomplishmentModel != null)
		{
			(int gold, int silver, int bronze) rarityReachedCounts = accomplishmentModel.GetRarityReachedCounts();
			int item = rarityReachedCounts.gold;
			int item2 = rarityReachedCounts.silver;
			int item3 = rarityReachedCounts.bronze;
			int num = idx switch
			{
				0 => item, 
				1 => item2, 
				_ => item3, 
			};
			if (_processText != null)
			{
				_processText.SetText("{0:0}", num);
			}
		}
	}
}
