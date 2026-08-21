using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildMemberView : UGuiView
{
	[SerializeField]
	private List<TabItem> subTabs;

	[SerializeField]
	private List<GameObject> subViews;

	[SerializeField]
	private LoopListView2 scrollView;

	[SerializeField]
	private TextMeshProUGUI emptyListTips;

	[SerializeField]
	private TextMeshProUGUI memberCount;

	[SerializeField]
	private Button btnOpenGuildPosition;

	[SerializeField]
	private Button btnExitGuild;

	[SerializeField]
	private TextMeshProUGUI applicationCount;

	[SerializeField]
	private Button btnOpenAuditSetting;

	[SerializeField]
	private Button btnRefuseAllApply;

	[SerializeField]
	private Button btnPassAllApply;

	[SerializeField]
	private Button btnRefreshRecommendPlayer;

	[SerializeField]
	private Button btnSendRecruitMsg;

	[SerializeField]
	private Button btnInviteAllPlayer;

	[SerializeField]
	private RectTransform memberOptionPanel;

	[SerializeField]
	private VerticalLayoutGroup optionPanelLayout;

	[SerializeField]
	private float optionItemHeight;

	[SerializeField]
	private Button btnCloseOptionPanel;

	[SerializeField]
	private Button btnOpenMemberInfo;

	[SerializeField]
	private Button btnSetViceMaster;

	[SerializeField]
	private Button btnSetExcellentMember;

	[SerializeField]
	private Button btnSetNormalMember;

	[SerializeField]
	private Button btnKickMember;

	[SerializeField]
	private Button btnTransMaster;

	private GuildMemberViewModel _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<GuildMemberViewModel>(userData);
		BindingSet<GuildMemberView, GuildMemberViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((GuildMemberView v) => v.OnTabClick).To((GuildMemberViewModel vm) => vm.OnTabClickRst);
		bindingSet.Bind().For((GuildMemberView v) => v.RefreshList).To((GuildMemberViewModel vm) => vm.RefreshListRst);
		bindingSet.Bind(((Component)(object)emptyListTips).gameObject).For((GameObject v) => v.activeSelf).ToExpression((GuildMemberViewModel vm) => !string.IsNullOrEmpty(vm.ListTips));
		bindingSet.Bind<TextMeshProUGUI>(emptyListTips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildMemberViewModel vm) => vm.ListTips);
		bindingSet.Bind<TextMeshProUGUI>(memberCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildMemberViewModel vm) => vm.MemberCountText);
		bindingSet.Bind<TextMeshProUGUI>(applicationCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildMemberViewModel vm) => vm.ApplicationCountText);
		bindingSet.Bind(btnOpenGuildPosition).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("OpenGuildPosition");
		bindingSet.Bind(btnExitGuild).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("ExitGuild");
		bindingSet.Bind(btnOpenAuditSetting).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("OpenAuditSetting");
		bindingSet.Bind(btnRefuseAllApply).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("RefuseAllApplication");
		bindingSet.Bind(btnPassAllApply).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("PassAllApplication");
		bindingSet.Bind(btnRefreshRecommendPlayer).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("RefreshRecommend");
		bindingSet.Bind(btnSendRecruitMsg).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("SendRecruit");
		bindingSet.Bind(btnInviteAllPlayer).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("InviteAll");
		bindingSet.Bind(btnOpenMemberInfo).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("OpenMemberInfo");
		bindingSet.Bind(btnSetViceMaster).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("SetViceMaster");
		bindingSet.Bind(btnSetExcellentMember).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("SetExcellentMember");
		bindingSet.Bind(btnSetNormalMember).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("SetNormalMember");
		bindingSet.Bind(btnKickMember).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("KickMember");
		bindingSet.Bind(btnTransMaster).For((Button v) => v.onClick).To((GuildMemberViewModel vm) => vm.RequestCmd)
			.CommandParameter("TransMaster");
		bindingSet.Bind().For((GuildMemberView v) => v.OpenOptionPanel).To((GuildMemberViewModel vm) => vm.OpenOptionPanelRst);
		bindingSet.Bind().For((GuildMemberView v) => v.CloseOptionPanel).To((GuildMemberViewModel vm) => vm.CloseOptionPanelRst);
		bindingSet.Bind().For((GuildMemberView v) => v.OnNewApplicationReceived).To((GuildMemberViewModel vm) => vm.OnNewApplicationRst);
		bindingSet.Build();
		RefreshLayoutByPermission();
		InitSubTabs();
		InitApplicationRed();
		scrollView.InitListView(_viewModel.GuildMembers.Count, OnGetItemByIndex);
		btnCloseOptionPanel.onClick.AddListener(delegate
		{
			btnCloseOptionPanel.gameObject.SetActive(value: false);
			memberOptionPanel.gameObject.SetActive(value: false);
		});
	}

	private void InitSubTabs()
	{
		if (subTabs != null)
		{
			GuildDefinition.GuildPositions position = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData().Position;
			for (int i = 0; i < subTabs.Count; i++)
			{
				subTabs[i].Init(new TabItemData(_viewModel, i + 1));
			}
			if (_viewModel.TabIndex == 2 && GuildDefinition.CheckGuildMemberPermission(position, GuildDefinition.GuildPermissions.ReplyApplication) && subTabs.Count >= 2)
			{
				subTabs[1].ViewModel.TabOnClick();
			}
			else if (_viewModel.TabIndex == 3 && GuildDefinition.CheckGuildMemberPermission(position, GuildDefinition.GuildPermissions.Find) && subTabs.Count >= 3)
			{
				subTabs[2].ViewModel.TabOnClick();
			}
			else if (subTabs.Count > 0)
			{
				subTabs[0].ViewModel.TabOnClick();
			}
		}
	}

	private void InitApplicationRed()
	{
		if (subTabs != null && subTabs.Count >= 2)
		{
			subTabs[1]?.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildApplicationUnread).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).GuildApplicationUnRead)
				.Invoke();
		}
	}

	private void OnTabClick(object sender, InteractionEventArgs e)
	{
		if (subViews != null)
		{
			for (int i = 0; i < subViews.Count; i++)
			{
				subViews[i].SetActive(_viewModel.TabIndex == i + 1);
			}
		}
		RefreshList();
	}

	private void RefreshList(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.TabIndex == 1)
		{
			scrollView.SetListItemCount(_viewModel.GuildMembers.Count);
		}
		else if (_viewModel.TabIndex == 2)
		{
			scrollView.SetListItemCount(_viewModel.GuildApplications.Count);
		}
		else if (_viewModel.TabIndex == 3)
		{
			scrollView.SetListItemCount(_viewModel.RecommendPlayers.Count);
		}
		scrollView.RefreshAllShownItem();
	}

	private void OpenOptionPanel(object sender, InteractionEventArgs e)
	{
		if (e.Context is GuildMemberItem guildMemberItem)
		{
			GuildDefinition.GuildPositions position = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData().Position;
			GuildDefinition.GuildPositions position2 = guildMemberItem.ViewModel.Position;
			int num = 0;
			btnOpenMemberInfo.gameObject.SetActive(value: true);
			num++;
			bool flag = position == GuildDefinition.GuildPositions.Master && position2 == GuildDefinition.GuildPositions.ExcellentMember;
			btnSetViceMaster.gameObject.SetActive(flag);
			num = (flag ? (num + 1) : num);
			bool flag2 = position == GuildDefinition.GuildPositions.Master && (position2 == GuildDefinition.GuildPositions.NormalMember || position2 == GuildDefinition.GuildPositions.ViceMaster);
			btnSetExcellentMember.gameObject.SetActive(flag2);
			num = (flag2 ? (num + 1) : num);
			bool flag3 = position == GuildDefinition.GuildPositions.Master && position2 == GuildDefinition.GuildPositions.ExcellentMember;
			btnSetNormalMember.gameObject.SetActive(flag3);
			num = (flag3 ? (num + 1) : num);
			bool flag4 = position switch
			{
				GuildDefinition.GuildPositions.ViceMaster => position2 > GuildDefinition.GuildPositions.ViceMaster, 
				GuildDefinition.GuildPositions.Master => true, 
				_ => false, 
			};
			btnKickMember.gameObject.SetActive(flag4);
			num = (flag4 ? (num + 1) : num);
			bool flag5 = position == GuildDefinition.GuildPositions.Master && position2 == GuildDefinition.GuildPositions.ViceMaster;
			btnTransMaster.gameObject.SetActive(flag5);
			num = (flag5 ? (num + 1) : num);
			float num2 = optionItemHeight * (float)num + (float)optionPanelLayout.padding.top + (float)optionPanelLayout.padding.bottom;
			memberOptionPanel.SetParent(guildMemberItem.BtnOption.transform);
			if (Math.Abs(guildMemberItem.RectTransform.anchoredPosition.y) > num2)
			{
				memberOptionPanel.anchorMin = new Vector2(0f, 0.5f);
				memberOptionPanel.anchorMax = new Vector2(0f, 0.5f);
				memberOptionPanel.pivot = new Vector2(1f, 0f);
			}
			else
			{
				memberOptionPanel.anchorMin = new Vector2(0f, 0.5f);
				memberOptionPanel.anchorMax = new Vector2(0f, 0.5f);
				memberOptionPanel.pivot = new Vector2(1f, 1f);
			}
			memberOptionPanel.anchoredPosition = Vector2.zero;
			memberOptionPanel.SetParent(btnCloseOptionPanel.transform);
			btnCloseOptionPanel.gameObject.SetActive(value: true);
			memberOptionPanel.gameObject.SetActive(value: true);
		}
	}

	private void CloseOptionPanel(object sender, InteractionEventArgs e)
	{
		btnCloseOptionPanel.gameObject.SetActive(value: false);
		memberOptionPanel.gameObject.SetActive(value: false);
	}

	private void OnNewApplicationReceived(object sender, InteractionEventArgs e)
	{
		if (subTabs.Count >= 2)
		{
			if (_viewModel.TabIndex != 2)
			{
				subTabs[1].ViewModel.Red = true;
			}
			else
			{
				subTabs[1].ViewModel.TabOnClick();
			}
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		LoopListViewItem2 loopListViewItem = null;
		UGuiView uGuiView = null;
		OptionBase userData = null;
		if (_viewModel.TabIndex == 1)
		{
			if (index < 0 || index >= _viewModel.GuildMembers.Count)
			{
				return null;
			}
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
				.Uid;
			loopListViewItem = scrollView.NewListViewItem("GuildMemberItem");
			uGuiView = ((loopListViewItem == null) ? null : loopListViewItem.GetComponent<GuildMemberItem>());
			userData = new GuildMemberItemData(_viewModel, _viewModel.GuildMembers[index], uid == _viewModel.GuildMembers[index].Uid);
		}
		else if (_viewModel.TabIndex == 2)
		{
			if (index < 0 || index >= _viewModel.GuildApplications.Count)
			{
				return null;
			}
			loopListViewItem = scrollView.NewListViewItem("GuildApplicationItem");
			uGuiView = ((loopListViewItem == null) ? null : loopListViewItem.GetComponent<GuildPlayerItem>());
			userData = new GuildPlayerItemData(_viewModel, _viewModel.GuildApplications[index]);
		}
		else if (_viewModel.TabIndex == 3)
		{
			if (index < 0 || index >= _viewModel.RecommendPlayers.Count)
			{
				return null;
			}
			loopListViewItem = scrollView.NewListViewItem("GuildRecommendPlayerItem");
			uGuiView = ((loopListViewItem == null) ? null : loopListViewItem.GetComponent<GuildPlayerItem>());
			userData = new GuildPlayerItemData(_viewModel, _viewModel.RecommendPlayers[index]);
		}
		if (loopListViewItem == null || uGuiView == null)
		{
			return null;
		}
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			uGuiView.Init(userData);
		}
		else
		{
			uGuiView.RefreshData(userData);
		}
		return loopListViewItem;
	}

	public void RefreshLayoutByPermission()
	{
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
		if (myGuildData != null)
		{
			GuildDefinition.GuildPositions position = myGuildData.Position;
			if (subTabs != null)
			{
				subTabs[1].gameObject.SetActive(GuildDefinition.CheckGuildMemberPermission(position, GuildDefinition.GuildPermissions.ReplyApplication));
				subTabs[2].gameObject.SetActive(GuildDefinition.CheckGuildMemberPermission(position, GuildDefinition.GuildPermissions.Find));
				subTabs[0].ViewModel?.TabOnClick();
			}
			btnOpenAuditSetting.gameObject.SetActive(GuildDefinition.CheckGuildMemberPermission(position, GuildDefinition.GuildPermissions.AuditSetting));
		}
	}
}
