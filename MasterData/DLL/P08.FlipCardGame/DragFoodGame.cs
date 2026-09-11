using System.Collections;
using UnityEngine;

public class DragFoodGame : MainStepBase
{
	public DragContainer dragCon;

	public float imgKeepTime = 2f;

	private bool isFinish;

	private int round;

	private void Start()
	{
		CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, 0, 3));
		dragCon = GetComponentInChildren<DragContainer>();
	}

	private void Update()
	{
		next_round();
		dofinishFood();
	}

	private void next_round()
	{
		if (dragCon.GetProcess() > round)
		{
			round = dragCon.GetProcess();
			CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, round, 3));
		}
	}

	private void dofinishFood()
	{
		if (dragCon.GetIsCover() && !isFinish)
		{
			StartCoroutine(EndGameCor());
		}
	}

	private IEnumerator EndGameCor()
	{
		isFinish = true;
		CookingGameManager.Instance.PlayStepPanelFinishAni();
		yield return new WaitForSeconds(imgKeepTime);
		StepFinish();
	}

	public override bool IsStepCompleted()
	{
		return isFinish;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		return new CookingGameConst.ProgressData(config.stepDescription, dragCon.GetProcess(), dragCon.GetMaxProcess());
	}
}
