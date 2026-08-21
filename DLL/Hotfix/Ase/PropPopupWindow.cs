using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropPopupWindow : PropInfoWindowBase
{
	[SerializeField]
	private Button outside2Btn;

	[SerializeField]
	private GameObject functionPart;

	[SerializeField]
	private TextMeshProUGUI functionDesc;

	[SerializeField]
	private GameObject sourcePart;

	[SerializeField]
	private Transform sourceRoot;

	[SerializeField]
	private PropSourceItem sourceTpl;

	[SerializeField]
	private GameObject expirePart;

	[SerializeField]
	private TextMeshProUGUI expireText;

	[SerializeField]
	private GameObject armourRank;

	[SerializeField]
	private Image rankColor;

	[SerializeField]
	private TextMeshProUGUI rank;

	[SerializeField]
	private Image armourType;

	[SerializeField]
	private GameObject armourCustomPart;

	[SerializeField]
	private TextMeshProUGUI armourCustomTitle;

	[SerializeField]
	private TextMeshProUGUI armourCustomDesc;

	private PropWindowViewModel _viewModel;

	private List<PropSourceItem> sourceItems = new List<PropSourceItem>();

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<PropWindowViewModel>();
		BindingSet<PropPopupWindow, PropWindowViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((PropPopupWindow v) => v.OnDismissRequest).To((PropWindowViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((PropPopupWindow v) => v.OpenUguiWindow).To((PropWindowViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((PropPopupWindow v) => ((UGuiWindow)v).OnVisibleChanged).To((PropWindowViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(outside2Btn).For((Button v) => v.onClick).To((PropWindowViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(outside2Btn.gameObject).For((GameObject v) => v.activeSelf).To((PropWindowViewModel vm) => vm.ShowOutsideMask2);
		if (armourRank != null)
		{
			bindingSet.Bind(armourRank).For((GameObject v) => v.activeSelf).To((PropWindowViewModel vm) => vm.ShowArmourRank);
		}
		if (rankColor != null)
		{
			bindingSet.Bind(rankColor).For((Image v) => v.color).To((PropWindowViewModel vm) => vm.ArmourRankColor);
		}
		if ((UnityEngine.Object)(object)rank != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropWindowViewModel vm) => vm.ArmourRankText);
		}
		if (armourType != null)
		{
			bindingSet.Bind(armourType.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropWindowViewModel vm) => !string.IsNullOrEmpty(vm.ArmourTypeIcon));
			bindingSet.Bind(armourType).For((Image v) => v.sprite).To((PropWindowViewModel vm) => vm.ArmourTypeIcon)
				.WithConversion("ItemIcon");
		}
		if (expirePart != null && (UnityEngine.Object)(object)expireText != null)
		{
			bindingSet.Bind(expirePart).For((GameObject v) => v.activeSelf).ToExpression((PropWindowViewModel vm) => (int)vm.Data.PropTimeLimitEnum != 0);
			bindingSet.Bind<TextMeshProUGUI>(expireText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropWindowViewModel vm) => vm.Data.TimeLimitText);
		}
		bindingSet.Build();
		Refresh();
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		if ((UnityEngine.Object)(object)CanvasGroup != null)
		{
			CanvasGroup.alpha = (flag ? 1 : 0);
			CanvasGroup.blocksRaycasts = flag;
		}
	}

	public void RefreshData(PropWindowViewModel newVm)
	{
		_viewModel = newVm;
		this.SetDataContext(newVm);
		base.RefreshData(newVm);
	}

	protected override void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel == null)
		{
			return;
		}
		SetRectInfo();
		RefreshCurHasCount();
		if (_viewModel.Data is PropData { Empty: false } propData)
		{
			((Component)(object)propDesc).gameObject.SetActive(value: false);
			if (propData.UseType.Contains(21))
			{
				RefreshArmourCustom(propData);
				functionPart.SetActive(value: false);
				sourcePart.SetActive(value: false);
			}
			else
			{
				RefreshFunctionDesc(propData);
				RefreshSource(propData);
				armourCustomPart.SetActive(value: false);
			}
		}
		else
		{
			functionPart.SetActive(value: false);
			sourcePart.SetActive(value: false);
			armourCustomPart.SetActive(value: false);
			RefreshDesc();
		}
	}

	private void RefreshFunctionDesc(PropData propData)
	{
		((TMP_Text)functionDesc).text = propData.Function.Replace("\\n", "\n");
		functionPart.SetActive(value: true);
	}

	private void RefreshSource(PropData propData)
	{
		if (propData.SourceName.Count <= 0)
		{
			sourcePart.gameObject.SetActive(value: false);
			return;
		}
		string empty = string.Empty;
		List<int> list = new List<int>();
		for (int i = 0; i < propData.SourceName.Count; i++)
		{
			empty = string.Empty;
			list.Clear();
			PropSourceItemData propSourceItemData = null;
			if (_viewModel.AllowSkipWindow)
			{
				if (propData.SourceWindow.Count > i && !propData.SourceWindow[i].Equals("0"))
				{
					empty = propData.SourceWindow[i];
				}
				if (propData.SourceParams.Count > i)
				{
					foreach (int item in propData.SourceParams[i])
					{
						list.Add(item);
					}
				}
				propSourceItemData = new PropSourceItemData(_viewModel, propData.SourceName[i], empty, list);
			}
			else
			{
				propSourceItemData = new PropSourceItemData(_viewModel, propData.SourceName[i]);
			}
			if (sourceItems.Count <= i)
			{
				PropSourceItem propSourceItem = UnityEngine.Object.Instantiate(sourceTpl, sourceRoot);
				sourceItems.Add(propSourceItem);
				propSourceItem.Init(propSourceItemData);
			}
			else
			{
				sourceItems[i].RefreshData(propSourceItemData);
			}
			sourceItems[i].gameObject.SetActive(value: true);
		}
		if (sourceItems.Count > propData.SourceName.Count)
		{
			for (int j = propData.SourceName.Count; j < sourceItems.Count; j++)
			{
				sourceItems[j].gameObject.SetActive(value: false);
			}
		}
		sourcePart.gameObject.SetActive(value: true);
	}

	private void RefreshArmourCustom(PropData propData)
	{
		((TMP_Text)armourCustomTitle).text = propData.Description;
		DREquipmentPacks dataRow = GameEntry.DataTable.GetDataRow<DREquipmentPacks>(propData.Id);
		if (dataRow != null)
		{
			((TMP_Text)armourCustomDesc).text = ArmourCustomDefinition.GetDescription(dataRow, "#120303", "#4a4040");
		}
		armourCustomPart.SetActive(value: true);
	}

	protected override void OnDestroy()
	{
		for (int num = sourceItems.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.DestroyImmediate(sourceItems[num]);
			sourceItems[num] = null;
		}
		sourceItems = null;
		base.OnDestroy();
	}
}
