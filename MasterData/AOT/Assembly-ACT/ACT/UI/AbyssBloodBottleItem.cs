using System.Text;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssBloodBottleItem : LoopScrollBaseItem
{
	[SerializeField]
	private GameObject equipIcon1;

	[SerializeField]
	private GameObject equipIcon2;

	[SerializeField]
	private TeamViewBottleCell teamViewBottleCell;

	public int _index;

	private BloodBottleData bottleData;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		_index = idx;
	}

	public void Refresh(BloodBottleData bottleData, ImageAssetStation station, PresetTeam curTeamProfile, StringBuilder sb)
	{
		this.bottleData = bottleData;
		teamViewBottleCell.Refresh(bottleData, station, curTeamProfile, sb);
		teamViewBottleCell.SetEquipState(isEquip: false);
	}

	public void SetBtnClick(UnityAction callBack)
	{
		teamViewBottleCell.btn.SetBtnClick(callBack);
	}

	public void RefreshState(int selectIndex)
	{
		int num = -1;
		for (int i = 0; i < Model<AbyssModel>.Interface.AbyssModifyData.Count; i++)
		{
			if (Model<AbyssModel>.Interface.AbyssModifyData[i].EquipPotionId == bottleData.id)
			{
				num = i;
				break;
			}
		}
		equipIcon1.SetActive(num == 0);
		equipIcon2.SetActive(num == 1);
		teamViewBottleCell.SetSelectState(selectIndex == _index);
	}
}
