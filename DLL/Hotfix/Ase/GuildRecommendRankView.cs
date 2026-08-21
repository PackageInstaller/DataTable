using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildRecommendRankView : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI noTips;

	[SerializeField]
	private GameObject guildInfoPart;

	[SerializeField]
	private Image headFrame;

	[SerializeField]
	private Image headIcon;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private Text masterName;

	[SerializeField]
	private Text guildDesc;

	[SerializeField]
	private TextMeshProUGUI applyLevelThreshold;

	[SerializeField]
	private TextMeshProUGUI auditType;

	[SerializeField]
	private TextMeshProUGUI guildUid;

	[SerializeField]
	private Button btnApply;

	[SerializeField]
	private GameObject btnApplyMask;

	[SerializeField]
	private LoopListView2 scrollList;

	private GuildRecommendRankViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildRecommendRankViewModel>(userData);
		BindingSet<GuildRecommendRankView, GuildRecommendRankViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((GuildRecommendRankViewModel vm) => vm.RequestJoinInGuildCmd);
		bindingSet.Bind(btnApplyMask).For((GameObject v) => v.activeSelf).To((GuildRecommendRankViewModel vm) => vm.ShowBtnApplyMask);
		bindingSet.Bind(((Component)(object)noTips).gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildRecommendRankViewModel vm) => !string.IsNullOrEmpty(vm.NoTips));
		bindingSet.Bind<TextMeshProUGUI>(noTips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendRankViewModel vm) => vm.NoTips);
		bindingSet.Bind(guildInfoPart).For((GameObject v) => v.activeSelf).To((GuildRecommendRankViewModel vm) => vm.ShowInfo);
		bindingSet.Bind(headIcon).For((Image v) => v.sprite).To((GuildRecommendRankViewModel vm) => vm.HeadIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(headFrame).For((Image v) => v.sprite).To((GuildRecommendRankViewModel vm) => vm.HeadFrameIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendRankViewModel vm) => vm.MasterLevel);
		bindingSet.Bind(masterName).For((Text v) => v.text).To((GuildRecommendRankViewModel vm) => vm.MasterName);
		bindingSet.Bind(guildDesc).For((Text v) => v.text).To((GuildRecommendRankViewModel vm) => vm.GuildDesc);
		bindingSet.Bind<TextMeshProUGUI>(applyLevelThreshold).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendRankViewModel vm) => vm.ApplyLevelThreshold);
		bindingSet.Bind<TextMeshProUGUI>(auditType).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendRankViewModel vm) => vm.AuditType);
		bindingSet.Bind<TextMeshProUGUI>(guildUid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildRecommendRankViewModel vm) => vm.GuildUid);
		bindingSet.Bind().For((GuildRecommendRankView v) => v.OnRankDatasChanged).To((GuildRecommendRankViewModel vm) => vm.OnRankDatasChanged);
		bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((GuildRecommendRankViewModel vm) => vm.RequestJoinInGuildCmd);
		bindingSet.Build();
		scrollList.InitListView(_viewModel.RankDatas.Count, OnGetItemByIndex);
	}

	private void OnRankDatasChanged(object sender, InteractionEventArgs e)
	{
		scrollList.SetListItemCount(_viewModel.RankDatas.Count);
		scrollList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.RankDatas.Count)
		{
			return null;
		}
		KeyValuePair<int, GuildData> keyValuePair = _viewModel.RankDatas[index];
		LoopListViewItem2 loopListViewItem = scrollList.NewListViewItem("GuildRankItem");
		GuildRankItemData guildRankItemData = new GuildRankItemData(_viewModel, keyValuePair.Value, keyValuePair.Key);
		GuildRankItem component = loopListViewItem.GetComponent<GuildRankItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(guildRankItemData);
		}
		else
		{
			component.RefreshData(guildRankItemData);
		}
		if (index == 0)
		{
			guildRankItemData.OnItemClick();
		}
		return loopListViewItem;
	}
}
