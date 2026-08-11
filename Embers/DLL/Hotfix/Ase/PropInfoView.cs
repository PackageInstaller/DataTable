using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PropInfoView : UGuiView
{
	[SerializeField]
	private Button outsideBtn;

	[SerializeField]
	private RectTransform prop;

	[SerializeField]
	private Image qualityTitleImg;

	[SerializeField]
	private Image qualityImg;

	[SerializeField]
	private Image propIcon;

	[SerializeField]
	private TextMeshProUGUI propName;

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
	private GameObject ownCountPart;

	[SerializeField]
	private TextMeshProUGUI curHasText;

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

	private PropInfoViewModel _viewModel;

	private EventHandler onDismissed;

	private List<PropSourceItem> sourceItems = new List<PropSourceItem>();

	public PropInfoViewModel ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		_viewModel = GetUserData<PropInfoViewModel>(userData);
		BindingSet<PropInfoView, PropInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((PropInfoView v) => v.OnVisibleChanged).To((PropInfoViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((PropInfoView v) => v.OpenWindow).To((PropInfoViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(outsideBtn).For((Button v) => v.onClick).To((PropInfoViewModel vm) => vm.Hide);
		bindingSet.Bind<TextMeshProUGUI>(propName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropInfoViewModel vm) => vm.PropData.Name);
		bindingSet.Bind(propIcon).For((Image v) => v.sprite).ToExpression((PropInfoViewModel vm) => vm.PropData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityTitleImg).For((Image v) => v.sprite).ToExpression((PropInfoViewModel vm) => $"Prop_Title_{vm.PropData.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(qualityImg).For((Image v) => v.sprite).ToExpression((PropInfoViewModel vm) => $"Prop_Bg_{vm.PropData.Quality}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(outsideBtn.gameObject).For((GameObject v) => v.activeSelf).To((PropInfoViewModel vm) => vm.ShowOutsideMask);
		bindingSet.Bind(ownCountPart.gameObject).For((GameObject v) => v.activeSelf).To((PropInfoViewModel vm) => vm.ShowOwnCount);
		bindingSet.Bind().For((PropInfoView v) => v.Refresh).To((PropInfoViewModel vm) => vm.RefreshRst);
		if (armourRank != null)
		{
			bindingSet.Bind(armourRank).For((GameObject v) => v.activeSelf).To((PropInfoViewModel vm) => vm.ShowArmourRank);
		}
		if (rankColor != null)
		{
			bindingSet.Bind(rankColor).For((Image v) => v.color).To((PropInfoViewModel vm) => vm.ArmourRankColor);
		}
		if ((UnityEngine.Object)(object)rank != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(rank).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PropInfoViewModel vm) => vm.ArmourRankText);
		}
		if (armourType != null)
		{
			bindingSet.Bind(armourType.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PropInfoViewModel vm) => !string.IsNullOrEmpty(vm.ArmourTypeIcon));
			bindingSet.Bind(armourType).For((Image v) => v.sprite).To((PropInfoViewModel vm) => vm.ArmourTypeIcon)
				.WithConversion("ItemIcon");
		}
		if (expirePart != null && (UnityEngine.Object)(object)expireText != null)
		{
			bindingSet.Bind(expirePart).For((GameObject v) => v.activeSelf).ToExpression((PropInfoViewModel vm) => (int)vm.PropData.PropTimeLimitEnum != 0);
			bindingSet.Bind<TextMeshProUGUI>(expireText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PropInfoViewModel vm) => vm.PropData.TimeLimitText);
		}
		bindingSet.Build();
	}

	public void RefreshData(PropInfoViewModel newVm)
	{
		_viewModel = newVm;
		this.SetDataContext(newVm);
		Refresh();
	}

	public void SetAnchorAndPivot(Vector2 anchorMin, Vector2 anchorMax, Vector2 pivot)
	{
		prop.anchorMin = anchorMin;
		prop.anchorMax = anchorMax;
		prop.pivot = pivot;
	}

	private void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel == null)
		{
			return;
		}
		prop.anchoredPosition = _viewModel.Vector3;
		PropData propData = _viewModel.PropData;
		if (propData != null)
		{
			if (propData.UseType.Contains(21))
			{
				RefreshArmourCustom(propData);
				functionPart.gameObject.SetActive(value: false);
				sourcePart.gameObject.SetActive(value: false);
			}
			else
			{
				RefreshFunctionDesc(propData);
				RefreshSource(propData);
				armourCustomPart.SetActive(value: false);
			}
			if (_viewModel.ShowOwnCount)
			{
				RefreshCurHasCount(propData);
			}
		}
	}

	private void RefreshFunctionDesc(PropData propData)
	{
		((TMP_Text)functionDesc).text = propData.Function.Replace("\\n", "\n");
		functionPart.gameObject.SetActive(value: true);
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

	private void RefreshCurHasCount(PropData propData)
	{
		int propOwnedCount = PropHelper.GetPropOwnedCount(propData.Id);
		((TMP_Text)curHasText).text = $"当前拥有 {propOwnedCount}";
	}

	private async void OpenWindow(object sender, InteractionEventArgs args)
	{
		Action callback = args.Callback;
		object context = args.Context;
		Window w = null;
		if (context is HeroWarehouseViewModel)
		{
			w = await GameEntry.UI.OpenWindow<HeroWarehouseWindow>("Hero/HeroWarehouseWindow", context);
		}
		else if (context is WorldMapViewModel)
		{
			w = await GameEntry.UI.OpenWindow<WorldMapWindow>("Map/WorldMapWindow", context);
		}
		else if (context is MapViewModel)
		{
			w = await GameEntry.UI.OpenWindow<MapWindow>("Map/MapWindow", context);
		}
		if (w != null && callback != null)
		{
			w.OnDismissed += Handler;
		}
		void Handler(object window, EventArgs e)
		{
			w.OnDismissed -= Handler;
			callback();
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		Refresh();
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
