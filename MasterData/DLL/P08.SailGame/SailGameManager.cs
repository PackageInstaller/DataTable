using System;
using System.Collections.Generic;
using UnityEngine;

public class SailGameManager : MonoBehaviour
{
	private Action<int> triggerEventHandler;

	private Action<int> triggerTipsHandler;

	private Action<bool> gamePauseHandler;

	private int curStageIndex;

	private float curTime;

	private float maxTime = 22f;

	private bool gameOver = true;

	private bool gamePause = true;

	private Dictionary<int, bool> tipsTimeDic = new Dictionary<int, bool>();

	private Dictionary<int, bool> cacheTipsTimeDic = new Dictionary<int, bool>();

	private Dictionary<int, int> eventTimeDic = new Dictionary<int, int>();

	[HideInInspector]
	public List<int> eventTimeList = new List<int>();

	private SailGameAnimController animController;

	public static SailGameManager Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
		if (animController == null)
		{
			animController = base.transform.GetComponent<SailGameAnimController>();
		}
		animController.Initialize();
	}

	public void GameStart()
	{
		animController.InitMark(curStageIndex, eventTimeList, maxTime);
		animController.GameStart();
		gameOver = false;
		gamePause = false;
		cacheTipsTimeDic.Clear();
	}

	public void GameOver()
	{
		gameOver = true;
		curTime = 0f;
		triggerEventHandler = null;
		triggerTipsHandler = null;
		gamePauseHandler = null;
	}

	public void ShutDown()
	{
		GameOver();
		animController.ShutDown();
	}

	public void SetGamePause(bool isPause)
	{
		gamePause = isPause;
		animController.SetPause(isPause);
		gamePauseHandler?.Invoke(isPause);
	}

	public void SetGamePauseHandler(Action<bool> handler)
	{
		gamePauseHandler = handler;
	}

	public void SetTriggerTipsHandler(Action<int> handler)
	{
		triggerTipsHandler = handler;
	}

	public void SetTriggerEventHandler(Action<int> handler)
	{
		triggerEventHandler = handler;
	}

	public bool IsRunning()
	{
		return !gameOver;
	}

	public void SetExchangeData(SailGameDataForExchange data)
	{
		curStageIndex = data.curStageIndex;
		curTime = data.startTime;
		maxTime = data.maxTime;
		int num = data.eventTimeList.Length;
		for (int i = 0; i < num; i++)
		{
			eventTimeDic[data.eventTimeList[i]] = i;
			eventTimeList.Add(data.eventTimeList[i]);
		}
		int[] tipsTimeList = data.tipsTimeList;
		foreach (int key in tipsTimeList)
		{
			tipsTimeDic[key] = true;
		}
	}

	public void UpdateStageIndex(int stageIndex)
	{
		curStageIndex = stageIndex;
	}

	private void Update()
	{
		if (!gamePause && !gameOver)
		{
			curTime += Time.deltaTime;
			animController.UpdateProgress(curTime / maxTime);
			int num = Mathf.FloorToInt(curTime);
			if (eventTimeDic.TryGetValue(num, out var value) && value >= curStageIndex)
			{
				SetGamePause(isPause: true);
				triggerEventHandler?.Invoke(num);
				animController.TriggerEvent(value, (float)num / maxTime);
			}
			if (tipsTimeDic.ContainsKey(num) && !cacheTipsTimeDic.ContainsKey(num))
			{
				triggerTipsHandler?.Invoke(num);
				cacheTipsTimeDic[num] = true;
			}
			if (curTime >= maxTime)
			{
				GameOver();
			}
		}
	}
}
