using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BattleStatViewModel : OptionBase
{
	private BattleStatView battleStatView;

	public override void ItemOnClick(object obj)
	{
	}

	public BattleStatViewModel()
	{
	}

	public BattleStatViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnInitView(BattleStatView battleStatView)
	{
		this.battleStatView = battleStatView;
	}

	public void OnInitHeros(List<HeroEntity> heroList)
	{
		battleStatView?.InitHeros(heroList);
	}

	public void OnOpenStat(BattleSpecialModeEnum specialModeEnum)
	{
		battleStatView?.OnInitStat(specialModeEnum, OnBtn_GM);
	}

	public void OnStartTimer(bool isStart)
	{
		battleStatView?.OnStartTimer(isStart);
	}

	public void OnBtn_GM(BattleGMEnum gmEnum)
	{
		parent.ItemOnClick(gmEnum);
	}

	public void UpdateGMState(BattleGMEnum gmEnum, bool isOpen)
	{
		battleStatView?.UpdateGMState(gmEnum, isOpen);
	}

	public void SetGMInteractable(BattleGMEnum gmEnum, bool isInter)
	{
		battleStatView?.SetGMInteractable(gmEnum, isInter);
	}

	public void RefreshStat(int battleTime, int entityId, EntityStatInfo info, List<EntityStatInfo> infoList)
	{
		battleStatView?.OnRefreshStat(battleTime, entityId, info, infoList);
	}

	public void ResetStatInfo()
	{
		battleStatView?.ResetStatInfo();
	}

	public void UpdateStatTime(float modeTime)
	{
		battleStatView?.OnUpdateStatTime(modeTime);
	}

	public void OnVisibility(bool visibility)
	{
		battleStatView?.OnVisibility(visibility);
	}
}
