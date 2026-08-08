using System;
using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;

public class CutContainer : MonoBehaviour
{
	public int progress;

	public int maxProgress;

	[NonSerialized]
	private Dictionary<Int, FoodCutLine> dict;

	private bool isFinish;

	private bool isCover;

	[SerializeField]
	private bool needMove;

	[SerializeField]
	private ControllerExCollection ctl;

	private ControllerEx cutController;

	private void Start()
	{
		FoodCutLine[] componentsInChildren = GetComponentsInChildren<FoodCutLine>(includeInactive: true);
		maxProgress = componentsInChildren.Length;
		progress = 0;
		if (maxProgress > 0)
		{
			initGame(componentsInChildren);
		}
		if (needMove)
		{
			cutController = ctl.GetController("cut");
			cutController.SetSelectedIndex(5);
		}
	}

	private void Update()
	{
		if (progress >= maxProgress)
		{
			isFinish = true;
		}
		activeNextCut();
		dofinishFood();
	}

	private void initGame(FoodCutLine[] AllCut)
	{
		dict = new Dictionary<Int, FoodCutLine>();
		foreach (FoodCutLine foodCutLine in AllCut)
		{
			dict.Add(foodCutLine.index, foodCutLine);
			if (foodCutLine.index == progress + 1)
			{
				foodCutLine.OpenImg();
			}
			else
			{
				foodCutLine.CloseImg();
			}
		}
	}

	private void activeNextCut()
	{
		if (isFinish)
		{
			return;
		}
		int num = progress + 1;
		FoodCutLine foodCutLine = dict[num];
		if (foodCutLine.GetCutOver() && foodCutLine.getFinishAnimator())
		{
			if (needMove)
			{
				cutController.SetSelectedIndex(progress);
			}
			else
			{
				dict[num].foodPicOG.SetActive(value: false);
				dict[num].cutlineOG.SetActive(value: true);
			}
			progress++;
			if (progress < maxProgress)
			{
				dict[num + 1].OpenImg();
			}
		}
	}

	private void dofinishFood()
	{
		if (!isFinish || isCover)
		{
			return;
		}
		foreach (FoodCutLine value in dict.Values)
		{
			value.CloseImg();
		}
		isCover = true;
	}

	public bool GetIsCover()
	{
		return isCover;
	}

	public int GetProcess()
	{
		if (maxProgress > progress)
		{
			return 0;
		}
		return 1;
	}

	public int GetMaxProcess()
	{
		return 1;
	}
}
