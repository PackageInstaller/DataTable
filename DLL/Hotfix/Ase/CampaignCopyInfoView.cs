using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CampaignCopyInfoView : UGuiView
{
	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private TextMeshProUGUI copyName;

	[SerializeField]
	private TextMeshProUGUI description;

	[SerializeField]
	private Button btnStart;

	[SerializeField]
	private TextMeshProUGUI btnStartText;

	[SerializeField]
	private RectTransform labelRoot;

	[SerializeField]
	private GameObject labelTpl;

	[SerializeField]
	private GameObject buffPart;

	[SerializeField]
	private RectTransform buffRoot;

	[SerializeField]
	private GameObject buffTpl;

	[SerializeField]
	private TextMeshProUGUI buffName;

	[SerializeField]
	private TextMeshProUGUI buffDesc;

	[SerializeField]
	private CanvasGroup buffInfoPanel;

	[SerializeField]
	private Button btnHideBuffInfo;

	[SerializeField]
	private LoopListView2 rewards;

	[SerializeField]
	private GameObject bossChallengeInfoGo;

	[SerializeField]
	private TextMeshProUGUI bossHpInfo;

	[SerializeField]
	private TextMeshProUGUI bossTimesInfo;

	[SerializeField]
	private GameObject consumeGo;

	[SerializeField]
	private Image consumeIcon;

	[SerializeField]
	private TextMeshProUGUI consumeCount;

	[SerializeField]
	private GameObject monsterInfoGo;

	[SerializeField]
	private Image monsterIcon;

	[SerializeField]
	private TextMeshProUGUI monsterLevelAndName;

	public LoopListView2 monsterAttrList;

	[SerializeField]
	private TextMeshProUGUI monsterDesc;

	private CampaignCopyInfoViewModel _viewModel;

	private GameObjectPool _labelPool;

	private GameObjectPool _buffPool;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<CampaignCopyInfoViewModel>(userData);
		BindingSet<CampaignCopyInfoView, CampaignCopyInfoViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(copyName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(description).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.Info);
		bindingSet.Bind(btnStart).For((Button v) => v.onClick).To((CampaignCopyInfoViewModel vm) => vm.OnStartClick);
		bindingSet.Bind<TextMeshProUGUI>(btnStartText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.BtnStartText);
		bindingSet.Bind().For((CampaignCopyInfoView v) => v.OnAreaDataRefresh).To((CampaignCopyInfoViewModel vm) => vm.AreaDataRefreshRst);
		bindingSet.Bind(buffPart).For((GameObject v) => v.activeSelf).To((CampaignCopyInfoViewModel vm) => vm.ShowBuffPart);
		bindingSet.Bind<TextMeshProUGUI>(buffName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.BuffInfoName);
		bindingSet.Bind<TextMeshProUGUI>(buffDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.BuffInfoDesc);
		bindingSet.Bind<CanvasGroup>(buffInfoPanel).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).ToExpression((CampaignCopyInfoViewModel vm) => vm.ShowBuffInfo ? 1 : 0);
		bindingSet.Bind<CanvasGroup>(buffInfoPanel).For((Expression<Func<CanvasGroup, bool>>)((CanvasGroup v) => v.blocksRaycasts)).To((CampaignCopyInfoViewModel vm) => vm.ShowBuffInfo);
		bindingSet.Bind(bossChallengeInfoGo).For((GameObject v) => v.activeSelf).To((CampaignCopyInfoViewModel vm) => vm.ShowChallengeInfo);
		bindingSet.Bind<TextMeshProUGUI>(bossHpInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.BossHpInfo);
		bindingSet.Bind(((Component)(object)bossHpInfo).gameObject).For((GameObject v) => v.activeSelf).ToExpression((CampaignCopyInfoViewModel vm) => !string.IsNullOrEmpty(vm.BossHpInfo));
		bindingSet.Bind<TextMeshProUGUI>(bossTimesInfo).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.BossTimesInfo);
		bindingSet.Bind(((Component)(object)bossTimesInfo).gameObject).For((GameObject v) => v.activeSelf).ToExpression((CampaignCopyInfoViewModel vm) => !string.IsNullOrEmpty(vm.BossTimesInfo));
		bindingSet.Bind(consumeGo).For((GameObject v) => v.activeSelf).To((CampaignCopyInfoViewModel vm) => vm.ShowConsume);
		bindingSet.Bind(consumeIcon).For((Image v) => v.sprite).To((CampaignCopyInfoViewModel vm) => vm.ConsumeIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(consumeCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.ConsumeCount);
		bindingSet.Bind(monsterInfoGo).For((GameObject v) => v.activeSelf).To((CampaignCopyInfoViewModel vm) => vm.ShowMonsterInfo);
		bindingSet.Bind(monsterIcon).For((Image v) => v.sprite).To((CampaignCopyInfoViewModel vm) => vm.MonsterIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(monsterLevelAndName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.BossLvAndName);
		bindingSet.Bind<TextMeshProUGUI>(monsterDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CampaignCopyInfoViewModel vm) => vm.BossDesc);
		bindingSet.Build();
		btnOutside.onClick.AddListener(Hide);
		btnClose.onClick.AddListener(Hide);
		btnHideBuffInfo.onClick.AddListener(delegate
		{
			if (_viewModel != null)
			{
				_viewModel.ShowBuffInfo = false;
			}
		});
		rewards.InitListView(_viewModel.Rewards.Count, OnGetRewardItemByIndex);
		monsterAttrList.InitListView(_viewModel.AdItemList.Count, OnGetAttributeItemByIndex);
		RefreshLabelsAndBuffs();
	}

	private void OnAreaDataRefresh(object sender, InteractionEventArgs e)
	{
		RefreshLabelsAndBuffs();
		rewards.SetListItemCount(_viewModel.Rewards.Count);
		rewards.RefreshAllShownItem();
		monsterAttrList.SetListItemCount(_viewModel.AdItemList.Count);
		monsterAttrList.RefreshAllShownItem();
	}

	private void RefreshLabelsAndBuffs()
	{
		if (_labelPool == null)
		{
			_labelPool = new GameObjectPool(labelTpl, labelRoot);
		}
		_labelPool.RecycleAll();
		foreach (string label in _viewModel.Labels)
		{
			((TMP_Text)_labelPool.Allocate().GetComponentInChildren<TextMeshProUGUI>()).text = label;
		}
		if (_buffPool == null)
		{
			_buffPool = new GameObjectPool(buffTpl, buffRoot);
		}
		_buffPool.RecycleAll();
		foreach (int buffId in _viewModel.EnvBuff)
		{
			DREnvironmentModifier dataRow = GameEntry.DataTable.GetDataRow((DREnvironmentModifier p) => p.BuffId.Equals(buffId));
			if (dataRow != null)
			{
				BaseItem component = _buffPool.Allocate(out var newCreate).GetComponent<BaseItem>();
				BaseItemData baseItemData = new BaseItemData(_viewModel)
				{
					Text = dataRow.ParadoxName,
					Arg = dataRow
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

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.AdItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			CopyBuffItemView component = loopListViewItem.GetComponent<CopyBuffItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				component.Init();
			}
			component.SetIcon(_viewModel.AdItemList[index]);
		}
		return loopListViewItem;
	}

	public void RefreshAreaData(CampaignMonsterData areaData)
	{
		_viewModel.RefreshAreaData(areaData);
	}

	public void RefreshAreaData(CampaignTaskData areaData)
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

	protected override void OnDestroy()
	{
		_labelPool?.Dispose();
		_buffPool?.Dispose();
		base.OnDestroy();
	}
}
