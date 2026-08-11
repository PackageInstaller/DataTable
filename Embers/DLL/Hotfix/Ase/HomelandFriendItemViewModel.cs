using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HomelandFriendItemViewModel : OptionBase
{
	private SimpleCommand<HomelandMainArg> optCommand;

	private PlayerData data;

	private Dictionary<int, HomelandBuildingData> buildingDatas;

	private bool isSelect;

	public PlayerData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public Dictionary<int, HomelandBuildingData> BuildingDatas => buildingDatas;

	public ICommand OptCommand => optCommand;

	public HomelandFriendItemViewModel()
	{
	}

	public HomelandFriendItemViewModel(OptionBase parent, PlayerData data)
	{
		base.parent = parent;
		this.data = data;
		optCommand = new SimpleCommand<HomelandMainArg>(OnOpt);
	}

	private void OnOpt(HomelandMainArg opt)
	{
		if (opt == HomelandMainArg.VisitFriend)
		{
			parent.ItemOnClick(this);
		}
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}
}
