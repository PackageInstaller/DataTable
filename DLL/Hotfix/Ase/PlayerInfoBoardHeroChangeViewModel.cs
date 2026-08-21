using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class PlayerInfoBoardHeroChangeViewModel : OptionBase
{
	private BoardHeroData currentBoardData;

	private BoardHeroItemData curSelectHeroItemData;

	private BoardChangeItemData curSelectSpineItemData;

	private BoardChangeItemData initialSpineItemData;

	private List<int> heroIdList = new List<int>();

	private List<BoardChangeItemData> screenHeroDatas = new List<BoardChangeItemData>();

	private InteractionRequest refreshSpineListRst = new InteractionRequest();

	private InteractionRequest refreshHeroListRst = new InteractionRequest();

	private SimpleCommand saveCmd;

	private SimpleCommand backCmd;

	public BoardHeroData CurrentBoardData => currentBoardData;

	public BoardChangeItemData CurSelectSpineItemData => curSelectSpineItemData;

	public BoardChangeItemData InitialSpineItemData => initialSpineItemData;

	public BoardHeroItemData CurSelectHeroItemData => curSelectHeroItemData;

	public List<int> HeroIdList => heroIdList;

	public List<BoardChangeItemData> ScreenHeroDatas => screenHeroDatas;

	public SimpleCommand SaveCmd => saveCmd;

	public SimpleCommand BackCmd => backCmd;

	public InteractionRequest RefreshSpineListRst => refreshSpineListRst;

	public InteractionRequest RefreshHeroListRst => refreshHeroListRst;

	public PlayerInfoBoardHeroChangeViewModel()
	{
	}

	public PlayerInfoBoardHeroChangeViewModel(OptionBase parent, BoardHeroData boardData)
	{
		base.parent = parent;
		saveCmd = new SimpleCommand(Save);
		backCmd = new SimpleCommand(Back);
		currentBoardData = boardData;
		InitCurSelectHeroItemData();
		RefreshBoardHeroData();
		InitCurSelectHeroItemAndSpineItme();
	}

	private void InitCurSelectHeroItemAndSpineItme()
	{
		screenHeroDatas.Clear();
		int heroId = curSelectHeroItemData.HeroId;
		List<int> heroSkins = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkins(heroId);
		DRBoardHeroList[] dataRows = GameEntry.DataTable.GetDataRows((DRBoardHeroList p) => p.HeroId == heroId);
		foreach (DRBoardHeroList dRBoardHeroList in dataRows)
		{
			if (heroSkins.Contains(dRBoardHeroList.HeroSkinId))
			{
				BoardChangeItemData boardChangeItemData = new BoardChangeItemData(this, dRBoardHeroList, currentBoardData.BoardHeroId == dRBoardHeroList.Id, unlock: true);
				if (currentBoardData.BoardHeroId == boardChangeItemData.Id)
				{
					curSelectSpineItemData = boardChangeItemData;
					initialSpineItemData = boardChangeItemData;
				}
				screenHeroDatas.Add(boardChangeItemData);
			}
		}
		refreshSpineListRst.Raise();
	}

	private void InitCurSelectHeroItemData()
	{
		DRBoardHeroList dataRow = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(currentBoardData.BoardHeroId);
		curSelectHeroItemData = new BoardHeroItemData(this, dataRow.HeroId);
	}

	private void RefreshBoardHeroData()
	{
		heroIdList.Clear();
		heroIdList = Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetAllHeroData().Keys.ToList();
		refreshHeroListRst.Raise();
	}

	public void OnOpen(int spineId)
	{
		int num = ((spineId == 0) ? 110400 : spineId);
		if (currentBoardData == null)
		{
			currentBoardData = new BoardHeroData(num, spineId);
		}
		else
		{
			currentBoardData.Change(num, spineId);
		}
		InitCurSelectHeroItemData();
		RefreshBoardHeroData();
		InitCurSelectHeroItemAndSpineItme();
	}

	public void SetSpineItemSelected(BoardChangeItemData itemData)
	{
		if (curSelectSpineItemData != null)
		{
			if (curSelectSpineItemData.Id == itemData.Id)
			{
				itemData.Selected = true;
				return;
			}
			curSelectSpineItemData.Selected = false;
		}
		curSelectSpineItemData = itemData;
		curSelectSpineItemData.Selected = true;
	}

	public void SetHeroItemSelected(BoardHeroItemData heroItemViewModel)
	{
		if (heroItemViewModel == null)
		{
			return;
		}
		if (curSelectHeroItemData != null)
		{
			if (curSelectHeroItemData.HeroId == heroItemViewModel.HeroId)
			{
				return;
			}
			curSelectHeroItemData.SetSelected(value: false);
		}
		curSelectHeroItemData = heroItemViewModel;
		curSelectHeroItemData.SetSelected(value: true);
		screenHeroDatas.Clear();
		int heroId = curSelectHeroItemData.HeroId;
		List<int> heroSkins = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkins(heroId);
		DRBoardHeroList[] dataRows = GameEntry.DataTable.GetDataRows((DRBoardHeroList p) => p.HeroId == heroId);
		foreach (DRBoardHeroList dRBoardHeroList in dataRows)
		{
			if (heroSkins.Contains(dRBoardHeroList.HeroSkinId))
			{
				screenHeroDatas.Add(new BoardChangeItemData(this, dRBoardHeroList, currentBoardData.BoardHeroId == dRBoardHeroList.Id, unlock: true));
			}
		}
		refreshHeroListRst.Raise();
		refreshSpineListRst.Raise();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is BoardHeroItemData heroItemSelected)
		{
			SetHeroItemSelected(heroItemSelected);
			parent?.ItemOnClick(obj);
		}
		else if (obj is BoardChangeItemData { DrHero: not null } boardChangeItemData)
		{
			SetSpineItemSelected(boardChangeItemData);
			parent?.ItemOnClick(obj);
		}
	}

	private void Save()
	{
		initialSpineItemData = curSelectSpineItemData;
		parent.ItemOnClick(new OptionArg(this, "OnSetBackGround"));
		base.IsVisible = false;
		Close();
	}

	private void Back()
	{
		if (initialSpineItemData.Id != curSelectSpineItemData.Id)
		{
			curSelectSpineItemData = initialSpineItemData;
		}
		base.IsVisible = false;
		parent.ItemOnClick(new OptionArg(this, "OnSetInitialBackGround"));
		Close();
	}

	public override void Close()
	{
		base.IsVisible = false;
	}
}
