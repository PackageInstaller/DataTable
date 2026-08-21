#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CopySecondType4ViewModel : CopyEnterViewModel
{
	private SimpleCommand<string> optCommand;

	private InteractionRequest<string> optRequest;

	private List<CopyTypeItemViewModel> typeVms;

	private List<CopyItemViewModel> copyItemVms;

	private string buffIcon;

	private string buffDesc;

	private string propIcon = "";

	private int starMax;

	private int starConfigMax;

	private bool red;

	private string timeLeft = "";

	private CopyTypeItemViewModel curTypeSelect;

	private CopyST4RewardViewModel rewardVM;

	private CopyST4EnterItemViewModel enterItemVM;

	private int curZone;

	private Dictionary<int, int> zoneStar = new Dictionary<int, int>();

	private Action closeChildAction;

	private bool isSave;

	private Dictionary<int, List<CopyReward4ItemViewModel>> rewardVmList = new Dictionary<int, List<CopyReward4ItemViewModel>>();

	private CopyViewModel copyVM;

	public string BuffDesc
	{
		get
		{
			return buffDesc;
		}
		private set
		{
			Set(ref buffDesc, value, "BuffDesc");
		}
	}

	public string PropIcon
	{
		get
		{
			return propIcon;
		}
		private set
		{
			Set(ref propIcon, value, "PropIcon");
		}
	}

	public string BuffIcon
	{
		get
		{
			return buffIcon;
		}
		private set
		{
			Set(ref buffIcon, value, "BuffIcon");
		}
	}

	public int StarMax
	{
		get
		{
			return starMax;
		}
		private set
		{
			Set(ref starMax, value, "StarMax");
		}
	}

	public int StarConfigMax
	{
		get
		{
			return starConfigMax;
		}
		private set
		{
			Set(ref starConfigMax, value, "StarConfigMax");
		}
	}

	public string TimeLeft
	{
		get
		{
			return timeLeft;
		}
		private set
		{
			Set(ref timeLeft, value, "TimeLeft");
		}
	}

	public bool Red
	{
		get
		{
			return red;
		}
		private set
		{
			Set(ref red, value, "Red");
		}
	}

	public ICommand OptCommand => optCommand;

	public List<CopyItemViewModel> CopyItemVms => copyItemVms;

	public IInteractionRequest OptRequest => optRequest;

	public List<CopyTypeItemViewModel> TypeVms => typeVms;

	public CopyST4RewardViewModel RewardVm => rewardVM;

	public CopySecondType4ViewModel()
	{
	}

	public CopySecondType4ViewModel(OptionBase parent, List<CopyTypeData> copyTypeDatas)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		typeVms = new List<CopyTypeItemViewModel>();
		copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		copyItemVms = new List<CopyItemViewModel>();
		RefreshAllCopys(copyTypeDatas);
		if (curTypeSelect.Data.EndTime == 0L)
		{
			TimeLeft = "";
		}
		else
		{
			TimeLeft = Utility.DateTime.GetLeftDateHourExact(curTypeSelect.Data.EndTime - copyVM.GetCurTime(), "dd\\天hh\\时mm\\分") + "钟";
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().typeRefreshAction = async delegate(long curTime)
		{
			if (curTypeSelect != null)
			{
				if (curTypeSelect.Data.EndTime == 0L)
				{
					TimeLeft = "";
				}
				else if (copyVM.CheckTypeOpen(curTypeSelect.Data))
				{
					SetTimeLeft(curTime);
				}
				else
				{
					int curSelId = 0;
					if (curTypeSelect != null)
					{
						curSelId = curTypeSelect.Data.CopyTypeId;
					}
					typeVms.Clear();
					copyItemVms.Clear();
					List<CopyTypeData> copyTypeDatasNew = copyVM.GetType4OpenCopy();
					if (copyTypeDatasNew != null)
					{
						RefreshAllCopys(copyTypeDatasNew);
						await GetZoneStar();
						GetZoneReward(curTypeSelect.Data);
						optRequest.Raise("RefreshCopyList");
						optRequest.Raise("RefreshCopyTypeList");
						bool flag = false;
						for (int i = 0; i < copyTypeDatasNew.Count; i++)
						{
							if (curSelId == copyTypeDatasNew[i].CopyTypeId)
							{
								flag = true;
							}
						}
						if (!flag)
						{
							rewardVM?.Close();
							closeChildAction?.Invoke();
						}
					}
					else
					{
						rewardVM?.Close();
						closeChildAction?.Invoke();
						Close();
					}
				}
			}
			else
			{
				TimeLeft = "";
			}
		};
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (jumpParams.WindowName.Equals("CopySecondType4Window"))
		{
			optionBase.Close();
			rewardVM?.Close();
			return false;
		}
		return true;
	}

	public async Task OnJump()
	{
		BackRefreshStar();
		await GetZoneStar();
		GetZoneReward(curTypeSelect.Data);
		CheckOpenRecordView();
		CheckCopyTypeUnlock();
	}

	private void CheckCopyTypeUnlock()
	{
		int copyType4ZoneOpen = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyType4ZoneOpen();
		for (int i = 0; i < typeVms.Count; i++)
		{
			typeVms[i].Data.Type4SetLockPrevious(typeVms[i].Data.Zone > copyType4ZoneOpen);
		}
	}

	private void CheckOpenRecordView()
	{
		CopyType4RecordData type4RecordData = copyVM.GetType4RecordData();
		if (type4RecordData != null)
		{
			CopyType4RecordViewModel userData = new CopyType4RecordViewModel(this, type4RecordData.typeData, type4RecordData.copyAccessIndex, type4RecordData.starGet, type4RecordData.starAll);
			openWindowRequest.Raise(new OpenViewArg(typeof(CopyType4RecordView), userData, "Default", isOpenWindow: false));
		}
	}

	public void RefreshAllCopys(List<CopyTypeData> copyTypeDatas)
	{
		for (int i = 0; i < copyTypeDatas.Count; i++)
		{
			List<CopyData> copyDataList = copyTypeDatas[i].CopyDataList;
			bool isComplete = copyDataList.Count != 0;
			for (int j = 0; j < copyDataList.Count; j++)
			{
				if (!copyDataList[j].IsAccessed)
				{
					isComplete = false;
					break;
				}
			}
			CopyTypeItemViewModel item = new CopyTypeItemViewModel(this, copyTypeDatas[i], isComplete);
			typeVms.Add(item);
		}
		int index = 0;
		for (int k = 0; k < typeVms.Count; k++)
		{
			if (!typeVms[k].IsComplete)
			{
				index = k;
				break;
			}
		}
		typeVms[index].SetSelect(isSelect: true);
		List<CopyData> copyDataList2 = typeVms[index].Data.CopyDataList;
		for (int l = 0; l < copyDataList2.Count; l++)
		{
			bool flag = false;
			for (int m = 0; m < copyItemVms.Count; m++)
			{
				if (copyItemVms[m].AddCopyData(copyDataList2[l]))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				copyItemVms.Add(new CopyItemViewModel(this, copyDataList2[l], 4));
			}
		}
		CalcuStar();
		curTypeSelect = typeVms[index];
		SetTimeLeft(copyVM.GetCurTime());
		GetZoneBuff(typeVms[index].Data);
		curZone = typeVms[index].Data.Zone;
	}

	public List<CopyData> GetCopyList(int copyId)
	{
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			if (copyItemVms[i].CheckCopyDataIn(copyId))
			{
				return copyItemVms[i].GetCopyDatas();
			}
		}
		return null;
	}

	private void SetTimeLeft(long curTime)
	{
		if (curTypeSelect.Data.EndTime == 0L)
		{
			TimeLeft = "";
			return;
		}
		long leftTime = curTypeSelect.Data.EndTime - curTime;
		TimeLeft = Utility.DateTime.GetLeftDateHourExact(leftTime, "dd\\天hh\\时mm\\分") + "钟";
	}

	public async Task GetZoneStar(bool force = false)
	{
		if (!force && zoneStar.ContainsKey(curZone))
		{
			StarMax = copyVM.GetZoneStartMax(curZone);
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetFloorCopyRewardInfo(curZone);
			StarMax = copyVM.GetZoneStartMax(curZone);
			if (zoneStar.ContainsKey(curZone))
			{
				zoneStar[curZone] = 0;
			}
			else
			{
				zoneStar.Add(curZone, 0);
			}
		}
		catch (Exception)
		{
		}
		loading.Dispose();
	}

	public void CalcuStar()
	{
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			copyItemVms[i].CalcuStar();
		}
		int num = 0;
		int num2 = 0;
		for (int j = 0; j < copyItemVms.Count; j++)
		{
			num += copyItemVms[j].StarMax;
			num2 += copyItemVms[j].StarConfigMax;
		}
		StarConfigMax = num2;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is CopyTypeItemViewModel itemTypeVm)
		{
			SelectCopyType(itemTypeVm);
		}
		else if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is CopyItemViewModel copyItemViewModel)
		{
			if (copyItemViewModel.Data.IsLock)
			{
				Toast.ShowInfo("完成上个黯隙后解锁");
				return;
			}
			SelectCopy(copyItemViewModel);
		}
		else if (obj is CopyST4EnterItemViewModel copyST4EnterItemViewModel)
		{
			enterItemVM = copyST4EnterItemViewModel;
			parent.ItemOnClick(obj);
		}
		else if (obj is CopyReward4ItemViewModel reward4ItemVm)
		{
			GetRewards(reward4ItemVm);
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("EnterResult"))
			{
				SetEnterResult((bool)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("CalStar"))
			{
				CalStar();
			}
		}
		base.ItemOnClick(obj);
	}

	private void SetEnterResult(bool enter)
	{
		if (!enter)
		{
			enterItemVM = null;
		}
		else
		{
			isSave = true;
		}
	}

	private async UniTask SelectCopy(CopyItemViewModel itemVm)
	{
		optCommand.Enabled = false;
		try
		{
			List<CopyData> copyDatas = itemVm.GetCopyDatas();
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetType4CopySettingInfos(copyDatas)))
			{
				Log.Error("获取深渊副本组队配置失败");
			}
			CopyST4EnterViewModel enter = new CopyST4EnterViewModel(this, copyDatas);
			closeChildAction = (Action)Delegate.Combine(closeChildAction, new Action(enter.Close));
			openWindowRequest.Raise(new OpenViewArg(typeof(CopyST4EnterWindow), enter), delegate
			{
				closeChildAction = (Action)Delegate.Remove(closeChildAction, new Action(enter.Close));
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开深渊本界面失败！" + ex.Message + "/" + ex.StackTrace);
			optCommand.Enabled = true;
		}
		optCommand.Enabled = true;
	}

	private async Task SelectCopyType(CopyTypeItemViewModel itemTypeVm)
	{
		for (int i = 0; i < typeVms.Count; i++)
		{
			if (typeVms[i].IsSelect && itemTypeVm == typeVms[i])
			{
				return;
			}
			if (typeVms[i].IsSelect)
			{
				typeVms[i].SetSelect(isSelect: false);
				break;
			}
		}
		itemTypeVm.SetSelect(isSelect: true);
		curZone = itemTypeVm.Data.Zone;
		await GetZoneStar();
		copyItemVms.Clear();
		List<CopyData> copyDataList = itemTypeVm.Data.CopyDataList;
		for (int j = 0; j < copyDataList.Count; j++)
		{
			bool flag = false;
			for (int k = 0; k < copyItemVms.Count; k++)
			{
				if (copyItemVms[k].AddCopyData(copyDataList[j]))
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				copyItemVms.Add(new CopyItemViewModel(this, copyDataList[j], 4));
			}
		}
		CalcuStar();
		curTypeSelect = itemTypeVm;
		SetTimeLeft(copyVM.GetCurTime());
		GetZoneBuff(itemTypeVm.Data);
		GetZoneReward(itemTypeVm.Data);
		optRequest.Raise("RefreshCopyList");
	}

	private void BackRefreshStar()
	{
		if (!isSave)
		{
			return;
		}
		for (int i = 0; i < copyItemVms.Count; i++)
		{
			copyItemVms[i].CalcuStar();
		}
		CalcuStar();
		GetZoneReward(curTypeSelect.Data);
		enterItemVM.SetCondition();
		for (int j = 0; j < typeVms.Count; j++)
		{
			if (typeVms[j].Data.Zone != curZone)
			{
				continue;
			}
			List<CopyData> copyDataList = typeVms[j].Data.CopyDataList;
			bool complete = copyDataList.Count != 0;
			for (int k = 0; k < copyDataList.Count; k++)
			{
				if (!copyDataList[k].IsAccessed)
				{
					complete = false;
					break;
				}
			}
			typeVms[j].SetComplete(complete);
			break;
		}
		isSave = false;
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OpenShop".Equals(optName))
		{
			try
			{
				ShopWindowViewModel userData = new ShopWindowViewModel(this);
				openWindowRequest.Raise(new OpenViewArg(typeof(ShopWindow), userData), delegate
				{
					optCommand.Enabled = true;
				});
			}
			catch (Exception ex)
			{
				Log.Error("打开商店界面失败！" + ex.Message + "/" + ex.StackTrace);
				optCommand.Enabled = true;
			}
		}
		else if ("OpenReward".Equals(optName))
		{
			try
			{
				List<CopyReward4ItemViewModel> reward4ItemVMs = rewardVmList[curTypeSelect.Data.Zone];
				if (rewardVM == null)
				{
					rewardVM = new CopyST4RewardViewModel(this, $"{starMax}/{starConfigMax}", reward4ItemVMs, 4);
				}
				else
				{
					rewardVM.RefreshData($"{starMax}/{starConfigMax}", reward4ItemVMs);
				}
				optRequest.Raise("OpenReward");
				optCommand.Enabled = true;
			}
			catch (Exception ex2)
			{
				Log.Error("打开奖励界面失败！" + ex2.Message + "/" + ex2.StackTrace);
				optCommand.Enabled = true;
			}
		}
		optCommand.Enabled = true;
	}

	private async Task GetRewards(CopyReward4ItemViewModel reward4ItemVm)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		Loading loading = await Loading.Show();
		try
		{
			RewardThings rewardThings = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetFloorCopyReward(reward4ItemVm.Zone, reward4ItemVm.Index);
			loading.Dispose();
			if (rewardThings != null)
			{
				PropGetViewModel userData = new PropGetViewModel(this, rewardThings);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData));
				List<CopyReward4ItemViewModel> list = rewardVmList[reward4ItemVm.Zone];
				for (int i = 0; i < list.Count; i++)
				{
					if (list[i].State == 1)
					{
						list[i].SetState(3);
						copyVM.SetReward4State(list[i].Zone, list[i].Index, get: true);
					}
				}
				Red = false;
				rewardVM.Sort();
				list.Sort(new CopyReward4ItemVmSort());
				PropIcon = list[0].GetPropIcon();
			}
		}
		catch (Exception)
		{
			loading.Dispose();
		}
		optCommand.Enabled = true;
	}

	private void GetZoneBuff(CopyTypeData copyTypeData)
	{
		if (copyTypeData.ZoneEnvironIds == null || copyTypeData.ZoneEnvironIds.Count == 0)
		{
			BuffDesc = "";
			BuffIcon = "";
			return;
		}
		int num = copyTypeData.ZoneEnvironIds[0];
		EnvironmentModifierDisplayInfo displayInfo = EnvironmentModifierHelper.GetDisplayInfo(num);
		if (displayInfo.EnvironId == 0)
		{
			if (num != 0)
			{
				Log.Error($"EnvironmentModifier表找不到配置Id为{num} 的环境效果，请检查CopyType表Id为{copyTypeData.CopyTypeId}的数据！");
			}
			BuffDesc = "";
			BuffIcon = "";
		}
		else
		{
			BuffDesc = displayInfo.Desc;
			BuffIcon = displayInfo.Icon;
		}
	}

	private void GetZoneReward(CopyTypeData data)
	{
		if (rewardVmList.ContainsKey(data.Zone))
		{
			List<CopyReward4ItemViewModel> list = rewardVmList[data.Zone];
			for (int i = 0; i < list.Count; i++)
			{
				if (copyVM.GetReward4State(list[i].Zone, list[i].Index))
				{
					list[i].SetState(3);
				}
				else if (starMax >= list[i].Count)
				{
					list[i].SetState(1);
				}
				else
				{
					list[i].SetState(2);
				}
			}
		}
		else
		{
			List<CopyReward4ItemViewModel> list2 = new List<CopyReward4ItemViewModel>();
			DRDepthsStar[] dataRows = GameEntry.DataTable.GetDataRows((DRDepthsStar p) => p.Zone == data.Zone);
			if (dataRows == null)
			{
				Log.Error($"找不到区域星级奖励数据 区域：{data.Zone}");
				return;
			}
			for (int num = 0; num < dataRows.Length; num++)
			{
				DRDepthsStar dRDepthsStar = dataRows[num];
				if (dRDepthsStar.StarReward.Count != dRDepthsStar.StarRewardType.Count || dRDepthsStar.StarReward.Count != dRDepthsStar.StarRewardNum.Count)
				{
					Log.Error($"DepthsStar表，奖励配置长度不对，Id：{dRDepthsStar.Id}");
				}
				List<PropDataBase> list3 = new List<PropDataBase>();
				for (int num2 = 0; num2 < dRDepthsStar.StarReward.Count; num2++)
				{
					PropDataBase propDataBase = PropDataBase.CreateByType(dRDepthsStar.StarRewardType[num2], dRDepthsStar.StarReward[num2], dRDepthsStar.StarRewardNum[num2]);
					if (propDataBase != null)
					{
						list3.Add(propDataBase);
					}
					else
					{
						Log.Error($"DepthsStar表，奖励配置异常，Id：{dRDepthsStar.Id}，找不到Prop Id为{dRDepthsStar.StarReward[num2]}的道具！");
					}
				}
				CopyReward4ItemViewModel item = new CopyReward4ItemViewModel(this, data.Zone, dataRows[num].Id, dataRows[num].Index, dataRows[num].StarNum, list3);
				list2.Add(item);
				if (copyVM.GetReward4State(list2[num].Zone, list2[num].Index))
				{
					list2[num].SetState(3);
				}
				else if (starMax >= list2[num].Count)
				{
					list2[num].SetState(1);
				}
				else
				{
					list2[num].SetState(2);
				}
			}
			rewardVmList.Add(data.Zone, list2);
		}
		List<CopyReward4ItemViewModel> list4 = rewardVmList[data.Zone];
		list4.Sort(new CopyReward4ItemVmSort());
		if (list4.Count > 0)
		{
			Red = list4[0].State == 1;
			PropIcon = list4[0].GetPropIcon();
		}
		else
		{
			Red = false;
			PropIcon = "";
		}
	}

	public int GetCurIndex()
	{
		for (int num = copyItemVms.Count - 1; num >= 0; num--)
		{
			if (!copyItemVms[num].Data.IsLock)
			{
				return num;
			}
		}
		return 0;
	}

	private void CalStar()
	{
		CalcuStar();
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}
}
