using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardWuchangPackageUI : MonoBehaviour
{
	public GameObject obj;

	public Transform wuChangTrs;

	public List<RogueCommonCard> wuChangList = new List<RogueCommonCard>();

	public Text lastNumText;

	public RogueCardHolder handHolder;

	private bool isDrawingCard;

	private Dictionary<RogueCardData, RogueCard> destroyCardSnapshot = new Dictionary<RogueCardData, RogueCard>();

	public void Init()
	{
		handHolder.Init(1);
		handHolder.SwapEvent.RemoveAllListeners();
		handHolder.SwapEvent.AddListener(SwapHandCard);
	}

	public void SwapHandCard(int index1, int index2)
	{
		if (!RogueCardGameMain.CheckDisableInput())
		{
			RogueCardGameMain.GameContext.wuChangWaitCards.SwapCardPositions(index1, index2);
		}
	}

	public void CacheDestroyCardSnapshot()
	{
		destroyCardSnapshot.Clear();
		foreach (RogueCard card in handHolder.cards)
		{
			if (!(card == null) && !(card.cardVisual == null) && card.gameObject.activeInHierarchy)
			{
				RogueCardData cardDataAtDisplayIndex = RogueCardGameMain.GameContext.wuChangWaitCards.GetCardDataAtDisplayIndex(card.ParentIndex());
				if (cardDataAtDisplayIndex != null && !destroyCardSnapshot.ContainsKey(cardDataAtDisplayIndex))
				{
					destroyCardSnapshot.Add(cardDataAtDisplayIndex, card);
				}
			}
		}
	}

	public void FinishDestroyAnimation()
	{
		isDrawingCard = false;
		destroyCardSnapshot.Clear();
	}

	public void Show(bool isShow)
	{
		base.gameObject.SetActive(isShow);
	}

	public void OnEnter()
	{
		RogueCardGameMain.GameContext.destroyedCardsCache.Clear();
		destroyCardSnapshot.Clear();
		if (RogueCardGameMain.Instance.gameContext.curPackageID != 0)
		{
			RogueCardGameMain.GameContext.RefreshWuChangPackage();
		}
		if (wuChangList != null)
		{
			foreach (RogueCommonCard wuChang in wuChangList)
			{
				ResetWuChangCardState(wuChang);
			}
		}
		RefreshCards(withDrawAnimation: true);
		RogueCardGameMain.Instance.saveSystem.SaveGameData();
	}

	private void ResetWuChangCardState(RogueCommonCard card)
	{
		if (card != null && card.view != null)
		{
			card.transform.localScale = Vector3.one;
			card.transform.localRotation = Quaternion.identity;
			card.view.transform.localScale = Vector3.one;
			card.view.transform.localRotation = Quaternion.identity;
			if (card.view.animator != null)
			{
				card.view.animator.Rebind();
				card.view.animator.Play("empty", -1, 0f);
				card.view.animator.Update(0f);
			}
		}
	}

	public float PlayWuChangAni()
	{
		float result = 0.15f;
		bool flag = false;
		bool flag2 = false;
		int wuChangID = 0;
		if (RogueCardGameMain.Instance.gameContext.curPackageWuChangID != 0)
		{
			wuChangID = RogueCardGameMain.Instance.gameContext.curPackageWuChangID;
		}
		else if (RogueCardGameMain.GameContext.selectWuChangIndex != -1 && RogueCardGameMain.GameContext.selectWuChangIndex < RogueCardGameMain.GameContext.packageWuChang.Count)
		{
			wuChangID = RogueCardGameMain.GameContext.packageWuChang[RogueCardGameMain.GameContext.selectWuChangIndex];
		}
		if (wuChangID != 0)
		{
			RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg c) => c.id == wuChangID);
			if (rogueCardItemCfg != null && rogueCardItemCfg.type == ItemType.WhiteWuChang && rogueCardItemCfg.effect_list != null && rogueCardItemCfg.effect_list.Length != 0)
			{
				if (rogueCardItemCfg.effect_list[0] == 5)
				{
					flag = true;
					result = 0.8f;
				}
				if (rogueCardItemCfg.effect_list[0] == 6)
				{
					flag2 = true;
					result = 1.1f;
				}
			}
		}
		if (RogueCardGameMain.GameContext.selectWuChangIndex != -1)
		{
			wuChangList[RogueCardGameMain.GameContext.selectWuChangIndex].view.PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan");
		}
		else
		{
			wuChangList[0].view.PlayAnimation("UI_Com_RogueCardBaseItem_jiesuan");
		}
		if (flag)
		{
			isDrawingCard = true;
			foreach (RogueCardData item in RogueCardGameMain.GameContext.destroyedCardsCache)
			{
				RogueCard value = null;
				if (!destroyCardSnapshot.TryGetValue(item, out value))
				{
					int displayIndex = RogueCardGameMain.GameContext.wuChangWaitCards.GetDataIndex(item);
					value = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == displayIndex);
				}
				if (!(value != null) || !(value.cardVisual != null))
				{
					continue;
				}
				VisualRogueCard visualRogueCard = value.cardVisual as VisualRogueCard;
				visualRogueCard.gameObject.SetActive(value: false);
				GameObject tempGo = UnityEngine.Object.Instantiate(visualRogueCard.gameObject, visualRogueCard.transform.parent);
				tempGo.transform.position = visualRogueCard.transform.position;
				tempGo.transform.localScale = visualRogueCard.transform.localScale;
				tempGo.SetActive(value: true);
				tempGo.transform.SetAsLastSibling();
				VisualRogueCard component = tempGo.GetComponent<VisualRogueCard>();
				if (component != null)
				{
					component.enabled = false;
					if (component.view != null)
					{
						component.view.PlayAnimation("UI_Com_RogueCardBaseItem_xiaohui");
					}
				}
				LeanTween.delayedCall(tempGo, 0.7f, (Action)delegate
				{
					UnityEngine.Object.Destroy(tempGo);
				});
			}
		}
		else if (flag2)
		{
			StartCoroutine(RogueCardGameMain.Instance.PlayWuChangCopyAnimCoroutine());
		}
		else
		{
			_ = RogueCardGameMain.GameContext.GetWuChangSelect;
			foreach (RogueCardData item2 in RogueCardGameMain.GameContext.GetWuChangSelect)
			{
				int displayIndex2 = RogueCardGameMain.GameContext.wuChangWaitCards.GetDataIndex(item2);
				(handHolder.cards.Find((RogueCard c) => c.ParentIndex() == displayIndex2).cardVisual as VisualRogueCard).view.PlayAnimation("UI_Com_RogueCardBaseItem_fanzhuan");
			}
		}
		return result;
	}

	public IEnumerator ExitPackage()
	{
		int finishedCount = 0;
		int totalExitAnims = 0;
		HandData<RogueCardData> wuChangWaitCards = RogueCardGameMain.GameContext.wuChangWaitCards;
		List<GameObject> tempCards = new List<GameObject>();
		int i;
		for (i = 0; i < wuChangWaitCards.HandCount; i++)
		{
			RogueCard rogueCard = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == i);
			if (rogueCard == null)
			{
				continue;
			}
			totalExitAnims++;
			float time = RogueCardTimeSystem.GetTime("cardDrawAnimationDuration");
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
				component.SetSelect(isSelect: false);
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
		RogueCardGameMain.Instance.ClearWuChangData();
		foreach (GameObject item in tempCards)
		{
			RogueCardGameMain.Instance.ReleaseTempRogueCard(item);
		}
	}

	public void RefreshCards(bool withDrawAnimation = false)
	{
		if (RogueCardGameMain.Instance.gameContext.curPackageID != 0)
		{
			foreach (RogueCommonCard wuChang in wuChangList)
			{
				wuChang.SetActive(isActive: false);
			}
			int i = 0;
			while (i < RogueCardGameMain.GameContext.packageWuChang.Count)
			{
				if (i >= wuChangList.Count)
				{
					GameObject gameObject = UnityEngine.Object.Instantiate(obj, wuChangTrs);
					wuChangList.Add(gameObject.GetComponent<RogueCommonCard>());
				}
				RogueCommonCard rogueCommonCard = wuChangList[i];
				rogueCommonCard.SetActive(isActive: true);
				RogueCardItemCfg wuChangCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg itemCfg) => itemCfg.id == RogueCardGameMain.GameContext.packageWuChang[i]);
				rogueCommonCard.SetData(wuChangCfg, i);
				int num = i + 1;
				i = num;
			}
			if (withDrawAnimation)
			{
				StartCoroutine(AnimateDrawCardsCoroutine());
			}
			else if (!isDrawingCard)
			{
				handHolder.ShowCard(RogueCardGameMain.GameContext.wuChangWaitCards);
			}
		}
		else
		{
			if (RogueCardGameMain.Instance.gameContext.curPackageWuChangID == 0)
			{
				return;
			}
			foreach (RogueCommonCard wuChang2 in wuChangList)
			{
				wuChang2.SetActive(isActive: false);
			}
			if (wuChangList.Count == 0)
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(obj, wuChangTrs);
				wuChangList.Add(gameObject2.GetComponent<RogueCommonCard>());
			}
			wuChangList[0].SetActive(isActive: true);
			RogueCardItemCfg wuChangCfg2 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg itemCfg) => itemCfg.id == RogueCardGameMain.Instance.gameContext.curPackageWuChangID);
			wuChangList[0].SetData(wuChangCfg2, -1);
			if (withDrawAnimation)
			{
				StartCoroutine(AnimateDrawCardsCoroutine());
			}
			else if (!isDrawingCard)
			{
				handHolder.ShowCard(RogueCardGameMain.GameContext.wuChangWaitCards);
			}
		}
	}

	private IEnumerator AnimateDrawCardsCoroutine()
	{
		isDrawingCard = true;
		InputLockToken inputLock = RogueCardGameMain.Instance.GetInputLock("WuChangPackageDraw", base.gameObject, 3f);
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
			List<GameObject> tempCards = new List<GameObject>();
			int finalDeckCount = RogueCardGameMain.GameContext.rogueDeck.cards.Count;
			int displayDeckCount = finalDeckCount + targetHandData.HandCount;
			RogueCardGameMain.Instance.SetForcedDeckUICount(displayDeckCount);
			forcedDeckUICountSet = true;
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
						component.SetSelect(isSelect: false);
					}
					tempCards.Add(tempRogueCard);
					Vector3 position = ((RogueCardGameMain.Instance.deckTransPoint != null) ? RogueCardGameMain.Instance.deckTransPoint.position : handHolder.transform.position);
					tempRogueCard.transform.position = position;
					tempRogueCard.transform.localScale = Vector3.zero;
					float num = (float)i2 * RogueCardTimeSystem.GetTime("cardDrawInterval");
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

	public void RefreshUI()
	{
		for (int i = 0; i < wuChangList.Count; i++)
		{
			wuChangList[i].SetSelect(i == RogueCardGameMain.GameContext.selectWuChangIndex);
		}
		if (!isDrawingCard)
		{
			handHolder.ShowCard(RogueCardGameMain.GameContext.wuChangWaitCards);
		}
	}
}
