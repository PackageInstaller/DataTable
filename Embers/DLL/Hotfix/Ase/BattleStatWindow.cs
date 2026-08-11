using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleStatWindow : UGuiWindow
{
	public enum StatTypeEnum
	{
		None,
		Timer,
		GM
	}

	[SerializeField]
	private StatTimerInfoView statTimerInfoView;

	[SerializeField]
	private StatGMInfoView statGMInfoView;

	private StatInfoViewBase statInfoViewBase;

	private BattleStatWindowModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleStatWindowModel>();
		viewModel.OnInitView(this);
		BindingSet<BattleStatWindow, BattleStatWindowModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleStatWindow v) => v.OnDismissRequest).To((BattleStatWindowModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BattleStatWindow v) => ((UGuiWindow)v).OnVisibleChanged).To((BattleStatWindowModel vm) => vm.VisibleRequest);
		bindingSet.Build();
	}

	public void InitHeros(List<HeroEntity> heroList)
	{
		if (heroList != null && heroList.Count != 0)
		{
			statInfoViewBase?.OnInitInfo(heroList);
		}
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		SetViewAlpha(flag ? 1 : 0);
		CanvasGroup.interactable = flag;
	}

	public void OnInitStat(BattleSpecialModeEnum specialModeEnum, Action<BattleGMEnum> callback)
	{
		switch (specialModeEnum)
		{
		case BattleSpecialModeEnum.BattleStatTimer:
			statTimerInfoView.OnShow(isShow: true);
			statGMInfoView.OnShow(isShow: false);
			statInfoViewBase = statTimerInfoView;
			break;
		case BattleSpecialModeEnum.BattleStatGM:
			statTimerInfoView.OnShow(isShow: false);
			statGMInfoView.OnShow(isShow: true);
			statInfoViewBase = statGMInfoView;
			statGMInfoView.InitGMAction(callback);
			break;
		}
		statInfoViewBase?.OnInit();
	}

	public void OnStartTimer(bool isTimer)
	{
		statTimerInfoView?.OnStartReadyTimer(isTimer);
	}

	public void UpdateGMState(BattleGMEnum gmEnum, bool isOpen)
	{
		statGMInfoView?.UpdateGMSatte(gmEnum, isOpen);
	}

	public void SetGMInteractable(BattleGMEnum gmEnum, bool isInter)
	{
		statGMInfoView?.SetGMInteractable(gmEnum, isInter);
	}

	public void OnRefreshStat(int battleTime, int entityId, EntityStatInfo info, List<EntityStatInfo> infoList)
	{
		statInfoViewBase?.OnRefreshStat(battleTime, entityId, info, infoList);
	}

	public void ResetStatInfo()
	{
		statInfoViewBase?.ResetStatInfo();
	}

	public void OnUpdateStatTime(float modeTime)
	{
		statInfoViewBase?.UpdateTimer(modeTime);
	}

	public void OnVisibility(bool isVisibility)
	{
		Visibility = isVisibility;
	}
}
