using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class PageWidgetBase : GuideWidget
{
	[SerializeReference]
	protected Button nextPage;

	[SerializeReference]
	protected Button lastPage;

	[SerializeReference]
	protected LocalizeStringEvent textLocalize;

	[SerializeReference]
	protected ActButton closeBtn;

	[SerializeReference]
	protected ActIndexGroup indexGroup;

	[SerializeReference]
	protected GameObject tip;

	[SerializeReference]
	protected BetterAnimation betterAnimation;

	[SerializeReference]
	protected BetterAnimation countDownAnimation;

	protected List<int> _contentIdList = new List<int>();

	private List<int> _describeIdList = new List<int>();

	private int _curPage = -1;

	private int _lastPage = -1;

	private bool _reachLastPage;

	private bool _countdownFinish;

	protected bool OnePage => _lastPage == 0;

	private bool ReachLastPage
	{
		get
		{
			return _reachLastPage;
		}
		set
		{
			if (!_reachLastPage)
			{
				_reachLastPage = value;
				closeBtn.gameObject.SetActive(_reachLastPage);
				tip.SetActive(!_reachLastPage);
			}
		}
	}

	private bool CanFinish
	{
		get
		{
			if (OnePage)
			{
				return _countdownFinish;
			}
			return ReachLastPage;
		}
	}

	protected bool _isPc => MonoECS.instance.ispc;

	public override void Init(GuideStepData stepData)
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_UINextPage, ShowNextPage);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_UIPrePage, ShowPrePage);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Guide_UIClosePage, CLosePage);
	}

	protected void StartCountDown()
	{
		countDownAnimation.GetSequence("CountDown").OnComplete((AnimationBuilder _) =>
		{
			_countdownFinish = true;
		}).Play();
	}

	protected void InitData(int guideTableId)
	{
		GuideTutorial data = CoreUtils.GetData(guideTableId, RuntimeConfigs.data.guideTutorials);
		if (data != null)
		{
			_contentIdList.Clear();
			_describeIdList.Clear();
			_curPage = -1;
			_lastPage = (_isPc ? data.pictureidPC.Length : data.pictureid.Length) - 1;
			ReachLastPage = false;
			_countdownFinish = !OnePage;
			int[] array = (_isPc ? data.pictureidPC : data.pictureid);
			foreach (int item in array)
			{
				_contentIdList.Add(item);
			}
			array = (_isPc ? data.tutorialDescPC : data.tutorialDesc);
			foreach (int item2 in array)
			{
				_describeIdList.Add(item2);
			}
			indexGroup.Init(_lastPage + 1);
		}
	}

	protected virtual void ShowByIndex(int index)
	{
		if (index >= 0 && index <= _lastPage)
		{
			GuideTutorialDes data = CoreUtils.GetData(_describeIdList[index], RuntimeConfigs.data.guideTutorialDess);
			textLocalize.StringReference.TableEntryReference = data.tutorialTitle;
			_curPage = index;
			ReachLastPage = _curPage == _lastPage;
			lastPage.gameObject.SetActive(_curPage - 1 >= 0);
			nextPage.gameObject.SetActive(_curPage + 1 <= _lastPage);
			indexGroup.SetToIndex(index);
		}
	}

	public void ShowNextPage()
	{
		if (_curPage < _lastPage)
		{
			ShowByIndex(_curPage + 1);
		}
	}

	private void ShowNextPage(BaseEventContent eventContent)
	{
		if (eventContent is GuideUINextPageEvt)
		{
			ShowNextPage();
		}
	}

	public void ShowLastPage()
	{
		if (_curPage > 0)
		{
			ShowByIndex(_curPage - 1);
		}
	}

	private void ShowPrePage(BaseEventContent eventContent)
	{
		if (eventContent is GuideUIPrePageEvt)
		{
			ShowLastPage();
		}
	}

	public override void StepFinish()
	{
		if (CanFinish)
		{
			base.StepFinish();
		}
	}

	private void CLosePage(BaseEventContent eventContent)
	{
		if (eventContent is GuideUIClosePage)
		{
			StepFinish();
		}
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_UINextPage, ShowNextPage);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_UIPrePage, ShowPrePage);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Guide_UIClosePage, CLosePage);
		indexGroup.UnInit();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder builder) =>
		{
			base.UnInit();
		}).Play();
	}
}
