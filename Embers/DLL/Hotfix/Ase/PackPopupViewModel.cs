using System.Collections.Generic;

namespace Ase;

public class PackPopupViewModel : OptionBase
{
	private PropDataBase propData;

	private string propDesc;

	private string rarityColorBg = "";

	private List<PropPackItemViewModel> propPackItemViewModelList = new List<PropPackItemViewModel>();

	public PropDataBase PropData
	{
		get
		{
			return propData;
		}
		set
		{
			Set(ref propData, value, "PropData");
			RarityColorBg = $"shop_prop_{value.GetRarity()}";
		}
	}

	public string RarityColorBg
	{
		get
		{
			return rarityColorBg;
		}
		set
		{
			Set(ref rarityColorBg, value, "RarityColorBg");
		}
	}

	public string PropDesc
	{
		get
		{
			return propDesc;
		}
		set
		{
			Set(ref propDesc, value.Replace("\\n", "\n"), "PropDesc");
		}
	}

	public List<PropPackItemViewModel> PropPackItemViewModelList => propPackItemViewModelList;

	public PackPopupViewModel()
	{
	}

	public PackPopupViewModel(OptionBase parent, PropDataBase propDataBase)
	{
		base.parent = parent;
		PropData = propDataBase;
		if (PropData.PropTypeEnum == PropTypeEnum.GiftPack)
		{
			LoadPackInfo();
		}
	}

	private void LoadPackInfo()
	{
		DRPacks dataRow = GameEntry.DataTable.GetDataRow<DRPacks>(PropData.Id);
		if (dataRow != null)
		{
			int chooseType = dataRow.ChooseType;
			int chooseNUM = dataRow.ChooseNUM;
			SetTipText(chooseType, chooseNUM);
			propPackItemViewModelList = new List<PropPackItemViewModel>();
			DRPacksInclude[] dataRows = GameEntry.DataTable.GetDataRows((DRPacksInclude p) => p.PacksID == PropData.Id);
			foreach (DRPacksInclude dRPacksInclude in dataRows)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dRPacksInclude.IncludeType, dRPacksInclude.IncludeID, dRPacksInclude.IncludeNUM);
				propDataBase.ExValue = dRPacksInclude.Id;
				PropPackItemViewModel item = new PropPackItemViewModel(this, propDataBase);
				propPackItemViewModelList.Add(item);
			}
		}
		else
		{
			Toast.ShowError($"礼包ID:{PropData.Id}的表数据丢失");
		}
	}

	private void SetTipText(int packType, int chooseNum)
	{
		switch (packType)
		{
		case 1:
			PropDesc = "<color=#FF961D>可获得</color>奖励内容";
			break;
		case 2:
			PropDesc = $"从下方奖励<color=#FF961D>选择获得</color>{chooseNum}种";
			break;
		case 3:
			PropDesc = $"<color=#FF961D>随机获得</color>下方奖励的{chooseNum}种";
			break;
		}
	}
}
