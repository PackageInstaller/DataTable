using System;
using UnityEngine;

namespace RogueCard;

public class RogueCardStoryChallengeUI : RogueCardStoryBaseUI
{
	public Animator falseAni;

	public Animator truthAni;

	public GameObject effectGo;

	private bool isAni;

	private int currentDisplayIndex = -1;

	private int pendingDisplayIndex = -1;

	private bool forceShowNormalAfterBossTransition;

	public override void Init()
	{
	}

	public override void SetData()
	{
		stageCfg = RogueCardDataManager.stageDatabase[RogueCardGameMain.GameContext.stageID];
		SyncCurrentStageDisplay();
	}

	public override void RefreshUI()
	{
		if (!isAni)
		{
			SyncCurrentStageDisplay();
		}
	}

	public override void OnStartNormalStage()
	{
		effectGo.SetActive(value: true);
		currentDisplayIndex = ((pendingDisplayIndex >= 0) ? pendingDisplayIndex : GetTransitionDisplayIndex());
		pendingDisplayIndex = -1;
		ApplyFalseDisplay(currentDisplayIndex);
		falseImg.gameObject.SetActive(value: true);
		trueImg.gameObject.SetActive(value: false);
		RogueCardGameMain.GameContext.isChallengeContinue = false;
		isAni = false;
	}

	public override void OnFinishNormalStage()
	{
		isAni = true;
		forceShowNormalAfterBossTransition = false;
		falseAni.Play("UI_False_xs", 0, 0f);
		effectGo.SetActive(value: false);
	}

	public override void OnStartChallengeState()
	{
		effectGo.SetActive(value: true);
		falseImg.gameObject.SetActive(value: false);
		trueImg.gameObject.SetActive(value: true);
		truthAni.enabled = true;
		RogueCardGameMain.Instance.clueTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_STAGE6_TITLE");
		isAni = false;
	}

	public override void OnFinishChallengeStage()
	{
		isAni = true;
		forceShowNormalAfterBossTransition = true;
		pendingDisplayIndex = GetTransitionDisplayIndex();
		truthAni.enabled = false;
		effectGo.SetActive(value: false);
		falseAni.Play("UI_Truth_xs", 0, 0f);
	}

	public void OnContinueStage()
	{
		RogueCardGameMain.Instance.resultCon.SetSelectedState("Plot");
	}

	public override void SetAll()
	{
		truthAni.enabled = false;
		effectGo.SetActive(value: false);
		falseAni.Play("UI_Truth_xs", 0, 0f);
	}

	private void SyncCurrentStageDisplay()
	{
		if (RogueCardGameMain.Instance.CurState == null)
		{
			falseImg.gameObject.SetActive(value: false);
			trueImg.gameObject.SetActive(value: false);
			return;
		}
		if (!(RogueCardGameMain.Instance.CurState is StateWithSubstates) && (RogueCardGameMain.Instance.CurState.GetIndex() > 2 || RogueCardGameMain.GameContext.curRound != 1 || RogueCardGameMain.GameContext.curStageState != StageType.Normal))
		{
			falseImg.gameObject.SetActive(value: false);
			trueImg.gameObject.SetActive(value: false);
			return;
		}
		if (ShouldShowBossDisplay())
		{
			ShowBossDisplay();
			return;
		}
		if (currentDisplayIndex < 0)
		{
			currentDisplayIndex = GetCurrentDisplayIndex();
		}
		ShowNormalDisplay(currentDisplayIndex);
	}

	private bool ShouldShowBossDisplay()
	{
		if (forceShowNormalAfterBossTransition)
		{
			return false;
		}
		if (RogueCardGameMain.GameContext.isChallengeContinue)
		{
			return false;
		}
		if (RogueCardGameMain.GameContext.restoreChallengeNormalStoryImage)
		{
			return false;
		}
		if (RogueCardGameMain.GameContext.curStageState == StageType.Boss)
		{
			return true;
		}
		if (RogueCardGameMain.GameContext.curStageState == StageType.Normal && RogueCardGameMain.Instance != null && RogueCardGameMain.Instance.CurState != null)
		{
			return RogueCardGameMain.Instance.CurState.GetIndex() >= 7;
		}
		return false;
	}

	private void ShowBossDisplay()
	{
		effectGo.SetActive(value: true);
		falseImg.gameObject.SetActive(value: false);
		trueImg.gameObject.SetActive(value: true);
		RogueCardGameMain.Instance.clueTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_STAGE6_TITLE");
	}

	private void ShowNormalDisplay(int displayIndex)
	{
		ApplyFalseDisplay(displayIndex);
		falseImg.gameObject.SetActive(value: true);
		trueImg.gameObject.SetActive(value: false);
		truthAni.enabled = false;
		effectGo.SetActive(value: true);
	}

	private int GetCurrentDisplayIndex()
	{
		if (stageCfg == null || stageCfg.false_picture == null || stageCfg.false_picture.Length == 0)
		{
			return 0;
		}
		return EnsureDisplayIndexForRound(RogueCardGameMain.GameContext.curRound, forceRefresh: false);
	}

	private int GetTransitionDisplayIndex()
	{
		if (stageCfg == null || stageCfg.false_picture == null || stageCfg.false_picture.Length == 0)
		{
			return 0;
		}
		int num = RogueCardGameMain.GameContext.curRound - 1;
		if (RogueCardGameMain.Instance.CurState.GetIndex() >= 7 && num < RogueCardGameMain.GameContext.allRoundNum - 1)
		{
			return EnsureDisplayIndexForRound(RogueCardGameMain.GameContext.curRound + 1, forceRefresh: true);
		}
		return EnsureDisplayIndexForRound(RogueCardGameMain.GameContext.curRound, forceRefresh: false);
	}

	private int EnsureDisplayIndexForRound(int round, bool forceRefresh)
	{
		int num = stageCfg.false_picture.Length;
		if (num <= 0)
		{
			return 0;
		}
		RogueCardGameContext gameContext = RogueCardGameMain.GameContext;
		if (!forceRefresh && gameContext.challengeStoryNormalImageIndex >= 0 && gameContext.challengeStoryNormalImageIndex < num)
		{
			return gameContext.challengeStoryNormalImageIndex;
		}
		return gameContext.challengeStoryNormalImageIndex = GenerateDisplayIndex(round, num);
	}

	private int GenerateDisplayIndex(int round, int pictureCount)
	{
		if (pictureCount <= 1)
		{
			return 0;
		}
		return new System.Random((((RogueCardGameMain.GameContext.RandomSeed * 397) ^ RogueCardGameMain.GameContext.stageID) * 397) ^ Mathf.Max(round, 1)).Next(0, pictureCount);
	}

	private void ApplyFalseDisplay(int displayIndex)
	{
		if (stageCfg != null && stageCfg.false_picture != null && stageCfg.false_picture.Length != 0)
		{
			int num = displayIndex % stageCfg.false_picture.Length;
			if (num < 0)
			{
				num += stageCfg.false_picture.Length;
			}
			AtlasManager.GetSpriteWithoutAtlas(falseImg, "TextureBg/Activity_JokerCard/" + stageCfg.false_picture[num]);
			RogueCardGameMain.Instance.clueTitle.text = RogueCardTipSystem.GetTip($"ROGUE_CARD_STAGE{num + 1}_TITLE");
		}
	}
}
