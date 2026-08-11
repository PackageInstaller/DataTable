#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class BattlePropConfigViewModel : OptionBase
{
	private List<BPItemViewModel> bpItemVMs = new List<BPItemViewModel>();

	private SimpleCommand makeCommand;

	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private BPItemViewModel curSelect;

	private BPCarryItemViewModel item1;

	private BPCarryItemViewModel item2;

	private bool carrying;

	private int carryMax;

	private InteractionRequest refreshItemRequest = new InteractionRequest();

	public BPItemViewModel CurSelect
	{
		get
		{
			return curSelect;
		}
		private set
		{
			Set(ref curSelect, value, "CurSelect");
		}
	}

	public bool Carrying
	{
		get
		{
			return carrying;
		}
		private set
		{
			Set(ref carrying, value, "Carrying");
		}
	}

	public ICommand MakeCommand => makeCommand;

	public ICommand OptCommand => optCommand;

	public List<BPItemViewModel> BpItemVMs => bpItemVMs;

	public IInteractionRequest RefreshItemRequest => refreshItemRequest;

	public IInteractionRequest OptRequest => optRequest;

	public BattlePropConfigViewModel(OptionBase parent, BPCarryItemViewModel curSelect, BPCarryItemViewModel item2, bool selectItem1)
	{
		base.parent = parent;
		makeCommand = new SimpleCommand(OnMake);
		optCommand = new SimpleCommand<string>(OnOpt);
		item1 = (selectItem1 ? new BPCarryItemViewModel(this, curSelect.Data, curSelect.Num) : new BPCarryItemViewModel(this, item2.Data, item2.Num));
		this.item2 = (selectItem1 ? new BPCarryItemViewModel(this, item2.Data, item2.Num) : new BPCarryItemViewModel(this, curSelect.Data, curSelect.Num));
		List<BPData> allBPDatas = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetAllBPDatas();
		if (allBPDatas != null)
		{
			allBPDatas.Sort(new BPDataNewSort());
			for (int i = 0; i < allBPDatas.Count; i++)
			{
				if (!allBPDatas[i].IsLock)
				{
					BPItemViewModel bPItemViewModel = new BPItemViewModel(this, allBPDatas[i]);
					bpItemVMs.Add(bPItemViewModel);
					if (allBPDatas[i] == item1.Data)
					{
						bPItemViewModel.Num = item1.Num;
						SelectBPItem(bPItemViewModel);
					}
					if (allBPDatas[i] == this.item2.Data)
					{
						bPItemViewModel.Num = this.item2.Num;
					}
				}
			}
			SelectCarryItem(selectItem1 ? item1 : this.item2);
			if (item1.Data == null && bpItemVMs.Count > 0)
			{
				SelectBPItem(bpItemVMs[0]);
			}
			CheckCarry();
			return;
		}
		throw new Exception("战斗道具数据为空！");
	}

	public void RefreshOpen(BPCarryItemViewModel curSelect)
	{
		for (int i = 0; i < bpItemVMs.Count; i++)
		{
			if (bpItemVMs[i].Data == curSelect.Data)
			{
				SelectBPItem(bpItemVMs[i]);
				SelectCarryItem((item1.Data == curSelect.Data) ? item1 : item2);
			}
		}
		if (curSelect.Data == null && bpItemVMs.Count > 0)
		{
			SelectBPItem(bpItemVMs[0]);
			SelectCarryItem((item1.Data == curSelect.Data) ? item1 : item2);
		}
		CheckCarry();
	}

	private void OnOpt(string optName)
	{
		try
		{
			if ("OnCarry".Equals(optName))
			{
				if (Carrying)
				{
					return;
				}
				optCommand.Enabled = false;
				BPCarryItemViewModel bPCarryItemViewModel = (item1.IsSelect ? item1 : item2);
				BPCarryItemViewModel bPCarryItemViewModel2 = (item1.IsSelect ? item2 : item1);
				if (bPCarryItemViewModel2.Data == curSelect.Data)
				{
					bPCarryItemViewModel2.RefreshData(bPCarryItemViewModel.Data);
					bPCarryItemViewModel.RefreshData(curSelect.Data);
					curSelect.Num = bPCarryItemViewModel.Num;
					for (int i = 0; i < bpItemVMs.Count; i++)
					{
						if (bpItemVMs[i].Data == bPCarryItemViewModel2.Data)
						{
							bpItemVMs[i].Num = bPCarryItemViewModel2.Num;
						}
					}
					refreshItemRequest.Raise();
					optCommand.Enabled = true;
					CheckCarry();
					optRequest.Raise($"PlayConfig{(item1.IsSelect ? 1 : 2)}Effect");
					return;
				}
				if (bPCarryItemViewModel.Data != null)
				{
					for (int j = 0; j < bpItemVMs.Count; j++)
					{
						if (bpItemVMs[j].Data == bPCarryItemViewModel.Data)
						{
							bpItemVMs[j].Num = 0;
							break;
						}
					}
				}
				bPCarryItemViewModel.RefreshData(curSelect.Data);
				curSelect.Num = bPCarryItemViewModel.Num;
				refreshItemRequest.Raise();
				CheckCarry();
				optCommand.Enabled = true;
				optRequest.Raise($"PlayConfig{(item1.IsSelect ? 1 : 2)}Effect");
				return;
			}
			if ("OnRemove".Equals(optName))
			{
				if (!Carrying)
				{
					return;
				}
				optCommand.Enabled = false;
				BPCarryItemViewModel bPCarryItemViewModel3 = (item1.IsSelect ? item1 : item2);
				if (bPCarryItemViewModel3.Data != null)
				{
					for (int k = 0; k < bpItemVMs.Count; k++)
					{
						if (bpItemVMs[k].Data == bPCarryItemViewModel3.Data)
						{
							bpItemVMs[k].Num = 0;
							break;
						}
					}
					bPCarryItemViewModel3.RefreshData(null);
				}
				refreshItemRequest.Raise();
				CheckCarry();
				optCommand.Enabled = true;
				return;
			}
			optCommand.Enabled = true;
		}
		catch (Exception)
		{
		}
		optCommand.Enabled = true;
	}

	public BPCarryItemViewModel GetItemByNum(int num)
	{
		if (item1.Num == num)
		{
			return item1;
		}
		if (item2.Num == num)
		{
			return item2;
		}
		return null;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is BPItemViewModel bpItemViewModel)
		{
			SelectBPItem(bpItemViewModel);
			CheckCarry();
		}
		else if (obj is BPCarryItemViewModel carryItemVM)
		{
			SelectCarryItem(carryItemVM);
			CheckCarry();
		}
	}

	private void SelectCarryItem(BPCarryItemViewModel carryItemVM)
	{
		if (!carryItemVM.IsSelect)
		{
			carryItemVM.SetSelect(val: true);
			item2.SetSelect(item2 == carryItemVM);
			item1.SetSelect(item1 == carryItemVM);
		}
		if (carryItemVM.Data == null)
		{
			return;
		}
		for (int i = 0; i < bpItemVMs.Count; i++)
		{
			if (bpItemVMs[i].Data == carryItemVM.Data)
			{
				SelectBPItem(bpItemVMs[i]);
				break;
			}
		}
	}

	private void SelectBPItem(BPItemViewModel bpItemViewModel)
	{
		if (curSelect != null)
		{
			curSelect.IsSelect = false;
		}
		CurSelect = bpItemViewModel;
		curSelect.IsSelect = true;
	}

	private void CheckCarry()
	{
		if (curSelect == null)
		{
			Carrying = false;
		}
		else if (curSelect.Num > 0)
		{
			if (item1.Num == curSelect.Num && item1.IsSelect)
			{
				Carrying = true;
			}
			else if (item2.Num == curSelect.Num && item2.IsSelect)
			{
				Carrying = true;
			}
			else
			{
				Carrying = false;
			}
		}
		else
		{
			Carrying = false;
		}
	}

	public async void OnMake()
	{
		try
		{
			makeCommand.Enabled = false;
			DRBattlePropMake dataRow = GameEntry.DataTable.GetDataRow((DRBattlePropMake p) => p.Id == curSelect.Data.Id);
			if (dataRow == null || dataRow.Item.Count != dataRow.Num.Count)
			{
				Log.Error($"战斗道具合成表配置异常 ID：【{curSelect.Data.Id}】");
			}
			else
			{
				for (int num = 0; num < dataRow.Item.Count; num++)
				{
					KnapsackPropData prop = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(dataRow.Item[num]);
					if (prop == null || prop.Amount < dataRow.Num[num])
					{
						Toast.ShowInfo("素材不足");
						makeCommand.Enabled = true;
						return;
					}
				}
				if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().MakeBattleProp(CurSelect.Data.TeamId, 1))
				{
					CurSelect.Data.AddCount(1);
					if (curSelect.Num > 0)
					{
						if (item1.Num == curSelect.Num)
						{
							item1.RefreshData(CurSelect.Data);
						}
						if (item2.Num == curSelect.Num)
						{
							item2.RefreshData(CurSelect.Data);
						}
					}
					optRequest.Raise("PlayMakeSuccessEffect");
				}
			}
			makeCommand.Enabled = true;
		}
		catch (Exception)
		{
			if (makeCommand != null)
			{
				makeCommand.Enabled = true;
			}
		}
	}
}
