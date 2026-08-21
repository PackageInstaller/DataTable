using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class BoardHeroChangeViewModel : OptionBase
{
	private bool canSave;

	private bool heroChanged;

	private bool bgChanged;

	private BoardHeroData currentBoardData;

	private BoardChangeItemData curSelectHeroItemData;

	private BoardChangeItemData curSelectBgItemData;

	private BoardChangeItemData bgDefaultModeItemData;

	private List<BoardChangeItemData> _screenHeroDatas = new List<BoardChangeItemData>();

	private List<BoardChangeItemData> _screenBgDatas = new List<BoardChangeItemData>();

	private InteractionRequest _refreshHeroRst = new InteractionRequest();

	private InteractionRequest _refreshBgRst = new InteractionRequest();

	private SimpleCommand saveCmd;

	public bool CanSave
	{
		get
		{
			return canSave;
		}
		set
		{
			Set(ref canSave, value, "CanSave");
		}
	}

	public BoardChangeItemData BgDefaultModeItemData => bgDefaultModeItemData;

	public BoardChangeItemData CurSelectBgItemData => curSelectBgItemData;

	public BoardChangeItemData CurSelectHeroItemData => curSelectHeroItemData;

	public List<BoardChangeItemData> ScreenHeroDatas => _screenHeroDatas;

	public List<BoardChangeItemData> ScreenBgDatas => _screenBgDatas;

	public InteractionRequest RefreshBgRst => _refreshBgRst;

	public InteractionRequest RefreshHeroRst => _refreshHeroRst;

	public SimpleCommand SaveCmd => saveCmd;

	public BoardHeroChangeViewModel()
	{
	}

	public BoardHeroChangeViewModel(OptionBase parent)
	{
		base.parent = parent;
		currentBoardData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
		bgDefaultModeItemData = new BoardChangeItemData(this, currentBoardData.BackgroundId.Equals(BoardHeroData.BgDefaultModeId));
		saveCmd = new SimpleCommand(OnBtnSaveClick);
		GetSortData();
	}

	private void SetHeroItemSelected(BoardChangeItemData itemData)
	{
		if (curSelectHeroItemData != null)
		{
			if (curSelectHeroItemData.Id == itemData.Id)
			{
				return;
			}
			curSelectHeroItemData.Selected = false;
		}
		curSelectHeroItemData = itemData;
		curSelectHeroItemData.Selected = true;
		RefreshHeroRst.Raise();
	}

	private void SetBgItemSelected(BoardChangeItemData itemData)
	{
		if (curSelectBgItemData != null)
		{
			if (curSelectBgItemData.Id == itemData.Id)
			{
				return;
			}
			curSelectBgItemData.Selected = false;
		}
		curSelectBgItemData = itemData;
		curSelectBgItemData.Selected = true;
		RefreshBgRst.Raise();
	}

	private void UpdateSaveEnable()
	{
		bool flag = !Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(curSelectHeroItemData.DrHero.HeroId).IsNullOrEmpty();
		if (1 == 0 || !flag)
		{
			CanSave = false;
			return;
		}
		heroChanged = !curSelectHeroItemData.Id.Equals(currentBoardData.BoardHeroId);
		bgChanged = !curSelectBgItemData.Id.Equals(currentBoardData.BackgroundId);
		CanSave = heroChanged || bgChanged;
	}

	private async void OnBtnSaveClick()
	{
		if (CanSave)
		{
			saveCmd.Enabled = false;
			IRoleService roleService = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
			if (heroChanged)
			{
				await roleService.ChangeBoardHeroData(curSelectHeroItemData.Id);
			}
			if (bgChanged)
			{
				await roleService.ChangeBoardBackgroundData(curSelectBgItemData.Id);
			}
			UpdateSaveEnable();
			saveCmd.Enabled = true;
			Close();
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is BoardChangeItemData boardChangeItemData)
		{
			if (boardChangeItemData.DrHero != null)
			{
				SetHeroItemSelected(boardChangeItemData);
			}
			else if (boardChangeItemData.DrBg != null || boardChangeItemData.IsDefaultBg)
			{
				SetBgItemSelected(boardChangeItemData);
			}
			UpdateSaveEnable();
		}
	}

	private void GetSortData()
	{
		IHeroService heroService = Singleton<ServiceSystem>.Instance.GetService<IHeroService>();
		List<DRBoardHeroList> list = GameEntry.DataTable.GetAllDataRow<DRBoardHeroList>().ToList();
		list.Sort(delegate(DRBoardHeroList a, DRBoardHeroList b)
		{
			bool flag = heroService.GetHeroById(a.HeroId).IsNullOrEmpty();
			bool flag2 = heroService.GetHeroById(b.HeroId).IsNullOrEmpty();
			if (flag != flag2)
			{
				if (!flag)
				{
					return -1;
				}
				return 1;
			}
			if (a.HeroId != b.HeroId)
			{
				if (a.HeroId <= b.HeroId)
				{
					return -1;
				}
				return 1;
			}
			return (a.StateType >= b.StateType) ? 1 : (-1);
		});
		_screenHeroDatas.Clear();
		list.ForEach(delegate(DRBoardHeroList p)
		{
			_screenHeroDatas.Add(new BoardChangeItemData(this, p, currentBoardData.BoardHeroId.Equals(p.Id), !heroService.GetHeroById(p.HeroId).IsNullOrEmpty()));
		});
		SetHeroItemSelected((curSelectHeroItemData == null) ? _screenHeroDatas.Find((BoardChangeItemData p) => currentBoardData.BoardHeroId.Equals(p.Id)) : _screenHeroDatas.Find((BoardChangeItemData p) => curSelectHeroItemData.Id.Equals(p.Id)));
		List<DRBoardBackGround> list2 = GameEntry.DataTable.GetDataRows((DRBoardBackGround p) => p.Id > 0).ToList();
		_screenBgDatas.Clear();
		list2.ForEach(delegate(DRBoardBackGround p)
		{
			_screenBgDatas.Add(new BoardChangeItemData(this, p, currentBoardData.BackgroundId.Equals(p.Id)));
		});
		if (curSelectBgItemData == null)
		{
			SetBgItemSelected(currentBoardData.BackgroundId.Equals(BoardHeroData.BgDefaultModeId) ? bgDefaultModeItemData : _screenBgDatas.Find((BoardChangeItemData p) => currentBoardData.BackgroundId.Equals(p.Id)));
		}
		else
		{
			SetBgItemSelected(curSelectBgItemData.Id.Equals(BoardHeroData.BgDefaultModeId) ? bgDefaultModeItemData : _screenBgDatas.Find((BoardChangeItemData p) => curSelectBgItemData.Id.Equals(p.Id)));
		}
	}
}
