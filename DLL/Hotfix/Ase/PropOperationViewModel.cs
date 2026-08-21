using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PropOperationViewModel : OptionBase
{
	private KnapsackDefinition.PropOperationMode operationMode;

	private int propId;

	private bool needAutoSelect;

	private KnapsackItemViewModel targetProp;

	private int targetPropSingleCount;

	private KnapsackItemViewModel consumeProp;

	private int consumePropSingleCount;

	private int targetPropHaveCount;

	private bool showOpeBtnMask;

	private string opeBtnText;

	private int sliderOpeCount;

	private OpeCountBtnSliderViewModel sliderViewModel;

	private TabItemData curSelectTab;

	private KnapsackItemViewModel selectItemViewModel;

	private SimpleCommand operateCmd;

	private List<DRWholeApart> composeConfigDatas = new List<DRWholeApart>();

	private List<DRWholeApart> deComposeConfigDatas = new List<DRWholeApart>();

	private List<KnapsackItemViewModel> displayDatas = new List<KnapsackItemViewModel>();

	private InteractionRequest refreshDisplayDatas = new InteractionRequest();

	private TabItemData _tabComposeItemData;

	private TabItemData _tabDecomposeItemData;

	private bool operated;

	public KnapsackDefinition.PropOperationMode OperationMode
	{
		get
		{
			return operationMode;
		}
		set
		{
			Set(ref operationMode, value, "OperationMode");
		}
	}

	public int PropId
	{
		get
		{
			return propId;
		}
		set
		{
			Set(ref propId, value, "PropId");
		}
	}

	public KnapsackItemViewModel TargetProp
	{
		get
		{
			return targetProp;
		}
		set
		{
			Set(ref targetProp, value, "TargetProp");
		}
	}

	public int TargetPropHaveCount
	{
		get
		{
			return targetPropHaveCount;
		}
		set
		{
			Set(ref targetPropHaveCount, value, "TargetPropHaveCount");
		}
	}

	public KnapsackItemViewModel ConsumeProp
	{
		get
		{
			return consumeProp;
		}
		set
		{
			Set(ref consumeProp, value, "ConsumeProp");
		}
	}

	public bool ShowOpeBtnMask
	{
		get
		{
			return showOpeBtnMask;
		}
		set
		{
			Set(ref showOpeBtnMask, value, "ShowOpeBtnMask");
		}
	}

	public string OpeBtnText
	{
		get
		{
			return opeBtnText;
		}
		set
		{
			Set(ref opeBtnText, value, "OpeBtnText");
		}
	}

	public int SliderOpeCount
	{
		get
		{
			return sliderOpeCount;
		}
		set
		{
			Set(ref sliderOpeCount, value, "SliderOpeCount");
		}
	}

	public OpeCountBtnSliderViewModel SliderViewModel => sliderViewModel;

	public InteractionRequest RefreshDisplayDatas => refreshDisplayDatas;

	public List<KnapsackItemViewModel> DisplayDatas => displayDatas;

	public SimpleCommand OperateCmd => operateCmd;

	public TabItemData TabComposeItemData => _tabComposeItemData;

	public TabItemData TabDecomposeItemData => _tabDecomposeItemData;

	public PropOperationViewModel()
	{
	}

	public PropOperationViewModel(OptionBase parent, KnapsackDefinition.PropOperationMode mode = KnapsackDefinition.PropOperationMode.Compose, int propId = 0)
	{
		base.parent = parent;
		sliderViewModel = new OpeCountBtnSliderViewModel(this);
		operateCmd = new SimpleCommand(RequestOperate);
		TargetProp = new KnapsackItemViewModel(this);
		ConsumeProp = new KnapsackItemViewModel(this, showOwner: false, showName: false, showOwnedAndRequiredCount: true);
		_tabComposeItemData = new TabItemData(this, 1);
		_tabDecomposeItemData = new TabItemData(this, 2);
		OperationMode = mode;
		PropId = propId;
		needAutoSelect = propId > 0;
		composeConfigDatas = GameEntry.DataTable.GetDataRows((DRWholeApart p) => p.Operate == 1).ToList();
		deComposeConfigDatas = GameEntry.DataTable.GetDataRows((DRWholeApart p) => p.Operate == 2).ToList();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is KnapsackItemViewModel propSelected)
		{
			SetPropSelected(propSelected);
		}
		else if (obj is OpeCountBtnSliderViewModel)
		{
			ChangePropCountBySlider();
		}
	}

	private void ChangePropCountBySlider()
	{
		if (sliderViewModel != null)
		{
			SliderOpeCount = sliderViewModel.OpeCount;
			if (TargetProp != null)
			{
				TargetProp.PropDataBase.Amount = targetPropSingleCount * sliderViewModel.OpeCount;
			}
			if (ConsumeProp != null)
			{
				ConsumeProp.PropDataBase.Amount = consumePropSingleCount * sliderViewModel.OpeCount;
			}
		}
	}

	public override bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		if (jumpParams.WindowName.Equals("PropOperationWindow"))
		{
			List<int> list = new List<int>();
			if (jumpParams.Args != null)
			{
				foreach (object arg in jumpParams.Args)
				{
					list.Add((int)arg);
				}
			}
			KnapsackDefinition.PropOperationMode propOperationMode = KnapsackDefinition.PropOperationMode.Compose;
			int num = -1;
			if (list.Count > 0 && Enum.IsDefined(typeof(KnapsackDefinition.PropOperationMode), list[0]))
			{
				propOperationMode = (KnapsackDefinition.PropOperationMode)list[0];
			}
			if (list.Count > 1)
			{
				num = list[1];
			}
			PropId = num;
			if (num > 0)
			{
				needAutoSelect = true;
			}
			switch (propOperationMode)
			{
			case KnapsackDefinition.PropOperationMode.Compose:
				_tabComposeItemData?.TabOnClick();
				break;
			case KnapsackDefinition.PropOperationMode.Decompose:
				_tabDecomposeItemData?.TabOnClick();
				break;
			}
			return false;
		}
		return true;
	}

	private void RefreshDatas(KnapsackDefinition.PropOperationMode mode, int selectPropId = -1)
	{
		displayDatas.Clear();
		List<DRWholeApart> list = new List<DRWholeApart>();
		switch (mode)
		{
		case KnapsackDefinition.PropOperationMode.Compose:
			list = composeConfigDatas;
			break;
		case KnapsackDefinition.PropOperationMode.Decompose:
			list = deComposeConfigDatas;
			break;
		}
		IKnapsackService service = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		foreach (DRWholeApart item2 in list)
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(item2.ProductID);
			if (dataRow != null)
			{
				KnapsackItemViewModel item = new KnapsackItemViewModel(this, new PropData(dataRow, item2.MainPropNum))
				{
					IsActive = service.CheckEnough(PropDataBase.CreateByType(PropTypeEnum.Prop, item2.MaterialID, item2.MaterialNum))
				};
				displayDatas.Add(item);
			}
		}
		displayDatas.Sort(delegate(KnapsackItemViewModel a, KnapsackItemViewModel b)
		{
			int num = 0;
			int num2 = 0;
			num = ((!a.IsActive) ? 1 : (-1));
			num2 = ((!b.IsActive) ? 1 : (-1));
			PropData propData = (PropData)a.PropDataBase;
			PropData propData2 = (PropData)b.PropDataBase;
			return num.CompareTo(num2) * 10 + propData.Sort.CompareTo(propData2.Sort);
		});
		if (selectPropId >= 0)
		{
			PropId = selectPropId;
		}
		refreshDisplayDatas.Raise();
	}

	private void RefreshItemState()
	{
		if (displayDatas == null)
		{
			return;
		}
		int opeType = (int)OperationMode;
		IKnapsackService service = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		foreach (KnapsackItemViewModel data in displayDatas)
		{
			DRWholeApart dataRow = GameEntry.DataTable.GetDataRow((DRWholeApart p) => p.ProductID == data.PropDataBase.Id && p.Operate == opeType);
			DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(dataRow.MaterialID);
			if (dataRow2 != null)
			{
				PropData needProp = new PropData(dataRow2, dataRow.MaterialNum);
				data.IsActive = service.CheckEnough(needProp);
			}
		}
	}

	private void SetTabSelected(TabItemData tabItemData)
	{
		if (curSelectTab != null)
		{
			curSelectTab.IsSelected = false;
		}
		curSelectTab = tabItemData;
		curSelectTab.IsSelected = true;
		OperationMode = (KnapsackDefinition.PropOperationMode)tabItemData.TabIndex;
		if (!needAutoSelect)
		{
			PropId = 0;
		}
		RefreshDatas(OperationMode, PropId);
	}

	private void SetPropSelected(KnapsackItemViewModel itemViewModel)
	{
		if (selectItemViewModel != null)
		{
			selectItemViewModel.IsSelected = false;
		}
		selectItemViewModel = itemViewModel;
		selectItemViewModel.IsSelected = true;
		needAutoSelect = false;
		PropId = itemViewModel.PropDataBase.Id;
		int opeType = ((OperationMode == KnapsackDefinition.PropOperationMode.Compose) ? 1 : 2);
		DRWholeApart dataRow = GameEntry.DataTable.GetDataRow((DRWholeApart p) => p.ProductID == PropId && p.Operate == opeType);
		TargetProp.Refresh(selectItemViewModel.PropDataBase);
		targetPropSingleCount = dataRow.MainPropNum;
		TargetPropHaveCount = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(PropId)?.Amount ?? 0;
		DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(dataRow.MaterialID);
		if (dataRow2 != null)
		{
			ConsumeProp.Refresh(new PropData(dataRow2, dataRow.MaterialNum));
			consumePropSingleCount = dataRow.MaterialNum;
		}
		RefreshSliderAndOpeBtn();
	}

	private void RefreshSliderAndOpeBtn()
	{
		int num = (Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(ConsumeProp.PropDataBase.Id)?.Amount ?? 0) / ConsumeProp.PropDataBase.Amount;
		sliderViewModel.SetOpeCountMin(1);
		sliderViewModel.SetOpeCountMax(Mathf.Max(num, 1));
		sliderViewModel.ResetToMin();
		ChangePropCountBySlider();
		ShowOpeBtnMask = num <= 0;
		OpeBtnText = (ShowOpeBtnMask ? "材料不足" : OperationMode.GetDescription());
	}

	public void OpenPropInfoWindow(KnapsackItemViewModel itemViewModel)
	{
		GameProcessType gameProcess = Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess();
		OpenViewArg openViewArg = itemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, gameProcess == GameProcessType.Outer);
		if (openViewArg != null)
		{
			openWindowRequest.Raise(openViewArg);
		}
	}

	private async void RequestOperate()
	{
		if (selectItemViewModel == null || selectItemViewModel.PropDataBase.Id <= 0)
		{
			return;
		}
		operateCmd.Enabled = false;
		int targetId = selectItemViewModel.PropDataBase.Id;
		int opeType = (int)OperationMode;
		IKnapsackService knapsackService = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		Loading loading = await Loading.Show();
		KeyValuePair<bool, List<KnapsackPropData>> keyValuePair = await knapsackService.RequestPropWholeApart(targetId, SliderOpeCount, opeType);
		loading?.Dispose();
		if (keyValuePair.Key)
		{
			operated = true;
			Toast.ShowInfo(((KnapsackDefinition.PropOperationMode)opeType).GetDescription() + "成功");
			if (keyValuePair.Value != null && keyValuePair.Value.Count > 0)
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(this, keyValuePair.Value)));
			}
			if (OperationMode == (KnapsackDefinition.PropOperationMode)opeType && selectItemViewModel != null && selectItemViewModel.PropDataBase.Id == targetId)
			{
				DRWholeApart dataRow = GameEntry.DataTable.GetDataRow((DRWholeApart p) => p.ProductID == selectItemViewModel.PropDataBase.Id && p.Operate == opeType);
				DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(dataRow.MaterialID);
				if (dataRow2 != null)
				{
					PropData data = new PropData(dataRow2, dataRow.MaterialNum);
					ConsumeProp.Refresh(data);
				}
				TargetPropHaveCount = knapsackService.GetKnapsackViewModel().GetProp(targetId)?.Amount ?? 0;
				RefreshSliderAndOpeBtn();
			}
			RefreshItemState();
		}
		operateCmd.Enabled = true;
	}

	public override void Close()
	{
		if (operated)
		{
			parent?.ItemOnClick(new OptionArg(this, "PropOperated"));
		}
		base.Close();
	}
}
