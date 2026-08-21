using System.Collections;
using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardFinishUI : RogueCardStateUIBase
{
	public ControllerExCollection mainEx;

	private ControllerEx modeCon;

	private ControllerEx plotCon;

	public Text normalWinTitleText;

	public Text normalLoseTitleText;

	public Text normalWinDescText;

	public Text normalLoseDescText;

	public Text challengeTitleText;

	public Text difficultyText;

	public Image deckImg;

	public Text ratioText;

	public Text handTypeNumText;

	public Text roundNumText;

	public Text maxRoundNumText;

	public Text useCardText;

	public Text discardText;

	public Text blackText;

	public Text whiteText;

	public Text goldText;

	public Text handTypeNumText2;

	public Text roundNumText2;

	public Text maxRoundNumText2;

	public Text useCardText2;

	public Text discardText2;

	public Text blackText2;

	public Text whiteText2;

	public Text goldText2;

	public Text scoreText;

	public Text scoreRatioText;

	public Button confirmBtn;

	public Button backBtn;

	public Button continueBtn;

	public Button restartBtn;

	public Text rollBackText;

	public Button rollBackTipBtn;

	public Button bgBtn;

	public GameObject rollBackTipGo;

	public Text rollBackTipText;

	public Animator mainAni;

	public ControllerExCollection btnEx;

	private ControllerEx btnCon;

	public override void Init()
	{
		plotCon = mainEx.GetController("Plot");
		modeCon = mainEx.GetController("Mode");
		btnCon = btnEx.GetController("gray");
		AddBtnListener(confirmBtn, delegate
		{
			List<int> list = new List<int>();
			foreach (KeyValuePair<HandType, int> item in RogueCardGameMain.GameContext.settleContext.handTypeUseNum)
			{
				list.Add(item.Value);
			}
			if (RogueCardGameMain.GameContext.stageType == LevelType.Challenge)
			{
				int num = (RogueCardGameMain.GameContext.result ? 1 : 2);
				LuaHelper.CallFunction("RogueCardGameBridge.ExitRogueCardGameWithSettle", RogueCardGameMain.GameContext.settleContext, RogueCardGameMain.GameContext.challengeDifficulty, RogueCardGameMain.GameContext.rogueDeck.deckID, num, RogueCardGameMain.Instance.ActiveSettle, list);
			}
			else
			{
				LuaHelper.CallFunction("RogueCardGameBridge.SettleStage", RogueCardGameMain.GameContext.result ? 1 : 2, RogueCardGameMain.GameContext.settleContext, RogueCardGameMain.Instance.ActiveSettle, list);
			}
		});
		AddBtnListener(backBtn, delegate
		{
			if (RogueCardGameMain.GameContext.rollBackNum <= 0)
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NO_ROLLBACK");
			}
			else
			{
				LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", false);
				StartCoroutine(StartRollBack());
			}
		});
		AddBtnListener(restartBtn, delegate
		{
			LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", false);
			StartCoroutine(StartRestart());
		});
		AddBtnListener(continueBtn, delegate
		{
			LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", false);
			mainAni.Play("UI_ResultCotent_xs", -1, 0f);
			RogueCardGameMain.Instance.ChallengeContinue();
		});
		AddBtnListener(rollBackTipBtn, delegate
		{
			rollBackTipGo.SetActive(value: true);
		});
		AddBtnListener(bgBtn, delegate
		{
			rollBackTipGo.SetActive(value: false);
		});
	}

	private IEnumerator StartRollBack()
	{
		RogueCardGameMain.Instance.OnDispose();
		bool isGuide = RogueCardGameMain.Instance.guideSystem.IsGuiding;
		mainAni.Play("UI_ResultCotent_xs", -1, 0f);
		yield return new WaitForEndOfFrame();
		RogueCardEffectManager.Instance.UnRegistAllEffects();
		RogueCardGameMain.Instance.StartGame(RogueCardGameMain.GameContext.stageID, RogueCardGameMain.Instance.saveSystem.rollBackData, RogueCardGameMain.Instance.saveSystem.rollBackData, isGuide, isRollBack: true);
		RogueCardGameMain.Instance.RefreshUI();
	}

	private IEnumerator StartRestart()
	{
		bool isGuide = RogueCardGameMain.Instance.guideSystem.IsGuiding;
		int deckID = RogueCardGameMain.GameContext.rogueDeck.deckID;
		RogueCardGameMain.Instance.OnDispose();
		mainAni.Play("UI_ResultCotent_xs", -1, 0f);
		yield return new WaitForEndOfFrame();
		RogueCardGameMain.Instance.StartGame(RogueCardGameMain.GameContext.stageID, deckID, RogueCardGameMain.GameContext.challengeDifficulty, isGuide);
		RogueCardGameMain.Instance.RefreshUI();
	}

	public override void OnEnter()
	{
		base.OnEnter();
		mainAni.Rebind();
		mainAni.Play("Empty", -1, 0f);
		rollBackTipGo.SetActive(value: false);
		RefreshUI();
		LuaHelper.CallFunction("RogueCardGameBridge.LuaCheckFinishMessage", RogueCardGameMain.GameContext.stageID, RogueCardGameMain.GameContext.rogueDeck.deckID, RogueCardGameMain.GameContext.challengeDifficulty, RogueCardGameMain.GameContext.result);
	}

	public override void OnExit()
	{
		RogueCardGameMain.GameContext.resultContinue = false;
		base.OnExit();
	}

	public override void RefreshUI()
	{
		if (RogueCardGameMain.GameContext.stageType == LevelType.Challenge)
		{
			if (RogueCardGameMain.GameContext.result && RogueCardGameMain.GameContext.resultContinue && RogueCardGameMain.GameContext.curRound == RogueCardGameMain.GameContext.allRoundNum)
			{
				plotCon.SetSelectedState("continue");
			}
			else
			{
				plotCon.SetSelectedState("win");
			}
		}
		else
		{
			plotCon.SetSelectedState(RogueCardGameMain.GameContext.result ? "win" : "lose");
		}
		modeCon.SetSelectedState((RogueCardGameMain.GameContext.stageType == LevelType.Challenge) ? "Challenge" : "Plot");
		int num = 0;
		HandType key = HandType.HighCard;
		foreach (KeyValuePair<HandType, int> item in RogueCardGameMain.GameContext.settleContext.handTypeUseNum)
		{
			if (num <= item.Value)
			{
				num = item.Value;
				key = item.Key;
			}
		}
		RogueHandTypeCfg rogueHandTypeCfg = RogueCardDataManager.handTypeDatabase[key];
		if (num == 0)
		{
			handTypeNumText.text = "";
		}
		else
		{
			handTypeNumText.text = $"{rogueHandTypeCfg.name}({num})";
		}
		roundNumText.text = RogueCardGameMain.GameContext.settleContext.round.ToString();
		maxRoundNumText.text = RogueCardGameMain.GameContext.settleContext.maxScore.ToString();
		useCardText.text = RogueCardGameMain.GameContext.settleContext.useCardNum.ToString();
		discardText.text = RogueCardGameMain.GameContext.settleContext.discardNum.ToString();
		blackText.text = RogueCardGameMain.GameContext.settleContext.blackWuChangNum.ToString();
		whiteText.text = RogueCardGameMain.GameContext.settleContext.whiteWuChangNum.ToString();
		goldText.text = RogueCardGameMain.GameContext.settleContext.gainGoldNum.ToString();
		if (num == 0)
		{
			handTypeNumText2.text = "";
		}
		else
		{
			handTypeNumText2.text = $"{rogueHandTypeCfg.name}({num})";
		}
		roundNumText2.text = RogueCardGameMain.GameContext.settleContext.round.ToString();
		maxRoundNumText2.text = RogueCardGameMain.GameContext.settleContext.maxScore.ToString();
		useCardText2.text = RogueCardGameMain.GameContext.settleContext.useCardNum.ToString();
		discardText2.text = RogueCardGameMain.GameContext.settleContext.discardNum.ToString();
		blackText2.text = RogueCardGameMain.GameContext.settleContext.blackWuChangNum.ToString();
		whiteText2.text = RogueCardGameMain.GameContext.settleContext.whiteWuChangNum.ToString();
		goldText2.text = RogueCardGameMain.GameContext.settleContext.gainGoldNum.ToString();
		normalWinTitleText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_WIN_TITLE");
		normalLoseTitleText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_LOSE_TITLE");
		normalWinDescText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_WIN_DESC");
		normalLoseDescText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_LOSE_DESC");
		challengeTitleText.text = (RogueCardGameMain.GameContext.result ? RogueCardTipSystem.GetTip("ROGUE_CARD_WIN_TITLE_EX") : RogueCardTipSystem.GetTip("ROGUE_CARD_LOSE_TITLE_EX"));
		difficultyText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_DIFFICULT", RogueCardGameMain.GameContext.challengeDifficulty.ToString());
		rollBackText.text = $"{RogueCardGameMain.GameContext.rollBackNum}/{RogueCardGameMain.Instance.rollBackMaxNum}";
		if (RogueCardGameMain.GameContext.rollBackNum == 0)
		{
			btnCon.SetSelectedState("on");
		}
		else
		{
			btnCon.SetSelectedState("off");
		}
		rollBackTipText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_ROLLBACK_TIPS");
		bool active = false;
		if (RogueCardGameMain.GameContext.stageType != LevelType.Challenge && !RogueCardGameMain.GameContext.result && (RogueCardGameMain.GameContext.curRound >= 2 || (RogueCardGameMain.GameContext.curRound == 1 && RogueCardGameMain.GameContext.curStageState == StageType.Boss && RogueCardGameMain.GameContext.stageType != LevelType.Boss)) && !RogueCardGameMain.Instance.ActiveSettle)
		{
			active = true;
		}
		backBtn.gameObject.SetActive(active);
		rollBackText.gameObject.SetActive(active);
		rollBackTipBtn.gameObject.SetActive(active);
		AtlasManager.GetSpriteWithoutAtlas(deckImg, $"TextureConfig/Activity_JokerCard/itembg/rogue_card_back_{RogueCardGameMain.GameContext.rogueDeck.deckID}");
		if (RogueCardGameMain.GameContext.stageType == LevelType.Challenge)
		{
			int num2 = (int)((float)RogueCardGameMain.GameContext.settleContext.score * ((float)RogueCardDataManager.difficultyDatabase[RogueCardGameMain.GameContext.challengeDifficulty].score_rate / 100f) * ((float)RogueCardDataManager.deckDatabase[RogueCardGameMain.GameContext.rogueDeck.deckID].score_rate / 100f));
			scoreText.text = num2.ToString();
			scoreRatioText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_CALCULATION_POINT_RANK", ((int)((float)RogueCardDataManager.difficultyDatabase[RogueCardGameMain.GameContext.challengeDifficulty].score_rate * ((float)RogueCardDataManager.deckDatabase[RogueCardGameMain.GameContext.rogueDeck.deckID].score_rate / 100f))).ToString());
		}
	}
}
