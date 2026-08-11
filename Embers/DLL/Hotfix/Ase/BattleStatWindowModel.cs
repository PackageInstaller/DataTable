using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BattleStatWindowModel : OptionBase
{
	private BattleStatWindow BattleStatWindow;

	private BattleSpecialModeEnum specialModeEnum;

	private List<HeroEntity> heroList;

	public BattleStatWindowModel()
	{
	}

	public BattleStatWindowModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public void OnInit(BattleSpecialModeEnum specialModeEnum, List<HeroEntity> heroList)
	{
		this.specialModeEnum = specialModeEnum;
		this.heroList = heroList;
		BattleStatWindow.OnInitStat(specialModeEnum, OnBtn_GM);
		BattleStatWindow.InitHeros(heroList);
	}

	public void OnInitView(BattleStatWindow BattleStatWindow)
	{
		this.BattleStatWindow = BattleStatWindow;
	}

	public void OnStartTimer(bool isStart)
	{
		BattleStatWindow?.OnStartTimer(isStart);
	}

	public void OnBtn_GM(BattleGMEnum gmEnum)
	{
		parent.ItemOnClick(gmEnum);
	}

	public void UpdateGMState(BattleGMEnum gmEnum, bool isOpen)
	{
		BattleStatWindow?.UpdateGMState(gmEnum, isOpen);
	}

	public void SetGMInteractable(BattleGMEnum gmEnum, bool isInter)
	{
		BattleStatWindow?.SetGMInteractable(gmEnum, isInter);
	}

	public void RefreshStat(int battleTime, int entityId, EntityStatInfo info, List<EntityStatInfo> infoList)
	{
		BattleStatWindow?.OnRefreshStat(battleTime, entityId, info, infoList);
	}

	public void ResetStatInfo()
	{
		BattleStatWindow?.ResetStatInfo();
	}

	public void UpdateStatTime(float modeTime)
	{
		BattleStatWindow?.OnUpdateStatTime(modeTime);
	}

	public void OnVisibility(bool visibility)
	{
		BattleStatWindow?.OnVisibility(visibility);
	}
}
