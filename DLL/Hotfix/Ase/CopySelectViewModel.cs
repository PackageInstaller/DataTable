#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CopySelectViewModel : OptionBase
{
	private CopyViewModel copyVm;

	private CopyEntryData red1;

	private CopyEntryData red2;

	private List<CopyGroupItemViewModel> cgroupVms1;

	private List<CopyGroupItemViewModel> cgroupVms2;

	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private bool isLight;

	private CopyFirstViewModel firstVM;

	private CopySecondType3ViewModel copySecondType3;

	private CopySecondType4ViewModel copySecondType4;

	private CopySecondType5ViewModel copySecondType5;

	private CopyTrainViewModel trainVM;

	private bool enablePlayEffect = true;

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public bool IsLight => isLight;

	public CopyViewModel CopyVm
	{
		get
		{
			return copyVm;
		}
		private set
		{
			Set(ref copyVm, value, "CopyVm");
		}
	}

	public CopyEntryData Red1
	{
		get
		{
			return red1;
		}
		private set
		{
			Set(ref red1, value, "Red1");
		}
	}

	public CopyEntryData Red2
	{
		get
		{
			return red2;
		}
		private set
		{
			Set(ref red2, value, "Red2");
		}
	}

	public List<CopyGroupItemViewModel> CgroupVms1 => cgroupVms1;

	public List<CopyGroupItemViewModel> CgroupVms2 => cgroupVms2;

	public CopySelectViewModel()
	{
	}

	public CopySelectViewModel(OptionBase parent)
	{
		base.parent = parent;
		copyVm = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		List<CopyEntryData> copyEntryDatas = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CopyEntryDatas;
		for (int i = 0; i < copyEntryDatas.Count; i++)
		{
			if (copyEntryDatas[i].EntryType == 1)
			{
				red1 = copyEntryDatas[i];
			}
			else if (copyEntryDatas[i].EntryType == 2)
			{
				red2 = copyEntryDatas[i];
			}
		}
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		isLight = true;
		cgroupVms1 = new List<CopyGroupItemViewModel>();
		cgroupVms2 = new List<CopyGroupItemViewModel>();
		List<CopyMainData> mainDataList = copyVm.MainDataList;
		for (int j = 0; j < mainDataList.Count; j++)
		{
			if (mainDataList[j].CopyType == 1)
			{
				cgroupVms1.Add(new CopyGroupItemViewModel(this, mainDataList[j]));
			}
			else if (mainDataList[j].CopyType == 2)
			{
				cgroupVms2.Add(new CopyGroupItemViewModel(this, mainDataList[j]));
			}
		}
	}

	public override async void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if ("OnMulti".Equals(optionArg.OptionName))
			{
				parent.ItemOnClick(optionArg);
			}
			else if ("Close".Equals(optionArg.OptionName))
			{
				enablePlayEffect = true;
				optRequest.Raise("PlayUnlockEffect");
			}
		}
		else if (obj is CopyGroupItemViewModel groupItemVm)
		{
			OpenCopyGroup(groupItemVm);
		}
		else if ("CloseFirst".Equals(obj))
		{
			enablePlayEffect = true;
			optRequest.Raise("PlayUnlockEffect");
			for (int i = 0; i < cgroupVms1.Count; i++)
			{
				cgroupVms1[i].SetSelect(isSelect: false);
			}
			optCommand.Enabled = true;
		}
		else if ("DisableCommand".Equals(obj))
		{
			optCommand.Enabled = false;
		}
	}

	private void OpenType3(CopyGroupItemViewModel groupItemVm)
	{
		if (groupItemVm.Data.MainId != 3)
		{
			return;
		}
		if (!copyVm.HasType3OpenCopy())
		{
			Toast.ShowInfo("暂无副本开放");
			optCommand.Enabled = true;
			return;
		}
		if (copyVm.GetType3CopyDatas() == null)
		{
			Toast.ShowInfo("暂无副本开放");
			optCommand.Enabled = true;
			return;
		}
		enablePlayEffect = false;
		copySecondType3 = new CopySecondType3ViewModel(this);
		openWindowRequest.Raise(new OpenViewArg(typeof(CopySecondType3Window), copySecondType3), delegate
		{
			optCommand.Enabled = true;
			copySecondType3 = null;
		});
	}

	private void OpenType4(CopyGroupItemViewModel groupItemVm)
	{
		if (groupItemVm.Data.MainId != 4)
		{
			return;
		}
		List<CopyTypeData> type4OpenCopy = copyVm.GetType4OpenCopy();
		if (type4OpenCopy != null)
		{
			enablePlayEffect = false;
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

	private async void OpenType5(CopyGroupItemViewModel groupItemVm)
	{
		if (groupItemVm.Data.MainId != 5)
		{
			return;
		}
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetRaceCopyInfo();
		loading.Dispose();
		int t5Zone = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().T5Zone;
		if (t5Zone != 0)
		{
			enablePlayEffect = false;
			copySecondType5 = new CopySecondType5ViewModel(this, t5Zone);
			openWindowRequest.Raise(new OpenViewArg(typeof(CopySecondType5Window), copySecondType5, "CopySelect"), delegate
			{
				optCommand.Enabled = true;
				copySecondType5 = null;
			});
		}
		else
		{
			Toast.ShowInfo("当前暂无副本开放！");
			optCommand.Enabled = true;
		}
	}

	private void OpenType99()
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

	private void OpenCopyGroup(CopyGroupItemViewModel groupItemVm)
	{
		if (!optCommand.Enabled)
		{
			if (firstVM == null)
			{
				return;
			}
			if (groupItemVm.Data.MainId == 3)
			{
				if (groupItemVm.Data.CopyTypeOpenDic.ContainsKey(copyVm.CopyType3CurId))
				{
					firstVM.OpenType3(groupItemVm.Data.CopyTypeOpenDic[copyVm.CopyType3CurId].CopyDataList);
				}
			}
			else if (groupItemVm.Data.MainId == 4)
			{
				firstVM.OpenType4(groupItemVm);
			}
			else if (groupItemVm.Data.MainId == 5)
			{
				firstVM.OpenType5();
			}
			else
			{
				firstVM.OpenCopyGroup(this, groupItemVm);
			}
			return;
		}
		optCommand.Enabled = false;
		try
		{
			if (groupItemVm.Data.MainId == 3)
			{
				OpenType3(groupItemVm);
				return;
			}
			if (groupItemVm.Data.MainId == 4)
			{
				OpenType4(groupItemVm);
				return;
			}
			if (groupItemVm.Data.MainId == 5)
			{
				OpenType5(groupItemVm);
				return;
			}
			if (firstVM == null)
			{
				List<CopyGroupItemViewModel> list = new List<CopyGroupItemViewModel>();
				for (int i = 0; i < cgroupVms1.Count; i++)
				{
					list.Add(cgroupVms1[i]);
				}
				for (int j = 0; j < cgroupVms2.Count; j++)
				{
					list.Add(cgroupVms2[j]);
				}
				firstVM = new CopyFirstViewModel(this, list);
			}
			firstVM.OpenCopyGroup(this, groupItemVm);
			enablePlayEffect = false;
			openWindowRequest.Raise(new OpenViewArg(typeof(CopyFirstWindow), firstVM), delegate
			{
				for (int k = 0; k < cgroupVms1.Count; k++)
				{
					cgroupVms1[k].SetSelect(isSelect: false);
				}
				for (int l = 0; l < cgroupVms2.Count; l++)
				{
					cgroupVms2[l].SetSelect(isSelect: false);
				}
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开副本一级界面发生异常！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OpenLight".Equals(optName))
		{
			if (isLight)
			{
				optCommand.Enabled = true;
				return;
			}
			optRequest.Raise(optName);
		}
		else if ("OpenDark".Equals(optName))
		{
			if (!isLight)
			{
				optCommand.Enabled = true;
				return;
			}
			optRequest.Raise(optName);
		}
		else if ("OpenTrain".Equals(optName))
		{
			OpenType99();
		}
		optCommand.Enabled = true;
	}

	public void EnableOpenMulti()
	{
		if (firstVM != null)
		{
			firstVM.EnableOpenMulti();
		}
		if (copySecondType3 != null)
		{
			copySecondType3.EnableOpenMulti();
		}
	}

	public void EnableEnterPlayEffect()
	{
		if (firstVM != null)
		{
			firstVM.EnableEnterPlayEffect();
		}
	}

	public void EnableOpt(bool isLight)
	{
		this.isLight = isLight;
	}

	public override void Dispose()
	{
		base.Dispose();
		CopyVm = null;
	}

	public bool CheckNeedPlayEffect()
	{
		if (!enablePlayEffect)
		{
			return false;
		}
		if (isLight)
		{
			for (int i = 0; i < cgroupVms1.Count; i++)
			{
				if (!cgroupVms1[i].Data.IsLock && !cgroupVms1[i].Data.HasPlayUnlock)
				{
					return true;
				}
			}
		}
		else
		{
			for (int j = 0; j < cgroupVms2.Count; j++)
			{
				if (!cgroupVms2[j].Data.IsLock && !cgroupVms2[j].Data.HasPlayUnlock)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void PlayUnlockEffect()
	{
		if (isLight)
		{
			for (int i = 0; i < cgroupVms1.Count; i++)
			{
				if (!cgroupVms1[i].Data.IsLock && !cgroupVms1[i].Data.HasPlayUnlock)
				{
					cgroupVms1[i].PlayUnlockEffect();
				}
			}
			return;
		}
		for (int j = 0; j < cgroupVms2.Count; j++)
		{
			if (!cgroupVms2[j].Data.IsLock && !cgroupVms2[j].Data.HasPlayUnlock)
			{
				cgroupVms2[j].PlayUnlockEffect();
			}
		}
	}
}
