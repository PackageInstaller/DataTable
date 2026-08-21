using System.Collections.Generic;

namespace Ase;

public class RankHeroSelectViewModel : OptionBase
{
	private List<RankDefinition.HeroChallengeData> _datas = new List<RankDefinition.HeroChallengeData>();

	private int _selectHeroId;

	private RankHeroSelectItemData curSelectItemData;

	public List<RankDefinition.HeroChallengeData> Datas => _datas;

	public int SelectHeroId => _selectHeroId;

	public RankHeroSelectViewModel()
	{
	}

	public RankHeroSelectViewModel(OptionBase parent, List<RankDefinition.HeroChallengeData> datas, int selectHeroId)
	{
		base.parent = parent;
		_datas = datas;
		_selectHeroId = selectHeroId;
	}

	public void SetItemSelected(RankHeroSelectItemData itemData)
	{
		if (curSelectItemData != null)
		{
			curSelectItemData.Selected = false;
		}
		curSelectItemData = itemData;
		curSelectItemData.Selected = true;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is RankHeroSelectItemData rankHeroSelectItemData)
		{
			SetItemSelected(rankHeroSelectItemData);
			parent?.ItemOnClick(rankHeroSelectItemData.Data);
			Close();
		}
	}
}
