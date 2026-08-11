#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CopySecondType2ViewModel : CopyEnterViewModel
{
	private List<CopyTypeItemViewModel> typeVms;

	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private List<CopyItemViewModel> copyItemVms;

	private CopyItemDetail2ViewModel copyDetailVm;

	private CopyPermitViewModel permitVM;

	private bool isEnteringClose;

	private CopyTypeItemViewModel curSelectTypeItem;

	private CopyItemViewModel curSelectItem;

	private int nextSelIndex = -1;

	private int selectIndex;

	private bool isOpenDetail;

	private bool enablePlayEffect = true;

	public int NextSelIndex => nextSelIndex;

	public CopyPermitViewModel PermitVm => permitVM;

	public List<CopyItemViewModel> CopyItemVms => copyItemVms;

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<CopyTypeItemViewModel> TypeVms => typeVms;

	public CopyItemDetail2ViewModel CopyDetailVm => copyDetailVm;

	public CopyItemViewModel CurSelectItem => curSelectItem;

	public CopySecondType2ViewModel()
	{
	}

	public CopySecondType2ViewModel(OptionBase parent, List<CopyTypeData> copyTypeDatas, CopyTypeData selected)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		typeVms = new List<CopyTypeItemViewModel>();
		for (int i = 0; i < copyTypeDatas.Count; i++)
		{
			CopyTypeItemViewModel copyTypeItemViewModel = new CopyTypeItemViewModel(this, copyTypeDatas[i]);
			typeVms.Add(copyTypeItemViewModel);
			if (copyTypeItemViewModel.Data == selected)
			{
				copyTypeItemViewModel.SetSelect(isSelect: true);
				curSelectTypeItem = copyTypeItemViewModel;
			}
		}
		copyItemVms = new List<CopyItemViewModel>();
		List<CopyData> copyDataList = curSelectTypeItem.Data.CopyDataList;
		for (int j = 0; j < copyDataList.Count; j++)
		{
			copyItemVms.Add(new CopyItemViewModel(this, copyDataList[j], 2));
		}
		SetSelectCopyItem(curSelectTypeItem);
		permitVM = new CopyPermitViewModel(this);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CopyTypeItemViewModel itemVm)
		{
			SaveSelectItem();
			if (copyItemVms != null && copyItemVms.Count > 0)
			{
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CancelAllCopyTypeRed(copyItemVms[0].Data.CopyType);
			}
			OpenCopyType(itemVm);
		}
		else if (obj is CopyItemViewModel itemVm2)
		{
			OpenCopyDetail(itemVm2);
			UpdateItemRed(itemVm2);
		}
		else if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			if (receiveItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Equipment)
			{
				OpenArmourSampleView((ArmourData)receiveItemViewModel.PropDataBase);
				return;
			}
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
		else if ("OpenMulti".Equals(obj))
		{
			OpenMulti();
		}
		else if ("ReturnMulti".Equals(obj))
		{
			OpenMulti(isReturn: true);
		}
		else if (obj is OptionArg optionArg)
		{
			if ("AfterPlayNewUnlockEffect".Equals(optionArg.OptionName))
			{
				AfterPlayNewUnlockEffect((CopyItemViewModel)optionArg.Obj);
			}
			else if (optionArg.Obj is BattleReadyViewModel && "Close".Equals(optionArg.OptionName))
			{
				if (isEnteringClose)
				{
					return;
				}
				enablePlayEffect = true;
				int num = selectIndex;
				SelcetNewOpen();
				if (num != selectIndex)
				{
					optRequest.Raise("RefreshCopyList");
				}
				optRequest.Raise("CheckLeftTabPlayUnlockEffect");
			}
		}
		base.ItemOnClick(obj);
	}

	protected override void SetEnterBattle()
	{
		isEnteringClose = true;
	}

	private void SaveSelectItem(CopyItemViewModel itemVM)
	{
		if (itemVM != null)
		{
			Singleton<ServiceSystem>.Instance?.GetService<ICopyService>()?.GetCopyVM()?.SaveLastSelectCopyId(itemVM.Data);
		}
	}

	public void SaveSelectItem()
	{
		if (curSelectItem != null && !curSelectItem.Data.IsLock)
		{
			SaveSelectItem(curSelectItem);
		}
	}

	private void AfterPlayNewUnlockEffect(CopyItemViewModel copyItemVM)
	{
	}

	private void UpdateItemRed(CopyItemViewModel itemVm)
	{
		if (itemVm.Data.HasNew)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().UpdateSingleCopyRed(itemVm.Data, isRed: false);
		}
	}

	public void JumpTo(bool selectNewOpen)
	{
		if (selectNewOpen)
		{
			SelcetNewOpen();
		}
		copyDetailVm.RefreshDropRank();
	}

	private void SelcetNewOpen()
	{
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (!copyItemVms[i].Data.IsLock && !copyItemVms[i].Data.HasPlayUnlock)
			{
				if (i != selectIndex)
				{
					SetSelectIndex(i);
					ItemOnClick(copyItemVms[i]);
				}
				break;
			}
		}
	}

	private void OpenCopyType(CopyTypeItemViewModel itemVm)
	{
		curSelectTypeItem.SetSelect(isSelect: false);
		curSelectTypeItem = itemVm;
		curSelectTypeItem.SetSelect(isSelect: true);
		copyItemVms.Clear();
		List<CopyData> copyDataList = curSelectTypeItem.Data.CopyDataList;
		for (int i = 0; i < copyDataList.Count; i++)
		{
			copyItemVms.Add(new CopyItemViewModel(this, copyDataList[i], 2));
		}
		SetSelectCopyItem(itemVm);
		optRequest.Raise("RefreshCopyItems");
	}

	private void SetSelectCopyItem(CopyTypeItemViewModel itemVm)
	{
		if (copyItemVms.Count <= 0)
		{
			return;
		}
		int index = 0;
		int num = -1;
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (!copyItemVms[i].Data.IsLock && !copyItemVms[i].Data.HasPlayUnlock)
			{
				num = Mathf.Max(i, num);
			}
		}
		if (num == -1)
		{
			int lastSelectCopyId = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetLastSelectCopyId(itemVm.Data);
			bool flag = false;
			for (int j = 0; j < copyItemVms.Count; j++)
			{
				if (copyItemVms[j].Data.Id == lastSelectCopyId)
				{
					if (!copyItemVms[j].Data.IsLock)
					{
						index = j;
						flag = true;
					}
					break;
				}
			}
			if (!flag)
			{
				int num2 = -1;
				for (int k = 0; k < copyItemVms.Count; k++)
				{
					if (!copyItemVms[k].Data.IsLock && copyItemVms[k].Data.HasPlayUnlock)
					{
						num2 = Mathf.Max(k, num2);
					}
				}
				index = num2;
			}
		}
		else
		{
			index = num;
		}
		copyItemVms[index].SetSelect(isSelect: true);
		SetCurSelectItemOpenState(copyItemVms[index], isOpenDetail);
		curSelectItem = copyItemVms[index];
		selectIndex = index;
	}

	private void OpenCopyDetail(CopyItemViewModel itemVm)
	{
		if (curSelectItem == null || !curSelectItem.IsSelect)
		{
			Log.Error("选中数据异常！");
		}
		else if (curSelectItem != itemVm)
		{
			_ = selectIndex;
			int num = -1;
			for (int i = 0; i < copyItemVms.Count; i++)
			{
				if (itemVm == copyItemVms[i])
				{
					num = i;
					break;
				}
			}
			if (num != -1 && num != selectIndex)
			{
				nextSelIndex = num;
				optRequest.Raise("AutoPlay2Click");
				isOpenDetail = true;
			}
		}
		else
		{
			if (copyDetailVm == null)
			{
				copyDetailVm = new CopyItemDetail2ViewModel(this);
			}
			bool num2 = copyDetailVm.Data == curSelectItem.Data && isOpenDetail;
			copyDetailVm.RefreshData(curSelectItem.Data);
			isOpenDetail = true;
			SetCurSelectItemOpenState(curSelectItem, isOpenDetail);
			if (!num2)
			{
				optRequest.Raise("OpenDetail");
			}
		}
	}

	public void OpenDetailState()
	{
		isOpenDetail = true;
		SetCurSelectItemOpenState(curSelectItem, isOpenDetail);
	}

	private void OpenSingle(bool isReturn = false)
	{
		if (!optCommand.Enabled || CopyEntryLimitHelper.TryBlockEntry(copyDetailVm.Data, isMulti: false))
		{
			return;
		}
		optCommand.Enabled = false;
		enablePlayEffect = false;
		try
		{
			BattleReadyViewModel userData = new BattleReadyViewModel(this, new BattleReadyData((!copyDetailVm.Data.IsNeedFirst || copyDetailVm.Data.IsAccessed) ? BattleReadyTarget.Copy : BattleReadyTarget.CopyFirstPass, copyDetailVm.Data.Id), isReturn);
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

	private void OpenArmourSampleView(ArmourData armourData)
	{
		ArmourPopupViewModel userData = new ArmourPopupViewModel(this, armourData);
		openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPopupSampleView), userData));
	}

	private async void OpenMulti(bool isReturn = false)
	{
		if (!optCommand.Enabled || CopyEntryLimitHelper.TryBlockEntry(curSelectItem.Data, isMulti: true))
		{
			return;
		}
		optCommand.Enabled = false;
		enablePlayEffect = false;
		try
		{
			Loading loading = await Loading.Show();
			await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().CreateMultiRoom(curSelectItem.Data, isReturn);
			loading.Dispose();
			optCommand.Enabled = true;
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	public void EnableOpenMulti()
	{
		optCommand.Enabled = true;
	}

	public int GetSelectIndex()
	{
		return selectIndex;
	}

	public List<int> GetShowList(int showMaxCount)
	{
		List<int> list = new List<int>();
		list.Add(selectIndex);
		int count = copyItemVms.Count;
		int num = showMaxCount / 2;
		for (int i = selectIndex + 1; i < count; i++)
		{
			list.Add(i);
			num--;
			if (num == 0)
			{
				break;
			}
		}
		num = showMaxCount / 2;
		for (int num2 = selectIndex - 1; num2 >= 0; num2--)
		{
			list.Insert(0, num2);
			num--;
			if (num == 0)
			{
				break;
			}
		}
		return list;
	}

	public void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("CloseDetail".Equals(optName))
		{
			isOpenDetail = false;
			SetCurSelectItemOpenState(curSelectItem, isOpenDetail);
			optRequest.Raise(optName);
		}
		optCommand.Enabled = true;
	}

	public override void Close()
	{
		if (isOpenDetail)
		{
			optRequest.Raise("CloseDetail");
			isOpenDetail = false;
			SetCurSelectItemOpenState(curSelectItem, isOpenDetail);
			optRequest.Raise("CheckLeftTabPlayUnlockEffect");
			return;
		}
		if (copyItemVms != null && copyItemVms.Count > 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CancelAllCopyTypeRed(copyItemVms[0].Data.CopyType);
		}
		SaveSelectItem();
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		permitVM?.RemoveListener();
		permitVM = null;
		dismissRequest.Raise();
		Dispose();
	}

	private void SetCurSelectItemOpenState(CopyItemViewModel copyItemVM, bool isOpenDetail)
	{
		if (copyItemVM != null && curSelectItem != null)
		{
			curSelectItem.SetOpenDetail(copyItemVM.IsSelect & isOpenDetail);
		}
	}

	public void SetSelectIndex(int index)
	{
		if (copyItemVms.Count <= index)
		{
			return;
		}
		if (selectIndex != index)
		{
			curSelectItem?.SetSelect(isSelect: false);
			SetCurSelectItemOpenState(curSelectItem, isOpenDetail);
		}
		copyItemVms[index].SetSelect(isSelect: true);
		curSelectItem = copyItemVms[index];
		selectIndex = index;
		SetCurSelectItemOpenState(copyItemVms[index], isOpenDetail);
		if (copyDetailVm == null)
		{
			copyDetailVm = new CopyItemDetail2ViewModel(this);
		}
		bool flag = curSelectItem.Data == copyDetailVm.Data;
		copyDetailVm.RefreshData(curSelectItem.Data);
		if (isOpenDetail)
		{
			UpdateItemRed(curSelectItem);
			if (!flag)
			{
				optRequest.Raise("OpenDetail");
			}
		}
		SaveSelectItem();
	}

	public int GetSelectTypeIndex()
	{
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (typeVms[i].IsSelect)
			{
				return i;
			}
		}
		return 0;
	}

	public int GetTypeOpenCount()
	{
		int num = 0;
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (!typeVms[i].Data.IsLock)
			{
				num++;
			}
		}
		return num;
	}

	public CopyTypeItemViewModel GetCopyTypeByIndex(int index)
	{
		int num = -1;
		for (int num2 = typeVms.Count - 1; num2 >= 0; num2--)
		{
			if (!typeVms[num2].Data.IsLock)
			{
				num++;
			}
			if (num == index)
			{
				return typeVms[num2];
			}
		}
		return null;
	}

	public void EnableOpt(bool isLight)
	{
		optCommand.Enabled = true;
	}

	public void EnableEnterPlayEffect()
	{
		enablePlayEffect = true;
		optRequest.Raise("CheckLeftTabPlayUnlockEffect");
	}

	public void Return2PlayEffect(bool enable)
	{
		enablePlayEffect = enable;
		isEnteringClose = false;
	}

	public int GetCurTypeMaxIndex()
	{
		int num = 0;
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (!typeVms[i].Data.IsLock && !typeVms[i].Data.HasPlayUnlock)
			{
				num = Mathf.Max(num, i);
			}
		}
		return num;
	}

	public bool CheckNeedPlayLeftTabEffect()
	{
		if (isOpenDetail || !enablePlayEffect)
		{
			return false;
		}
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (!typeVms[i].Data.IsLock && !typeVms[i].Data.HasPlayUnlock)
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckNeedPlayMiddleEffect()
	{
		if (!enablePlayEffect)
		{
			return false;
		}
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (!copyItemVms[i].Data.IsLock && !copyItemVms[i].Data.HasPlayUnlock)
			{
				return true;
			}
		}
		return false;
	}

	public void PlayLeftUnlockEffect()
	{
		if (isOpenDetail)
		{
			return;
		}
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (!typeVms[i].Data.IsLock && !typeVms[i].Data.HasPlayUnlock)
			{
				typeVms[i].PlayUnlockEffect();
			}
		}
	}

	public void PlayMiddleUnlockEffect()
	{
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (!copyItemVms[i].Data.IsLock && !copyItemVms[i].Data.HasPlayUnlock)
			{
				copyItemVms[i].PlayUnlockEffect();
			}
		}
	}
}
