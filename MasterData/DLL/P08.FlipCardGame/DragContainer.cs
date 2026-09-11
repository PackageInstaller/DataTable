using System;
using UnityEngine;

public class DragContainer : MonoBehaviour
{
	private int progress;

	private int num;

	private int Maxnum;

	private int maxProgress;

	private bool isFinish;

	[NonSerialized]
	private DragStep[] AllDrag;

	private bool isCover;

	public GameObject image;

	private void Start()
	{
		AllDrag = GetComponentsInChildren<DragStep>(includeInactive: true);
		progress = 0;
		maxProgress = AllDrag.Length;
		num = 0;
		AllDrag[progress].init();
	}

	private void Update()
	{
		nextDrag();
		doFinish();
	}

	private void nextDrag()
	{
		if (!isFinish && AllDrag[progress].getState())
		{
			progress++;
			if (progress == maxProgress)
			{
				image.SetActive(value: true);
				isFinish = true;
			}
			else
			{
				AllDrag[progress].init();
			}
		}
	}

	private void doFinish()
	{
		if (isFinish)
		{
			AllDrag[progress - 1].finish();
			isCover = true;
		}
	}

	public bool GetIsCover()
	{
		return isCover;
	}

	public int GetProcess()
	{
		return progress;
	}

	public int GetMaxProcess()
	{
		return maxProgress;
	}
}
