using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BFBEWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItem battleEmoteTab;

	[SerializeField]
	private TabItem bubbleTab;

	[SerializeField]
	private TabItem decorationTab;

	[SerializeField]
	private TabItem indicatorTab;

	[SerializeField]
	private HeroDisplaySetView heroDisplaySetView;

	[SerializeField]
	private ChatBubbleSetView chatBubbleSetView;

	[SerializeField]
	private BattleEmoteSetView battleEmoteSetView;

	[SerializeField]
	private IndicatorSetView indicatorSetView;

	private BFBEViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BFBEViewModel>();
		BindingSet<BFBEWindow, BFBEViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BFBEWindow v) => v.OnDismissRequest).To((BFBEViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BFBEWindow v) => v.OpenUguiWindow).To((BFBEViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BFBEViewModel vm) => vm.Close);
		bindingSet.Bind().For((BFBEWindow v) => v.OnTabClick).To((BFBEViewModel vm) => vm.OnTabClickRst);
		bindingSet.Build();
		Init();
		OnTabClick();
	}

	private void Init()
	{
		heroDisplaySetView.Init(new HeroDisplaySetViewModel(viewModel));
		chatBubbleSetView.Init(new ChatBubbleSetViewModel(viewModel));
		battleEmoteSetView.Init(new BattleEmoteSetViewModel(viewModel));
		indicatorSetView.Init(new IndicatorSetViewModel(viewModel));
		decorationTab.Init(viewModel.CreateTabItemData(1));
		bubbleTab.Init(viewModel.CreateTabItemData(2));
		battleEmoteTab.Init(viewModel.CreateTabItemData(3));
		indicatorTab.Init(viewModel.CreateTabItemData(4));
		battleEmoteTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.BattleEmoji).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.BattleEmote) ?? new List<RoleDecorateData>()).Exists((RoleDecorateData p) => p.isNew))
			.Invoke();
		bubbleTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ChatBubble).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.ChatBubble) ?? new List<RoleDecorateData>()).Exists((RoleDecorateData p) => p.isNew))
			.Invoke();
		decorationTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroCardFrame).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.CardFrame) ?? new List<RoleDecorateData>()).Exists((RoleDecorateData p) => p.isNew))
			.Invoke();
		indicatorTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.Indicator).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.Indicator) ?? new List<RoleDecorateData>()).Exists((RoleDecorateData p) => p.isNew))
			.Invoke();
		foreach (RoleDecorateData item in Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.Indicator) ?? new List<RoleDecorateData>())
		{
			if (item.isNew)
			{
				viewModel.CurTabIndex = 4;
				break;
			}
		}
		foreach (RoleDecorateData item2 in Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.BattleEmote) ?? new List<RoleDecorateData>())
		{
			if (item2.isNew)
			{
				viewModel.CurTabIndex = 3;
				break;
			}
		}
		foreach (RoleDecorateData item3 in Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.ChatBubble) ?? new List<RoleDecorateData>())
		{
			if (item3.isNew)
			{
				viewModel.CurTabIndex = 2;
				break;
			}
		}
		foreach (RoleDecorateData item4 in Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.CardFrame) ?? new List<RoleDecorateData>())
		{
			if (item4.isNew)
			{
				viewModel.CurTabIndex = 1;
				break;
			}
		}
		viewModel.ByViewSetSelectTab();
	}

	private async void OnTabClick(object sender = null, InteractionEventArgs e = null)
	{
		heroDisplaySetView.CanvasGroup.alpha = ((viewModel.CurTabIndex == 1) ? 1 : 0);
		heroDisplaySetView.CanvasGroup.blocksRaycasts = viewModel.CurTabIndex == 1;
		chatBubbleSetView.CanvasGroup.alpha = ((viewModel.CurTabIndex == 2) ? 1 : 0);
		chatBubbleSetView.CanvasGroup.blocksRaycasts = viewModel.CurTabIndex == 2;
		battleEmoteSetView.CanvasGroup.alpha = ((viewModel.CurTabIndex == 3) ? 1 : 0);
		battleEmoteSetView.CanvasGroup.blocksRaycasts = viewModel.CurTabIndex == 3;
		indicatorSetView.CanvasGroup.alpha = ((viewModel.CurTabIndex == 4) ? 1 : 0);
		indicatorSetView.CanvasGroup.blocksRaycasts = viewModel.CurTabIndex == 4;
		if (battleEmoteSetView.CanvasGroup.alpha == 1f)
		{
			battleEmoteSetView.ViewOnEnable();
		}
	}
}
