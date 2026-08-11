using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TeamBPConfigViewModel : OptionBase
{
	private BPCarryItemViewModel vm1;

	private BPCarryItemViewModel vm2;

	private bool canAdd = true;

	private bool showConfigView;

	private BattlePropConfigViewModel configViewModel;

	private InteractionRequest refreshDataRequest = new InteractionRequest();

	public bool ShowConfigView
	{
		get
		{
			return showConfigView;
		}
		private set
		{
			Set(ref showConfigView, value, "ShowConfigView");
		}
	}

	public BPCarryItemViewModel Vm1 => vm1;

	public BPCarryItemViewModel Vm2 => vm2;

	public IInteractionRequest RefreshDataRequest => refreshDataRequest;

	public TeamBPConfigViewModel(OptionBase parent)
	{
		base.parent = parent;
		Dictionary<int, BPCarryItemViewModel> carringBPs = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetCarringBPs();
		vm1 = carringBPs[1];
		vm2 = carringBPs[2];
		vm1.SetParent(this);
		vm2.SetParent(this);
		CheckOpen();
	}

	public static TeamBPConfigViewModel CreateMultiTeammate(OptionBase parent, Dictionary<int, BPData> bpCarrying)
	{
		TeamBPConfigViewModel teamBPConfigViewModel = new TeamBPConfigViewModel(parent, bpCarrying);
		teamBPConfigViewModel.SetCanAdd(val: false);
		return teamBPConfigViewModel;
	}

	private TeamBPConfigViewModel(OptionBase parent, Dictionary<int, BPData> bpCarrying)
	{
		base.parent = parent;
		Dictionary<int, BPCarryItemViewModel> dictionary = new Dictionary<int, BPCarryItemViewModel>
		{
			{
				1,
				new BPCarryItemViewModel(null, bpCarrying.ContainsKey(1) ? bpCarrying[1] : null, 1)
			},
			{
				2,
				new BPCarryItemViewModel(null, bpCarrying.ContainsKey(2) ? bpCarrying[2] : null, 2)
			}
		};
		vm1 = dictionary[1];
		vm2 = dictionary[2];
		vm1.SetParent(this);
		vm2.SetParent(this);
		CheckOpen();
	}

	public void RefreshTeammateBP(Dictionary<int, BPData> bpCarrying)
	{
		vm1 = new BPCarryItemViewModel(null, bpCarrying.ContainsKey(1) ? bpCarrying[1] : null, 1);
		vm2 = new BPCarryItemViewModel(null, bpCarrying.ContainsKey(2) ? bpCarrying[2] : null, 2);
		SetCanAdd(canAdd);
	}

	public void CheckOpen()
	{
		ShowConfigView = Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70013);
	}

	public void SetTeamSetId(int teamSetId)
	{
		DRTeamSet dataRow = GameEntry.DataTable.GetDataRow<DRTeamSet>(teamSetId);
		if (dataRow != null)
		{
			ShowConfigView = Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70013) && dataRow.IsBattleProp;
		}
		else
		{
			ShowConfigView = Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70013);
		}
	}

	public void Refresh()
	{
		if (configViewModel != null)
		{
			vm1.RefreshData(configViewModel.GetItemByNum(1)?.Data);
			vm2.RefreshData(configViewModel.GetItemByNum(2)?.Data);
			Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().SaveCarringBPs(vm1.Data, vm2.Data);
			refreshDataRequest.Raise();
		}
	}

	public void SetCanAdd(bool val)
	{
		canAdd = val;
		vm1.SetCanAdd(val);
		vm2.SetCanAdd(val);
	}

	public void RefreshMulti()
	{
		if (configViewModel != null)
		{
			vm1.RefreshData(configViewModel.GetItemByNum(1)?.Data);
			vm2.RefreshData(configViewModel.GetItemByNum(2)?.Data);
			refreshDataRequest.Raise();
		}
	}

	public TeamBPConfigViewModel(OptionBase parent, List<int> bpIds)
	{
		base.parent = parent;
		Dictionary<int, BPData> bPWarehouse = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPWarehouse();
		Dictionary<int, BPCarryItemViewModel> dictionary = new Dictionary<int, BPCarryItemViewModel>
		{
			{
				1,
				new BPCarryItemViewModel(null, (bpIds != null && bpIds.Count > 0 && bPWarehouse.ContainsKey(bpIds[0])) ? bPWarehouse[bpIds[0]] : null, 1)
			},
			{
				2,
				new BPCarryItemViewModel(null, (bpIds != null && bpIds.Count > 1 && bPWarehouse.ContainsKey(bpIds[1])) ? bPWarehouse[bpIds[1]] : null, 2)
			}
		};
		vm1 = dictionary[1];
		vm2 = dictionary[2];
		vm1.SetParent(this);
		vm2.SetParent(this);
		CheckOpen();
	}

	public void RefreshData(List<int> bpIds)
	{
		Dictionary<int, BPData> bPWarehouse = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPWarehouse();
		vm1.RefreshData((bpIds != null && bpIds.Count > 0 && bPWarehouse.ContainsKey(bpIds[0])) ? bPWarehouse[bpIds[0]] : null);
		vm2.RefreshData((bpIds != null && bpIds.Count > 1 && bPWarehouse.ContainsKey(bpIds[1])) ? bPWarehouse[bpIds[1]] : null);
	}

	public void ClearBP()
	{
		vm1.ClearData();
		vm2.ClearData();
		refreshDataRequest.Raise();
	}

	public void ClearBPType5()
	{
		vm1.ClearData();
		vm2.ClearData();
		configViewModel = null;
		refreshDataRequest.Raise();
	}

	public void Refresh(int copyId)
	{
		if (configViewModel != null)
		{
			vm1.RefreshData(configViewModel.GetItemByNum(1)?.Data);
			vm2.RefreshData(configViewModel.GetItemByNum(2)?.Data);
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCarringBPs(copyId, (vm1.Data != null) ? vm1.Data.TeamId : 0, (vm2.Data != null) ? vm2.Data.TeamId : 0);
			refreshDataRequest.Raise();
		}
	}

	public void RefreshCopyType5(int copyType)
	{
		if (configViewModel != null)
		{
			vm1.RefreshData(configViewModel.GetItemByNum(1)?.Data);
			vm2.RefreshData(configViewModel.GetItemByNum(2)?.Data);
			refreshDataRequest.Raise();
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is BPCarryItemViewModel bPCarryItemViewModel)
		{
			if (configViewModel == null)
			{
				configViewModel = new BattlePropConfigViewModel(parent, bPCarryItemViewModel, (vm1 == bPCarryItemViewModel) ? vm2 : vm1, vm1 == bPCarryItemViewModel);
			}
			else
			{
				configViewModel.RefreshOpen(bPCarryItemViewModel);
			}
			parent.ItemOnClick(configViewModel);
		}
	}

	public void RemoveCofigVM()
	{
		configViewModel = null;
	}

	public TeamBPConfigViewModel()
	{
	}

	public bool CheckBPEnough()
	{
		if (vm1 == null || vm1.Data == null || vm2 == null || vm2.Data == null)
		{
			return false;
		}
		if (vm1.Count >= vm1.Data.CarryMax)
		{
			return vm2.Count >= vm2.Data.CarryMax;
		}
		return false;
	}

	public bool CheckBPCountEnough()
	{
		if (vm1 == null || vm1.Data == null || vm2 == null || vm2.Data == null)
		{
			return false;
		}
		if (vm1.Count >= vm1.Data.CarryMax)
		{
			return vm2.Count < vm2.Data.CarryMax;
		}
		return true;
	}

	public List<int> GetBPIds()
	{
		List<int> list = new List<int>();
		if (vm1 == null || vm1.Data == null)
		{
			list.Add(0);
		}
		else
		{
			list.Add(vm1.Data.TeamId);
		}
		if (vm2 == null || vm2.Data == null)
		{
			list.Add(0);
		}
		else
		{
			list.Add(vm2.Data.TeamId);
		}
		return list;
	}
}
