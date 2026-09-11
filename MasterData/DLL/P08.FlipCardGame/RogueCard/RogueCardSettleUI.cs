using System.Collections;
using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardSettleUI : RogueCardStateUIBase
{
	public Text winPoint;

	public Text playNumPoint;

	public Text allPoint;

	public Text wealText;

	public GameObject jokerTabGo;

	public Transform tabContainTrs;

	public GameObject wealGo;

	public Button okBtn;

	public ControllerExCollection mainEx;

	private ControllerEx bossCon;

	private List<GameObject> jokerTabList;

	public override void Init()
	{
		base.Init();
		jokerTabList = new List<GameObject>();
		AddBtnListener(okBtn, delegate
		{
			if (!RogueCardGameMain.CheckDisableInput())
			{
				StartCoroutine(PlayWoeAni());
			}
		});
		bossCon = mainEx.GetController("boss");
	}

	private IEnumerator PlayWoeAni()
	{
		if (RogueCardGameMain.Instance.woeTipGo.activeSelf)
		{
			InputLockToken settleFlyLock = RogueCardGameMain.Instance.GetInputLock("settleFly", base.gameObject, 2f);
			RogueCardGameMain.Instance.woeTipAnimator.Play("UI_tips_xs", 0, 0f);
			AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_unlock02", useStream: false);
			yield return new WaitForSeconds(1.5f);
			settleFlyLock.Release();
		}
		if (RogueCardGameMain.GameContext.stageID == 101 || RogueCardGameMain.GameContext.stageID == 102)
		{
			RogueCardGameMain.Instance.ChangeMainState(new ShopState());
		}
		else if (RogueCardGameMain.GameContext.curStageState == StageType.Normal && !RogueCardGameMain.GameContext.isAlwaysWuChang)
		{
			RogueCardGameMain.Instance.ChangeMainState(new ShopState());
		}
		else
		{
			RogueCardGameMain.Instance.ChangeMainState(new WuChangState());
		}
		RogueCardGameMain.Instance.RefreshWealAndWoe();
	}

	public override void RefreshUI()
	{
		base.RefreshUI();
		int num = RogueCardGameMain.GameContext.wealList[RogueCardGameMain.GameContext.wealList.Count - 1];
		bossCon.SetSelectedState((RogueCardGameMain.GameContext.curStageState == StageType.Boss && num != 199) ? "boss" : "normal");
		int[] stageReward = RogueCardGameMain.GameContext.GetStageReward();
		winPoint.text = stageReward[1].ToString();
		playNumPoint.text = stageReward[2].ToString();
		allPoint.text = stageReward[0].ToString();
		int stageID = RogueCardGameMain.GameContext.stageID;
		_ = RogueCardDataManager.stageDatabase[stageID];
		RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = RogueCardDataManager.wealAndWoeDatabase[num];
		RogueCardTipSystem.SetRichText(wealText, rogueCardWealAndWoeCfg.desc);
		RefreshJokerGold();
	}

	private void RefreshJokerGold()
	{
		Dictionary<int, int> jokerGold = RogueCardGameMain.GameContext.jokerGold;
		int num = 0;
		foreach (KeyValuePair<int, int> dicCfg in jokerGold)
		{
			if (num >= jokerTabList.Count)
			{
				GameObject item = Object.Instantiate(jokerTabGo, tabContainTrs);
				jokerTabList.Add(item);
			}
			GameObject obj = jokerTabList[num];
			obj.SetActive(value: true);
			Transform transform = obj.transform.Find("root/Image/text");
			Transform transform2 = obj.transform.Find("root/ndcoin/textcoin");
			if (transform != null)
			{
				Text component = transform.GetComponent<Text>();
				RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg rogueCardItemCfg2) => rogueCardItemCfg2.id == dicCfg.Key);
				component.text = rogueCardItemCfg.name;
				transform2.GetComponent<Text>().text = dicCfg.Value.ToString();
			}
			num++;
		}
		for (int num2 = num; num2 < jokerTabList.Count; num2++)
		{
			jokerTabList[num2].SetActive(value: false);
		}
	}

	public override void OnEnter()
	{
		base.OnEnter();
	}

	public override void OnExit()
	{
		base.OnExit();
	}
}
