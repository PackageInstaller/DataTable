using ControllerExSpace;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardSelectStageUI : RogueCardStateUIBase
{
	public Text roundText;

	public ControllerExCollection mainEx;

	public RogueCardSelectStage_StageItemUI normalStageItem;

	public RogueCardSelectStage_StageItemUI bossStageItem;

	private ControllerEx stageCon;

	private ControllerEx wealWoeCon;

	public override void Init()
	{
		base.Init();
		normalStageItem.Init();
		bossStageItem.Init();
		stageCon = mainEx.GetController("state");
		wealWoeCon = mainEx.GetController("Opposition");
	}

	public override void RefreshUI()
	{
		base.RefreshUI();
		roundText.text = $"{RogueCardGameMain.GameContext.curRound} / {RogueCardGameMain.GameContext.allRoundNum}";
		normalStageItem.RefreshUI();
		bossStageItem.RefreshUI();
		if (RogueCardGameMain.GameContext.woeList[RogueCardGameMain.GameContext.curRound - 1] == 299)
		{
			wealWoeCon.SetSelectedState("off");
		}
		else
		{
			wealWoeCon.SetSelectedState("on");
		}
	}

	public override void OnEnter()
	{
		base.OnEnter();
		if (RogueCardGameMain.GameContext.stageType == LevelType.Boss)
		{
			stageCon.SetSelectedState("one");
		}
		else
		{
			stageCon.SetSelectedState("two");
		}
	}

	public override void OnExit()
	{
		base.OnExit();
	}
}
