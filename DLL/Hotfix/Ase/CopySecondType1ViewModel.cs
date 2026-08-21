#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CopySecondType1ViewModel : CopyEnterViewModel
{
	private CopyItemDetail1ViewModel copyDetailVm;

	private List<CopyItemViewModel> copyItemVms;

	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private InteractionRequest refreshCopyTypeRequest;

	private List<CopyData> copyDatas;

	private CopyMaterialSortViewModel sortVM;

	private CopyItemViewModel curSelectItem;

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<CopyItemViewModel> CopyItemVms => copyItemVms;

	public CopyItemDetail1ViewModel CopyDetailVm => copyDetailVm;

	public CopyMaterialSortViewModel SortVm => sortVM;

	public CopyItemViewModel CurSelectItem => curSelectItem;

	public CopySecondType1ViewModel()
	{
	}

	public CopySecondType1ViewModel(OptionBase parent, int copyTypeId, int materialTypeId = -1)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		copyItemVms = new List<CopyItemViewModel>();
		copyDatas = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyTypeById(copyTypeId)
			.CopyDataList;
		copyDatas.Sort(new CopyDataSort());
		for (int i = 0; i < copyDatas.Count; i++)
		{
			CopyItemViewModel item = new CopyItemViewModel(this, copyDatas[i]);
			copyItemVms.Add(item);
			if (!copyDatas[i].IsAccessed)
			{
				break;
			}
		}
		int copyType = 0;
		if (copyItemVms.Count > 0)
		{
			copyType = copyItemVms[0].Data.CopyType;
		}
		int num = materialTypeId;
		if (num == -1)
		{
			num = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetSortId(copyType);
		}
		sortVM = new CopyMaterialSortViewModel(this);
		if (copyItemVms.Count > 0)
		{
			sortVM.SetSortGroup(copyItemVms[0].Data.Drops);
		}
		sortVM.SetMaterial(num);
		for (int j = 0; j < copyItemVms.Count; j++)
		{
			copyItemVms[j].SetMaterial(num);
		}
		SaveSort(sortVM.Item1);
	}

	public void JumpTo()
	{
		optCommand.Enabled = true;
		copyItemVms.Clear();
		for (int i = 0; i < copyDatas.Count; i++)
		{
			CopyItemViewModel item = new CopyItemViewModel(this, copyDatas[i]);
			copyItemVms.Add(item);
			if (!copyDatas[i].IsAccessed)
			{
				break;
			}
		}
		for (int j = 0; j < copyItemVms.Count; j++)
		{
			if (curSelectItem != null && copyItemVms[j].Data == curSelectItem.Data)
			{
				curSelectItem = copyItemVms[j];
				curSelectItem.SetSelect(isSelect: true);
			}
			copyItemVms[j].SetMaterial(sortVM.SortMaterialType);
		}
		copyDetailVm.RefreshDropRank();
	}

	public override void ItemOnClick(object obj)
	{
		if (!(obj is OptionArg))
		{
			if (obj is CopyItemViewModel copyItemViewModel)
			{
				OpenCopyDetail(copyItemViewModel);
				if (copyItemViewModel.Data.HasNew)
				{
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().UpdateSingleCopyRed(copyItemViewModel.Data, isRed: false);
				}
			}
			else if (obj is CMSortItemViewModel sortItemVm)
			{
				SortCopy(sortItemVm);
				SaveSort(sortItemVm);
			}
			else if (obj is ReceiveItemViewModel receiveItemViewModel)
			{
				OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
				if (openViewArg != null)
				{
					openWindowRequest.Raise(openViewArg);
				}
			}
			else if ("OpenSingle".Equals(obj))
			{
				OpenSingle();
			}
			else if ("ReturnSingle".Equals(obj))
			{
				OpenSingle(isReturn: true);
			}
		}
		base.ItemOnClick(obj);
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (jumpParams.WindowName.Equals("CopySecondType1Window"))
		{
			if (jumpParams.Args != null && jumpParams.Args.Count > 0)
			{
				int num = ((jumpParams.Args.Count > 0) ? ((int)jumpParams.Args[0]) : 0);
				int num2 = ((jumpParams.Args.Count > 1) ? ((int)jumpParams.Args[1]) : (-1));
				if (num != curSelectItem.Data.CopyType)
				{
					copyDatas = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyTypeById(num)
						.CopyDataList;
					copyDatas.Sort(new CopyDataSort());
					JumpTo();
					optRequest.Raise("RefreshCopyType");
				}
				if (num2 != -1)
				{
					sortVM.SetMaterial(num2);
					for (int i = 0; i < copyItemVms.Count; i++)
					{
						copyItemVms[i].SetMaterial(num2);
					}
				}
			}
			optionBase.Close();
			OnOpt("CloseDetail");
			return false;
		}
		return true;
	}

	private void OpenSingle(bool isReturn = false)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		try
		{
			BattleReadyViewModel userData = new BattleReadyViewModel(this, new BattleReadyData((!copyDetailVm.Data.IsNeedFirst || copyDetailVm.Data.IsAccessed) ? BattleReadyTarget.Copy : BattleReadyTarget.CopyFirstPass, copyDetailVm.Data.Id, sortVM.SortMaterialType), isReturn);
			openWindowRequest.Raise(new OpenViewArg(typeof(BattleReadyWindow), userData), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private void OpenCopyDetail(CopyItemViewModel itemVm)
	{
		if (curSelectItem != null)
		{
			if (curSelectItem == itemVm)
			{
				return;
			}
			curSelectItem.SetSelect(isSelect: false);
		}
		curSelectItem = itemVm;
		curSelectItem.SetSelect(isSelect: true);
		if (copyDetailVm == null)
		{
			copyDetailVm = new CopyItemDetail1ViewModel(this);
		}
		copyDetailVm.RefreshData(curSelectItem.Data, sortVM.SortMaterialType);
		optRequest.Raise("OpenDetail");
	}

	public int GetCurSelectIndex()
	{
		if (curSelectItem == null)
		{
			return 0;
		}
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (curSelectItem == copyItemVms[i])
			{
				return i;
			}
		}
		return 0;
	}

	private void SortCopy(CMSortItemViewModel sortItemVm)
	{
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			copyItemVms[i].SetMaterial(sortItemVm.DropTypeId);
		}
		if (copyDetailVm != null)
		{
			copyDetailVm.GetCopyDrops(sortItemVm.DropTypeId);
		}
	}

	private void SaveSort(CMSortItemViewModel sortItemVm)
	{
		int num = 0;
		if (copyItemVms.Count > 0)
		{
			num = copyItemVms[0].Data.CopyType;
		}
		if (num > 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().SaveSortDatas(num, sortItemVm.DropTypeId);
		}
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("CloseDetail".Equals(optName))
		{
			if (curSelectItem != null)
			{
				curSelectItem.SetSelect(isSelect: false);
				curSelectItem = null;
			}
			optRequest.Raise(optName);
		}
		optCommand.Enabled = true;
	}

	public void EnableOpt(bool isLight)
	{
		optCommand.Enabled = true;
	}

	public override void Close()
	{
		if (copyDatas != null && copyDatas.Count > 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CancelAllCopyTypeRed(copyDatas[0].CopyType);
		}
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}
}
