using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HCTDescView : UGuiView
{
	[SerializeField]
	private GameObject disableMask;

	[SerializeField]
	private Button btnBgMask;

	[SerializeField]
	private GameObject descRoot;

	[SerializeField]
	private RectTransform descPos2;

	[SerializeField]
	private RectTransform skillAutoFitRTNext;

	[SerializeField]
	private RectTransform skillAutoFitRTCur;

	[SerializeField]
	private GameObject desc2Root;

	[SerializeField]
	private TextMeshProUGUI disableText;

	[SerializeField]
	private TextMeshProUGUI textBtn;

	[SerializeField]
	private Button btnOpenNext;

	[SerializeField]
	private Button btnOpenNext2;

	[SerializeField]
	private Button btnUpgrade;

	[SerializeField]
	private TextMeshProUGUI smallTypeName;

	[SerializeField]
	private TextMeshProUGUI smallDesc;

	[SerializeField]
	private GameObject textScrollView;

	[SerializeField]
	private TextMeshProUGUI skillTypeName;

	[SerializeField]
	private RectTransform arrow1;

	[SerializeField]
	private RectTransform arrow2;

	[SerializeField]
	private GameObject materialRoot;

	[SerializeField]
	private GameObject upgradeRoot;

	[SerializeField]
	private GameObject maxRoot;

	[SerializeField]
	private GameObject parentRoootInMaterialAndUpgrade;

	[SerializeField]
	private TextMeshProUGUI goldCount;

	[SerializeField]
	private TextMeshProUGUI goldCount2;

	[SerializeField]
	private LoopListView2 materialList;

	[SerializeField]
	private ScrollRect affixList;

	[SerializeField]
	private TextItemView attrItem;

	private List<TextItemView> attrItemList = new List<TextItemView>();

	private HCTDescViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<HCTDescViewModel>(userData);
		BindingSet<HCTDescView, HCTDescViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HCTDescView v) => ((UGuiView)v).OnVisibleChanged).To((HCTDescViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind<TextMeshProUGUI>(skillTypeName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HCTDescViewModel vm) => $"燃点·{vm.SkillTypeName}");
		bindingSet.Bind().For((HCTDescView v) => v.RefreshCur).To((HCTDescViewModel vm) => vm.RefreshCurRequest);
		bindingSet.Bind(materialRoot).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => !vm.IsBigMax && !vm.IsSmallActive);
		bindingSet.Bind(upgradeRoot).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => !vm.IsBigMax);
		bindingSet.Bind(maxRoot).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => vm.IsBigMax);
		if (!viewModel.IsSelf)
		{
			bindingSet.Bind(parentRoootInMaterialAndUpgrade).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => vm.IsSelf);
		}
		bindingSet.Bind(btnOpenNext.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => !vm.IsBigMax);
		bindingSet.Bind(btnOpenNext2.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => vm.SmallTinderType == 1);
		bindingSet.Bind<TextMeshProUGUI>(smallTypeName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTDescViewModel vm) => vm.SmallTypeName);
		bindingSet.Bind<TextMeshProUGUI>(smallDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTDescViewModel vm) => vm.SmallDesc);
		bindingSet.Bind(disableMask).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => !vm.EnableUpgrade);
		bindingSet.Bind<TextMeshProUGUI>(textBtn).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTDescViewModel vm) => vm.BtnText);
		bindingSet.Bind<TextMeshProUGUI>(disableText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTDescViewModel vm) => vm.DisableDesc);
		bindingSet.Bind(btnUpgrade).For((Button v) => v.onClick).To((HCTDescViewModel vm) => vm.ActiveCommand);
		bindingSet.Bind(desc2Root.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => !vm.IsBig);
		bindingSet.Bind(descRoot.gameObject).For((GameObject v) => v.activeSelf).To((HCTDescViewModel vm) => vm.IsBig);
		bindingSet.Bind<TextMeshProUGUI>(goldCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTDescViewModel vm) => vm.GoldCount);
		bindingSet.Bind<TextMeshProUGUI>(goldCount2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HCTDescViewModel vm) => vm.GoldCount);
		bindingSet.Bind(((Component)(object)goldCount).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => !vm.IsLackGold);
		bindingSet.Bind(((Component)(object)goldCount2).gameObject).For((GameObject v) => v.activeSelf).ToExpression((HCTDescViewModel vm) => vm.IsLackGold);
		bindingSet.Bind(this).For((HCTDescView v) => v.UpdateMaterial).To((HCTDescViewModel vm) => vm.UpdateMaterialRequest);
		bindingSet.Bind(this).For((HCTDescView v) => v.UpdateAffix).To((HCTDescViewModel vm) => vm.UpdateAffixRequest);
		bindingSet.Build();
		btnOpenNext.onClick.AddListener(OpenCur);
		btnOpenNext2.onClick.AddListener(OpenCur);
		btnBgMask.onClick.AddListener(CloseSkillDesc);
		btnBgMask.gameObject.SetActive(value: false);
		skillAutoFitRTNext.gameObject.SetActive(value: false);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null)
		{
			UpdateMaterial(null, null);
			UpdateAffix(null, null);
			skillAutoFitRTCur.GetComponent<HCSkillDescAutoFitView>().Init(viewModel.HCTSkillVm, null, viewModel.IsBigMax);
		}
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		btnBgMask.gameObject.SetActive(value: false);
	}

	private void UpdateAffix(object sender, InteractionEventArgs e)
	{
		if (viewModel.TextItemVMs.Count > 0)
		{
			textScrollView.gameObject.SetActive(value: false);
			affixList.gameObject.SetActive(value: true);
		}
		else
		{
			textScrollView.gameObject.SetActive(value: true);
			affixList.gameObject.SetActive(value: false);
		}
		TextItemView textItemView = attrItem;
		List<TextItemView> list = attrItemList;
		for (int i = 0; i < list.Count; i++)
		{
			if (i < viewModel.TextItemVMs.Count)
			{
				list[i].RefreshData(viewModel.TextItemVMs[i]);
				list[i].gameObject.SetActive(value: true);
			}
			else
			{
				list[i].gameObject.SetActive(value: false);
			}
		}
		for (int j = list.Count; j < viewModel.TextItemVMs.Count; j++)
		{
			TextItemView component = UnityEngine.Object.Instantiate(textItemView.gameObject, affixList.content).GetComponent<TextItemView>();
			list.Add(component);
			component.Init(viewModel.TextItemVMs[j]);
			component.gameObject.SetActive(value: true);
		}
	}

	private void CloseSkillDesc()
	{
		arrow1.localRotation = Quaternion.Euler(0f, 0f, 0f);
		arrow2.localRotation = Quaternion.Euler(0f, 0f, 0f);
		skillAutoFitRTNext.gameObject.SetActive(value: false);
		btnBgMask.gameObject.SetActive(value: false);
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		base.OnVisibleChanged(sender, e);
		if (!Visibility)
		{
			skillAutoFitRTNext.gameObject.SetActive(value: false);
			btnBgMask.gameObject.SetActive(value: false);
		}
		else
		{
			UpdateMaterial(null, null);
		}
	}

	private void OpenCur()
	{
		skillAutoFitRTNext.gameObject.SetActive(!skillAutoFitRTNext.gameObject.activeSelf);
		btnBgMask.gameObject.SetActive(skillAutoFitRTNext.gameObject.activeSelf);
		if (skillAutoFitRTNext.gameObject.activeSelf)
		{
			skillAutoFitRTNext.transform.SetParent(descPos2);
			skillAutoFitRTNext.anchoredPosition = Vector2.zero;
			skillAutoFitRTNext.GetComponent<HCSkillDescAutoFitView>().Init(viewModel.IsBig ? viewModel.HCTNextSkillVm : viewModel.HCTSkillVm, null, max: false);
		}
		arrow1.localRotation = Quaternion.Euler(0f, 0f, skillAutoFitRTNext.gameObject.activeSelf ? 180 : 0);
		arrow2.localRotation = Quaternion.Euler(0f, 0f, skillAutoFitRTNext.gameObject.activeSelf ? 180 : 0);
		skillAutoFitRTCur.GetComponent<HCSkillDescAutoFitView>().Init(viewModel.HCTSkillVm, null, viewModel.IsBigMax);
	}

	private void RefreshCur(object sender, InteractionEventArgs e)
	{
		if (skillAutoFitRTNext.gameObject.activeSelf)
		{
			skillAutoFitRTNext.GetComponent<HCSkillDescAutoFitView>().Init(viewModel.IsBig ? viewModel.HCTNextSkillVm : viewModel.HCTSkillVm, null, max: false);
		}
		skillAutoFitRTCur.GetComponent<HCSkillDescAutoFitView>().Init(viewModel.HCTSkillVm, null, viewModel.IsBigMax);
	}

	private void UpdateMaterial(object sender, InteractionEventArgs e)
	{
		if (materialList.IsInited)
		{
			materialList.ChangeArrangeType((viewModel.MaterialItemDatas.Count > 3) ? ListItemArrangeType.LeftToRight : ListItemArrangeType.LeftToRight_Center);
			materialList.SetListItemCount(viewModel.MaterialItemDatas.Count);
			materialList.RefreshAllShownItem();
		}
		else
		{
			materialList.ArrangeType = ((viewModel.MaterialItemDatas.Count > 3) ? ListItemArrangeType.LeftToRight : ListItemArrangeType.LeftToRight_Center);
			materialList.InitListView(viewModel.MaterialItemDatas.Count, OnGetMaterialItemByIndex);
		}
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

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<HCTDescViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
