using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardBattleInfoUI : MonoBehaviour
{
	public GameObject handTypeGo;

	public Transform handTypeContentTrs;

	public GameObject wealWoeGo;

	public Transform wealWoeContentTrs;

	public ControllerExCollection pageControllerEx;

	public ControllerExCollection tabDeckControllerEx;

	public ControllerExCollection tabWealWoeControllerEx;

	private ControllerEx pageCon;

	private ControllerEx speedCon;

	private ControllerEx tabDeckCon;

	private ControllerEx tabWealCon;

	public Controller emptyCon;

	private ControllerEx wealWoeCon;

	public Button handTypeButton;

	public Button wealWoeButton;

	public Button speed1Button;

	public Button speed2Button;

	public GameObject tipGo;

	private List<RogueCardHandTypeItem> handTypeItemList;

	private List<RogueCardWoeWealItem> woeWealItemList;

	private int curPage = 1;

	private int curSelect = -1;

	public Text handTypeInfoText;

	public List<RogueCardCommonView> cardList;

	public Button bgBtn;

	public void Awake()
	{
		handTypeItemList = new List<RogueCardHandTypeItem>();
		woeWealItemList = new List<RogueCardWoeWealItem>();
		pageCon = pageControllerEx.GetController("content");
		speedCon = pageControllerEx.GetController("Speed");
		tabDeckCon = tabDeckControllerEx.GetController("select");
		tabWealCon = tabWealWoeControllerEx.GetController("select");
		wealWoeCon = pageControllerEx.GetController("wealWoe");
		curPage = 1;
		pageCon.SetSelectedState("CardTable");
		tabDeckCon.SetSelectedState("on");
		tabWealCon.SetSelectedState("off");
		bgBtn.onClick.AddListener(delegate
		{
			SelectHandType(-1);
		});
		handTypeButton.onClick.AddListener(delegate
		{
			if (curPage != 1)
			{
				curPage = 1;
				pageCon.SetSelectedState("CardTable");
				tabDeckCon.SetSelectedState("on");
				tabWealCon.SetSelectedState("off");
			}
		});
		wealWoeButton.onClick.AddListener(delegate
		{
			if (curPage != 2)
			{
				curPage = 2;
				pageCon.SetSelectedState("Opposition");
				tabDeckCon.SetSelectedState("off");
				tabWealCon.SetSelectedState("on");
			}
		});
		speed1Button.onClick.AddListener(delegate
		{
			RogueCardGameMain.Instance.ChangeAniSpeed(isSpeedUp: false);
			RefreshUI();
		});
		speed2Button.onClick.AddListener(delegate
		{
			RogueCardGameMain.Instance.ChangeAniSpeed(isSpeedUp: true);
			RefreshUI();
		});
		int num = 0;
		foreach (KeyValuePair<HandType, RogueHandTypeCfg> item in RogueCardDataManager.handTypeDatabase)
		{
			_ = item;
			if (handTypeItemList.Count <= num)
			{
				GameObject gameObject = Object.Instantiate(handTypeGo, handTypeContentTrs);
				handTypeItemList.Add(gameObject.GetComponent<RogueCardHandTypeItem>());
			}
			RogueCardHandTypeItem rogueCardHandTypeItem = handTypeItemList[num];
			rogueCardHandTypeItem.SetActive(isActive: true);
			rogueCardHandTypeItem.Init(num, SelectHandType);
			num++;
		}
		for (int num2 = num; num2 < handTypeItemList.Count; num2++)
		{
			handTypeItemList[num2].SetActive(isActive: false);
		}
		RefreshUI();
	}

	public void OnEnable()
	{
		SelectHandType(-1);
		curPage = 1;
		pageCon.SetSelectedState("CardTable");
		tabDeckCon.SetSelectedState("on");
		tabWealCon.SetSelectedState("off");
		RefreshUI();
	}

	public void SelectHandType(int index)
	{
		if (curSelect == index)
		{
			curSelect = -1;
		}
		else
		{
			curSelect = index;
		}
		for (int i = 0; i < handTypeItemList.Count; i++)
		{
			if (i == curSelect)
			{
				handTypeItemList[i].SetSelect(isSelect: true);
			}
			else
			{
				handTypeItemList[i].SetSelect(isSelect: false);
			}
		}
		if (curSelect == -1)
		{
			tipGo.SetActive(value: false);
			return;
		}
		tipGo.SetActive(value: true);
		HandType type = handTypeItemList[index].type;
		RogueHandTypeCfg rogueHandTypeCfg = RogueCardDataManager.handTypeDatabase[type];
		cardList[0].Init();
		cardList[1].Init();
		cardList[2].Init();
		cardList[0].SetData((Suit)rogueHandTypeCfg.exampleCard1[0], (Rank)rogueHandTypeCfg.exampleCard1[1]);
		cardList[1].SetData((Suit)rogueHandTypeCfg.exampleCard2[0], (Rank)rogueHandTypeCfg.exampleCard2[1]);
		cardList[2].SetData((Suit)rogueHandTypeCfg.exampleCard3[0], (Rank)rogueHandTypeCfg.exampleCard3[1]);
		handTypeInfoText.text = rogueHandTypeCfg.desc;
	}

	public void RefreshUI()
	{
		int num = 0;
		foreach (KeyValuePair<HandType, RogueHandTypeCfg> item in RogueCardDataManager.handTypeDatabase)
		{
			int num2 = RogueCardGameMain.GameContext.handTypeLevel[item.Key];
			RogueHandTypeCfg value = item.Value;
			int score = value.base_score + (num2 - 1) * value.add_score;
			int multi = value.base_multi + (num2 - 1) * value.add_multi;
			handTypeItemList[num].SetData(item.Key, num2, value.name, score, multi, RogueCardGameMain.GameContext.settleContext.handTypeUseNum[item.Key]);
			num++;
		}
		if (RogueCardGameMain.GameContext.GetShowWealWoeNum == 0)
		{
			wealWoeCon.SetSelectedState("off");
			curPage = 1;
			pageCon.SetSelectedState("CardTable");
			tabDeckCon.SetSelectedState("on");
			tabWealCon.SetSelectedState("off");
		}
		else
		{
			wealWoeCon.SetSelectedState("on");
		}
		num = 0;
		foreach (RogueCardWoeWealItem woeWealItem in woeWealItemList)
		{
			woeWealItem.SetActive(isActive: false);
		}
		emptyCon.SetSelectedState("false");
		for (int i = 0; i < RogueCardGameMain.GameContext.wealList.Count; i++)
		{
			int num3 = RogueCardGameMain.GameContext.wealList[i];
			int num4 = RogueCardGameMain.GameContext.woeList[i];
			if (num3 == 199 && num4 == 299)
			{
				continue;
			}
			if (i == RogueCardGameMain.GameContext.wealList.Count - 1 && (RogueCardGameMain.GameContext.curStageState == StageType.Normal || (RogueCardGameMain.GameContext.curStageState == StageType.Boss && RogueCardGameMain.Instance.CurState.GetIndex() <= 2)))
			{
				if (i == 0)
				{
					emptyCon.SetSelectedState("true");
				}
			}
			else
			{
				if (woeWealItemList.Count <= num)
				{
					GameObject gameObject = Object.Instantiate(wealWoeGo, wealWoeContentTrs);
					woeWealItemList.Add(gameObject.GetComponent<RogueCardWoeWealItem>());
				}
				RogueCardWoeWealItem rogueCardWoeWealItem = woeWealItemList[num];
				rogueCardWoeWealItem.SetActive(isActive: true);
				rogueCardWoeWealItem.OnEnter();
				rogueCardWoeWealItem.SetData(num3, num4, RogueCardGameMain.GameContext.GetCurWealWoeNum > i, RogueCardGameMain.GameContext.stageType != LevelType.Challenge && (i + 1 >= RogueCardGameMain.GameContext.allRoundNum || num3 == 199));
			}
			num++;
		}
		speedCon.SetSelectedState(RogueCardGameMain.Instance.isAniSpeedUp ? "two" : "one");
		LayoutRebuilder.ForceRebuildLayoutImmediate(handTypeContentTrs as RectTransform);
		LayoutRebuilder.ForceRebuildLayoutImmediate(handTypeContentTrs as RectTransform);
	}
}
