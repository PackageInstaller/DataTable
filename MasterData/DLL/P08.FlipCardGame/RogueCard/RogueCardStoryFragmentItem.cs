using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardStoryFragmentItem : MonoBehaviour
{
	public ControllerExCollection mainEx;

	public Button selfBtn;

	public RollingNumber progressText;

	public Animator selfAni;

	public Animator progressAnim;

	private ControllerEx stateCon;

	private ControllerEx selectCon;

	private ControllerEx progressCon;

	private int index;

	private bool unlock;

	private bool isProgressAniming;

	public void Init(Action<int, bool> btnAction, int index)
	{
		this.index = index;
		stateCon = mainEx.GetController("state");
		selectCon = mainEx.GetController("select");
		progressCon = mainEx.GetController("Progress");
		selfBtn.onClick.RemoveAllListeners();
		selfBtn.onClick.AddListener(delegate
		{
			if (!RogueCardGameMain.CheckDisableInput())
			{
				btnAction(index, arg2: false);
			}
		});
	}

	public void SetData(int stageID)
	{
		unlock = false;
	}

	public void SetSelect(bool isSelect)
	{
		selectCon.SetSelectedState(isSelect ? "on" : "off");
	}

	public void PlayChangeAni()
	{
		selfAni.Play("UI_nd01_cx", 0, 0f);
		int targetValue = Math.Min(100, (int)((float)RogueCardGameMain.GameContext.score / (float)RogueCardGameMain.GameContext.GetTargetScore * 100f));
		progressText.ScrollTo(targetValue);
	}

	public void HideProgress()
	{
		if (!isProgressAniming && !(progressCon.GetSelectedState() == "off"))
		{
			progressAnim.Play("UI_Progress_xs");
			isProgressAniming = true;
			LeanTween.delayedCall(1f, (Action)delegate
			{
				progressCon.SetSelectedState("off");
				isProgressAniming = false;
			});
		}
	}

	public void Refresh()
	{
		if (!(RogueCardGameMain.Instance.CurState is StateWithSubstates))
		{
			HideProgress();
		}
		else if (RogueCardGameMain.GameContext.curRound - 1 > index)
		{
			HideProgress();
		}
		else if (RogueCardGameMain.GameContext.curRound - 1 == index && RogueCardGameMain.Instance.CurState.GetIndex() >= 7 && RogueCardGameMain.GameContext.curStageState == StageType.Boss)
		{
			HideProgress();
		}
		else if (RogueCardGameMain.GameContext.curRound - 1 == index && RogueCardGameMain.Instance.CurState.GetIndex() >= 7 && RogueCardGameMain.GameContext.curStageState == StageType.Boss)
		{
			HideProgress();
		}
		else if (RogueCardGameMain.GameContext.curRound - 1 < index)
		{
			HideProgress();
		}
		else
		{
			progressCon.SetSelectedState("on");
		}
		if (RogueCardGameMain.GameContext.curRound - 1 > index)
		{
			stateCon.SetSelectedState("restore");
		}
		else if (RogueCardGameMain.GameContext.curRound - 1 == index)
		{
			if (RogueCardGameMain.Instance.CurState.GetIndex() >= 7 && RogueCardGameMain.GameContext.curStageState == StageType.Boss)
			{
				stateCon.SetSelectedState("restore");
			}
			else if (RogueCardGameMain.Instance.CurState.GetIndex() == 6 && RogueCardGameMain.GameContext.curStageState == StageType.Boss)
			{
				stateCon.SetSelectedState("unlock");
			}
			else if (RogueCardGameMain.GameContext.curStageState == StageType.Boss || (RogueCardGameMain.Instance.CurState.GetIndex() >= 7 && RogueCardGameMain.GameContext.curStageState == StageType.Normal))
			{
				stateCon.SetSelectedState("unlock");
				int targetValue = Math.Min(100, (int)((float)RogueCardGameMain.GameContext.score / (float)RogueCardGameMain.GameContext.GetTargetScore * 100f));
				progressText.ScrollTo(targetValue);
			}
			else if (RogueCardGameMain.Instance.CurState.GetIndex() == 6 && RogueCardGameMain.GameContext.curStageState == StageType.Normal)
			{
				stateCon.SetSelectedState("lock");
			}
			else
			{
				stateCon.SetSelectedState("lock");
				int targetValue2 = Math.Min(100, (int)((float)RogueCardGameMain.GameContext.score / (float)RogueCardGameMain.GameContext.GetTargetScore * 100f));
				progressText.ScrollTo(targetValue2);
			}
		}
		else
		{
			stateCon.SetSelectedState("lock");
		}
	}
}
