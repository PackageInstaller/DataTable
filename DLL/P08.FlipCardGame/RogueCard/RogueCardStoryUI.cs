using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardStoryUI : RogueCardStoryBaseUI
{
	[SerializeField]
	private List<RogueCardStoryFragmentItem> fragmentList;

	public GameObject infoGo;

	public Animator infoAni;

	public Text infoTitle;

	public Text infoDesc;

	public GameObject tipCompleteGo;

	public Animator fragmentAni;

	public Button bgBtn;

	public override void Init()
	{
		storyTypeCon = mainEx.GetController("Type");
		for (int i = 0; i < fragmentList.Count; i++)
		{
			fragmentList[i].Init(SelectItem, i);
		}
		bgBtn.RemoveAllListener();
		bgBtn.onClick.AddListener(delegate
		{
			if (!RogueCardGameMain.CheckDisableInput())
			{
				SelectItem(-1);
			}
		});
	}

	public override void SetData()
	{
		stageCfg = RogueCardDataManager.stageDatabase[RogueCardGameMain.GameContext.stageID];
		storyTypeCon.SetSelectedState("disperse");
		_ = stageCfg.round;
		for (int i = 0; i < fragmentList.Count; i++)
		{
			fragmentList[i].SetData(RogueCardGameMain.GameContext.stageID);
		}
	}

	public void PLayHideAni()
	{
		infoAni.Play("UI_Tips_xs", 0, 0f);
	}

	public override void SelectItem(int index, bool useLastText = false)
	{
		if (stageCfg.type == LevelType.Challenge || stageCfg.type == LevelType.Boss)
		{
			return;
		}
		infoGo.SetActive(value: false);
		if (index >= stageCfg.round || index == selectIndex)
		{
			selectIndex = -1;
		}
		else
		{
			selectIndex = index;
		}
		for (int i = 0; i < fragmentList.Count; i++)
		{
			fragmentList[i].SetSelect(i == selectIndex);
			if (i == selectIndex)
			{
				infoGo.SetActive(value: true);
				ASCIIEncoding aSCIIEncoding = new ASCIIEncoding();
				byte[] bytes = new byte[1] { (byte)(i + 65) };
				infoTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_CLUE_TIP_TITLE", aSCIIEncoding.GetString(bytes));
				int num = -1;
				num = (RogueCardGameMain.Instance.IsStageComplete(selectIndex + 1) ? 3 : ((!RogueCardGameMain.Instance.IsNormalStageComplete(selectIndex + 1)) ? 1 : 2));
				if (useLastText)
				{
					num--;
				}
				switch (num)
				{
				case 3:
				{
					string clue2 = RogueCardDataManager.GetClue(stageCfg.clue_group_id, i + 1, 2);
					infoDesc.text = clue2;
					tipCompleteGo.SetActive(value: true);
					break;
				}
				case 2:
				{
					string clue = RogueCardDataManager.GetClue(stageCfg.clue_group_id, i + 1, 1);
					infoDesc.text = clue;
					tipCompleteGo.SetActive(value: false);
					break;
				}
				case 1:
					infoDesc.text = RogueCardTipSystem.GetTip("ROGUE_CARD_NO_CLUE_TIP");
					tipCompleteGo.SetActive(value: false);
					break;
				}
			}
		}
	}

	public override void OnFinishNormalStage()
	{
		int index = RogueCardGameMain.GameContext.curRound - 1;
		fragmentList[index].PlayChangeAni();
	}

	public void RefreshFragmentList()
	{
		int index = RogueCardGameMain.GameContext.curRound - 1;
		fragmentList[index].Refresh();
	}

	public override void OnFinishChallengeStage()
	{
		int index = RogueCardGameMain.GameContext.curRound - 1;
		fragmentList[index].PlayChangeAni();
	}

	public override void PlayAllAni()
	{
		fragmentAni.Play("UI_disperse_cx");
	}

	public override void RefreshUI()
	{
		if (!RogueCardGameMain.Instance.IsSettleAni)
		{
			for (int i = 0; i < fragmentList.Count && i < stageCfg.round; i++)
			{
				fragmentList[i].Refresh();
			}
		}
	}

	public override void OnDispose()
	{
	}

	public override void SetAll()
	{
		allProgressGo.SetActive(value: false);
		storyTypeCon.SetSelectedState("All");
	}
}
