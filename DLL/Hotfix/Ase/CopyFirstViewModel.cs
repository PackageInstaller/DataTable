#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CopyFirstViewModel : OptionBase
{
	private List<CopyGroupItemViewModel> groupList;

	private List<CopyGroupItemViewModel> oriGroupList;

	private List<CopyTypeItemViewModel> typeVms;

	private SimpleCommand optCommand;

	private Dictionary<int, CopyTypeItemViewModel> typeDics;

	private InteractionRequest<int> openGroupRequest;

	private InteractionRequest<string> optRequest;

	private CopySecondType2ViewModel copySecondType2;

	private CopySecondType3ViewModel copySecondType3;

	private CopySecondType4ViewModel copySecondType4;

	private CopySecondType5ViewModel copySecondType5;

	private CopyTrainViewModel trainVM;

	private CopyPermitViewModel permitVM;

	private CopyGroupItemViewModel curOpenGroup;

	private int copyMainId;

	private bool jumpToBackFlag;

	private bool enablePlayEffect = true;

	public List<CopyGroupItemViewModel> GroupList => groupList;

	public List<CopyTypeItemViewModel> TypeVms => typeVms;

	public int CopyMainId
	{
		get
		{
			return copyMainId;
		}
		private set
		{
			Set(ref copyMainId, value, "CopyMainId");
		}
	}

	public CopyPermitViewModel PermitVm => permitVM;

	public IInteractionRequest OpenGroupRequest => openGroupRequest;

	public IInteractionRequest OptRequest => optRequest;

	public CopyFirstViewModel(OptionBase parent, List<CopyGroupItemViewModel> groupList)
	{
		openGroupRequest = new InteractionRequest<int>();
		optRequest = new InteractionRequest<string>();
		base.parent = parent;
		oriGroupList = groupList;
		optCommand = new SimpleCommand(OnOpt);
		CheckGroupSystemOpen();
		CheckType2TimeLock();
	}

	public CopyFirstViewModel(OptionBase parent, int copyMainId)
	{
		openGroupRequest = new InteractionRequest<int>();
		optRequest = new InteractionRequest<string>();
		oriGroupList = new List<CopyGroupItemViewModel>();
		List<CopyMainData> mainDataList = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().MainDataList;
		CopyGroupItemViewModel groupItemVm = null;
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].CopyType == 1 || mainDataList[i].CopyType == 2)
			{
				oriGroupList.Add(new CopyGroupItemViewModel(this, mainDataList[i]));
				if (mainDataList[i].MainId == copyMainId)
				{
					groupItemVm = oriGroupList[i];
				}
			}
		}
		optCommand = new SimpleCommand(OnOpt);
		CheckGroupSystemOpen();
		CheckType2TimeLock();
		OpenCopyGroup(parent, groupItemVm);
	}

	private void AddGroupList()
	{
		if (groupList == null)
		{
			groupList = new List<CopyGroupItemViewModel>();
		}
		else
		{
			groupList.Clear();
		}
		for (int i = 0; i < oriGroupList.Count; i++)
		{
			if (!oriGroupList[i].Data.IsLock && oriGroupList[i].IsSystemOpen)
			{
				groupList.Add(oriGroupList[i]);
			}
		}
		optRequest.Raise("RefreshGroup");
	}

	public void CheckGroupSystemOpen()
	{
		for (int i = 0; i < oriGroupList.Count; i++)
		{
			oriGroupList[i].CheckSystemOpen();
		}
		AddGroupList();
	}

	private void OnOpt()
	{
	}

	public void JumpTo()
	{
		jumpToBackFlag = true;
		optCommand.Enabled = true;
		CheckGroupSystemOpen();
		for (int i = 0; i < groupList.Count; i++)
		{
			if (groupList[i].Data.MainId == copyMainId)
			{
				groupList[i].SetSelect(isSelect: true);
				if (copyMainId == 1)
				{
					OpenCopyGroup(parent, groupList[i]);
				}
			}
		}
		parent.ItemOnClick("DisableCommand");
	}

	public void OpenCopyGroup(OptionBase parent, CopyGroupItemViewModel groupItemVm)
	{
		base.parent = parent;
		if (curOpenGroup != null)
		{
			curOpenGroup.SetSelect(isSelect: false);
		}
		curOpenGroup = groupItemVm;
		groupItemVm.SetSelect(isSelect: true);
		copyMainId = groupItemVm.Data.MainId;
		if (typeDics == null)
		{
			typeDics = new Dictionary<int, CopyTypeItemViewModel>();
			typeVms = new List<CopyTypeItemViewModel>();
		}
		typeVms.Clear();
		foreach (KeyValuePair<int, CopyTypeData> item in groupItemVm.Data.CopyTypeOpenDic)
		{
			if (!typeDics.ContainsKey(item.Key))
			{
				CopyTypeItemViewModel value = new CopyTypeItemViewModel(this, item.Value);
				typeDics.Add(item.Key, value);
			}
			if (copyMainId == 1)
			{
				if (item.Value.IsLock)
				{
					continue;
				}
				for (int i = 0; i < item.Value.CopyDataList.Count; i++)
				{
					if (!item.Value.CopyDataList[i].IsLock)
					{
						typeVms.Add(typeDics[item.Key]);
						break;
					}
				}
			}
			else if (copyMainId == 2)
			{
				if (permitVM == null)
				{
					permitVM = new CopyPermitViewModel(this);
				}
				typeVms.Add(typeDics[item.Key]);
			}
		}
		if (copyMainId == 1)
		{
			typeVms.Sort(new CopyType1Sort());
		}
		else if (copyMainId == 2)
		{
			typeVms.Sort(new CopyType2Sort());
		}
		openGroupRequest.Raise(copyMainId);
	}

	private void OpenGroupItem(CopyGroupItemViewModel groupItemVm)
	{
		switch (groupItemVm.Data.MainId)
		{
		case 1:
		case 2:
			OpenCopyGroup(parent, groupItemVm);
			break;
		case 3:
		{
			CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
			OpenType3(groupItemVm.Data.CopyTypeOpenDic[copyVM.CopyType3CurId].CopyDataList);
			break;
		}
		case 4:
			OpenType4(groupItemVm);
			break;
		case 5:
			OpenType5();
			break;
		}
	}

	private void CheckType2TimeLock()
	{
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CheckType2TimeLock();
	}

	public void OpenType3(List<CopyData> copyList)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		try
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().HasType3OpenCopy())
			{
				Toast.ShowInfo("暂无副本开放");
				optCommand.Enabled = true;
				return;
			}
			copySecondType3 = new CopySecondType3ViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(CopySecondType3Window), copySecondType3), delegate
			{
				optCommand.Enabled = true;
				copySecondType3 = null;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开界面失败 ！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	public void OpenType4(CopyGroupItemViewModel groupItemVm)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		try
		{
			List<CopyTypeData> type4OpenCopy = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetType4OpenCopy();
			if (type4OpenCopy != null)
			{
				copySecondType4 = new CopySecondType4ViewModel(this, type4OpenCopy);
				openWindowRequest.Raise(new OpenViewArg(typeof(CopySecondType4Window), copySecondType4), delegate
				{
					optCommand.Enabled = true;
					copySecondType4 = null;
				});
			}
			else
			{
				Toast.ShowInfo("暂无开放副本！");
				optCommand.Enabled = true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开界面失败 ！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	public async void OpenType5()
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		Loading loading = await Loading.Show();
		try
		{
			await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRaceCopyInfo();
			int t5Zone = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().T5Zone;
			if (t5Zone != 0)
			{
				copySecondType5 = new CopySecondType5ViewModel(this, t5Zone);
				openWindowRequest.Raise(new OpenViewArg(typeof(CopySecondType5Window), copySecondType5, "CopyFirst"), delegate
				{
					optCommand.Enabled = true;
					copySecondType5 = null;
				});
			}
			else
			{
				optCommand.Enabled = true;
				Toast.ShowInfo("当前暂无副本开放！");
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开界面失败 ！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
		loading.Dispose();
	}

	public void OpenType99()
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		try
		{
			if (trainVM == null)
			{
				trainVM = new CopyTrainViewModel(this);
			}
			else
			{
				trainVM.SetParent(this);
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(CopyTrainWindow), trainVM), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开界面失败 ！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	public override async void ItemOnClick(object obj)
	{
		if (parent == this)
		{
			Log.Error("界面嵌套！");
			return;
		}
		base.ItemOnClick(obj);
		if (obj is CopyTypeItemViewModel copyTypeItemViewModel)
		{
			if (!copyTypeItemViewModel.Data.IsLock)
			{
				OpenCopyType(copyTypeItemViewModel);
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnMulti".Equals(optionArg.OptionName))
			{
				parent.ItemOnClick(optionArg);
			}
			else if (optionArg.Obj is CopySecondType1ViewModel && "Close".Equals(optionArg.OptionName))
			{
				enablePlayEffect = true;
				if (jumpToBackFlag)
				{
					openGroupRequest.Raise(copyMainId);
					jumpToBackFlag = false;
				}
			}
			else if (optionArg.Obj is CopySecondType2ViewModel && "Close".Equals(optionArg.OptionName))
			{
				enablePlayEffect = true;
			}
		}
		else if (obj is CopyGroupItemViewModel groupItemVm)
		{
			OpenGroupItem(groupItemVm);
		}
		else if (obj is BattleReadyViewModel)
		{
			parent.ItemOnClick(obj);
		}
		else if (obj is CopyST4EnterItemViewModel)
		{
			parent.ItemOnClick(obj);
		}
	}

	private void OpenCopyType(CopyTypeItemViewModel itemVm)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		try
		{
			if (copyMainId == 1)
			{
				optCommand.Enabled = false;
				enablePlayEffect = false;
				openWindowRequest.Raise(new OpenViewArg(typeof(CopySecondType1Window), new CopySecondType1ViewModel(this, itemVm.Data.CopyTypeId)), delegate
				{
					optCommand.Enabled = true;
				});
			}
			else if (copyMainId == 2)
			{
				optCommand.Enabled = false;
				enablePlayEffect = false;
				List<CopyTypeData> list = new List<CopyTypeData>();
				for (int num = 0; num < typeVms.Count; num++)
				{
					list.Add(typeVms[num].Data);
				}
				copySecondType2 = new CopySecondType2ViewModel(this, list, itemVm.Data);
				openWindowRequest.Raise(new OpenViewArg(typeof(CopySecondType2Window), copySecondType2), delegate
				{
					optCommand.Enabled = true;
				});
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开副本失败！ " + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	public override void Close()
	{
		permitVM?.RemoveListener();
		permitVM = null;
		if (parent != null)
		{
			parent.ItemOnClick("CloseFirst");
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CloseCheckType2TimeLock();
		base.Close();
	}

	public void EnableOpenMulti()
	{
		if (copySecondType2 != null)
		{
			copySecondType2.EnableOpenMulti();
		}
		if (copySecondType3 != null)
		{
			copySecondType3.EnableOpenMulti();
		}
	}

	public void EnableEnterPlayEffect()
	{
		if (copySecondType2 != null)
		{
			copySecondType2.EnableEnterPlayEffect();
		}
	}

	public bool CheckNeedPlayEffect()
	{
		if (!enablePlayEffect)
		{
			return false;
		}
		if (copyMainId == 1 || copyMainId == 2)
		{
			for (int i = 0; i < typeVms.Count; i++)
			{
				if (!typeVms[i].Data.IsLock && !typeVms[i].Data.HasPlayUnlock)
				{
					return true;
				}
			}
		}
		return false;
	}

	public int GetNewUnlockIndex()
	{
		if (copyMainId == 1 || copyMainId == 2)
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
		return 0;
	}

	public void PlayUnlockEffect()
	{
		if (copyMainId != 1 && copyMainId != 2)
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

	public float GetUnlockRatio()
	{
		if (copyMainId == 2)
		{
			int count = typeVms.Count;
			if (count == 0)
			{
				return 1f;
			}
			int num = 0;
			for (int i = 0; i < typeVms.Count && !typeVms[i].Data.IsLock; i++)
			{
				num++;
			}
			return (float)num * 1f / (float)count;
		}
		return 1f;
	}
}
