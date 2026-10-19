using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Core;
using ACT.Model;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ChangePageBase : UIBehaviour
{
	public int pageIndex;

	public int DataId;

	public BetterAnimation anim;

	public TimeAndDesItem timeAndDesItem;

	[SerializeField]
	private List<ChangePageBase> pages;

	private int _defaultPageIndex;

	private int currentPageIndex = -1;

	private int nextPageIndex = -1;

	private CancellationTokenSource cts;

	public int defaultPageIndex => _defaultPageIndex;

	public List<ChangePageBase> Pages => pages;

	public async UniTask SwitchPage(int pageIndex)
	{
		CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
		cts?.Cancel();
		cts?.Dispose();
		cts = cancellationTokenSource;
		if (pageIndex == currentPageIndex || pageIndex >= pages.Count)
		{
			return;
		}
		try
		{
			nextPageIndex = pageIndex;
			if (currentPageIndex >= 0)
			{
				ChangePageBase oldPage = pages[currentPageIndex];
				await oldPage.PlayCloseAnim(cts.Token);
				oldPage.UnInit();
				if (cts.IsCancellationRequested)
				{
					return;
				}
			}
			ChangePageBase changePageBase = pages[nextPageIndex];
			changePageBase.Init();
			await changePageBase.PlayOpenAnim(cts.Token);
			if (!cts.IsCancellationRequested)
			{
				currentPageIndex = nextPageIndex;
			}
		}
		catch (OperationCanceledException)
		{
			nextPageIndex = currentPageIndex;
		}
		finally
		{
			cts?.Dispose();
			cts = null;
		}
	}

	public void ResetData()
	{
		List<ChangePageBase> list = pages;
		if (list != null && list.Count > 0)
		{
			pages.Clear();
		}
		currentPageIndex = -1;
		nextPageIndex = -1;
	}

	public virtual void Init()
	{
		timeAndDesItem?.Init(Model<ActivityCenterModel>.Interface.GetActivityCenterData(DataId), -1L);
	}

	public virtual void UnInit()
	{
	}

	public virtual async UniTask PlayOpenAnim(CancellationToken token)
	{
		if (!(anim == null))
		{
			bool over = false;
			anim.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				over = true;
			}).Play();
			await UniTask.WaitUntil(() => over, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			if (token.IsCancellationRequested)
			{
				anim.StopAnimation();
			}
		}
	}

	public virtual async UniTask PlayCloseAnim(CancellationToken token)
	{
		if (!(anim == null))
		{
			bool over = false;
			anim.GetSequence("Close").OnComplete((AnimationBuilder _) =>
			{
				over = true;
			}).Play();
			await UniTask.WaitUntil(() => over, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
			if (token.IsCancellationRequested)
			{
				anim.StopAnimation();
			}
		}
	}

	public void ResortSubPasnel()
	{
		pages.Sort(sortPanel);
		for (int i = 0; i < pages.Count; i++)
		{
			pages[i].pageIndex = i;
		}
	}

	private int sortPanel(ChangePageBase a, ChangePageBase b)
	{
		int sortList = CoreUtils.GetData(a.DataId, RuntimeConfigs.data.activityDatas).sortList;
		int sortList2 = CoreUtils.GetData(b.DataId, RuntimeConfigs.data.activityDatas).sortList;
		if (sortList != 0 && sortList2 != 0)
		{
			return sortList.CompareTo(sortList2);
		}
		return a.pageIndex.CompareTo(b.pageIndex);
	}
}
