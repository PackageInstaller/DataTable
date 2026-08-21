using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattlePropMakeWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Image icon;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private TextMeshProUGUI curCount;

	[SerializeField]
	private TextMeshProUGUI makeCount;

	[SerializeField]
	private TextMeshProUGUI makeCountMin;

	[SerializeField]
	private TextMeshProUGUI makeCountMax;

	[SerializeField]
	private UIStarGroup star;

	[SerializeField]
	private Button btnMake;

	[SerializeField]
	private GameObject disableMake;

	[SerializeField]
	private TextMeshProUGUI makeText;

	[SerializeField]
	private Button btnMax;

	[SerializeField]
	private GameObject maskRoot;

	[SerializeField]
	private float pressSpeed = 0.05f;

	[SerializeField]
	private GameObject addObj;

	[SerializeField]
	private GameObject decObj;

	[SerializeField]
	private ButtonLong btnAdd;

	[SerializeField]
	private ButtonLong btnDec;

	[SerializeField]
	private Slider slider;

	[SerializeField]
	private GameObject lockRoot;

	[SerializeField]
	private GameObject unlockRoot;

	[SerializeField]
	private LoopListView2 materialList;

	[SerializeField]
	private LoopGridView itemList;

	private bool showConfirm;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private GameObject confirmRoot;

	[SerializeField]
	private LoopListView2 confirmPropList;

	[SerializeField]
	private BPItemView bpItem;

	[SerializeField]
	private TextMeshProUGUI propName;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private AutoDispose makeEffect;

	private BattlePropMakeViewModel viewModel;

	public bool ShowConfirm
	{
		get
		{
			return showConfirm;
		}
		set
		{
			showConfirm = value;
			confirmRoot.SetActive(showConfirm);
			if (showConfirm)
			{
				((TMP_Text)propName).text = $"{viewModel.MakeBPItem.Data.Name}×{viewModel.MakeCountCur}";
				bpItem.RefreshData(viewModel.MakeBPItem);
				confirmPropList.SetListItemCount(viewModel.ItemNeedDatas.Count);
				confirmPropList.RefreshAllShownItem();
			}
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattlePropMakeViewModel>();
		BindingSet<BattlePropMakeWindow, BattlePropMakeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattlePropMakeWindow v) => v.OnDismissRequest).To((BattlePropMakeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BattlePropMakeWindow v) => v.OpenUguiWindow).To((BattlePropMakeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((BattlePropMakeWindow v) => v.UpdateMaterial).To((BattlePropMakeViewModel vm) => vm.UpdateMaterialRequest);
		bindingSet.Bind(this).For((BattlePropMakeWindow v) => v.UpdateSlider).To((BattlePropMakeViewModel vm) => vm.UpdateSliderRequest);
		bindingSet.Bind(this).For((BattlePropMakeWindow v) => v.PlayMakeEffect).To((BattlePropMakeViewModel vm) => vm.PlayMakeEffectRequest);
		bindingSet.Bind(this).For((BattlePropMakeWindow v) => v.ResetSlider).To((BattlePropMakeViewModel vm) => vm.ResetSliderRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BattlePropMakeViewModel vm) => vm.Close);
		bindingSet.Bind(icon).For((Image v) => v.sprite).To((BattlePropMakeViewModel vm) => vm.CurSelect.Data.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropMakeViewModel vm) => vm.CurSelect.Data.Name);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropMakeViewModel vm) => vm.CurSelect.Data.Desc);
		bindingSet.Bind<TextMeshProUGUI>(curCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropMakeViewModel vm) => vm.CurSelect.Data.Count);
		bindingSet.Bind(star).For((UIStarGroup v) => v.MaxCount).To((BattlePropMakeViewModel vm) => vm.CurSelect.Data.LevelMax);
		bindingSet.Bind(star).For((UIStarGroup v) => v.CurCount).To((BattlePropMakeViewModel vm) => vm.CurSelect.Data.Level);
		bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).To((BattlePropMakeViewModel vm) => vm.IsItemLock);
		bindingSet.Bind(unlockRoot).For((GameObject v) => v.activeSelf).ToExpression((BattlePropMakeViewModel vm) => !vm.IsItemLock);
		bindingSet.Bind<TextMeshProUGUI>(makeCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropMakeViewModel vm) => vm.MakeCountCur);
		bindingSet.Bind(addObj).For((GameObject v) => v.activeSelf).ToExpression((BattlePropMakeViewModel vm) => vm.MakeCountCur == vm.MakeCountMax);
		bindingSet.Bind(decObj).For((GameObject v) => v.activeSelf).ToExpression((BattlePropMakeViewModel vm) => vm.MakeCountCur == vm.MakeCountMin);
		bindingSet.Bind<TextMeshProUGUI>(makeCountMin).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropMakeViewModel vm) => vm.MakeCountMin);
		bindingSet.Bind<TextMeshProUGUI>(makeCountMax).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattlePropMakeViewModel vm) => vm.MakeCountMax);
		bindingSet.Bind(disableMake).For((GameObject v) => v.activeSelf).ToExpression((BattlePropMakeViewModel vm) => !vm.CanMake);
		bindingSet.Bind<TextMeshProUGUI>(makeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((BattlePropMakeViewModel vm) => vm.CanMake ? "合成" : "素材不足");
		bindingSet.Bind(btnMake).For((Button v) => v.onClick).To((BattlePropMakeViewModel vm) => vm.MakeCommand);
		bindingSet.Bind(slider).For((Slider v) => v.value).To((BattlePropMakeViewModel vm) => vm.MakeFill);
		bindingSet.Bind(this).For((BattlePropMakeWindow v) => v.ShowConfirm).To((BattlePropMakeViewModel vm) => vm.ShowConfirm);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((BattlePropMakeViewModel vm) => vm.ConfirmCommand);
		bindingSet.Bind(maskRoot).For((GameObject v) => v.activeSelf).To((BattlePropMakeViewModel vm) => vm.TouchMask);
		bindingSet.Build();
		itemList.InitGridView(viewModel.BpItemVMs.Count, OnGetPropItemByIndex);
		materialList.InitListView(viewModel.MaterialItemDatas.Count, OnGetMaterialItemByIndex);
		confirmPropList.InitListView(viewModel.ItemNeedDatas.Count, OnGetPropItemByIndex);
		bpItem.Init(viewModel.MakeBPItem);
		slider.onValueChanged.AddListener(viewModel.OnSlider);
		btnAdd.onClick.AddListener(viewModel.OnAdd);
		btnDec.onClick.AddListener(viewModel.OnDec);
		btnAdd.onPress.AddListener(AddPropPress);
		btnDec.onPress.AddListener(DecPropPress);
		btnCancel.onClick.AddListener(viewModel.CloseConfirmView);
		btnClose.onClick.AddListener(viewModel.CloseConfirmView);
		btnMax.onClick.AddListener(viewModel.OnMax);
		confirmRoot.SetActive(value: false);
		makeEffect.AddDisposeAction(delegate(GameObject go)
		{
			go.gameObject.SetActive(value: false);
			viewModel.ShowRewardViewAfterEffect();
		});
	}

	private void ResetSlider(object sender, InteractionEventArgs e)
	{
		if (viewModel.MakeCountMax == 0)
		{
			slider.value = 0f;
		}
		else
		{
			slider.value = (float)viewModel.MakeCountCur * 1f / (float)viewModel.MakeCountMax;
		}
	}

	private void PlayMakeEffect(object sender, InteractionEventArgs e)
	{
		makeEffect.gameObject.SetActive(value: true);
	}

	private void UpdateSlider(object sender, InteractionEventArgs e)
	{
		slider.value = 1f;
	}

	private void UpdateMaterial(object sender, InteractionEventArgs e)
	{
		materialList.SetListItemCount(viewModel.MaterialItemDatas.Count);
		materialList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetPropItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.BpItemVMs.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BPItemView");
		if (loopGridViewItem != null)
		{
			BPItemView component = loopGridViewItem.GetComponent<BPItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BpItemVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.BpItemVMs[index]);
			}
		}
		return loopGridViewItem;
	}

	private LoopListViewItem2 OnGetMaterialItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.MaterialItemDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CastingMaterialItem");
		if (loopListViewItem != null)
		{
			CastingMaterialItem component = loopListViewItem.GetComponent<CastingMaterialItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.MaterialItemDatas[index]);
			}
			else
			{
				component.RefreshData(viewModel.MaterialItemDatas[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetPropItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ItemNeedDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropMiddleItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ItemNeedDatas[index]);
			}
			else
			{
				component.RefreshData(viewModel.ItemNeedDatas[index]);
			}
		}
		return loopListViewItem;
	}

	private void AddPropPress()
	{
		float val = slider.value + pressSpeed;
		viewModel.OnSlider(val);
	}

	private void DecPropPress()
	{
		float val = slider.value - pressSpeed;
		viewModel.OnSlider(val);
	}
}
