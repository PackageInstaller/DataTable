using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardDeckDetailUI : MonoBehaviour
{
	public List<GameObject> cardParentGoList = new List<GameObject>();

	public Dictionary<Suit, List<RogueCommonCard>> cardDic;

	public GameObject cardItemGo;

	public List<Text> rankText;

	public List<Text> suitText;

	public Text deckName;

	public Text deckDesc;

	public Image deckImg;

	public Button tabLast;

	public Button tabAll;

	public ControllerExCollection stateEx;

	public ControllerExCollection tabLastEx;

	public ControllerExCollection tabAllEx;

	[HideInInspector]
	public ControllerEx stateCon;

	[HideInInspector]
	public ControllerEx tabLastCon;

	[HideInInspector]
	public ControllerEx tabAllCon;

	[HideInInspector]
	public bool isAll;

	public RogueCardCommonTipItem commonTip;

	private RogueCardData curTipData;

	public Button bgBtn;

	private RogueCardCommonView selectCard;

	public void Awake()
	{
		cardDic = new Dictionary<Suit, List<RogueCommonCard>>
		{
			{
				Suit.Spades,
				new List<RogueCommonCard>()
			},
			{
				Suit.Hearts,
				new List<RogueCommonCard>()
			},
			{
				Suit.Clubs,
				new List<RogueCommonCard>()
			},
			{
				Suit.Diamonds,
				new List<RogueCommonCard>()
			}
		};
		cardDic[Suit.Spades].AddRange(cardParentGoList[0].GetComponentsInChildren<RogueCommonCard>());
		cardDic[Suit.Hearts].AddRange(cardParentGoList[1].GetComponentsInChildren<RogueCommonCard>());
		cardDic[Suit.Clubs].AddRange(cardParentGoList[2].GetComponentsInChildren<RogueCommonCard>());
		cardDic[Suit.Diamonds].AddRange(cardParentGoList[3].GetComponentsInChildren<RogueCommonCard>());
		tabLastCon = tabLastEx.GetController("select");
		tabAllCon = tabAllEx.GetController("select");
		stateCon = stateEx.GetController("state");
		tabLast.onClick.RemoveAllListeners();
		tabAll.onClick.RemoveAllListeners();
		tabLast.onClick.AddListener(delegate
		{
			RefreshCards(all: false, isAlways: false);
		});
		tabAll.onClick.AddListener(delegate
		{
			RefreshCards(all: true, isAlways: false);
		});
		bgBtn.onClick.AddListener(delegate
		{
			ShowTip();
		});
		RefreshCards(all: false, isAlways: true);
	}

	private void OnEnable()
	{
		if (RogueCardGameMain.Instance.CurState is StageState)
		{
			stateCon.SetSelectedState("two");
			isAll = false;
		}
		else
		{
			stateCon.SetSelectedState("one");
			isAll = true;
		}
		selectCard?.SetSelect(isSelect: false);
		if (selectCard?.canvas != null)
		{
			selectCard.canvas.overrideSorting = false;
			selectCard.transform.parent.transform.SetLocalScale(Vector3.one * 0.825f);
		}
		selectCard = null;
		RefreshCards(isAll, isAlways: true);
	}

	public void RefreshCards(bool all, bool isAlways)
	{
		int deckID = RogueCardGameMain.GameContext.rogueDeck.deckID;
		RogueDeckCfg rogueDeckCfg = RogueCardDataManager.deckDatabase[deckID];
		deckName.text = rogueDeckCfg.name;
		deckDesc.text = rogueDeckCfg.desc;
		AtlasManager.GetSpriteWithoutAtlas(deckImg, "TextureConfig/Activity_JokerCard/itembg/" + rogueDeckCfg.pic);
		if (!isAlways && all == isAll)
		{
			return;
		}
		ShowTip();
		isAll = all;
		tabLastCon.SetSelectedState(isAll ? "off" : "on");
		tabAllCon.SetSelectedState(isAll ? "on" : "off");
		List<RogueCardData> getAllCards = RogueCardGameMain.GameContext.GetAllCards;
		List<RogueCardData> cards = RogueCardGameMain.GameContext.rogueDeck.cards;
		Dictionary<Suit, int> dictionary = new Dictionary<Suit, int>();
		Dictionary<Rank, int> dictionary2 = new Dictionary<Rank, int>();
		List<List<RogueCardData>> list = new List<List<RogueCardData>>
		{
			getAllCards.FindAll((RogueCardData card) => card.suit == Suit.Spades),
			getAllCards.FindAll((RogueCardData card) => card.suit == Suit.Hearts),
			getAllCards.FindAll((RogueCardData card) => card.suit == Suit.Clubs),
			getAllCards.FindAll((RogueCardData card) => card.suit == Suit.Diamonds)
		};
		foreach (KeyValuePair<Suit, List<RogueCommonCard>> item in cardDic)
		{
			_ = item.Value;
			int num = 0;
			list[(int)(item.Key - 1)].Sort();
			list[(int)(item.Key - 1)].Reverse();
			for (int num2 = 0; num2 < list[(int)(item.Key - 1)].Count; num2++)
			{
				if (cardDic[item.Key].Count <= num2)
				{
					GameObject gameObject = Object.Instantiate(cardItemGo, cardParentGoList[(int)(item.Key - 1)].transform);
					cardDic[item.Key].Add(gameObject.GetComponent<RogueCommonCard>());
					cardDic[item.Key][num2].SetSpecialPointEvent(ShowTip);
				}
				cardDic[item.Key][num2].SetActive(isActive: true);
				cardDic[item.Key][num2].SetData(list[(int)(item.Key - 1)][num2], -1);
				if (!isAll && !cards.Contains(list[(int)(item.Key - 1)][num2]))
				{
					cardDic[item.Key][num2].view.SetShadow(isShadow: true);
				}
				else
				{
					Rank rank = list[(int)(item.Key - 1)][num2].rank;
					Suit suit = list[(int)(item.Key - 1)][num2].suit;
					if (!dictionary2.ContainsKey(rank))
					{
						dictionary2.Add(rank, 1);
					}
					else
					{
						dictionary2[rank]++;
					}
					if (!dictionary.ContainsKey(suit))
					{
						dictionary.Add(suit, 1);
					}
					else
					{
						dictionary[suit]++;
					}
					cardDic[item.Key][num2].view.SetShadow(isShadow: false);
				}
				num++;
			}
			for (int num3 = num; num3 < cardDic[item.Key].Count; num3++)
			{
				cardDic[item.Key][num3].SetActive(isActive: false);
			}
		}
		for (int num4 = 2; num4 <= 11; num4++)
		{
			if (dictionary2.ContainsKey((Rank)num4))
			{
				rankText[num4 - 2].text = dictionary2[(Rank)num4].ToString();
			}
			else
			{
				rankText[num4 - 2].text = "0";
			}
		}
		for (int num5 = 1; num5 <= 4; num5++)
		{
			if (dictionary.ContainsKey((Suit)num5))
			{
				suitText[num5 - 1].text = dictionary[(Suit)num5].ToString();
			}
			else
			{
				suitText[num5 - 1].text = "0";
			}
		}
	}

	public void ShowTip()
	{
		selectCard?.SetSelect(isSelect: false);
		if (selectCard?.canvas != null)
		{
			selectCard.canvas.overrideSorting = false;
			selectCard.transform.parent.transform.SetLocalScale(Vector3.one * 0.825f);
		}
		selectCard = null;
		curTipData = null;
		commonTip.SetActive(bActive: false);
		commonTip.RefreshUI();
	}

	public void ShowTip(RogueCardData data, IRogueCardNeedTip target)
	{
		selectCard?.SetSelect(isSelect: false);
		if (selectCard?.canvas != null)
		{
			selectCard.canvas.overrideSorting = false;
			selectCard.transform.parent.transform.SetLocalScale(Vector3.one * 0.825f);
		}
		selectCard = target as RogueCardCommonView;
		selectCard?.SetSelect(isSelect: true);
		if (selectCard?.canvas != null)
		{
			selectCard.canvas.overrideSorting = true;
			selectCard.transform.parent.transform.SetLocalScale(Vector3.one * 0.9f);
		}
		if (curTipData == data)
		{
			curTipData = null;
			ShowTip();
		}
		else
		{
			curTipData = data;
			commonTip.SetActive(bActive: true);
			commonTip.RefreshUI(data, target);
		}
	}
}
