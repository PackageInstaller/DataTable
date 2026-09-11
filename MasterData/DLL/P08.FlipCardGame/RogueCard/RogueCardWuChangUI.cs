using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardWuChangUI : RogueCardStateUIBase
{
	public Button cancelBtn;

	public Button okBtn;

	public Button okBtn_grey;

	public Button whiteResetBtn;

	public Button blackResetBtn;

	public GameObject obj;

	public Text resetText;

	public RogueCommonCard whiteWuChang;

	public RogueCommonCard blackWuChang;

	public RogueCardHolder handHolder;

	private bool wuchangLock;

	public ControllerExCollection btnEx;

	private ControllerEx btnCon;

	public Animator wuchangBindAni;

	private bool isDrawingCard;

	private bool hasPlayedWuChangDestroy;

	public override void Init()
	{
		handHolder.Init(2);
		handHolder.SwapEvent.AddListener(SwapHandCard);
		btnCon = btnEx.GetController("btn");
		AddBtnListener(cancelBtn, delegate
		{
			if (!wuchangLock)
			{
				RogueCardSaveSystem.SendTrackingPoint4(RogueCardGameMain.Instance.saveSystem.GetGameData(), 3, RogueCardGameMain.GameContext.wuChangWaitCards.handCards, RogueCardGameMain.GameContext.GetWuChangSelect, 0, new List<int>
				{
					RogueCardGameMain.GameContext.whiteWuChangID,
					RogueCardGameMain.GameContext.blackWuChangID
				});
				StartCoroutine(BackState());
			}
		});
		AddBtnListener(okBtn, delegate
		{
			if (!wuchangLock)
			{
				RogueCardSaveSystem.SendTrackingPoint4(RogueCardGameMain.Instance.saveSystem.GetGameData(), 1, RogueCardGameMain.GameContext.wuChangWaitCards.handCards, RogueCardGameMain.GameContext.GetWuChangSelect, 0, new List<int>
				{
					RogueCardGameMain.GameContext.whiteWuChangID,
					RogueCardGameMain.GameContext.blackWuChangID
				});
				RogueCardGameMain.Instance.ConfirmBlackWuChangCoverIfNeeded(RogueCardGameMain.GameContext.blackWuChangID, RogueCardGameMain.GameContext.GetWuChangSelect, delegate
				{
					StartCoroutine(PlayWuChangEffect());
				});
			}
		});
		AddBtnListener(okBtn_grey, delegate
		{
			LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NOT_SELECT_CARD");
		});
		AddBtnListener(whiteResetBtn, delegate
		{
			if (!wuchangLock)
			{
				if (RogueCardGameMain.GameContext.wuChangResetNum > 0)
				{
					RogueCardSaveSystem.SendTrackingPoint4(RogueCardGameMain.Instance.saveSystem.GetGameData(), 2, RogueCardGameMain.GameContext.wuChangWaitCards.handCards, RogueCardGameMain.GameContext.GetWuChangSelect);
					RogueCardGameMain.GameContext.wuChangResetNum--;
					RogueCardGameMain.GameContext.RefreshWuChangWhiteData();
					StartCoroutine(PlayResetWhiteAni());
					RogueCardGameMain.Instance.saveSystem.SaveGameData();
				}
				else
				{
					LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NO_RESET");
				}
			}
		});
		AddBtnListener(blackResetBtn, delegate
		{
			if (!wuchangLock)
			{
				if (RogueCardGameMain.GameContext.wuChangResetNum > 0)
				{
					RogueCardSaveSystem.SendTrackingPoint4(RogueCardGameMain.Instance.saveSystem.GetGameData(), 2, RogueCardGameMain.GameContext.wuChangWaitCards.handCards, RogueCardGameMain.GameContext.GetWuChangSelect);
					RogueCardGameMain.GameContext.wuChangResetNum--;
					RogueCardGameMain.GameContext.RefreshWuChangBlackData();
					StartCoroutine(PlayResetBlackAni());
					RogueCardGameMain.Instance.saveSystem.SaveGameData();
				}
				else
				{
					LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NO_RESET");
				}
			}
		});
	}

	public void SwapHandCard(int index1, int index2)
	{
		RogueCardGameMain.GameContext.wuChangWaitCards.SwapCardPositions(index1, index2);
	}

	private IEnumerator BackState()
	{
		wuchangLock = true;
		try
		{
			yield return new WaitForSecondsRealtime(0.3f);
			yield return StartCoroutine(ExitPackage());
		}
		finally
		{
			wuchangLock = false;
		}
	}

	private void PlayWuChangDestroyOnce(bool ignoreXiaohui = false)
	{
		if (hasPlayedWuChangDestroy)
		{
			return;
		}
		hasPlayedWuChangDestroy = true;
		wuchangBindAni.enabled = true;
		if (!ignoreXiaohui)
		{
			if (whiteWuChang != null && whiteWuChang.view != null)
			{
				whiteWuChang.view.PlayAnimation("UI_Com_RogueCardBaseItem_xiaohui");
			}
			if (blackWuChang != null && blackWuChang.view != null)
			{
				blackWuChang.view.PlayAnimation("UI_Com_RogueCardBaseItem_xiaohui");
			}
		}
	}

	private IEnumerator ExitPackage()
	{
		PlayWuChangDestroyOnce(ignoreXiaohui: true);
		yield return new WaitForSeconds(0.6f);
		isDrawingCard = true;
		HandData<RogueCardData> wuChangWaitCards = RogueCardGameMain.GameContext.wuChangWaitCards;
		List<GameObject> tempCards = new List<GameObject>();
		float time = 0.3f;
		int finishedCount = 0;
		int totalExitAnims = 0;
		int i;
		for (i = 0; i < wuChangWaitCards.HandCount; i++)
		{
			RogueCard rogueCard = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == i);
			if (rogueCard == null)
			{
				continue;
			}
			totalExitAnims++;
			RogueCardData cardDataAtDisplayIndex = wuChangWaitCards.GetCardDataAtDisplayIndex(i);
			if (RogueCardGameMain.GameContext.destroyedCardsCache.Contains(cardDataAtDisplayIndex))
			{
				finishedCount++;
				continue;
			}
			if (rogueCard.cardVisual != null)
			{
				rogueCard.cardVisual.gameObject.SetActive(value: false);
			}
			GameObject tempRogueCard = RogueCardGameMain.Instance.GetTempRogueCard(handHolder.transform.parent);
			VisualRogueCard component = tempRogueCard.GetComponent<VisualRogueCard>();
			if (component != null)
			{
				component.ShowCardData(cardDataAtDisplayIndex);
			}
			tempRogueCard.transform.position = rogueCard.transform.position;
			tempRogueCard.transform.localScale = Vector3.one;
			tempCards.Add(tempRogueCard);
			Transform deckTransPoint = RogueCardGameMain.Instance.deckTransPoint;
			if (deckTransPoint != null)
			{
				LeanTween.move(tempRogueCard, deckTransPoint.position, time).setEase(LeanTweenType.easeOutCubic);
				LeanTween.scale(tempRogueCard, Vector3.zero, time).setEase(LeanTweenType.easeInBack).setOnComplete((Action)delegate
				{
					finishedCount++;
				});
			}
			else
			{
				finishedCount++;
			}
		}
		if (totalExitAnims > 0)
		{
			yield return new WaitUntil(() => finishedCount >= totalExitAnims);
		}
		foreach (GameObject item in tempCards)
		{
			RogueCardGameMain.Instance.ReleaseTempRogueCard(item);
		}
		isDrawingCard = false;
		RogueCardGameMain.Instance.ClearWuChangData();
		RogueCardGameMain.Instance.ChangeMainState(new ShopState());
		wuchangLock = false;
	}

	private IEnumerator PlayResetWhiteAni()
	{
		InputLockToken wuchangLock = RogueCardGameMain.Instance.GetInputLock("wuchang", null, 1f);
		try
		{
			RogueCardItemCfg white = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == RogueCardGameMain.GameContext.whiteWuChangID);
			whiteWuChang.view.PlayAnimation("UI_Com_RogueCardBaseItem_chongzhi_wuchang");
			RogueCardGameMain.Instance.HideTips();
			yield return new WaitForSeconds(0.12f);
			whiteWuChang.SetData(white, -1);
			yield return new WaitForSeconds(0.12f);
			RefreshUI();
		}
		finally
		{
			wuchangLock?.Release();
		}
	}

	private IEnumerator PlayResetBlackAni()
	{
		InputLockToken wuchangLock = RogueCardGameMain.Instance.GetInputLock("wuchang", null, 1f);
		try
		{
			RogueCardItemCfg black = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == RogueCardGameMain.GameContext.blackWuChangID);
			blackWuChang.view.PlayAnimation("UI_Com_RogueCardBaseItem_chongzhi_wuchang");
			RogueCardGameMain.Instance.HideTips();
			yield return new WaitForSeconds(0.12f);
			blackWuChang.SetData(black, -1);
			yield return new WaitForSeconds(0.12f);
			RefreshUI();
		}
		finally
		{
			wuchangLock?.Release();
		}
	}

	private IEnumerator PlayWuChangEffect()
	{
		RogueCardGameMain.Instance.HideTips();
		wuchangLock = true;
		try
		{
			for (int i = 0; i < handHolder.cards.Count; i++)
			{
				if (RogueCardGameMain.GameContext.wuChangWaitCards.GetSelectIndexList().Contains(handHolder.cards[i].ParentIndex()))
				{
					(handHolder.cards[i].cardVisual as VisualRogueCard).view.PlayAnimation("UI_Com_RogueCardBaseItem_fanzhuan");
				}
			}
			if (whiteWuChang != null && whiteWuChang.view != null)
			{
				whiteWuChang.view.PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan");
			}
			if (blackWuChang != null && blackWuChang.view != null)
			{
				blackWuChang.view.PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan");
			}
			yield return new WaitForSecondsRealtime(0.2f);
			RogueCardGameMain.Instance.AddAllWuChang();
			if (RogueCardGameMain.Instance.isWuChangCopyAnimating)
			{
				yield return new WaitUntil(() => !RogueCardGameMain.Instance.isWuChangCopyAnimating);
			}
			else
			{
				yield return new WaitForSecondsRealtime(0.4f);
			}
			RogueCardGameMain.GameContext.wuChangWaitCards.DeSelect();
			RefreshUI();
			foreach (RogueCardData item in RogueCardGameMain.GameContext.destroyedCardsCache)
			{
				int displayIndex = RogueCardGameMain.GameContext.wuChangWaitCards.GetDataIndex(item);
				RogueCard rogueCard = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == displayIndex);
				if (!(rogueCard != null) || !(rogueCard.cardVisual != null))
				{
					continue;
				}
				VisualRogueCard visualRogueCard = rogueCard.cardVisual as VisualRogueCard;
				GameObject obj = UnityEngine.Object.Instantiate(visualRogueCard.gameObject, visualRogueCard.transform.parent);
				obj.transform.position = visualRogueCard.transform.position;
				obj.transform.localScale = visualRogueCard.transform.localScale;
				visualRogueCard.SetActive(bActive: false);
				obj.SetActive(value: true);
				obj.transform.SetAsLastSibling();
				VisualRogueCard component = obj.GetComponent<VisualRogueCard>();
				if (component != null)
				{
					component.enabled = false;
					if (component.view != null)
					{
						component.view.PlayAnimation("UI_Com_RogueCardBaseItem_xiaohui");
					}
				}
				UnityEngine.Object.Destroy(obj, 0.3f);
			}
			yield return new WaitForSeconds(0.4f);
			wuchangBindAni.enabled = true;
			PlayWuChangDestroyOnce();
			yield return new WaitForSeconds(0.6f);
			isDrawingCard = true;
			HandData<RogueCardData> wuChangWaitCards = RogueCardGameMain.GameContext.wuChangWaitCards;
			List<GameObject> tempCards = new List<GameObject>();
			float time = 0.3f;
			int finishedCount = 0;
			int totalExitAnims = 0;
			int i2;
			for (i2 = 0; i2 < wuChangWaitCards.HandCount; i2++)
			{
				RogueCard rogueCard2 = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == i2);
				if (rogueCard2 == null)
				{
					continue;
				}
				totalExitAnims++;
				RogueCardData cardDataAtDisplayIndex = wuChangWaitCards.GetCardDataAtDisplayIndex(i2);
				if (RogueCardGameMain.GameContext.destroyedCardsCache.Contains(cardDataAtDisplayIndex))
				{
					finishedCount++;
					continue;
				}
				if (rogueCard2.cardVisual != null)
				{
					rogueCard2.cardVisual.gameObject.SetActive(value: false);
				}
				GameObject tempRogueCard = RogueCardGameMain.Instance.GetTempRogueCard(handHolder.transform.parent);
				VisualRogueCard component2 = tempRogueCard.GetComponent<VisualRogueCard>();
				if (component2 != null)
				{
					component2.ShowCardData(cardDataAtDisplayIndex);
				}
				tempRogueCard.transform.position = rogueCard2.transform.position;
				tempRogueCard.transform.localScale = Vector3.one;
				tempCards.Add(tempRogueCard);
				Transform deckTransPoint = RogueCardGameMain.Instance.deckTransPoint;
				if (deckTransPoint != null)
				{
					LeanTween.move(tempRogueCard, deckTransPoint.position, time).setEase(LeanTweenType.easeOutCubic);
					LeanTween.scale(tempRogueCard, Vector3.zero, time).setEase(LeanTweenType.easeInBack).setOnComplete((Action)delegate
					{
						finishedCount++;
					});
				}
				else
				{
					finishedCount++;
				}
			}
			if (totalExitAnims > 0)
			{
				yield return new WaitUntil(() => finishedCount >= totalExitAnims);
			}
			foreach (GameObject item2 in tempCards)
			{
				RogueCardGameMain.Instance.ReleaseTempRogueCard(item2);
			}
			isDrawingCard = false;
			RogueCardGameMain.Instance.ClearWuChangData();
			RogueCardGameMain.Instance.ChangeMainState(new ShopState());
		}
		finally
		{
			RogueCardWuChangUI rogueCardWuChangUI = this;
			rogueCardWuChangUI.isDrawingCard = false;
			rogueCardWuChangUI.wuchangLock = false;
		}
	}

	public override void OnEnter()
	{
		base.OnEnter();
		RogueCardGameMain.GameContext.destroyedCardsCache.Clear();
		hasPlayedWuChangDestroy = false;
		if (wuchangBindAni != null)
		{
			wuchangBindAni.enabled = false;
		}
		handHolder.ShowCard(RogueCardGameMain.GameContext.wuChangWaitCards);
		wuchangLock = false;
		StartCoroutine(AnimateDrawCardsCoroutine());
	}

	public override void OnExit()
	{
		base.OnExit();
	}

	public override void RefreshUI()
	{
		if (!RogueCardGameMain.Instance.saveSystem.saveLock)
		{
			if (RogueCardGameMain.GameContext.wuChangWaitCards.GetSelectIndexList().Length == 0)
			{
				okBtn.gameObject.SetActive(value: false);
				okBtn_grey.gameObject.SetActive(value: true);
			}
			else
			{
				okBtn.gameObject.SetActive(value: true);
				okBtn_grey.gameObject.SetActive(value: false);
			}
			RogueCardItemCfg wuChangCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == RogueCardGameMain.GameContext.whiteWuChangID);
			RogueCardItemCfg wuChangCfg2 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == RogueCardGameMain.GameContext.blackWuChangID);
			whiteWuChang.SetData(wuChangCfg, -1);
			blackWuChang.SetData(wuChangCfg2, -1);
			if (!isDrawingCard && !RogueCardGameMain.Instance.isWuChangCopyAnimating)
			{
				handHolder.ShowCard(RogueCardGameMain.GameContext.wuChangWaitCards);
			}
			btnCon.SetSelectedState((RogueCardGameMain.GameContext.wuChangResetNum > 0) ? "on" : "off");
			resetText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_WUCHANG_RESET_NUM", RogueCardGameMain.GameContext.wuChangResetNum.ToString());
		}
	}

	private IEnumerator AnimateDrawCardsCoroutine()
	{
		isDrawingCard = true;
		InputLockToken inputLock = RogueCardGameMain.Instance.GetInputLock("WuChangDraw", base.gameObject, 3f);
		HandData<RogueCardData> targetHandData = RogueCardGameMain.GameContext.wuChangWaitCards;
		bool forcedDeckUICountSet = false;
		try
		{
			handHolder.ShowCard(targetHandData);
			Canvas.ForceUpdateCanvases();
			int i;
			for (i = 0; i < targetHandData.HandCount; i++)
			{
				RogueCard rogueCard = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == i);
				if (rogueCard != null && rogueCard.cardVisual != null)
				{
					rogueCard.cardVisual.gameObject.SetActive(value: false);
				}
			}
			int finishedCount = 0;
			int totalAnims = 0;
			int finalDeckCount = RogueCardGameMain.GameContext.rogueDeck.cards.Count;
			int displayDeckCount = finalDeckCount + targetHandData.HandCount;
			RogueCardGameMain.Instance.SetForcedDeckUICount(displayDeckCount);
			forcedDeckUICountSet = true;
			yield return new WaitForSeconds(0.8f);
			List<GameObject> tempCards = new List<GameObject>();
			int i2;
			for (i2 = 0; i2 < targetHandData.HandCount; i2++)
			{
				RogueCardData cardDataAtDisplayIndex = targetHandData.GetCardDataAtDisplayIndex(i2);
				RogueCard rogueCard2 = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == i2);
				if (!(rogueCard2 == null))
				{
					totalAnims++;
					GameObject tempRogueCard = RogueCardGameMain.Instance.GetTempRogueCard(handHolder.transform.parent);
					VisualRogueCard component = tempRogueCard.GetComponent<VisualRogueCard>();
					if (component != null)
					{
						component.ShowCardData(cardDataAtDisplayIndex);
					}
					tempCards.Add(tempRogueCard);
					Vector3 position = ((RogueCardGameMain.Instance.deckTransPoint != null) ? RogueCardGameMain.Instance.deckTransPoint.position : handHolder.transform.position);
					tempRogueCard.transform.position = position;
					tempRogueCard.transform.localScale = Vector3.zero;
					float num = (float)i2 * 0.1f;
					AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_card01", useStream: false);
					LeanTween.delayedCall(base.gameObject, num, (Action)delegate
					{
						displayDeckCount = Mathf.Max(finalDeckCount, displayDeckCount - 1);
						RogueCardGameMain.Instance.SetForcedDeckUICount(displayDeckCount);
					});
					LeanTween.scale(tempRogueCard, Vector3.one, 0.4f).setDelay(num).setEase(LeanTweenType.easeOutBack);
					LeanTween.move(tempRogueCard, rogueCard2.transform.position, 0.4f).setDelay(num).setEase(LeanTweenType.easeOutCubic)
						.setOnComplete((Action)delegate
						{
							finishedCount++;
						});
				}
			}
			if (totalAnims > 0)
			{
				yield return new WaitUntil(() => finishedCount >= totalAnims);
			}
			yield return null;
			foreach (GameObject item in tempCards)
			{
				RogueCardGameMain.Instance.ReleaseTempRogueCard(item);
			}
			isDrawingCard = false;
			int i3;
			for (i3 = 0; i3 < targetHandData.HandCount; i3++)
			{
				RogueCard rogueCard3 = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == i3);
				if (rogueCard3 != null && rogueCard3.cardVisual != null)
				{
					VisualCardBase cardVisual = rogueCard3.cardVisual;
					cardVisual.transform.position = rogueCard3.transform.position;
					cardVisual.transform.localScale = Vector3.one;
					cardVisual.gameObject.SetActive(value: true);
				}
			}
			RogueCardGameMain.Instance.ClearForcedDeckUICount();
			forcedDeckUICountSet = false;
		}
		finally
		{
			isDrawingCard = false;
			if (forcedDeckUICountSet)
			{
				RogueCardGameMain.Instance.ClearForcedDeckUICount();
			}
			inputLock?.Release();
		}
	}
}
