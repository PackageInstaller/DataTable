#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleStatView : UGuiView
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

	private BattleSpecialModeEnum specialModeEnum;

	private BattleStatViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<BattleStatViewModel>(userData);
		viewModel?.OnInitView(this);
		this.CreateBindingSet(viewModel).Build();
	}

	public override void OnShow()
	{
	}

	public void InitHeros(List<HeroEntity> heroList)
	{
		if (heroList == null || heroList.Count == 0)
		{
			Log.Error("Hero数量为空，无法打开战斗统计面板");
		}
		else
		{
			statInfoViewBase?.OnInitInfo(heroList);
		}
	}

	public void OnInitStat(BattleSpecialModeEnum specialModeEnum, Action<BattleGMEnum> callback)
	{
		this.specialModeEnum = specialModeEnum;
		switch (specialModeEnum)
		{
		case BattleSpecialModeEnum.BattleStatTimer:
			statInfoViewBase = statTimerInfoView;
			Visibility = true;
			break;
		case BattleSpecialModeEnum.BattleStatGM:
			statInfoViewBase = statGMInfoView;
			statGMInfoView.InitGMAction(callback);
			Visibility = true;
			break;
		}
		statInfoViewBase?.OnInit();
	}

	public void OnStartTimer(bool isTimer)
	{
		if (specialModeEnum == BattleSpecialModeEnum.BattleStatTimer)
		{
			statTimerInfoView?.OnStartReadyTimer(isTimer);
		}
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
