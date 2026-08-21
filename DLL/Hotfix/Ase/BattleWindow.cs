using System;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleWindow : UGuiWindow
{
	[SerializeField]
	private BattleUserInfoView userInfoView;

	[SerializeField]
	private BossBloodBarView bossBloodBarView;

	[SerializeField]
	private SystemInfoView systemInfoView;

	[SerializeField]
	private MiniMapView miniMapView;

	[SerializeField]
	private BattleTweenInfoView battleTweenInfoView;

	[SerializeField]
	private NPCPopDialogView npcPopDialogView;

	[SerializeField]
	private BattleUserSelfView battleUserSelfView;

	[SerializeField]
	private BattleTipFloatingWindow battleTipFloatingWindow;

	[SerializeField]
	private DirPosView dirPosView;

	[SerializeField]
	private BattleEmoteView _battleEmoteView;

	private BattleViewModel viewModel;

	[SerializeField]
	private CanvasGroup _panelAlpha;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleViewModel>();
		BindingSet<BattleWindow, BattleViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleWindow v) => v.OpenUguiWindow).To((BattleViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((BattleWindow v) => v.OnVisibleChanged).To((BattleViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((BattleWindow v) => v.OnHidePanelChanged).To((BattleViewModel vm) => vm.HidePanelRequest);
		bindingSet.Bind(this).For((BattleWindow v) => v.OnDismissRequest).To((BattleViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BattleWindow v) => v.SetChildViewVisibility).To((BattleViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind().For((BattleWindow v) => v.UpdateMiniMap).To((BattleViewModel vm) => vm.UpdateMiniMapRst);
		bindingSet.Build();
		viewModel.ChildViewParent = ((Component)(object)_panelAlpha).transform;
	}

	public void BingChildUI()
	{
		userInfoView.Init(viewModel.UserInfoViewModel);
		bossBloodBarView.Init(viewModel.BossInfoViewModel);
		systemInfoView.Init(viewModel.SystemInfoViewModel);
		miniMapView.Init(viewModel.MiniMapViewModel);
		battleTipFloatingWindow.Init();
		battleTweenInfoView.Init(viewModel.TweenInfoViewModel);
		npcPopDialogView.Init(viewModel.NpcPopDialogVM);
		_battleEmoteView?.Init(viewModel.BattleEmoteViewModel);
		dirPosView?.Init(viewModel.DirPosViewModel);
	}

	protected override void OnShow()
	{
		base.OnShow();
		AddBattleViews();
		UpdateMiniMap();
	}

	public void RefreshUserLayout(TouchLayout touchLayout)
	{
		if (userInfoView != null)
		{
			userInfoView.RefreshLayout(touchLayout);
		}
	}

	protected override async Task<bool> CheckOpenWindow(OpenViewArg openViewArg, string path, ViewConfig? config, string entrance, Action callback)
	{
		object userData = openViewArg.UserData;
		if (userData is TaotieEatViewModel taotieVM)
		{
			TaotieEatView taotieEatView = (await CheckOpenView(openViewArg.ViewName, path, taotieVM, config, entrance)) as TaotieEatView;
			if (taotieEatView != null)
			{
				taotieVM.SetAngleConfig(taotieEatView.RorateAnglesConfig);
			}
			return true;
		}
		return false;
	}

	private async void AddBattleViews()
	{
		for (int i = 0; i < viewModel.initOpenViews.Count; i++)
		{
			OpenUguiWindow(null, new InteractionEventArgs(viewModel.initOpenViews[i], null));
		}
		for (int j = 0; j < childViewList.Count; j++)
		{
			childViewList[j].OnShow();
		}
	}

	private void UpdateMiniMap(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel.ShowMiniMap)
		{
			miniMapView.gameObject.SetActive(value: true);
		}
		miniMapView.SetMininMapState(viewModel.ShowMiniMap);
	}

	private void OnHidePanelChanged(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		_panelAlpha.alpha = (flag ? 1 : 0);
	}

	public void SetBattleCameraEnergyFollowRoot(Camera battleCamera, Transform energyFollow, Vector2 offset)
	{
		battleUserSelfView.SetBattleCameraEnergyFollowRoot(battleCamera, energyFollow, offset);
	}

	public void ShowBattleTipFloatingWindow(float time, string content)
	{
		battleTipFloatingWindow.Show(time, content);
	}
}
