using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardCommonTipItem : MonoBehaviour, IPointerClickHandler, IEventSystemHandler
{
	public bool isShow;

	public Text mainName;

	public Text mainDesc;

	public Text mainExtenDesc;

	public GameObject mainExtenGo;

	public GameObject mainNewGo;

	public GameObject tagMainGo;

	public GameObject[] tagGoList = new GameObject[3];

	public Text[] tagTextList = new Text[3];

	public GameObject sellGo;

	public Text sellGoldText;

	public GameObject mainGo;

	public GameObject subGo1;

	public Text subName1;

	public Text subDesc1;

	public GameObject subNewGo1;

	public GameObject subGo2;

	public Text subName2;

	public Text subDesc2;

	public GameObject subNewGo2;

	public GameObject subGo3;

	public Text subDesc3;

	public IRogueCardNeedTip targetGo;

	private StringBuilder descStr = new StringBuilder(string.Empty);

	private StringBuilder exDescStr = new StringBuilder(string.Empty);

	private void Update()
	{
		if (!isShow || (!Input.GetMouseButtonDown(0) && !Input.GetMouseButtonDown(1)) || EventSystem.current == null)
		{
			return;
		}
		PointerEventData eventData = new PointerEventData(EventSystem.current)
		{
			position = Input.mousePosition
		};
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(eventData, list);
		bool flag = true;
		for (int i = 0; i < list.Count; i++)
		{
			GameObject gameObject = list[i].gameObject;
			if (!(gameObject == null))
			{
				if (gameObject.transform.IsChildOf(base.transform))
				{
					flag = false;
					break;
				}
				if (gameObject.GetComponentInParent<IRogueCardNeedTip>() != null)
				{
					flag = false;
					break;
				}
				if (gameObject.GetComponentInParent<RogueCard>() != null)
				{
					flag = false;
					break;
				}
			}
		}
		if (flag)
		{
			RogueCardGameMain.Instance.HideTips();
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		RefreshUI();
	}

	public void Show(bool isActive)
	{
		base.gameObject.SetActive(isActive);
		isShow = isActive;
	}

	public void RefreshUI()
	{
		Show(isActive: false);
		if (targetGo != null)
		{
			targetGo?.SetLookTips(isSelect: false);
			targetGo = null;
			mainGo.SetActive(value: true);
			tagMainGo.SetActive(value: false);
			mainNewGo.SetActive(value: false);
			subNewGo1.SetActive(value: false);
			subNewGo2.SetActive(value: false);
		}
	}

	public void RefreshUI(RogueCardData cardData, IRogueCardNeedTip target)
	{
		if (targetGo != target)
		{
			RefreshUI(target);
			Show(isActive: true);
			switch (cardData.suit)
			{
			case Suit.Spades:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_SPADE", cardData.GetRankStr());
				break;
			case Suit.Hearts:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_HEART", cardData.GetRankStr());
				break;
			case Suit.Clubs:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_CLUB", cardData.GetRankStr());
				break;
			case Suit.Diamonds:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_DIAMOND", cardData.GetRankStr());
				break;
			}
			Text text = mainDesc;
			string[] array = new string[1];
			int rank = (int)cardData.rank;
			array[0] = rank.ToString();
			text.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_DESC", array);
			if (cardData.tagID != 0)
			{
				subGo1.SetActive(value: true);
				subName1.text = RogueCardTipSystem.GetTip("ROGUE_CARD_TAG");
				RogueCardTipSystem.SetRichText(subDesc1, RogueCardDataManager.enhanceDatabase[cardData.tagID].desc);
			}
			if (cardData.enhanceID != 0)
			{
				subGo2.SetActive(value: true);
				subName2.text = RogueCardTipSystem.GetTip("ROGUE_CARD_ENHANCE");
				RogueCardTipSystem.SetRichText(subDesc2, RogueCardDataManager.enhanceDatabase[cardData.enhanceID].desc);
			}
		}
	}

	public void RefreshUI(IRogueCardNeedTip target)
	{
		if (targetGo == target)
		{
			targetGo.SetLookTips(isSelect: false);
			targetGo = null;
			Show(isActive: false);
			return;
		}
		if (targetGo != null)
		{
			targetGo.SetLookTips(isSelect: false);
		}
		targetGo = target;
		mainGo.SetActive(value: true);
		targetGo?.SetLookTips(isSelect: true);
		subGo1.SetActive(value: false);
		subGo2.SetActive(value: false);
		subGo3.SetActive(value: false);
		mainExtenGo.SetActive(value: false);
		tagMainGo.SetActive(value: false);
		sellGo.SetActive(value: false);
		mainNewGo.SetActive(value: false);
		subNewGo1.SetActive(value: false);
		subNewGo2.SetActive(value: false);
	}

	public void RefreshUI(Transform baseTrans, int wuChangID, IRogueCardNeedTip target)
	{
		if (targetGo != target)
		{
			RefreshUI(target);
			base.transform.position = baseTrans.position;
			base.transform.localPosition = base.transform.localPosition;
			(base.transform as RectTransform).pivot = (baseTrans as RectTransform).pivot;
			Show(isActive: true);
			RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg cfg) => cfg.id == wuChangID);
			mainName.text = rogueCardItemCfg.name;
			RogueCardTipSystem.SetRichText(mainDesc, rogueCardItemCfg.desc);
			if (RogueCardGameMain.Instance.CheckIsNew(1, wuChangID))
			{
				mainNewGo.SetActive(value: true);
			}
			mainExtenGo.SetActive(value: true);
			RogueCardTipSystem.SetRichText(mainExtenDesc, rogueCardItemCfg.ex_desc);
		}
	}

	public void RefreshUI(Transform baseTrans, ShopItemData shopItem, IRogueCardNeedTip target)
	{
		if (targetGo == target)
		{
			return;
		}
		RogueCardItemCfg cfg = shopItem.cfg;
		RefreshUI(target);
		base.transform.position = baseTrans.position;
		base.transform.localPosition = base.transform.localPosition;
		(base.transform as RectTransform).pivot = (baseTrans as RectTransform).pivot;
		Show(isActive: true);
		if (RogueCardGameMain.Instance.CheckIsNew(1, cfg.id))
		{
			mainNewGo.SetActive(value: true);
		}
		if (cfg.tag.Length != 0)
		{
			tagMainGo.SetActive(value: true);
			for (int i = 0; i < cfg.tag.Length; i++)
			{
				tagGoList[i].SetActive(value: true);
				tagTextList[i].text = RogueCardTipSystem.GetJokerTag(cfg.tag[i]);
			}
			for (int j = cfg.tag.Length; j < 4; j++)
			{
				tagGoList[j].SetActive(value: false);
			}
		}
		if (shopItem.versionID != 0)
		{
			subGo1.SetActive(value: true);
			subName1.text = RogueCardTipSystem.GetTip("ROGUE_CARD_VERSION");
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[shopItem.versionID];
			subDesc1.text = rogueCardEnhanceCfg.desc;
			if (RogueCardGameMain.Instance.CheckIsNew(2, shopItem.versionID))
			{
				subNewGo1.SetActive(value: true);
			}
		}
		else
		{
			subGo1.SetActive(value: false);
		}
		mainName.text = cfg.name;
		descStr.Clear();
		if (cfg.id == 119)
		{
			Rank randomRank = RogueCardGameMain.GameContext.randomRank;
			object obj;
			if (randomRank != Rank.A)
			{
				int num = (int)randomRank;
				obj = num.ToString();
			}
			else
			{
				obj = "A";
			}
			string arg = (string)obj;
			string value = string.Format(cfg.desc, arg);
			descStr.Append(value);
		}
		else if (cfg.desc_type > 0 && cfg.ex_desc == "")
		{
			if (cfg.id == 116 || cfg.id == 117)
			{
				RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[cfg.effect_list[0]];
				descStr.Append(string.Format(cfg.desc, rogueCardEffectCfg.param2[2]));
			}
			else
			{
				if (cfg.desc_type == 1)
				{
					descStr.Append(string.Format(cfg.desc, 0));
				}
				if (cfg.desc_type == 2)
				{
					descStr.Append(string.Format(cfg.desc, 0));
				}
				if (cfg.desc_type == 3)
				{
					descStr.Append(string.Format(cfg.desc, 1f.ToString("#.#")));
				}
			}
		}
		else
		{
			descStr.Append(cfg.desc);
		}
		RogueCardTipSystem.SetRichText(mainDesc, descStr.ToString());
		exDescStr.Clear();
		if (cfg.id == 121)
		{
			int num2 = RogueCardDataManager.effectDatabase[cfg.effect_list[0]].param2[1];
			exDescStr.Append(string.Format(cfg.ex_desc, (num2 * (RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] - RogueCardGameMain.GameContext.jokerData.HandCount)).ToString()));
		}
		else if (cfg.id == 217)
		{
			int num3 = RogueCardDataManager.effectDatabase[cfg.effect_list[0]].param2[2];
			exDescStr.Append(string.Format(cfg.ex_desc, Math.Max(num3 * (40 - RogueCardGameMain.GameContext.GetAllCards.Count), 0)));
		}
		else if (cfg.id == 218)
		{
			List<RogueCardData> getAllCards = RogueCardGameMain.GameContext.GetAllCards;
			int num4 = 0;
			for (int k = 0; k < getAllCards.Count; k++)
			{
				RogueCardData rogueCardData = getAllCards[k];
				if (rogueCardData.enhanceID != 0 || rogueCardData.tagID != 0)
				{
					num4++;
				}
			}
			int num5 = RogueCardDataManager.effectDatabase[cfg.effect_list[0]].param2[1];
			exDescStr.Append(string.Format(cfg.ex_desc, Math.Max(num5 * num4, 0)));
		}
		else if (cfg.desc_type == 1)
		{
			exDescStr.Append(string.Format(cfg.ex_desc, 0));
		}
		else if (cfg.desc_type == 2)
		{
			exDescStr.Append(string.Format(cfg.ex_desc, 0));
		}
		else if (cfg.desc_type == 3)
		{
			exDescStr.Append(string.Format(cfg.ex_desc, 1f.ToString("#.#")));
		}
		else if (cfg.ex_desc != "")
		{
			exDescStr.Append(cfg.ex_desc);
		}
		if (exDescStr.Length == 0)
		{
			mainExtenGo.SetActive(value: false);
			return;
		}
		mainExtenGo.SetActive(value: true);
		RogueCardTipSystem.SetRichText(mainExtenDesc, exDescStr.ToString());
	}

	public void RefreshUI(Transform baseTrans, RogueCardPackageCfg cfg, IRogueCardNeedTip target)
	{
		if (targetGo != target)
		{
			RefreshUI(target);
			base.transform.position = baseTrans.position;
			base.transform.localPosition = base.transform.localPosition;
			(base.transform as RectTransform).pivot = (baseTrans as RectTransform).pivot;
			Show(isActive: true);
			mainName.text = cfg.name;
			mainDesc.text = cfg.desc;
		}
	}

	public void RefreshUI(Transform baseTrans, RogueCardData cardData, IRogueCardNeedTip target)
	{
		if (targetGo != target)
		{
			RefreshUI(target);
			base.transform.position = baseTrans.position;
			base.transform.localPosition = base.transform.localPosition;
			(base.transform as RectTransform).pivot = (baseTrans as RectTransform).pivot;
			Show(isActive: true);
			switch (cardData.suit)
			{
			case Suit.Spades:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_SPADE", cardData.GetRankStr());
				break;
			case Suit.Hearts:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_HEART", cardData.GetRankStr());
				break;
			case Suit.Clubs:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_CLUB", cardData.GetRankStr());
				break;
			case Suit.Diamonds:
				mainName.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_NAME_DIAMOND", cardData.GetRankStr());
				break;
			}
			Text text = mainDesc;
			string[] array = new string[1];
			int rank = (int)cardData.rank;
			array[0] = rank.ToString();
			text.text = RogueCardTipSystem.GetTip("ROGUE_CARD_POKER_DESC", array);
			if (cardData.effectDisable)
			{
				mainDesc.text = RogueCardTipSystem.GetTip("ROGUE_CARD_LOSE_EFFECT");
			}
			if (cardData.tagID != 0)
			{
				subGo1.SetActive(value: true);
				subName1.text = RogueCardTipSystem.GetTip("ROGUE_CARD_TAG");
				RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[cardData.tagID];
				RogueCardTipSystem.SetRichText(subDesc1, rogueCardEnhanceCfg.desc);
			}
			if (cardData.enhanceID != 0)
			{
				subGo2.SetActive(value: true);
				subName2.text = RogueCardTipSystem.GetTip("ROGUE_CARD_ENHANCE");
				RogueCardEnhanceCfg rogueCardEnhanceCfg2 = RogueCardDataManager.enhanceDatabase[cardData.enhanceID];
				RogueCardTipSystem.SetRichText(subDesc2, rogueCardEnhanceCfg2.desc);
			}
		}
	}

	public void RefreshUI(Transform baseTrans, RogueCardJokerData jokerData, IRogueCardNeedTip target)
	{
		if (targetGo == target)
		{
			return;
		}
		RefreshUI(target);
		base.transform.position = baseTrans.position;
		base.transform.localPosition = base.transform.localPosition;
		(base.transform as RectTransform).pivot = (baseTrans as RectTransform).pivot;
		Show(isActive: true);
		if (jokerData.versionID != 0)
		{
			subGo1.SetActive(value: true);
			subName1.text = RogueCardTipSystem.GetTip("ROGUE_CARD_VERSION");
			RogueCardEnhanceCfg rogueCardEnhanceCfg = RogueCardDataManager.enhanceDatabase[jokerData.versionID];
			subDesc1.text = rogueCardEnhanceCfg.desc;
		}
		else
		{
			subGo1.SetActive(value: false);
		}
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg cfg) => cfg.id == jokerData.realID);
		mainName.text = rogueCardItemCfg.name;
		sellGo.SetActive(value: true);
		sellGoldText.text = Math.Floor((float)jokerData.GetPrice()).ToString();
		if (rogueCardItemCfg.tag.Length != 0)
		{
			tagMainGo.SetActive(value: true);
			for (int num = 0; num < rogueCardItemCfg.tag.Length; num++)
			{
				tagGoList[num].SetActive(value: true);
				tagTextList[num].text = RogueCardTipSystem.GetJokerTag(rogueCardItemCfg.tag[num]);
			}
			for (int num2 = rogueCardItemCfg.tag.Length; num2 < 3; num2++)
			{
				tagGoList[num2].SetActive(value: false);
			}
		}
		descStr.Clear();
		if (jokerData.realID == 119)
		{
			Rank rank = (jokerData.effect[0].action as ComboCardAction).Rank;
			object obj;
			if (rank != Rank.A)
			{
				int num3 = (int)rank;
				obj = num3.ToString();
			}
			else
			{
				obj = "A";
			}
			string arg = (string)obj;
			string value = string.Format(rogueCardItemCfg.desc, arg);
			descStr.Append(value);
		}
		else if (rogueCardItemCfg.desc_type > 0 && rogueCardItemCfg.ex_desc == "")
		{
			if (rogueCardItemCfg.desc_type == 1)
			{
				descStr.Append(string.Format(rogueCardItemCfg.desc, jokerData.addPoint.ToString()));
			}
			if (rogueCardItemCfg.desc_type == 2)
			{
				descStr.Append(string.Format(rogueCardItemCfg.desc, jokerData.addMutli.ToString()));
			}
			if (rogueCardItemCfg.desc_type == 3)
			{
				descStr.Append(string.Format(rogueCardItemCfg.desc, ((float)jokerData.mulRatio / 100f).ToString("#.#")));
			}
		}
		else
		{
			descStr.Append(rogueCardItemCfg.desc);
		}
		exDescStr.Clear();
		if (jokerData.realID == 311)
		{
			if (jokerData.realID == jokerData.id)
			{
				exDescStr.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_DAMO_FAILURE"));
			}
			else
			{
				RogueCardItemCfg rogueCardItemCfg2 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg cfg) => cfg.id == jokerData.id);
				exDescStr.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_DAMO_SUCCESS", rogueCardItemCfg2.name));
			}
		}
		else if (jokerData.realID == 306)
		{
			RogueCardJokerData leftJoker = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(0);
			if (leftJoker != null)
			{
				RogueCardItemCfg rogueCardItemCfg3 = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == leftJoker.realID);
				if (rogueCardItemCfg3.no_copy)
				{
					exDescStr.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_COPY_CARD_FAILURE", rogueCardItemCfg3.name));
				}
				else
				{
					exDescStr.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_COPY_CARD_SUCCESS", rogueCardItemCfg3.name));
				}
			}
			else
			{
				exDescStr.Append(RogueCardTipSystem.GetTip("ROGUE_CARD_COPY_CARD_FAILURE", rogueCardItemCfg.name));
			}
		}
		else if (jokerData.realID == 121)
		{
			int num4 = (jokerData.effect[0].action as ChangeValueByJokerSlotAction).Num;
			exDescStr.Append(string.Format(rogueCardItemCfg.ex_desc, (num4 * (RogueCardGameMain.GameContext.globalAttrDic[AttributeType.JokerMaxNum] - RogueCardGameMain.GameContext.jokerData.HandCount)).ToString()));
		}
		else if (jokerData.realID == 217)
		{
			int num5 = (jokerData.effect[0].action as AddByDeckNumAction).Num;
			exDescStr.Append(string.Format(rogueCardItemCfg.ex_desc, Math.Max(num5 * (40 - RogueCardGameMain.GameContext.GetAllCards.Count), 0)));
		}
		else if (jokerData.realID == 218)
		{
			List<RogueCardData> getAllCards = RogueCardGameMain.GameContext.GetAllCards;
			int num6 = 0;
			for (int num7 = 0; num7 < getAllCards.Count; num7++)
			{
				RogueCardData rogueCardData = getAllCards[num7];
				if (rogueCardData.enhanceID != 0 || rogueCardData.tagID != 0)
				{
					num6++;
				}
			}
			int num8 = (jokerData.effect[0].action as AddByDeckEnhanceAction).num;
			exDescStr.Append(string.Format(rogueCardItemCfg.ex_desc, Math.Max(num8 * num6, 0)));
		}
		else if (rogueCardItemCfg.desc_type == 1)
		{
			exDescStr.Append(string.Format(rogueCardItemCfg.ex_desc, jokerData.addPoint.ToString()));
		}
		else if (rogueCardItemCfg.desc_type == 2)
		{
			exDescStr.Append(string.Format(rogueCardItemCfg.ex_desc, jokerData.addMutli.ToString()));
		}
		else if (rogueCardItemCfg.desc_type == 3)
		{
			exDescStr.Append(string.Format(rogueCardItemCfg.ex_desc, ((float)jokerData.mulRatio / 100f).ToString("#.#")));
		}
		string content = descStr.ToString();
		string content2 = exDescStr.ToString();
		RogueCardTipSystem.SetRichText(mainDesc, content);
		if (exDescStr.Length == 0)
		{
			mainExtenGo.SetActive(value: false);
			return;
		}
		mainExtenGo.SetActive(value: true);
		RogueCardTipSystem.SetRichText(mainExtenDesc, content2);
	}

	public void RefreshUI(Transform baseTrans, string comtipKey, IRogueCardNeedTip target)
	{
		if (targetGo != target)
		{
			RefreshUI(target);
			base.transform.position = baseTrans.position;
			base.transform.localPosition = base.transform.localPosition;
			(base.transform as RectTransform).pivot = (baseTrans as RectTransform).pivot;
			Show(isActive: true);
			mainGo.SetActive(value: false);
			subGo3.SetActive(value: true);
			subDesc3.text = RogueCardTipSystem.GetTip(comtipKey);
		}
	}
}
