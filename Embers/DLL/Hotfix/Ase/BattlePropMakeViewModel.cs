#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using Unity.Mathematics;

namespace Ase;

public class BattlePropMakeViewModel : OptionBase
{
	private List<BPItemViewModel> bpItemVMs = new List<BPItemViewModel>();

	private List<CastingMaterialItemData> materialItemDatas = new List<CastingMaterialItemData>();

	private List<KnapsackItemViewModel> itemNeedDatas = new List<KnapsackItemViewModel>();

	private SimpleCommand makeCommand;

	private SimpleCommand confirmCommand;

	private BPItemViewModel curSelect;

	private BPItemViewModel makeBPItem;

	private bool canMake;

	private bool isItemLock;

	private int makeCountMin;

	private int makeCountMax;

	private int makeCountCur;

	private float makeFill;

	private bool showConfirm;

	private InteractionRequest updateMaterialRequest = new InteractionRequest();

	private InteractionRequest updateSliderRequest = new InteractionRequest();

	private InteractionRequest playMakeEffectRequest = new InteractionRequest();

	private InteractionRequest resetSliderRequest = new InteractionRequest();

	private PropGetViewModel propGetCache;

	private bool touchMask;

	public bool IsItemLock
	{
		get
		{
			return isItemLock;
		}
		private set
		{
			Set(ref isItemLock, value, "IsItemLock");
		}
	}

	public bool TouchMask
	{
		get
		{
			return touchMask;
		}
		private set
		{
			Set(ref touchMask, value, "TouchMask");
		}
	}

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

	public List<CastingMaterialItemData> MaterialItemDatas => materialItemDatas;

	public List<KnapsackItemViewModel> ItemNeedDatas => itemNeedDatas;

	public int MakeCountMin
	{
		get
		{
			return makeCountMin;
		}
		private set
		{
			Set(ref makeCountMin, value, "MakeCountMin");
		}
	}

	public int MakeCountMax
	{
		get
		{
			return makeCountMax;
		}
		private set
		{
			makeCountMax = value - 1;
			Set(ref makeCountMax, value, "MakeCountMax");
		}
	}

	public int MakeCountCur
	{
		get
		{
			return makeCountCur;
		}
		private set
		{
			Set(ref makeCountCur, value, "MakeCountCur");
		}
	}

	public float MakeFill
	{
		get
		{
			return makeFill;
		}
		private set
		{
			Set(ref makeFill, value, "MakeFill");
		}
	}

	public bool CanMake
	{
		get
		{
			return canMake;
		}
		private set
		{
			Set(ref canMake, value, "CanMake");
		}
	}

	public bool ShowConfirm
	{
		get
		{
			return showConfirm;
		}
		private set
		{
			Set(ref showConfirm, value, "ShowConfirm");
		}
	}

	public BPItemViewModel MakeBPItem
	{
		get
		{
			return makeBPItem;
		}
		private set
		{
			Set(ref makeBPItem, value, "MakeBPItem");
		}
	}

	public ICommand MakeCommand => makeCommand;

	public ICommand ConfirmCommand => confirmCommand;

	public IInteractionRequest UpdateMaterialRequest => updateMaterialRequest;

	public IInteractionRequest UpdateSliderRequest => updateSliderRequest;

	public IInteractionRequest PlayMakeEffectRequest => playMakeEffectRequest;

	public IInteractionRequest ResetSliderRequest => resetSliderRequest;

	public List<BPItemViewModel> BpItemVMs => bpItemVMs;

	public BattlePropMakeViewModel(OptionBase parent)
	{
		base.parent = parent;
		makeCommand = new SimpleCommand(OnMake);
		confirmCommand = new SimpleCommand(OnConfirm);
		List<BPData> allBPDatas = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetAllBPDatas();
		if (allBPDatas != null)
		{
			allBPDatas.Sort(new BPDataNewSort());
			for (int i = 0; i < allBPDatas.Count; i++)
			{
				bpItemVMs.Add(new BPItemViewModel(this, allBPDatas[i]));
			}
			if (bpItemVMs.Count > 0)
			{
				SelectBPItem(bpItemVMs[0]);
				return;
			}
			throw new Exception("战斗道具数据为空！");
		}
		throw new Exception("战斗道具数据为空！");
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is BPItemViewModel bpItemViewModel)
		{
			SelectBPItem(bpItemViewModel);
			updateMaterialRequest.Raise();
			resetSliderRequest.Raise();
		}
		else if (obj is CastingMaterialItemData castingMaterialItemData)
		{
			OpenViewArg openViewArg = new KnapsackItemViewModel(this, castingMaterialItemData.PropData).OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg2 = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg2 != null)
			{
				openWindowRequest.Raise(openViewArg2);
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
		makeBPItem = bpItemViewModel;
		curSelect.IsSelect = true;
		IsItemLock = curSelect.Data.IsLock;
		CanMake = !isItemLock;
		materialItemDatas.Clear();
		itemNeedDatas.Clear();
		DRBattlePropMake dataRow = GameEntry.DataTable.GetDataRow((DRBattlePropMake p) => p.Id == curSelect.Data.Id);
		if (dataRow == null)
		{
			Log.Error($"找不到合成图纸{curSelect.Data.Id}");
			MakeCountCur = 0;
			MakeFill = 1f;
			CanMake = false;
			return;
		}
		makeCountMin = int.MaxValue;
		makeCountMax = int.MaxValue;
		if (dataRow.Item.Count != dataRow.Num.Count)
		{
			Log.Error($"战斗道具合成表配置异常 ID：【{dataRow.Id}】");
		}
		else
		{
			for (int num = 0; num < dataRow.Item.Count; num++)
			{
				KnapsackPropData knapsackPropData = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(dataRow.Item[num]);
				KnapsackPropData knapsackPropData2 = null;
				if (knapsackPropData == null)
				{
					knapsackPropData = KnapsackPropData.Create(dataRow.Item[num], 0);
					makeCountMax = 0;
				}
				knapsackPropData2 = KnapsackPropData.Create(dataRow.Item[num], 0);
				MakeCountMax = math.min(knapsackPropData.Amount / dataRow.Num[num], makeCountMax);
				MakeCountMin = math.min(1, makeCountMax);
				materialItemDatas.Add(new CastingMaterialItemData(this, dataRow.Num[num], knapsackPropData));
				itemNeedDatas.Add(new KnapsackItemViewModel(this, knapsackPropData2));
			}
		}
		MakeCountCur = makeCountMin;
		MakeFill = ((makeCountMax == 0) ? 1f : ((makeCountMax == 1) ? 1f : ((float)(makeCountCur - 1) * 1f / (float)(makeCountMax - 1))));
		CanMake = canMake && makeCountMin > 0;
	}

	public void OnMake()
	{
		if (canMake)
		{
			makeCommand.Enabled = false;
			for (int i = 0; i < itemNeedDatas.Count; i++)
			{
				itemNeedDatas[i].PropDataBase.Amount = materialItemDatas[i].Need * makeCountCur;
			}
			MakeBPItem = new BPItemViewModel(null, curSelect.Data, makeCountCur);
			ShowConfirm = true;
		}
	}

	private async void OnConfirm()
	{
		confirmCommand.Enabled = false;
		if (await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().MakeBattleProp(CurSelect.Data.TeamId, makeCountCur))
		{
			TouchMask = true;
			List<PropDataBase> list = new List<PropDataBase>();
			list.Add(new PropDataBase(CurSelect.Data, makeCountCur));
			propGetCache = new PropGetViewModel(this, list);
			playMakeEffectRequest.Raise();
			CurSelect.Data.AddCount(makeCountCur);
			SelectBPItem(CurSelect);
			updateMaterialRequest.Raise();
			CloseConfirmView();
		}
		confirmCommand.Enabled = true;
	}

	public void ShowRewardViewAfterEffect()
	{
		if (propGetCache != null)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetCache), delegate
			{
				propGetCache = null;
				TouchMask = false;
			});
		}
	}

	public void OnMax()
	{
		MakeCountCur = makeCountMax;
		MakeFill = 1f;
		updateSliderRequest.Raise();
	}

	public void OnSlider(float val)
	{
		if (makeCountMax == 1)
		{
			MakeFill = 1f;
		}
		else if (makeCountMax == 0)
		{
			MakeFill = 1f;
			updateSliderRequest.Raise();
		}
		else
		{
			MakeCountCur = (int)(val * (float)(makeCountMax - 1)) + 1;
		}
	}

	public void OnAdd()
	{
		if (makeCountMax == 1)
		{
			MakeFill = 1f;
			return;
		}
		if (makeCountMax == 0)
		{
			MakeFill = 1f;
			return;
		}
		MakeCountCur = math.clamp(makeCountCur + 1, makeCountMin, makeCountMax);
		MakeFill = ((makeCountMax == 0) ? 1f : ((float)(makeCountCur - 1) * 1f / (float)(makeCountMax - 1)));
	}

	public void OnDec()
	{
		if (makeCountMax == 1)
		{
			MakeFill = 1f;
			return;
		}
		if (makeCountMax == 0)
		{
			MakeFill = 1f;
			return;
		}
		MakeCountCur = math.clamp(makeCountCur - 1, makeCountMin, makeCountMax);
		MakeFill = ((makeCountMax == 0) ? 1f : ((float)(makeCountCur - 1) * 1f / (float)(makeCountMax - 1)));
	}

	public void CloseConfirmView()
	{
		makeCommand.Enabled = true;
		ShowConfirm = false;
	}
}
