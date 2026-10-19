using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.Interface;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Fundamental;
using Runtime.UI.CommonComponent.CommonScrollBag;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Tables;
using UnityEngine.UI;

namespace ACT.UI;

public class TargetGuidView : BaseTabContent
{
	public GameObject leftRoot;

	public LoopVerticalScrollRect guideScrollRect;

	public LocalizeStringEvent chapterName;

	public ActButton leftBtn;

	public ActButton rightBtn;

	public CanvasGroup btnCanvasGroup;

	public OperateBtnPrompt leftBtnPrompt;

	public OperateBtnPrompt rightBtnPrompt;

	public RedDotItem leftBtnRedDot;

	public RedDotItem rightBtnRedDot;

	public Image chapterProgressImg;

	public LocalizeStringEvent nextChapterLockProgressTxt;

	public GameObject chapterProgressRoot;

	public TextMeshProUGUI leftProgressNum;

	public TextMeshProUGUI rightProgressNum;

	public GameObject lastChapterDes;

	public GameObject lockRoot;

	public LocalizeStringEvent lockTxt;

	public CommonScrollBagComponent chapterRewardScrollBag;

	public TextMeshProUGUI chapterRewardLeftNum;

	public TextMeshProUGUI chapterRewardRightNum;

	public ActButton chapterRewardBtn;

	public GameObject chapterRewardBtnRoot;

	public GameObject chapterCantRewardRoot;

	public GameObject chapterIsInProgressTxt;

	public GameObject chapterAlreadyRewardTxt;

	private List<TargetGuideCellData> _curDisplayCellData;

	private List<ItemUnifierProxy> _curDisplayChapterRewards;

	private int _curShowChapter;

	private MonoHandbookView _view;

	private const int LOCKTXT = 2471;

	private const int CHAPTER = 2467;

	private const int NEXTCHAPTERUNLOCKPROGRESS = 2468;

	private const int CHAPTERISDONE = 2503;

	private void Awake()
	{
		_curDisplayCellData = ListPool<TargetGuideCellData>.Get();
		_curDisplayChapterRewards = ListPool<ItemUnifierProxy>.Get();
		leftBtn.SetBtnClick(LeftBtnClick);
		rightBtn.SetBtnClick(RightBtnClick);
		_curShowChapter = RuntimeConfigs.data.mainGuids.First().Value.id;
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	public void SetView(MonoHandbookView view)
	{
		_view = view;
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetPCButtonInvade(mode == DeviceInputMode.Gamepad);
	}

	private void SetPCButtonInvade(bool hide)
	{
		btnCanvasGroup.alpha = ((!hide) ? 1 : 0);
		leftBtnPrompt.SetVisible(_curShowChapter != RuntimeConfigs.data.mainGuids.Values.First().id);
		rightBtnPrompt.SetVisible(_curShowChapter != RuntimeConfigs.data.mainGuids.Values.Last().id);
	}

	protected override void OnRelease()
	{
		base.OnRelease();
		ListPool<TargetGuideCellData>.Release(_curDisplayCellData);
		ListPool<ItemUnifierProxy>.Release(_curDisplayChapterRewards);
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		int defultShowChapter = Model<TargetGuideModel>.Interface.GetDefultShowChapter();
		UpdateDisplay(defultShowChapter);
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		_curShowChapter = 1;
	}

	public override void OnPushStack()
	{
		base.OnPushStack();
	}

	public override void OnPopStack()
	{
		base.OnPopStack();
		UpdateDisplay(_curShowChapter, reFocus: true);
		_view.ChangeToGamePadInputState(_view.GetCurSubControllerType(), needReFocusLayer: true);
	}

	private void UpdateDisplay(int chapterId, bool reFocus = false)
	{
		_curShowChapter = chapterId;
		UpdateChapterDisplay(chapterId);
		RefreshCurChapterRewards(chapterId);
		FillChapterRewards();
		SetPCButtonInvade(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		if (chapterId != RuntimeConfigs.data.mainGuids.Values.First().id)
		{
			int curChapterId = chapterId - 1;
			if (!Model<TargetGuideModel>.Interface.NextChapterIsUnLock(curChapterId))
			{
				SetChapterLockState(isLock: true);
				return;
			}
		}
		SetChapterLockState(isLock: false);
		RefreshCurChapterGuideMissionsData(chapterId);
		FillTargetGuideCell();
		_view.ChangeToGamePadInputState(HandBookSubController.targetGuideMain, reFocus);
	}

	private void RefreshCurChapterGuideMissionsData(int chapterId)
	{
		MainGuid data = CoreUtils.GetData(chapterId, RuntimeConfigs.data.mainGuids);
		if (data != null)
		{
			_curDisplayCellData.Clear();
			for (int i = 0; i < data.missionGroupID.Length; i++)
			{
				TargetGuideCellData targetGuideCellData = new TargetGuideCellData();
				targetGuideCellData.missionGroupId = data.missionGroupID[i];
				targetGuideCellData.missionRewardCollectionId = data.missionRewards[i];
				targetGuideCellData.belongChapter = chapterId;
				_curDisplayCellData.Add(targetGuideCellData);
			}
			if (_curDisplayCellData.Count > 0)
			{
				_curDisplayCellData.Sort(SortUtility.SortTargetGuide);
			}
		}
	}

	private void FillTargetGuideCell()
	{
		guideScrollRect.ClearCells();
		guideScrollRect.totalCount = _curDisplayCellData.Count;
		guideScrollRect.RefillCells();
		PlayAnimation();
	}

	public void OnGuideMissionCellShow(ILoopScrollDataSource source)
	{
		if (source is TargetGuideCell { index: var index } targetGuideCell)
		{
			targetGuideCell.Init(_curDisplayCellData[index]);
		}
	}

	private void PlayAnimation()
	{
		int childCount = guideScrollRect.content.childCount;
		for (int i = 0; i < childCount; i++)
		{
			guideScrollRect.content.GetChild(i).GetComponent<TargetGuideCell>().betterAnimation?.GetSequence("Show")?.Goto(0f).SetDelay((float)i * 0.05f).Play();
		}
	}

	private void RefreshCurChapterRewards(int chapterId)
	{
		MainGuid data = CoreUtils.GetData(chapterId, RuntimeConfigs.data.mainGuids);
		if (data == null)
		{
			return;
		}
		ItemUnifierProxy.ItemUnifierPool.Release(_curDisplayChapterRewards);
		_curDisplayChapterRewards.Clear();
		int chapterRewards = data.chapterRewards;
		List<ItemKv> certain = RuntimeConfigs.data.collections[chapterRewards].certain;
		if (certain == null || certain.Count <= 0)
		{
			return;
		}
		foreach (ItemKv item2 in certain)
		{
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, item2.count);
			_curDisplayChapterRewards.Add(item);
		}
		_curDisplayChapterRewards.Sort(SortUtility.ItemUnifierQuality);
	}

	private void FillChapterRewards()
	{
		chapterRewardScrollBag.CountShowType = ItemUIComponentBase.ItemCountShowType.OneSide;
		chapterRewardScrollBag.AnimName = "Show";
		chapterRewardScrollBag.ItemSource = _curDisplayChapterRewards;
		chapterRewardScrollBag.Station = Station;
		chapterRewardScrollBag.SelectMode = CommonScrollBagComponent.SelectModeType.Single;
		chapterRewardScrollBag.ItemShowType = ItemUIComponentBase.InitType.BagItem;
		chapterRewardScrollBag.OnItemShow = null;
		CommonScrollBagComponent commonScrollBagComponent = chapterRewardScrollBag;
		commonScrollBagComponent.OnItemShow = (Action<ItemUIComponentBase>)Delegate.Combine(commonScrollBagComponent.OnItemShow, (Action<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			if (_curShowChapter == 0)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("当前章节id为0，检查_curShowChapter的赋值");
				}
			}
			else
			{
				MainGuid data = CoreUtils.GetData(_curShowChapter, RuntimeConfigs.data.mainGuids);
				bool chapterRewardState = Model<TargetGuideModel>.Interface.GetChapterRewardState(data.id);
				l.IsComplete = chapterRewardState;
			}
		}));
	}

	private void UpdateChapterDisplay(int chapterId)
	{
		(int, int) nextChapterLockProgress = Model<TargetGuideModel>.Interface.GetNextChapterLockProgress(chapterId);
		(int, int) curChapterRewardProgress = Model<TargetGuideModel>.Interface.GetCurChapterRewardProgress(chapterId);
		bool flag = Model<TargetGuideModel>.Interface.CurAllRewardIsAwarded(chapterId);
		bool flag2 = Model<TargetGuideModel>.Interface.CurChapterIsUnlock(chapterId);
		chapterName.SetTable(LocalizeTable.Common);
		chapterName.StringReference.TableEntryReference = 2467L;
		chapterName.GetVariable<string>("0").Value = chapterId.ToString();
		lastChapterDes.SetActive(chapterId == RuntimeConfigs.data.mainGuids.Values.Last().id);
		chapterProgressRoot.SetActive(chapterId != RuntimeConfigs.data.mainGuids.Values.Last().id);
		nextChapterLockProgressTxt.gameObject.SetActive((chapterId != RuntimeConfigs.data.mainGuids.Values.Last().id) & flag2);
		if (chapterId != RuntimeConfigs.data.mainGuids.Values.Last().id)
		{
			nextChapterLockProgressTxt.SetTable(LocalizeTable.Common);
			TableEntryReference tableEntryReference = (nextChapterLockProgressTxt.StringReference.TableEntryReference = (flag ? 2503 : 2468));
			nextChapterLockProgressTxt.GetVariable<string>("0").Value = (flag ? chapterId : (chapterId + 1)).FastToString();
			int num;
			if (curChapterRewardProgress.Item1 < nextChapterLockProgress.Item2)
			{
				(num, _) = curChapterRewardProgress;
			}
			else
			{
				num = nextChapterLockProgress.Item2;
			}
			int value = num;
			leftProgressNum.SetText(value.FastToString());
			rightProgressNum.SetText(nextChapterLockProgress.Item2.FastToString());
			chapterProgressImg.fillAmount = (float)curChapterRewardProgress.Item1 / (float)nextChapterLockProgress.Item2;
		}
		chapterRewardLeftNum.SetText(curChapterRewardProgress.Item1.FastToString());
		chapterRewardRightNum.SetText(curChapterRewardProgress.Item2.FastToString());
		var (active, active2) = Model<TargetGuideModel>.Interface.HasRewardableChapterAround(chapterId);
		leftBtnRedDot.gameObject.SetActive(active);
		rightBtnRedDot.gameObject.SetActive(active2);
		RefreshChapterRewardBtn(chapterId);
		RefreshSelectChapterBtn(chapterId);
	}

	public void RefreshChapterDisplay()
	{
		RefreshCurChapterGuideMissionsData(_curShowChapter);
		FillTargetGuideCell();
		UpdateChapterDisplay(_curShowChapter);
	}

	public void SetCurrentCellViewControlLayer(ViewControlLayer viewControlLayer, Transform trans)
	{
		_view.ViewControlLayers[HandBookSubController.targetGuideSelectItem] = viewControlLayer;
		_view.ViewControlLayers[HandBookSubController.targetGuideSelectItem].SetTargetTransform(trans);
	}

	private void RefreshChapterRewardBtn(int chapterId)
	{
		bool chapterRewardState = Model<TargetGuideModel>.Interface.GetChapterRewardState(chapterId);
		bool flag = Model<TargetGuideModel>.Interface.CurChapterCanReward(chapterId);
		chapterRewardBtn.gameObject.SetActive(!chapterRewardState & flag);
		chapterCantRewardRoot.SetActive(!flag | chapterRewardState);
		if (chapterRewardState)
		{
			chapterIsInProgressTxt.SetActive(value: false);
			chapterAlreadyRewardTxt.SetActive(value: true);
		}
		else if (flag)
		{
			chapterRewardBtn.SetBtnClick(() =>
			{
				Model<TargetGuideModel>.Interface.AwardChapterReward(chapterId, () =>
				{
					RefreshChapterRewardBtn(chapterId);
				});
			});
		}
		else
		{
			chapterIsInProgressTxt.SetActive(value: true);
			chapterAlreadyRewardTxt.SetActive(value: false);
		}
	}

	private void RefreshSelectChapterBtn(int chapterId)
	{
		leftBtn.gameObject.SetActive(chapterId != RuntimeConfigs.data.mainGuids.Values.First().id);
		rightBtn.gameObject.SetActive(chapterId != RuntimeConfigs.data.mainGuids.Values.Last().id);
	}

	private void LeftBtnClick()
	{
		_curShowChapter--;
		if (_curShowChapter < RuntimeConfigs.data.mainGuids.Values.First().id)
		{
			_curShowChapter = RuntimeConfigs.data.mainGuids.Values.First().id;
		}
		UpdateDisplay(_curShowChapter);
	}

	private void RightBtnClick()
	{
		_curShowChapter++;
		if (_curShowChapter > RuntimeConfigs.data.mainGuids.Values.Last().id)
		{
			_curShowChapter = RuntimeConfigs.data.mainGuids.Values.Last().id;
		}
		UpdateDisplay(_curShowChapter);
	}

	private void SetChapterLockState(bool isLock)
	{
		leftRoot.SetActive(!isLock);
		lockRoot.SetActive(isLock);
		chapterRewardBtnRoot.SetActive(!isLock);
		if (!isLock)
		{
			return;
		}
		if (_curShowChapter == 1)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("目标指引第一章不可能走到这，检查刷新章节表现");
			}
		}
		else
		{
			(int, int) nextChapterLockProgress = Model<TargetGuideModel>.Interface.GetNextChapterLockProgress(_curShowChapter - 1);
			lockTxt.SetTable(LocalizeTable.Common);
			lockTxt.StringReference.TableEntryReference = 2471L;
			lockTxt.GetVariable<string>("0").Value = (_curShowChapter - 1).FastToString();
			lockTxt.GetVariable<string>("1").Value = nextChapterLockProgress.Item2.FastToString();
		}
	}
}
