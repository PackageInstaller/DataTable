using System;
using System.Collections.Generic;
using System.Globalization;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class BoardHeroViewModel : OptionBase
{
	private int id;

	private DRBoardHeroList _drBoardHeroList;

	private GameObject heroSpine;

	private BoardHeroPreviewTransformData previewTransformData;

	private InteractionRequest refreshRequest = new InteractionRequest();

	private InteractionRequest<BoardActionData> playActionRst = new InteractionRequest<BoardActionData>();

	private InteractionRequest<bool> returnSpineRst = new InteractionRequest<bool>();

	public int ClickTime;

	public int FrequentClickTime;

	public float FrequentClickTimer;

	public int Id
	{
		get
		{
			return id;
		}
		private set
		{
			Set(ref id, value, "Id");
			DrBoardHeroList = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(value);
		}
	}

	public DRBoardHeroList DrBoardHeroList
	{
		get
		{
			return _drBoardHeroList;
		}
		private set
		{
			Set(ref _drBoardHeroList, value, "DrBoardHeroList");
		}
	}

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

	public InteractionRequest RefreshRequest => refreshRequest;

	public InteractionRequest<bool> ReturnSpineRst => returnSpineRst;

	public InteractionRequest<BoardActionData> PlayActionRst => playActionRst;

	public BoardHeroViewModel()
	{
	}

	public BoardHeroViewModel(OptionBase parent)
	{
		base.parent = parent;
		Refresh();
	}

	public void PlayLoginAction()
	{
		if (DrBoardHeroList == null)
		{
			return;
		}
		DRBoardSpine[] dataRows = GameEntry.DataTable.GetDataRows((DRBoardSpine p) => p.BoardHeroId.Contains(DrBoardHeroList.Id) && p.TriggerType.Contains(3));
		if (dataRows == null || dataRows.Length == 0)
		{
			return;
		}
		List<DRBoardSpine> list = new List<DRBoardSpine>();
		DRBoardSpine[] array = dataRows;
		foreach (DRBoardSpine dRBoardSpine in array)
		{
			if (CheckActionOpenState(dRBoardSpine.ActionIndex, out var _))
			{
				list.Add(dRBoardSpine);
			}
		}
		if (list.Count > 0)
		{
			if (list.Count == 1)
			{
				playActionRst.Raise(new BoardActionData(list[0], new SpinePlayCommand()));
				return;
			}
			int index = new System.Random().Next(list.Count);
			playActionRst.Raise(new BoardActionData(list[index], new SpinePlayCommand()));
		}
	}

	public void PlayStandbyAction()
	{
		if (DrBoardHeroList == null)
		{
			return;
		}
		DRBoardSpine[] dataRows = GameEntry.DataTable.GetDataRows((DRBoardSpine p) => p.BoardHeroId.Contains(DrBoardHeroList.Id) && p.TriggerType.Contains(2));
		if (dataRows == null || dataRows.Length == 0)
		{
			return;
		}
		List<DRBoardSpine> list = new List<DRBoardSpine>();
		DRBoardSpine[] array = dataRows;
		foreach (DRBoardSpine dRBoardSpine in array)
		{
			if (CheckActionOpenState(dRBoardSpine.ActionIndex, out var _))
			{
				list.Add(dRBoardSpine);
			}
		}
		if (list.Count > 0)
		{
			if (list.Count == 1)
			{
				playActionRst.Raise(new BoardActionData(list[0], new SpinePlayCommand()));
				return;
			}
			int index = new System.Random().Next(list.Count);
			playActionRst.Raise(new BoardActionData(list[index], new SpinePlayCommand()));
		}
	}

	public bool PlayFrequentClickAction()
	{
		if (DrBoardHeroList == null)
		{
			return false;
		}
		DRBoardSpine[] dataRows = GameEntry.DataTable.GetDataRows((DRBoardSpine p) => p.BoardHeroId.Contains(DrBoardHeroList.Id) && p.TriggerType.Contains(4));
		if (dataRows == null || dataRows.Length == 0)
		{
			return false;
		}
		List<DRBoardSpine> list = new List<DRBoardSpine>();
		DRBoardSpine[] array = dataRows;
		foreach (DRBoardSpine dRBoardSpine in array)
		{
			if (CheckActionOpenState(dRBoardSpine.ActionIndex, out var _))
			{
				list.Add(dRBoardSpine);
			}
		}
		if (list.Count <= 0)
		{
			return false;
		}
		if (list.Count == 1)
		{
			playActionRst.Raise(new BoardActionData(list[0], new SpinePlayCommand()));
		}
		else
		{
			int index = new System.Random().Next(list.Count);
			playActionRst.Raise(new BoardActionData(list[index], new SpinePlayCommand()));
		}
		return true;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is BoardItem boardItem)
		{
			OnBoardItemClick(boardItem);
		}
	}

	public bool HandleBoardPartState(BoardPartState state, bool checkFrequentlyUsed, ISpinePlayCommand spinePlayCommand)
	{
		if (checkFrequentlyUsed)
		{
			ClickTime++;
			if (ClickTime >= FrequentClickTime)
			{
				ClickTime = 0;
				FrequentClickTimer = 0f;
				if (PlayFrequentClickAction())
				{
					return false;
				}
			}
		}
		if (!TryResolveBoardPartActionData(state, spinePlayCommand, out var actionData))
		{
			return false;
		}
		playActionRst.Raise(actionData, delegate(BoardActionData playedAction)
		{
			state.AppendResolvedActions(playedAction.ActionIndex);
			Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().SendBoardHeroClick();
		});
		int boardHeroId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData.BoardHeroId;
		DRBoardHeroList dataRow = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(boardHeroId);
		if (dataRow != null)
		{
			int backgroundId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData.BackgroundId;
			AddBoardHeroClickTDA(dataRow.HeroId, dataRow.Id, backgroundId, state.PartId);
		}
		return true;
	}

	private bool TryResolveBoardPartActionData(BoardPartState state, ISpinePlayCommand spinePlayCommand, out BoardActionData actionData)
	{
		if (state == null)
		{
			actionData = default(BoardActionData);
			return false;
		}
		if (state.LastResolvedEntry == null || state.LastResolvedEntry.Actions == null || state.LastResolvedEntry.Actions.Count == 0)
		{
			actionData = default(BoardActionData);
			return false;
		}
		List<DRBoardSpine> list = new List<DRBoardSpine>();
		for (int i = 0; i < state.ActionPoolCache.Count; i++)
		{
			string text = state.ActionPoolCache[i];
			if (!string.IsNullOrEmpty(text) && CheckActionOpenState(text, out var drBoardSpine))
			{
				list.Add(drBoardSpine);
			}
		}
		DRBoardSpine dRBoardSpine = SelectBoardSpineConfig(list, state.LastResolvedEntry.PlayMode);
		if (dRBoardSpine != null)
		{
			actionData = new BoardActionData(dRBoardSpine, spinePlayCommand);
			state.RemoveActionFromActionPoolCache(dRBoardSpine.ActionIndex);
			return true;
		}
		Toast.ShowInfo("无开放动作");
		actionData = default(BoardActionData);
		return false;
	}

	private void OnBoardItemClick(BoardItem boardItem)
	{
		ClickTime++;
		if (ClickTime >= FrequentClickTime)
		{
			ClickTime = 0;
			FrequentClickTimer = 0f;
			if (PlayFrequentClickAction())
			{
				return;
			}
		}
		List<DRBoardSpine> list = new List<DRBoardSpine>();
		foreach (string cacheAniName in boardItem.CacheAniNames)
		{
			if (CheckActionOpenState(cacheAniName, out var drBoardSpine))
			{
				list.Add(drBoardSpine);
			}
		}
		if (list.Count <= 0)
		{
			boardItem.ReloadAniConfig();
			foreach (string cacheAniName2 in boardItem.CacheAniNames)
			{
				if (CheckActionOpenState(cacheAniName2, out var drBoardSpine2))
				{
					list.Add(drBoardSpine2);
				}
			}
			if (list.Count <= 0)
			{
				Toast.ShowInfo("无开放动作");
				return;
			}
		}
		DRBoardSpine dRBoardSpine = null;
		if (list.Count == 1)
		{
			dRBoardSpine = list[0];
		}
		else
		{
			int index = new System.Random().Next(list.Count);
			dRBoardSpine = list[index];
		}
		if (dRBoardSpine != null)
		{
			playActionRst.Raise(new BoardActionData(dRBoardSpine, new SpinePlayCommand()), delegate(BoardActionData actionData)
			{
				boardItem.RemoveCacheAni(actionData.ActionIndex);
				Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().SendBoardHeroClick();
			});
			int boardHeroId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData.BoardHeroId;
			DRBoardHeroList dataRow = GameEntry.DataTable.GetDataRow<DRBoardHeroList>(boardHeroId);
			if (dataRow != null)
			{
				int backgroundId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData.BackgroundId;
				AddBoardHeroClickTDA(dataRow.HeroId, dataRow.Id, backgroundId, boardItem.name);
			}
		}
	}

	private void AddBoardHeroClickTDA(int heroId, int boardHeroId, int bgId, string clickPart)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("hero_id", $"{heroId}");
		dictionary.Add("hall_character_id", $"{boardHeroId}");
		dictionary.Add("hall_background_id", $"{bgId}");
		dictionary.Add("hero_point", clickPart);
		TDAHandler.Instance.SendUserEvent("hall_interaction", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	private DRBoardSpine SelectBoardSpineConfig(List<DRBoardSpine> openAniConfigs, BoardPartPlayMode playMode)
	{
		if (openAniConfigs == null || openAniConfigs.Count == 0)
		{
			return null;
		}
		if (playMode == BoardPartPlayMode.Fixed || openAniConfigs.Count == 1)
		{
			return openAniConfigs[0];
		}
		int index = new System.Random().Next(openAniConfigs.Count);
		return openAniConfigs[index];
	}

	private bool CheckActionOpenState(string actionIndex, out DRBoardSpine drBoardSpine)
	{
		drBoardSpine = null;
		if (DrBoardHeroList == null)
		{
			return false;
		}
		drBoardSpine = GameEntry.DataTable.GetDataRow((DRBoardSpine p) => p.BoardHeroId.Contains(DrBoardHeroList.Id) && p.ActionIndex.Equals(actionIndex));
		if (drBoardSpine == null)
		{
			return false;
		}
		if (CheckActionInOpenTime(drBoardSpine) && CheckActionInFixOpenTime(drBoardSpine))
		{
			return CheckActionNormalCondition(drBoardSpine);
		}
		return false;
	}

	private bool CheckActionInOpenTime(DRBoardSpine drBoardSpine)
	{
		if (string.IsNullOrEmpty(drBoardSpine.StartOpenTime) || string.IsNullOrEmpty(drBoardSpine.EndOpenTime))
		{
			return true;
		}
		bool num = DateTime.TryParseExact(drBoardSpine.StartOpenTime, "yyyy-MM-dd HH:mm:ss", CultureInfo.CurrentCulture, DateTimeStyles.None, out var result);
		bool flag = DateTime.TryParseExact(drBoardSpine.EndOpenTime, "yyyy-MM-dd HH:mm:ss", CultureInfo.CurrentCulture, DateTimeStyles.None, out var result2);
		if (!num || !flag || DateTime.Compare(result, result2) >= 0)
		{
			return false;
		}
		DateTime now = DateTime.Now;
		if (DateTime.Compare(result, now) < 0)
		{
			return DateTime.Compare(now, result2) < 0;
		}
		return false;
	}

	private bool CheckActionInFixOpenTime(DRBoardSpine drBoardSpine)
	{
		if (drBoardSpine.FixTimeRange == null || drBoardSpine.FixTimeRange.Count <= 0)
		{
			return true;
		}
		if (drBoardSpine.FixTimeRange.Count < 2)
		{
			return false;
		}
		bool num = DateTime.TryParseExact(drBoardSpine.FixTimeRange[0], "HH:mm:ss", CultureInfo.CurrentCulture, DateTimeStyles.None, out var result);
		bool flag = DateTime.TryParseExact(drBoardSpine.FixTimeRange[1], "HH:mm:ss", CultureInfo.CurrentCulture, DateTimeStyles.None, out var result2);
		if (!num || !flag || DateTime.Compare(result, result2) >= 0)
		{
			return false;
		}
		DateTime now = DateTime.Now;
		if (DateTime.Compare(result, now) < 0)
		{
			return DateTime.Compare(now, result2) < 0;
		}
		return false;
	}

	private bool CheckActionNormalCondition(DRBoardSpine drBoardSpine)
	{
		if (drBoardSpine.OpenType.Count <= 0)
		{
			return true;
		}
		for (int i = 0; i < drBoardSpine.OpenType.Count && drBoardSpine.OpenArgs.Count > i; i++)
		{
			int num = drBoardSpine.OpenType[i];
			int num2 = drBoardSpine.OpenArgs[i];
			if (DrBoardHeroList == null)
			{
				return false;
			}
			HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(DrBoardHeroList.HeroId);
			switch (num)
			{
			case 1:
				if (heroById.FeelingLevel < num2)
				{
					return false;
				}
				break;
			case 2:
				if (heroById.StarLevel < num2)
				{
					return false;
				}
				break;
			case 3:
				if (heroById.DestinyLevel < num2)
				{
					return false;
				}
				break;
			case 4:
			{
				TaskDataViewModel taskDataViewModel = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetCurrentMainTask();
				if (taskDataViewModel != null && taskDataViewModel.CopyOpen < num2)
				{
					return false;
				}
				break;
			}
			}
		}
		return true;
	}

	public void Refresh()
	{
		BoardHeroData boardHeroData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
		Id = boardHeroData.BoardHeroId;
		refreshRequest.Raise();
	}

	public GameObject GetSpineGameObject()
	{
		GameObject result = HeroSpine;
		HeroSpine = null;
		return result;
	}

	public void ReturnSpineGameObject(GameObject spine)
	{
		ClearPreviewTransformData();
		HeroSpine = spine;
		if (spine != null)
		{
			BoardHeroData boardHeroData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().BoardHeroData;
			bool context = Id != boardHeroData.BoardHeroId;
			Id = boardHeroData.BoardHeroId;
			returnSpineRst.Raise(context);
		}
		else
		{
			Refresh();
		}
	}

	public void PreviewSpine(int boardHeroId, GameObject spine)
	{
		HeroSpine = spine;
		bool context = Id != boardHeroId;
		Id = boardHeroId;
		ReturnSpineRst.Raise(context);
	}

	public void SetPreviewTransformData(BoardHeroPreviewTransformData data)
	{
		previewTransformData = data;
	}

	public void ClearPreviewTransformData()
	{
		previewTransformData = null;
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

	public void SetTempBoardHeroId(int boardHeroId)
	{
		Id = boardHeroId;
	}
}
