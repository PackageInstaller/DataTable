using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class GameNewsTipService : IGameNewsTipService
{
	private ISubscription<NewsTickerNotify> newsTickerNotify;

	private readonly IMessenger messenger;

	private ISubscription<GameNewsMessage> subscription_GameNews;

	private List<NewsTipItemViewModel> cacheNewsTipList;

	private List<NewsTipItemViewModel> totalNewsTipList;

	private List<long> openNewsTipList;

	private NewsTipViewModel newsTipViewModel;

	private bool isOpening;

	private long? openingNewsTipId;

	public GameNewsTipService()
	{
		newsTickerNotify = Singleton<NetworkSystem>.Instance.Subscribe<NewsTickerNotify>(LoadNewsTipWindow);
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_GameNews = messenger.Subscribe<GameNewsMessage>(GameNews);
		cacheNewsTipList = new List<NewsTipItemViewModel>();
		totalNewsTipList = new List<NewsTipItemViewModel>();
		openNewsTipList = new List<long>();
	}

	private void LoadNewsTipWindow(NewsTickerNotify notify)
	{
		foreach (PbNewsTicker newsTicker in notify.NewsTickers)
		{
			NewsTipItemViewModel newsTipItemViewModel = new NewsTipItemViewModel(newsTicker.Id, newsTicker.Content, newsTicker.StartTS, newsTicker.EndTS, newsTicker.Interval, newsTicker.IsDelete);
			if (newsTipItemViewModel.IsDelete)
			{
				RemoveNewsImmediately(newsTipItemViewModel);
			}
			else
			{
				AddNews(newsTipItemViewModel);
			}
		}
		OpenNewsTip();
	}

	private void GameNews(GameNewsMessage gameNewsMessage)
	{
		NewsTipItemViewModel newsTipItemViewModel = (NewsTipItemViewModel)gameNewsMessage.Arg;
		if (newsTipItemViewModel != null)
		{
			if (gameNewsMessage.MsgEnum == NewsTipMsgEnum.AddNew)
			{
				AddNews(newsTipItemViewModel);
			}
			else if (gameNewsMessage.MsgEnum == NewsTipMsgEnum.RemoveImmediately)
			{
				RemoveNewsImmediately(newsTipItemViewModel);
			}
			else if (gameNewsMessage.MsgEnum == NewsTipMsgEnum.Add)
			{
				Add(newsTipItemViewModel);
			}
			else if (gameNewsMessage.MsgEnum == NewsTipMsgEnum.Remove)
			{
				Remove(newsTipItemViewModel);
			}
		}
	}

	private void AddNews(NewsTipItemViewModel itemViewModel)
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		if (curServerTime == 0L)
		{
			AddOrReplaceNews(cacheNewsTipList, itemViewModel);
			return;
		}
		RemoveQueuedNews(itemViewModel.ID);
		if (itemViewModel.EndTime > curServerTime)
		{
			AddOrReplaceNews(totalNewsTipList, itemViewModel);
			itemViewModel.OpenStartEndTimer(curServerTime);
		}
		OpenNewsTip();
	}

	private void Add(NewsTipItemViewModel itemViewModel)
	{
		if (IsInTotalList(itemViewModel.ID) && !IsQueuedOrOpening(itemViewModel.ID))
		{
			openNewsTipList.Add(itemViewModel.ID);
			OpenNewsTip();
		}
	}

	private void RemoveNewsImmediately(NewsTipItemViewModel itemViewModel)
	{
		if (newsTipViewModel != null && newsTipViewModel.id == itemViewModel.ID)
		{
			newsTipViewModel.Close();
		}
		Remove(itemViewModel);
	}

	private void Remove(NewsTipItemViewModel itemViewModel)
	{
		long iD = itemViewModel.ID;
		if (newsTipViewModel != null && newsTipViewModel.id == iD && !newsTipViewModel.IsCloseView)
		{
			newsTipViewModel.Close();
		}
		for (int num = totalNewsTipList.Count - 1; num >= 0; num--)
		{
			if (totalNewsTipList[num].ID == iD)
			{
				totalNewsTipList[num].Close();
				totalNewsTipList.RemoveAt(num);
			}
		}
		for (int num2 = cacheNewsTipList.Count - 1; num2 >= 0; num2--)
		{
			if (cacheNewsTipList[num2].ID == iD)
			{
				cacheNewsTipList[num2].Close();
				cacheNewsTipList.RemoveAt(num2);
			}
		}
		RemoveQueuedNews(iD);
		itemViewModel.Close();
	}

	private bool IsQueuedOrOpening(long id)
	{
		if (!openingNewsTipId.HasValue || openingNewsTipId.Value != id)
		{
			return openNewsTipList.Contains(id);
		}
		return true;
	}

	private bool IsInTotalList(long id)
	{
		return totalNewsTipList.Exists((NewsTipItemViewModel item) => item.ID == id);
	}

	private void AddOrReplaceNews(List<NewsTipItemViewModel> list, NewsTipItemViewModel itemViewModel)
	{
		for (int num = list.Count - 1; num >= 0; num--)
		{
			if (list[num].ID == itemViewModel.ID)
			{
				list[num].Close();
				list.RemoveAt(num);
			}
		}
		list.Add(itemViewModel);
	}

	private void RemoveQueuedNews(long id)
	{
		for (int num = openNewsTipList.Count - 1; num >= 0; num--)
		{
			if (openNewsTipList[num] == id)
			{
				openNewsTipList.RemoveAt(num);
			}
		}
	}

	private void FinishOpeningNews(long id)
	{
		if (openNewsTipList.Count > 0 && openNewsTipList[0] == id)
		{
			openNewsTipList.RemoveAt(0);
		}
		else
		{
			RemoveQueuedNews(id);
		}
		if (openingNewsTipId.HasValue && openingNewsTipId.Value == id)
		{
			openingNewsTipId = null;
		}
		if (newsTipViewModel != null && newsTipViewModel.id == id)
		{
			newsTipViewModel = null;
		}
	}

	private async void OpenNewsTip()
	{
		if (isOpening || openNewsTipList.Count == 0)
		{
			return;
		}
		isOpening = true;
		long openingId = openNewsTipList[0];
		openingNewsTipId = openingId;
		bool callbackHandled = false;
		try
		{
			NewsTipItemViewModel newsTipItemViewModel = totalNewsTipList.Find((NewsTipItemViewModel p) => p.ID == openingId);
			if (newsTipItemViewModel == null)
			{
				FinishOpeningNews(openingId);
				OpenNext();
				return;
			}
			newsTipViewModel = new NewsTipViewModel(null, newsTipItemViewModel.ID, newsTipItemViewModel.Content);
			await GameEntry.UI.OpenWindow<NewsTipWindow>("PopupView/NewsTipWindow", "Tip", newsTipViewModel, delegate
			{
				if (!callbackHandled)
				{
					callbackHandled = true;
					FinishOpeningNews(openingId);
					OpenNext();
				}
			});
		}
		catch (Exception)
		{
			FinishOpeningNews(openingId);
			OpenNext();
		}
	}

	private async void OpenNext()
	{
		isOpening = false;
		await UniTask.Delay(500);
		OpenNewsTip();
	}

	public void OpenNewsTipWindow()
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		if (curServerTime == 0L)
		{
			return;
		}
		for (int num = cacheNewsTipList.Count - 1; num >= 0; num--)
		{
			NewsTipItemViewModel newsTipItemViewModel = cacheNewsTipList[num];
			cacheNewsTipList.RemoveAt(num);
			if (newsTipItemViewModel.EndTime > curServerTime)
			{
				AddOrReplaceNews(totalNewsTipList, newsTipItemViewModel);
				newsTipItemViewModel.OpenStartEndTimer(curServerTime);
			}
			else
			{
				newsTipItemViewModel.Close();
			}
		}
		OpenNewsTip();
	}

	public void ClearNewsTipWindow()
	{
		newsTipViewModel?.Close();
	}

	public bool CheckOpenScoreWindow(int id)
	{
		SDKLoginResult sDKLoginResult = Singleton<ServiceSystem>.Instance.GetService<ISDKService>().GetSDKLoginResult();
		if (sDKLoginResult == null || sDKLoginResult.ChannelID != 259)
		{
			return false;
		}
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		long accountCreateTime = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().AccountCreateTime;
		DateTime localDateTime = DateTimeOffset.FromUnixTimeSeconds(curServerTime).LocalDateTime;
		DateTime localDateTime2 = DateTimeOffset.FromUnixTimeSeconds(accountCreateTime).LocalDateTime;
		string key = $"{uid}_GameScore_{id}";
		bool flag = long.TryParse(PlayerPrefs.GetString(key, "0"), out var result);
		DRGameScore dataRow = GameEntry.DataTable.GetDataRow<DRGameScore>(id);
		if (dataRow == null)
		{
			return false;
		}
		if (dataRow.IsShare)
		{
			int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.GameScoreEveryYear, 3);
			int num = ((localDateTime.DayOfYear >= localDateTime2.DayOfYear) ? localDateTime.Year : (localDateTime.Year - 1));
			string key2 = $"{uid}_GameScore_{num}";
			int num2 = PlayerPrefs.GetInt(key2, 0);
			if (num2 > constantConfigInt)
			{
				return false;
			}
			if (((dataRow.Type == 1) & flag) && result != 0L && Utility.DateTime.GetTimeIntervalDays(result, curServerTime) <= dataRow.Day)
			{
				return false;
			}
			PlayerPrefs.SetInt(key2, num2 + 1);
			PlayerPrefs.SetString(key, $"{curServerTime}");
			return true;
		}
		if (((dataRow.Type == 1) & flag) && result != 0L && Utility.DateTime.GetTimeIntervalDays(result, curServerTime) <= dataRow.Day)
		{
			return false;
		}
		PlayerPrefs.SetString(key, $"{curServerTime}");
		return true;
	}
}
