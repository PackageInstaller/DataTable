using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardStageUI : RogueCardStateUIBase
{
	public Button playBtn;

	public Button discardBtn;

	public Button sortBtn;

	public Button speedBtn;

	public Button playBtnGray;

	public Button discardBtnGray;

	public RogueCardHolder handHolder;

	public Text scoreText1;

	public Text scoreText2;

	private bool ignoreScoreAni;

	public Animator scoreAni1;

	public Animator scoreAni2;

	public GameObject scoreFire1;

	public GameObject scoreFire2;

	public Text scoreTextAll;

	public Text speedText;

	public GameObject previewScoreGo;

	public GameObject scoreTypeTextGo;

	public Text scoreTypeText;

	public Text scoreLevelText;

	public Text specialText;

	public Text sortText;

	public GameObject deckInfoRootGo;

	public RogueCardDeckInfoUI deckInfo;

	public ControllerExCollection calControllerEx;

	[HideInInspector]
	public ControllerEx calController;

	[HideInInspector]
	public ControllerEx specialTextCon;

	public List<RogueCommonCard> calScoreCardList;

	private ControllerEx playCardCon;

	private ControllerEx discardCon;

	public Animator scoringTextAni;

	public Animator numberAni;

	public GameObject woeTextGo;

	public Text woeText;

	public Animator woeAni;

	public GameObject flyPointGo;

	public override void Init()
	{
		handHolder.Init();
		handHolder.SwapEvent.AddListener(SwapHandCard);
		deckInfo.Init();
		calController = calControllerEx.GetController("speed");
		playCardCon = calControllerEx.GetController("playBtn");
		discardCon = calControllerEx.GetController("discardBtn");
		specialTextCon = calControllerEx.GetController("specialText");
		AddBtnListener(playBtn, delegate
		{
			if (RogueCardGameMain.GameContext.GetSelectIndexList().Length == 0)
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NOT_SELECT_CARD");
			}
			else
			{
				RogueCardGameMain.Instance?.PlayCard();
			}
		});
		AddBtnListener(playBtnGray, delegate
		{
			if (RogueCardGameMain.GameContext.GetSelectIndexList().Length == 0)
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NOT_SELECT_CARD");
			}
			else
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_LACK_PLAY_NUM");
			}
		});
		AddBtnListener(discardBtn, delegate
		{
			if (RogueCardGameMain.GameContext.GetSelectIndexList().Length == 0)
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NOT_SELECT_CARD");
			}
			else if (RogueCardGameMain.GameContext.discardNum <= 0)
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_LACK_DISCARD_NUM");
			}
			else
			{
				RogueCardGameMain.Instance?.DisCardCard();
			}
		});
		AddBtnListener(discardBtnGray, delegate
		{
			if (RogueCardGameMain.GameContext.GetSelectIndexList().Length == 0)
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NOT_SELECT_CARD");
			}
			else
			{
				LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_LACK_DISCARD_NUM");
			}
		});
		AddBtnListener(sortBtn, delegate
		{
			RogueCardGameMain.Instance.SortCard();
		});
		AddForceBtnListener(speedBtn, delegate
		{
			RogueCardGameMain.Instance.ChangeAniSpeed();
			speedText.text = (RogueCardGameMain.Instance.isAniSpeedUp ? "X2" : "X1");
		});
		scoreText1.UnregisterDirtyVerticesCallback(OnScore1Change);
		scoreText1.RegisterDirtyVerticesCallback(OnScore1Change);
		scoreText2.UnregisterDirtyVerticesCallback(OnScore2Change);
		scoreText2.RegisterDirtyVerticesCallback(OnScore2Change);
	}

	public override void OnEnter()
	{
		base.OnEnter();
		calController.SetSelectedState("off");
		handHolder.ResetAndRebuild();
		List<int> woeList = RogueCardGameMain.GameContext.woeList;
		int num = woeList[woeList.Count - 1];
		if (RogueCardGameMain.GameContext.curStageState == StageType.Boss && num != 299 && !RogueCardGameMain.GameContext.ignoreWoe)
		{
			ShowWoeState();
		}
		else
		{
			RogueCardGameMain.Instance.ShowWoeTip(isShow: false);
		}
		PreviewScore(isPreview: false);
	}

	public override void OnExit()
	{
		handHolder.OnDispose();
		base.OnExit();
	}

	public override void RefreshUI()
	{
		handHolder.ShowCard(RogueCardGameMain.GameContext.handData);
		playCardCon.SetSelectedState("on");
		discardCon.SetSelectedState("on");
		speedText.text = (RogueCardGameMain.Instance.isAniSpeedUp ? "X2" : "X1");
		if (RogueCardGameMain.GameContext.GetSelectIndexList().Length == 0)
		{
			playCardCon.SetSelectedState("off");
			discardCon.SetSelectedState("off");
		}
		if (RogueCardGameMain.GameContext.discardNum <= 0)
		{
			discardCon.SetSelectedState("off");
		}
		if (RogueCardGameMain.GameContext.sortState == 2)
		{
			sortText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_SORT_SUIT");
		}
		else
		{
			sortText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_SORT_RANK");
		}
		if (RogueCardGameMain.GameContext.scoreResult.Show)
		{
			if (!RogueCardGameMain.Instance.notScore)
			{
				specialTextCon.SetSelectedState("off");
				if (!RogueCardGameMain.Instance.isShowingScore)
				{
					RogueCardGameMain.Instance.isShowingScore = true;
					scoreText1.text = "0";
					scoreText2.text = "0";
					calController.SetSelectedState("on");
					RogueCardTimeSystem.StartTick();
					StartCoroutine(ShowScore());
				}
			}
			return;
		}
		RogueCardGameMain.Instance.isShowingScore = false;
		bool num = RogueCardGameMain.Instance.IsSettleAni || RogueCardGameMain.Instance.CurState is TurnSettleState || RogueCardGameMain.Instance.CurState is SettleState;
		string selectedState = calController.GetSelectedState();
		bool flag = selectedState == "hideBtn" || selectedState == "off_on";
		if (num)
		{
			calController.SetSelectedState("hideBtn");
		}
		else if (!flag)
		{
			if (RogueCardGameMain.GameContext.GetTargetScore >= int.MaxValue)
			{
				calController.SetSelectedState("off");
			}
			else if (RogueCardGameMain.GameContext.score >= RogueCardGameMain.GameContext.GetTargetScore)
			{
				calController.SetSelectedState("finish");
			}
			else
			{
				calController.SetSelectedState("off");
			}
		}
		int[] selectIndexList = RogueCardGameMain.GameContext.GetSelectIndexList();
		List<RogueCardData> list = new List<RogueCardData>();
		int[] array = selectIndexList;
		foreach (int index in array)
		{
			list.Add(RogueCardGameMain.GameContext.GetHandCard(index));
		}
		specialTextCon.SetSelectedState("off");
		if (list.Count > 0)
		{
			PreviewScore(isPreview: true);
			Tuple<HandType, int, int> previewData = RogueCardScoreSystem.Instance.GetPreviewData(list.ToArray());
			RogueHandTypeCfg rogueHandTypeCfg = RogueCardDataManager.handTypeDatabase[previewData.Item1];
			if (rogueHandTypeCfg.name != scoreTypeText.text)
			{
				scoreTypeTextGo.SetActive(value: false);
			}
			scoreTypeTextGo.SetActive(value: true);
			scoreTextAll.gameObject.SetActive(value: false);
			scoreTypeText.text = rogueHandTypeCfg.name;
			scoreLevelText.text = RogueCardTipSystem.GetTip("PINBALLGAME_GAME_SKILL_LEVEL2", RogueCardGameMain.GameContext.handTypeLevel[previewData.Item1].ToString());
			scoreText1.text = previewData.Item2.ToString();
			scoreText2.text = previewData.Item3.ToString();
			if (previewData.Item1 == (HandType)0 || previewData.Item2 == 0)
			{
				if (RogueCardGameMain.GameContext.isDisableType)
				{
					specialTextCon.SetSelectedState("on");
					specialText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_NO_SCORE") + "\n" + RogueCardTipSystem.GetTip("ROGUE_CARD_USED_HAND_TYPE");
				}
				else if (RogueCardGameMain.GameContext.isOnlyType && RogueCardGameMain.GameContext.onlyType.HasValue)
				{
					specialTextCon.SetSelectedState("on");
					HandType value = RogueCardGameMain.GameContext.onlyType.Value;
					specialText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_NO_SCORE") + "\n" + RogueCardTipSystem.GetTip("ROGUE_CARD_ALLOW_HAND_TYPE", RogueCardDataManager.handTypeDatabase[value].name);
				}
				else
				{
					specialTextCon.SetSelectedState("off");
				}
			}
		}
		else
		{
			PreviewScore(isPreview: false);
		}
	}

	private void OnScore1Change()
	{
		if (!ignoreScoreAni)
		{
			scoreAni1.Play("UI_textleftnum", 0, 0f);
		}
	}

	private void OnScore2Change()
	{
		if (!ignoreScoreAni)
		{
			scoreAni2.Play("UI_textleftnum", 0, 0f);
		}
	}

	public void PreviewScore(bool isPreview)
	{
		if (!isPreview)
		{
			previewScoreGo.SetActive(value: false);
		}
		else
		{
			previewScoreGo.SetActive(value: true);
		}
	}

	public void ShowWoeState()
	{
		woeTextGo.SetActive(value: true);
		Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase = RogueCardDataManager.wealAndWoeDatabase;
		List<int> woeList = RogueCardGameMain.GameContext.woeList;
		RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = wealAndWoeDatabase[woeList[woeList.Count - 1]];
		woeText.text = rogueCardWealAndWoeCfg.desc;
		StartCoroutine(ShowWoe());
	}

	private IEnumerator ShowWoe()
	{
		yield return new WaitForSeconds(2f);
		woeAni.Play("UI_text_xs", 0, 0f);
		yield return new WaitForSeconds(1f);
		RogueCardGameMain.Instance.ShowWoeTip(isShow: true);
		woeTextGo.SetActive(value: false);
	}

	private string FormatFloat(float value)
	{
		if (float.IsNaN(value))
		{
			return "NaN";
		}
		if (float.IsInfinity(value))
		{
			return "INF";
		}
		if (value >= 2.1474836E+09f)
		{
			return "INF";
		}
		if (Math.Abs(value) < 100f)
		{
			return value.ToString("0.#", CultureInfo.InvariantCulture);
		}
		long num = (long)Math.Round(value);
		if (!(Math.Abs(value) >= 1000f))
		{
			return num.ToString("0", CultureInfo.InvariantCulture);
		}
		return num.ToString("N0", CultureInfo.InvariantCulture);
	}

	private string BuildScoreEffectText(ScoreBase scoreData, out FlyNumberType type)
	{
		StringBuilder stringBuilder = new StringBuilder("");
		type = FlyNumberType.Normal;
		if (scoreData.score != 0f)
		{
			stringBuilder.Append(string.Format(RogueCardTipSystem.GetTip("ROGUE_CARD_PLAY_SCORE"), scoreData.score.ToString("#.#")));
			type = FlyNumberType.Score;
		}
		if (scoreData.multi != 0f)
		{
			stringBuilder.Append(string.Format(RogueCardTipSystem.GetTip("ROGUE_CARD_PLAY_ADD_MULTI"), scoreData.multi.ToString("#.#")));
			type = FlyNumberType.Multi;
		}
		if (scoreData.allMulti != 100f)
		{
			float num = scoreData.allMulti / 100f;
			stringBuilder.Append(string.Format(RogueCardTipSystem.GetTip("ROGUE_CARD_PLAY_MULTI"), num.ToString("#.#")));
			type = FlyNumberType.Multi;
		}
		if (scoreData.isMulti)
		{
			stringBuilder.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_MULTI_SCORE"));
			type = FlyNumberType.Normal;
		}
		if (scoreData.isLevelUp)
		{
			stringBuilder.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_ADD_LEVEL"));
			type = FlyNumberType.Normal;
		}
		if (scoreData.isEnhance != 0)
		{
			stringBuilder.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_ENHANCE"));
			type = FlyNumberType.Normal;
		}
		if (scoreData.addDiscard != 0)
		{
			stringBuilder.Append(string.Format(RogueCardTipSystem.GetTip("ROGUE_CARD_CHANGE_DISCARD_NUM"), $"{scoreData.addDiscard:+0;-0;0}"));
			type = FlyNumberType.Normal;
		}
		return stringBuilder.ToString();
	}

	private string BuildCardScoreFlyText(ScoreBase scoreData, out FlyNumberType type)
	{
		string text = BuildScoreEffectText(scoreData, out type);
		string.IsNullOrEmpty(text);
		return text;
	}

	private bool HasScoreEffectDisplay(ScoreBase scoreData)
	{
		if (scoreData == null)
		{
			return false;
		}
		if (scoreData.score == 0f && scoreData.multi == 0f && scoreData.allMulti == 100f && !scoreData.isMulti && !scoreData.isLevelUp && scoreData.isEnhance == 0 && scoreData.addDiscard == 0)
		{
			return scoreData.addDraw != 0;
		}
		return true;
	}

	private bool TryGetHandTwoPair(ScoreResult result, ScoreBase scoreData, out CardScore pairedCardScore)
	{
		pairedCardScore = null;
		if (!(scoreData is JokerScore { playTogetherWithNext: not false, linkedCardData: not null } jokerScore))
		{
			return false;
		}
		if (result.scoreQueue.Count <= 0)
		{
			return false;
		}
		if (!(result.scoreQueue.Peek() is CardScore cardScore))
		{
			return false;
		}
		if (cardScore.cardData != jokerScore.linkedCardData || cardScore.linkedJokerData != jokerScore.jokerData)
		{
			return false;
		}
		pairedCardScore = result.scoreQueue.Dequeue() as CardScore;
		return pairedCardScore != null;
	}

	private IEnumerator ShowScore()
	{
		RogueCardGameMain.Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_COMMUNICATION_LOCK_TITLE");
		InputLockToken inputLock = RogueCardGameMain.Instance.GetInputLock("ShowScore", base.gameObject, 30f);
		try
		{
			RogueCardGameMain.Instance.SwitchStoryModule(isStory: false);
			ScoreResult result = RogueCardGameMain.GameContext.scoreResult;
			scoreTypeTextGo.SetActive(value: true);
			scoreTextAll.gameObject.SetActive(value: false);
			for (int i = 0; i < 3; i++)
			{
				if (i >= result.scoreCardData.Count)
				{
					calScoreCardList[i].SetActive(isActive: false);
					continue;
				}
				calScoreCardList[i].SetActive(isActive: true);
				RogueCardData cardData = ((i < result.originScoreCardData.Count && result.originScoreCardData[i] != null) ? result.originScoreCardData[i] : result.scoreCardData[i]);
				calScoreCardList[i].SetData(cardData, i);
			}
			int num = RogueCardGameMain.GameContext.handTypeLevel[result.HandType];
			int displayLv = num - result.shouleSubLv;
			int num2 = ((result.beforeLv > 0) ? result.beforeLv : displayLv);
			float score = result.HandTypeScore;
			float mul = result.HandTypeMulti;
			if (num2 != displayLv && result.beforeLvJoker != null && result.beforeLvJoker.Count > 0)
			{
				RogueHandTypeCfg rogueHandTypeCfg = RogueCardDataManager.handTypeDatabase[result.HandType];
				scoreText1.text = (rogueHandTypeCfg.base_score + (num2 - 1) * rogueHandTypeCfg.add_score).ToString();
				scoreText2.text = (rogueHandTypeCfg.base_multi + (num2 - 1) * rogueHandTypeCfg.add_multi).ToString();
				scoreTypeTextGo.SetActive(value: true);
				scoreTextAll.gameObject.SetActive(value: false);
				scoreTypeText.text = rogueHandTypeCfg.name;
				scoreLevelText.text = RogueCardTipSystem.GetTip("PINBALLGAME_GAME_SKILL_LEVEL2", num2.ToString());
				yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true));
				foreach (int index in result.beforeLvJoker)
				{
					RogueCard rogueCard = RogueCardGameMain.Instance.jokerHolder.cards.Find((RogueCard card) => card.ParentIndex() == index);
					if (rogueCard != null)
					{
						(rogueCard.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_chufa", RogueCardTimeSystem.GetSpeed);
						(rogueCard.cardVisual as VisualJokerCard).PlayFlyNum(RogueCardTipSystem.GetTip("ROGUE_CARD_ADD_LEVEL"), FlyNumberType.Normal, speed: true);
					}
				}
				numberAni.Play("UI_ndModel_change", -1, 0f);
				scoreText1.text = FormatFloat(score);
				scoreText2.text = FormatFloat(mul);
			}
			else
			{
				ignoreScoreAni = true;
				scoreText1.text = FormatFloat(score);
				scoreText2.text = FormatFloat(mul);
				ignoreScoreAni = false;
			}
			RogueHandTypeCfg rogueHandTypeCfg2 = RogueCardDataManager.handTypeDatabase[result.HandType];
			scoreTypeTextGo.SetActive(value: true);
			scoreTextAll.gameObject.SetActive(value: false);
			scoreTypeText.text = rogueHandTypeCfg2.name;
			scoreLevelText.text = RogueCardTipSystem.GetTip("PINBALLGAME_GAME_SKILL_LEVEL2", displayLv.ToString());
			yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true));
			if (RogueCardGameMain.Instance.guideSystem.CheckScorePause(24303))
			{
				yield return new WaitWhile(() => RogueCardGameMain.Instance.guideSystem.CheckScorePause(24303));
			}
			int i2 = 0;
			while (i2 >= 0 && result.scoreQueue.Count != 0)
			{
				ScoreBase scoreData = result.scoreQueue.Dequeue();
				if (scoreData != null)
				{
					CardScore pairedCardScore = null;
					bool hasHandTwoPair = TryGetHandTwoPair(result, scoreData, out pairedCardScore);
					score += scoreData.score;
					mul += scoreData.multi;
					mul *= scoreData.allMulti / 100f;
					if (hasHandTwoPair && pairedCardScore != null)
					{
						score += pairedCardScore.score;
						mul += pairedCardScore.multi;
						mul *= pairedCardScore.allMulti / 100f;
					}
					scoreText1.text = FormatFloat(score);
					scoreText2.text = FormatFloat(mul);
					if (score * mul > (float)RogueCardGameMain.GameContext.GetTargetScore)
					{
						scoreFire1.SetActive(value: true);
						scoreFire2.SetActive(value: true);
						AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_fire", useStream: false);
					}
					else
					{
						scoreFire1.SetActive(value: false);
						scoreFire2.SetActive(value: false);
					}
					if (scoreData.addDiscard > 0)
					{
						RogueCardGameMain.Instance.ApplyDelayedDiscardNumDisplay(scoreData.addDiscard);
					}
					bool hasPlayedEffect = false;
					if (scoreData is JokerScore)
					{
						RogueCard joker = RogueCardGameMain.Instance.jokerHolder.GetCard(scoreData.GetIndex());
						int num3 = ((hasHandTwoPair && pairedCardScore != null) ? pairedCardScore.GetIndex() : (-1));
						VisualRogueCard cardView = ((num3 >= 0) ? handHolder.GetCardByIndex(num3) : null)?.cardVisual as VisualRogueCard;
						if (joker != null)
						{
							FlyNumberType flyType = FlyNumberType.Normal;
							string flyText = BuildScoreEffectText(scoreData, out flyType);
							if (scoreData.isEnhance != 0 && calScoreCardList.Count > 0 && calScoreCardList[0] != null && result.scoreCardData.Count > 0)
							{
								calScoreCardList[0].PlayAnimation("UI_Com_RogueCardBaseItem_fanzhuan", RogueCardTimeSystem.GetSpeed);
								yield return new WaitForSeconds(RogueCardTimeSystem.GetTime("fanzhuan", useSpeed: true));
								calScoreCardList[0].SetData(result.scoreCardData[0], 0);
							}
							if (!scoreData.suppressFlyText && !string.IsNullOrEmpty(flyText))
							{
								(joker.cardVisual as VisualJokerCard).PlayFlyNum(flyText, flyType, speed: true);
							}
							(joker.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_chufa", RogueCardTimeSystem.GetSpeed);
							if (hasHandTwoPair && pairedCardScore != null && cardView != null)
							{
								string text = BuildCardScoreFlyText(pairedCardScore, out flyType);
								if (!string.IsNullOrEmpty(text))
								{
									cardView.PlayFlyNum(text, flyType, speed: true);
									cardView.PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan", RogueCardTimeSystem.GetSpeed);
								}
							}
							hasPlayedEffect = true;
							float time = (hasHandTwoPair ? Mathf.Max(RogueCardTimeSystem.GetTime("Score_JokerPlayNum", useSpeed: true), RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true)) : RogueCardTimeSystem.GetTime("Score_JokerPlayNum", useSpeed: true));
							yield return new WaitForSecondsRealtime(time);
						}
						else if (hasHandTwoPair && pairedCardScore != null && cardView != null)
						{
							FlyNumberType type = FlyNumberType.Normal;
							string text2 = BuildCardScoreFlyText(pairedCardScore, out type);
							if (!string.IsNullOrEmpty(text2))
							{
								cardView.PlayFlyNum(text2, type, speed: true);
								cardView.PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan", RogueCardTimeSystem.GetSpeed);
								hasPlayedEffect = true;
								yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true));
							}
						}
					}
					else if (scoreData is CardScore)
					{
						CardScore cardScore = scoreData as CardScore;
						if (result.scoreCardData.Contains(cardScore.cardData))
						{
							int index2 = cardScore.GetIndex();
							if (index2 >= 0 && index2 < calScoreCardList.Count && calScoreCardList[index2] != null)
							{
								FlyNumberType type2 = FlyNumberType.Normal;
								string text3 = BuildCardScoreFlyText(scoreData, out type2);
								if (!string.IsNullOrEmpty(text3))
								{
									calScoreCardList[index2].PlayFlyNum(text3, type2, speed: true);
									calScoreCardList[index2].PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan", RogueCardTimeSystem.GetSpeed);
									hasPlayedEffect = true;
									yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true));
								}
							}
						}
						else if (RogueCardGameMain.Instance.gameContext.handData.handCards.Contains(cardScore.cardData))
						{
							int index3 = cardScore.GetIndex();
							VisualRogueCard visualRogueCard = ((index3 >= 0) ? handHolder.GetCardByIndex(index3) : null)?.cardVisual as VisualRogueCard;
							if (visualRogueCard != null)
							{
								FlyNumberType type3 = FlyNumberType.Normal;
								string text4 = BuildCardScoreFlyText(scoreData, out type3);
								if (!string.IsNullOrEmpty(text4))
								{
									visualRogueCard.PlayFlyNum(text4, type3, speed: true);
									visualRogueCard.PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan", RogueCardTimeSystem.GetSpeed);
									hasPlayedEffect = true;
									yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true));
								}
							}
						}
					}
					if (!hasPlayedEffect && HasScoreEffectDisplay(scoreData))
					{
						float time2 = ((scoreData is JokerScore) ? RogueCardTimeSystem.GetTime("Score_JokerPlayNum", useSpeed: true) : RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true));
						yield return new WaitForSecondsRealtime(time2);
					}
					if (i2 == 0 && RogueCardGameMain.Instance.guideSystem.CheckScorePause(24304))
					{
						yield return new WaitWhile(() => RogueCardGameMain.Instance.guideSystem.CheckScorePause(24304));
					}
				}
				int num4 = i2 + 1;
				i2 = num4;
			}
			scoreText1.text = FormatFloat(result.FinalScore);
			scoreText2.text = FormatFloat(result.FinalMulti);
			yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_CardScoreShow", useSpeed: true));
			scoreText1.text = FormatFloat(0f);
			scoreText2.text = FormatFloat(0f);
			scoreTextAll.gameObject.SetActive(value: true);
			scoreTypeTextGo.SetActive(value: false);
			scoreTextAll.text = ((result.TotalScore >= Int.MaxValue) ? "INF" : result.TotalScore.ToString("N0"));
			yield return new WaitForSecondsRealtime(RogueCardTimeSystem.GetTime("Score_CardPlayNum", useSpeed: true));
			scoreTextAll.gameObject.SetActive(value: false);
			RogueCardGameMain.Instance.isShowingScore = false;
			scoreFire1.SetActive(value: false);
			scoreFire2.SetActive(value: false);
			AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_fire_stop", useStream: false);
			if (result.TotalScore != 0L)
			{
				flyPointGo.SetActive(value: true);
				yield return new WaitForSecondsRealtime(0.75f);
			}
			RogueCardGameMain.Instance.storyUI?.RefreshUI();
			if (result.TotalScore != 0L)
			{
				if (RogueCardGameMain.GameContext.score >= int.MaxValue)
				{
					RogueCardGameMain.Instance.curScore.SetValueImmediate(int.MaxValue);
					RogueCardGameMain.Instance.curScore.gameObject.SetActive(value: false);
					RogueCardGameMain.Instance.infScoreText.SetActive(value: true);
				}
				else
				{
					RogueCardGameMain.Instance.curScore.ScrollTo(RogueCardGameMain.GameContext.score);
				}
				yield return new WaitForSecondsRealtime(1.25f);
			}
			flyPointGo.SetActive(value: false);
			RogueCardGameMain.Instance.ShowScore(isShow: false);
		}
		finally
		{
			if (RogueCardGameMain.Instance != null)
			{
				if (RogueCardGameMain.GameContext != null && RogueCardGameMain.GameContext.scoreResult != null && RogueCardGameMain.GameContext.scoreResult.Show)
				{
					RogueCardGameMain.Instance.isShowingScore = false;
					RogueCardGameMain.Instance.ShowScore(isShow: false);
				}
				if (RogueCardGameMain.Instance.mainTitle != null)
				{
					RogueCardGameMain.Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_INVESTIGATION_TITLE", $"{RogueCardGameMain.GameContext.curRound}/{RogueCardGameMain.GameContext.allRoundNum}", RogueCardDataManager.stageDatabase[RogueCardGameMain.GameContext.stageID].name);
				}
			}
			inputLock?.Release();
			RogueCardTimeSystem.EndTick();
		}
	}

	public void SwapHandCard(int index1, int index2)
	{
		RogueCardGameMain.GameContext.handData.SwapCardPositions(index1, index2);
	}

	public void ShowDeckUI()
	{
		deckInfo.RefreshUI();
		deckInfoRootGo.SetActive(!deckInfoRootGo.activeSelf);
	}

	public void ShowDeckUI(bool isShow)
	{
		deckInfo.RefreshUI();
		deckInfoRootGo.SetActive(isShow);
	}
}
