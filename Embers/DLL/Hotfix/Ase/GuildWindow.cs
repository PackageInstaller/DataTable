using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildWindow : UGuiWindowBase
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItem infoTab;

	[SerializeField]
	private TabItem memberTab;

	[SerializeField]
	private TabItem taskTab;

	[SerializeField]
	private TabItem shopTab;

	[SerializeField]
	private TabItem activityTab;

	[SerializeField]
	private GuildInfoView infoView;

	[SerializeField]
	private GuildMemberView memberView;

	[SerializeField]
	private GuildTaskView taskView;

	[SerializeField]
	private GuildShopView shopView;

	[SerializeField]
	private GuildActivityView activityView;

	private GuildViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildViewModel>();
		BindingSet<GuildWindow, GuildViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildWindow v) => v.OnDismissRequest).To((GuildViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildWindow v) => v.OpenUguiWindow).To((GuildViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((GuildWindow v) => v.SetChildViewVisibility).To((GuildViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GuildViewModel vm) => vm.Close);
		bindingSet.Bind().For((GuildWindow v) => v.OnTabClick).To((GuildViewModel vm) => vm.OnTabClickRst);
		bindingSet.Build();
		Init();
		SettleInitParam();
	}

	private void Init()
	{
		infoView.Init(_viewModel.InfoViewModel);
		memberView.Init(_viewModel.MemberViewModel);
		taskView.Init(_viewModel.TaskViewModel);
		shopView.Init(_viewModel.ShopViewModel);
		activityView.Init(_viewModel.ActivityViewModel);
		infoTab.Init(_viewModel.CreateTabItemData(1));
		memberTab.Init(_viewModel.CreateTabItemData(2));
		taskTab.Init(_viewModel.CreateTabItemData(3));
		shopTab.Init(_viewModel.CreateTabItemData(4));
		activityTab.Init(_viewModel.CreateTabItemData(5));
		infoTab.GetComponent<UIRedPoint>()?.Dispose();
		infoTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildBuild).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).GuildCanBuild)
			.Invoke();
		taskTab.GetComponent<UIRedPoint>()?.Dispose();
		taskTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildTaskComplete).AddEnum(RedPointMessageEnum.GuildActiveReward)
			.SetFuncOnMessage(delegate
			{
				RedPointService redPointService = (RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
				return redPointService.GuildTaskCanComplete || redPointService.GuildActiveRewardCanGet;
			})
			.Invoke();
		memberTab.GetComponent<UIRedPoint>()?.Dispose();
		memberTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildApplicationUnread).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).GuildApplicationUnRead)
			.Invoke();
		shopTab.GetComponent<UIRedPoint>()?.Dispose();
		shopTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ShopRed).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).MainShopReds.Contains(GuildDefinition.GetGuildMainShopId()))
			.Invoke();
		activityTab.GetComponent<UIRedPoint>()?.Dispose();
		activityTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.GuildActivityUnread).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).GuildActivityUnread)
			.Invoke();
		if (_viewModel.CurTabIndex == 1)
		{
			infoTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == 2)
		{
			memberTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == 3)
		{
			taskTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == 4)
		{
			shopTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == 5)
		{
			activityTab.ViewModel.TabOnClick();
		}
		OnTabClick();
	}

	private async void OnTabClick(object sender = null, InteractionEventArgs e = null)
	{
		infoView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 1) ? 1 : 0);
		infoView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 1;
		if (_viewModel.CurTabIndex == 2)
		{
			memberView.RefreshLayoutByPermission();
		}
		memberView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 2) ? 1 : 0);
		memberView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 2;
		taskView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 3) ? 1 : 0);
		taskView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 3;
		if (_viewModel.CurTabIndex == 4)
		{
			await _viewModel.RequestData();
			await _viewModel.ShopViewModel.OnOpen();
		}
		shopView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 4) ? 1 : 0);
		shopView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 4;
		activityView.CanvasGroup.alpha = ((_viewModel.CurTabIndex == 5) ? 1 : 0);
		activityView.CanvasGroup.blocksRaycasts = _viewModel.CurTabIndex == 5;
		switch (_viewModel.CurTabIndex)
		{
		case 1:
		{
			Animator component4 = infoView.GetComponent<Animator>();
			if (component4 != null)
			{
				component4.SetTrigger("enter");
			}
			break;
		}
		case 2:
		{
			Animator component2 = memberView.GetComponent<Animator>();
			if (component2 != null)
			{
				component2.SetTrigger("enter");
			}
			break;
		}
		case 3:
		{
			Animator component3 = taskView.GetComponent<Animator>();
			if (component3 != null)
			{
				component3.SetTrigger("enter");
			}
			break;
		}
		case 4:
		{
			Animator component = shopView.GetComponent<Animator>();
			if (component != null)
			{
				component.SetTrigger("enter");
			}
			break;
		}
		case 5:
			break;
		}
	}

	private async UniTaskVoid SettleInitParam()
	{
		if (_viewModel != null && _viewModel.initParam != null)
		{
			await UniTask.WaitUntil(() => Visibility);
			_viewModel.SettleInitParam();
		}
	}
}
