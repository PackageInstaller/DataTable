using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class BoardHeroChangeData : OptionBase
{
	private GameObject heroSpine;

	private bool canSave;

	private bool heroChanged;

	private bool bgChanged;

	private bool bgUnlock;

	private BoardHeroData currentBoardData;

	private BoardChangeItemData bgDefaultModeItemData;

	private List<int> heroIdList = new List<int>();

	private List<BoardChangeItemData> _screenHeroDatas = new List<BoardChangeItemData>();

	private List<BoardChangeItemData> _screenBgDatas = new List<BoardChangeItemData>();

	private InteractionRequest _refreshHeroListRst = new InteractionRequest();

	private InteractionRequest _refreshSpineListRst = new InteractionRequest();

	private InteractionRequest _refreshSpineRst = new InteractionRequest();

	private InteractionRequest _refreshBgRst = new InteractionRequest();

	private SimpleCommand saveCmd;

	private SimpleCommand adjustCmd;

	private PosterGirlAdjustViewModel posterGirlAdjustVM;

	private InteractionRequest adjustViewBtnRst = new InteractionRequest();

	private InteractionRequest<bool> previewAlphaRst = new InteractionRequest<bool>();

	private InteractionRequest rebindSpineRst = new InteractionRequest();

	private BoardHeroPreviewTransformData previewTransformData;

	private Action hideCallback;

	private InteractionRequest changeTabRst = new InteractionRequest();

	private TabItemData curTabData;

	private BoardHeroItemData curSelectHeroItemData;

	private BoardChangeItemData curSelectSpineItemData;

	private BoardChangeItemData curSelectBgItemData;

	private List<BackgroundData> bgDatas = new List<BackgroundData>();

	public BoardHeroData CurrentBoardData => currentBoardData;

	public InteractionRequest ChangeTabRst => changeTabRst;

	public TabItemData CurTabData => curTabData;

	public BoardHeroItemData CurSelectHeroItemData => curSelectHeroItemData;

	public GameObject HeroSpine
	{
		get
		{
			return heroSpine;
		}
		set
		{
			heroSpine = value;
		}
	}

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

	public BoardChangeItemData CurSelectSpineItemData => curSelectSpineItemData;

	public List<int> HeroIdList => heroIdList;

	public List<BoardChangeItemData> ScreenHeroDatas => _screenHeroDatas;

	public List<BoardChangeItemData> ScreenBgDatas => _screenBgDatas;

	public InteractionRequest RefreshHeroListRst => _refreshHeroListRst;

	public InteractionRequest RefreshSpineListRst => _refreshSpineListRst;

	public InteractionRequest RefreshBgRst => _refreshBgRst;

	public InteractionRequest RefreshSpineRst => _refreshSpineRst;

	public SimpleCommand SaveCmd => saveCmd;

	public SimpleCommand AdjustCmd => adjustCmd;

	public BoardHeroPreviewTransformData PreviewTransformData => previewTransformData;

	public PosterGirlAdjustViewModel PosterGirlAdjustVM => posterGirlAdjustVM;

	public InteractionRequest AdjustViewBtnRst => adjustViewBtnRst;

	public InteractionRequest<bool> PreviewAlphaRst => previewAlphaRst;

	public InteractionRequest RebindSpineRst => rebindSpineRst;

	public BoardHeroChangeData()
	{
	}

	public BoardHeroChangeData(OptionBase parent, GameObject spine)
	{
		base.parent = parent;
		currentBoardData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
		bgDefaultModeItemData = new BoardChangeItemData(this, currentBoardData.BackgroundId.Equals(BoardHeroData.BgDefaultModeId));
		saveCmd = new SimpleCommand(OnBtnSaveClick);
		posterGirlAdjustVM = new PosterGirlAdjustViewModel();
		adjustCmd = new SimpleCommand(OnBtnAdjustClick);
		HeroSpine = spine;
		RefreshBoardHeroData();
	}

	private void OnBtnAdjustClick()
	{
		adjustViewBtnRst.Raise();
	}

	private void RefreshBoardHeroData()
	{
		heroIdList.Clear();
		heroIdList = Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.GetAllHeroData().Keys.ToList();
		_refreshHeroListRst.Raise();
	}

	private void RefreshBgData()
	{
		List<DRBoardBackGround> list = GameEntry.DataTable.GetDataRows((DRBoardBackGround p) => p.Id > 0).ToList();
		_screenBgDatas.Clear();
		list.ForEach(delegate(DRBoardBackGround p)
		{
			_screenBgDatas.Add(new BoardChangeItemData(this, p, currentBoardData.BackgroundId.Equals(p.Id), bgDatas.Exists((BackgroundData m) => m.Id == p.Id)));
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

	private void SetTabSelected(TabItemData tabItemData)
	{
		if (tabItemData != null && (curTabData == null || curTabData.TabIndex != tabItemData.TabIndex))
		{
			if (curTabData != null)
			{
				curTabData.IsSelected = false;
			}
			curTabData = tabItemData;
			curTabData.IsSelected = true;
			changeTabRst.Raise();
		}
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
		_screenHeroDatas.Clear();
		int heroId = curSelectHeroItemData.HeroId;
		List<int> heroSkins = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkins(heroId);
		DRBoardHeroList[] dataRows = GameEntry.DataTable.GetDataRows((DRBoardHeroList p) => p.HeroId == heroId);
		foreach (DRBoardHeroList dRBoardHeroList in dataRows)
		{
			if (heroSkins.Contains(dRBoardHeroList.HeroSkinId))
			{
				_screenHeroDatas.Add(new BoardChangeItemData(this, dRBoardHeroList, currentBoardData.BoardHeroId == dRBoardHeroList.Id, unlock: true));
			}
		}
		_refreshSpineListRst.Raise();
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
		_refreshSpineRst.Raise();
	}

	private void SetBgItemSelected(BoardChangeItemData itemData)
	{
		if (curSelectBgItemData != null)
		{
			if (curSelectBgItemData.Id == itemData.Id)
			{
				itemData.Selected = true;
				return;
			}
			curSelectBgItemData.Selected = false;
		}
		curSelectBgItemData = itemData;
		curSelectBgItemData.Selected = true;
		RefreshBgRst.Raise();
	}

	public void Refresh(GameObject spine)
	{
		currentBoardData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
		curSelectHeroItemData = null;
		curSelectSpineItemData = null;
		curSelectBgItemData = null;
		HeroSpine = spine;
		RefreshBoardHeroData();
		RefreshBgData();
		UpdateSaveEnable();
	}

	public async UniTask RequestBgData()
	{
		bgDatas.Clear();
		bgDatas = await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().RequestBackgroundData();
		if (bgDatas == null)
		{
			bgDatas = new List<BackgroundData>();
		}
		RefreshBgData();
	}

	private void UpdateSaveEnable()
	{
		if (curSelectSpineItemData == null || curSelectBgItemData == null || currentBoardData == null)
		{
			CanSave = false;
			return;
		}
		bgUnlock = curSelectBgItemData.Unlock;
		heroChanged = !curSelectSpineItemData.Id.Equals(currentBoardData.BoardHeroId);
		bgChanged = !curSelectBgItemData.Id.Equals(currentBoardData.BackgroundId);
		CanSave = heroChanged || (bgChanged && bgUnlock);
	}

	private async void OnBtnSaveClick()
	{
		if (CanSave)
		{
			saveCmd.Enabled = false;
			IRoleService roleService = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
			if (heroChanged && await roleService.ChangeBoardHeroData(curSelectSpineItemData.Id))
			{
				AddInfoChangeTDA("看板娘", $"{curSelectSpineItemData.Id}", "");
			}
			if (bgChanged && bgUnlock && await roleService.ChangeBoardBackgroundData(curSelectBgItemData.Id))
			{
				AddInfoChangeTDA("背景", $"{curSelectBgItemData.Id}", "");
			}
			UpdateSaveEnable();
			saveCmd.Enabled = true;
			Hide();
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is BoardHeroItemData heroItemSelected)
		{
			SetHeroItemSelected(heroItemSelected);
			UpdateSaveEnable();
		}
		else if (obj is BoardChangeItemData boardChangeItemData)
		{
			if (boardChangeItemData.DrHero != null)
			{
				SetSpineItemSelected(boardChangeItemData);
			}
			else if (boardChangeItemData.DrBg != null || boardChangeItemData.IsDefaultBg)
			{
				SetBgItemSelected(boardChangeItemData);
			}
			UpdateSaveEnable();
		}
	}

	public void Hide()
	{
		base.IsVisible = false;
		hideCallback?.Invoke();
	}

	public void AddHideCallback(Action cb)
	{
		hideCallback = (Action)Delegate.Combine(hideCallback, cb);
	}

	public void SetPreviewTransformData(BoardHeroPreviewTransformData data)
	{
		previewTransformData = data;
	}

	public bool TryGetPreviewTransformData(int boardHeroId, out BoardHeroPreviewTransformData data)
	{
		data = previewTransformData;
		if (data != null)
		{
			return data.BoardHeroId == boardHeroId;
		}
		return false;
	}

	public void ClearPreviewTransformData()
	{
		previewTransformData = null;
	}

	public void RemoveAllHideCallback()
	{
		hideCallback = null;
	}

	private void AddInfoChangeTDA(string type, string id, string name)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("type", type);
		dictionary.Add("id", id);
		dictionary.Add("name", name);
		List<Dictionary<string, object>> list = CollectionPool<List<Dictionary<string, object>>, Dictionary<string, object>>.Get();
		list.Add(dictionary);
		Dictionary<string, object> dictionary2 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary2.Add("edit_detail", list);
		TDAHandler.Instance.SendUserEvent("profile_edit", dictionary2);
		dictionary2.Clear();
		list.Clear();
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary2);
		CollectionPool<List<Dictionary<string, object>>, Dictionary<string, object>>.Release(list);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}
}
