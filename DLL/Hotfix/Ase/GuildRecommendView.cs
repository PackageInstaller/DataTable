using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildRecommendView : UGuiView
{
	[SerializeField]
	private InputField inputField;

	[SerializeField]
	private Button btnClearInput;

	[SerializeField]
	private LoopListView2 scrollView;

	[SerializeField]
	private GameObject recommendBtns;

	[SerializeField]
	private Button btnRefresh;

	[SerializeField]
	private Button btnFastJoin;

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

	private GuildRecommendViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildRecommendViewModel>(userData);
		BindingSet<GuildRecommendView, GuildRecommendViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((GuildRecommendView v) => v.OnDisplayGuildsChanged).To((GuildRecommendViewModel vm) => vm.RefreshDisplayGuilds);
		bindingSet.Bind(btnRefresh).For((Button v) => v.onClick).To((GuildRecommendViewModel vm) => vm.RequestRecommendGuild);
		bindingSet.Bind(btnFastJoin).For((Button v) => v.onClick).To((GuildRecommendViewModel vm) => vm.RequestFastJoinCmd);
		bindingSet.Bind(recommendBtns).For((GameObject v) => v.activeSelf).ToExpression((GuildRecommendViewModel vm) => !vm.IsSearching);
		bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((GuildRecommendViewModel vm) => vm.RequestJoinInGuildCmd);
		bindingSet.Bind(btnApplyMask).For((GameObject v) => v.activeSelf).To((GuildRecommendViewModel vm) => vm.ShowBtnApplyMask);
		bindingSet.Bind(((Component)(object)noTips).gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildRecommendViewModel vm) => !string.IsNullOrEmpty(vm.NoTips));
		bindingSet.Bind<TextMeshProUGUI>(noTips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendViewModel vm) => vm.NoTips);
		bindingSet.Bind(guildInfoPart).For((GameObject v) => v.activeSelf).To((GuildRecommendViewModel vm) => vm.ShowInfo);
		bindingSet.Bind(headIcon).For((Image v) => v.sprite).To((GuildRecommendViewModel vm) => vm.HeadIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(headFrame).For((Image v) => v.sprite).To((GuildRecommendViewModel vm) => vm.HeadFrameIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendViewModel vm) => vm.MasterLevel);
		bindingSet.Bind(masterName).For((Text v) => v.text).To((GuildRecommendViewModel vm) => vm.MasterName);
		bindingSet.Bind(guildDesc).For((Text v) => v.text).To((GuildRecommendViewModel vm) => vm.GuildDesc);
		bindingSet.Bind<TextMeshProUGUI>(applyLevelThreshold).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendViewModel vm) => vm.ApplyLevelThreshold);
		bindingSet.Bind<TextMeshProUGUI>(auditType).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRecommendViewModel vm) => vm.AuditType);
		bindingSet.Bind<TextMeshProUGUI>(guildUid).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GuildRecommendViewModel vm) => vm.GuildUid);
		bindingSet.Build();
		inputField.onEndEdit.AddListener(_viewModel.OnInputFieldEndEdit);
		btnClearInput.onClick.AddListener(OnClearInput);
		scrollView.InitListView(_viewModel.DisplayGuilds.Count, OnGetItemByIndex);
	}

	private void OnClearInput()
	{
		if (!string.IsNullOrEmpty(inputField.text))
		{
			inputField.text = string.Empty;
			_viewModel.OnInputFieldEndEdit(string.Empty);
		}
	}

	private void OnDisplayGuildsChanged(object sender, InteractionEventArgs e)
	{
		scrollView.SetListItemCount(_viewModel.DisplayGuilds.Count);
		scrollView.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.DisplayGuilds.Count)
		{
			return null;
		}
		GuildData guildData = _viewModel.DisplayGuilds[index];
		if (guildData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = scrollView.NewListViewItem("GuildItem");
		GuildItemData guildItemData = new GuildItemData(_viewModel, guildData);
		GuildItem component = loopListViewItem.GetComponent<GuildItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(guildItemData);
		}
		else
		{
			component.RefreshData(guildItemData);
		}
		if (_viewModel.SelectGuild != null)
		{
			if (guildData.Uid == _viewModel.SelectGuild.Uid)
			{
				guildItemData.OnItemClick();
			}
		}
		else if (index == 0)
		{
			guildItemData.OnItemClick();
		}
		return loopListViewItem;
	}
}
