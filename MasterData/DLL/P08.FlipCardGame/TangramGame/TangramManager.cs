using UnityEngine;

namespace TangramGame;

public class TangramManager
{
	private static TangramManager _instance;

	public bool canEdit;

	public bool isRunTime;

	public TangramGameChip editChip;

	public TangramGameStageManager curStageManager;

	public static TangramManager Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = new TangramManager();
			}
			return _instance;
		}
	}

	public void Init()
	{
		isRunTime = false;
		canEdit = false;
	}

	public void InitPrefab(GameObject stagePrefab)
	{
		curStageManager = stagePrefab.GetComponent<TangramGameStageManager>();
	}

	public void StartStage(int[] finfishList, string stageID)
	{
		isRunTime = true;
		ControllerEditState(flag: true);
		curStageManager.GenerateStage(stageID, finfishList);
	}

	public void Dispose(bool retainTile = false)
	{
		if ((bool)curStageManager)
		{
			curStageManager.Dispose(retainTile);
		}
		isRunTime = false;
	}

	private void ControllerEditState(bool flag)
	{
		canEdit = flag;
	}
}
