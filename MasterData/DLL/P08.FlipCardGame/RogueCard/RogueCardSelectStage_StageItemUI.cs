using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardSelectStage_StageItemUI : MonoBehaviour
{
	public ControllerExCollection controllerExCollection;

	public ControllerEx stateController;

	private ControllerEx woeController;

	public Text stageName;

	public Text targetScore;

	public Text rewardGold;

	public Text buttonState;

	public Button startBtn;

	public bool isBoss;

	[Header("挑战关:恩与祸")]
	public Text wealDesc;

	public Text woeDesc;

	public Button changeBtn;

	public Animator leftAni;

	public Animator rightAni;

	public void Init()
	{
		stateController = controllerExCollection.GetController("state");
		startBtn.onClick.AddListener(delegate
		{
			if (!RogueCardGameMain.CheckDisableInput())
			{
				if (isBoss)
				{
					RogueCardGameMain.Instance.ChangeMainState(new BossStageState());
				}
				else
				{
					RogueCardGameMain.Instance.ChangeMainState(new NormalStageState());
				}
			}
		});
		if (!isBoss || RogueCardGameMain.CheckDisableInput())
		{
			return;
		}
		woeController = controllerExCollection.GetController("Opposition");
		changeBtn.onClick.AddListener(delegate
		{
			if (RogueCardGameMain.GameContext.wealWoeRefreshNum > 0)
			{
				leftAni.Play("UI_text_sg_cx");
				rightAni.Play("UI_text_sg_cx");
				RogueCardGameMain.GameContext.RefreshWoeWealList(isChange: true);
				RogueCardGameMain.Instance.RefreshUI();
				RogueCardGameMain.Instance.saveSystem.SaveGameData();
			}
		});
	}

	public void RefreshUI()
	{
		int stageID = RogueCardGameMain.GameContext.stageID;
		RogueCardStageCfg rogueCardStageCfg = RogueCardDataManager.stageDatabase[stageID];
		if (isBoss)
		{
			if (rogueCardStageCfg.type == LevelType.Challenge && RogueCardGameMain.GameContext.curStageState == StageType.Boss && RogueCardGameMain.GameContext.wealWoeRefreshNum > 0)
			{
				changeBtn.gameObject.SetActive(value: true);
			}
			else
			{
				changeBtn.gameObject.SetActive(value: false);
			}
			targetScore.text = RogueCardGameMain.GameContext.bossTargetScore.ToString();
			if (RogueCardGameMain.GameContext.bossTargetScore >= int.MaxValue)
			{
				targetScore.text = "NaN";
			}
		}
		else
		{
			targetScore.text = RogueCardGameMain.GameContext.targetScore.ToString();
			if (RogueCardGameMain.GameContext.targetScore >= int.MaxValue)
			{
				targetScore.text = "NaN";
			}
		}
		rewardGold.text = (isBoss ? RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BossStageReward] : RogueCardGameMain.GameContext.globalAttrDic[AttributeType.NormalStageReward]).ToString();
		if (isBoss)
		{
			if (RogueCardGameMain.GameContext.curStageState == StageType.Normal)
			{
				stateController.SetSelectedState("off");
			}
			else
			{
				stateController.SetSelectedState("on");
			}
			if (RogueCardGameMain.GameContext.stageType != LevelType.Challenge && RogueCardGameMain.GameContext.curRound == RogueCardGameMain.GameContext.allRoundNum)
			{
				woeController.SetSelectedState("one");
			}
			else
			{
				woeController.SetSelectedState("two");
				int key = RogueCardGameMain.GameContext.wealList[RogueCardGameMain.GameContext.curRound - 1];
				RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = RogueCardDataManager.wealAndWoeDatabase[key];
				RogueCardTipSystem.SetRichText(wealDesc, rogueCardWealAndWoeCfg.desc);
			}
			int key2 = RogueCardGameMain.GameContext.woeList[RogueCardGameMain.GameContext.curRound - 1];
			RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg2 = RogueCardDataManager.wealAndWoeDatabase[key2];
			RogueCardTipSystem.SetRichText(woeDesc, rogueCardWealAndWoeCfg2.desc);
		}
		else if (RogueCardGameMain.GameContext.curStageState == StageType.Normal)
		{
			stateController.SetSelectedState("on");
		}
		else
		{
			stateController.SetSelectedState("complete");
		}
	}
}
