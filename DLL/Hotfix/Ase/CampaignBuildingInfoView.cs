using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignBuildingInfoView : UGuiView
{
	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private GameObject unlockGo;

	[SerializeField]
	private GameObject lockGo;

	[SerializeField]
	private List<Button> btnCloseList;

	[SerializeField]
	private List<Image> buildingIconList;

	[SerializeField]
	private List<TextMeshProUGUI> buildingNames;

	[SerializeField]
	private List<TextMeshProUGUI> descriptions;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private RectTransform materialRoot;

	[SerializeField]
	private GameObject materialTpl;

	private GameObjectPool _materialPool;

	[SerializeField]
	private GameObject rewardGo;

	[SerializeField]
	private LoopListView2 rewards;

	[SerializeField]
	private Button btnUpgrade;

	[SerializeField]
	private List<GameObject> upgradeGos;

	private CampaignBuildingInfoViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignBuildingInfoViewModel>(userData);
		BindingSet<CampaignBuildingInfoView, CampaignBuildingInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(unlockGo).For((GameObject v) => v.activeSelf).To((CampaignBuildingInfoViewModel vm) => vm.Unlock);
		bindingSet.Bind(lockGo).For((GameObject v) => v.activeSelf).ToExpression((CampaignBuildingInfoViewModel vm) => !vm.Unlock);
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignBuildingInfoViewModel vm) => vm.Level);
		if (buildingIconList != null)
		{
			foreach (Image buildingIcon in buildingIconList)
			{
				if (!(buildingIcon == null))
				{
					bindingSet.Bind(buildingIcon).For((Image v) => v.sprite).To((CampaignBuildingInfoViewModel vm) => vm.BuildingIcon)
						.WithConversion("ItemIcon");
				}
			}
		}
		if (buildingNames != null)
		{
			foreach (TextMeshProUGUI buildingName in buildingNames)
			{
				if (!((UnityEngine.Object)(object)buildingName == null))
				{
					bindingSet.Bind<TextMeshProUGUI>(buildingName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignBuildingInfoViewModel vm) => vm.Name);
				}
			}
		}
		if (descriptions != null)
		{
			foreach (TextMeshProUGUI description in descriptions)
			{
				if (!((UnityEngine.Object)(object)description == null))
				{
					bindingSet.Bind<TextMeshProUGUI>(description).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignBuildingInfoViewModel vm) => vm.Description);
				}
			}
		}
		if (upgradeGos != null)
		{
			foreach (GameObject upgradeGo in upgradeGos)
			{
				if (!(upgradeGo == null))
				{
					bindingSet.Bind(upgradeGo).For((GameObject v) => v.activeSelf).ToExpression((CampaignBuildingInfoViewModel vm) => vm.Unlock && !vm.IsMaxLevel);
				}
			}
		}
		bindingSet.Bind(btnUpgrade).For((Button v) => v.onClick).To((CampaignBuildingInfoViewModel vm) => vm.OnUpgradeClick);
		bindingSet.Bind().For((CampaignBuildingInfoView v) => v.RefreshLoopList).To((CampaignBuildingInfoViewModel vm) => vm.AreaDataRefreshRst);
		bindingSet.Build();
		btnOutside.onClick.AddListener(Hide);
		btnCloseList?.ForEach(delegate(Button p)
		{
			p.onClick.AddListener(Hide);
		});
		rewards.InitListView(_viewModel.Rewards.Count, OnGetRewardItemByIndex);
		_materialPool = new GameObjectPool(materialTpl, materialRoot);
		RefreshMaterial();
	}

	private void RefreshLoopList(object sender, InteractionEventArgs e)
	{
		RefreshMaterial();
		rewards.SetListItemCount(_viewModel.Rewards.Count);
		rewards.RefreshAllShownItem();
	}

	private void RefreshMaterial()
	{
		_materialPool.RecycleAll();
		foreach (PropDataBase material in _viewModel.Materials)
		{
			(int, long) tuple = _viewModel.MaterialInfos.Find(((int, long) p) => p.Item1.Equals(material.Id));
			BaseItem component = _materialPool.Allocate(out var newCreate).GetComponent<BaseItem>();
			BaseItemData baseItemData = new BaseItemData(_viewModel)
			{
				Icon = material.Icon,
				Text = $"{tuple.Item2}/{material.Amount}"
			};
			if (newCreate)
			{
				component.Init(baseItemData);
			}
			else
			{
				component.RefreshData(baseItemData);
			}
		}
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.Rewards.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			KnapsackItemViewModel viewModel = new KnapsackItemViewModel(_viewModel.Parent, _viewModel.Rewards[index]);
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel);
			}
			else
			{
				component.RefreshData(viewModel);
			}
		}
		return loopListViewItem;
	}

	public void RefreshAreaData(CampaignBuildingData areaData)
	{
		_viewModel.RefreshAreaData(areaData);
	}

	public void Show()
	{
		CanvasGroup.alpha = 1f;
		CanvasGroup.blocksRaycasts = true;
	}

	public void Hide()
	{
		CanvasGroup.alpha = 0f;
		CanvasGroup.blocksRaycasts = false;
	}
}
