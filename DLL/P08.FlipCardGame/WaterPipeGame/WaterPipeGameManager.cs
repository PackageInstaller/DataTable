using UnityEngine;

namespace WaterPipeGame;

public class WaterPipeGameManager : MonoBehaviour
{
	private float times;

	private bool isPause;

	public int width;

	public int height;

	public int stageID;

	public int cubeSize;

	public GameState gameState;

	public WaterPipeItemManager pipeItemManager;

	public WaterPipeHeroManager pipeHeroManager;

	public WaterPipeEventManager pipeEventManager;

	private static WaterPipeGameManager _instance;

	public static WaterPipeGameManager Instance => _instance;

	private void Awake()
	{
		_instance = this;
	}

	public void Update()
	{
		UpdateTime();
	}

	public void UpdateTime()
	{
		if (!isPause)
		{
			times += Time.deltaTime;
		}
	}

	public float GetTimes()
	{
		return times;
	}

	public void PauseGame(bool flag)
	{
		isPause = flag;
	}

	public void InitData()
	{
		times = 0f;
		isPause = false;
		gameState = GameState.PLAYING;
	}

	public void StartGame(int stageID)
	{
		InitData();
		LoadStageDataByStageID(stageID);
	}

	public void SetEventOrderSort(int[] eventOrderSort)
	{
		pipeItemManager.SetEventOrderSort(eventOrderSort);
	}

	public void CheckStageFinish()
	{
		pipeItemManager.CheckStageFinish();
	}

	public void LoadStageDataByStageID(int stageID)
	{
		WaterPipeStageSaveData waterPipeStageSaveData = WaterPipeTools.LoadPipeStageData(stageID);
		this.stageID = stageID;
		width = waterPipeStageSaveData.width;
		height = waterPipeStageSaveData.height;
		cubeSize = waterPipeStageSaveData.cubeSize;
		pipeItemManager.LoadStage(waterPipeStageSaveData.pipeItemDataArray);
	}

	public void ExitGame()
	{
		pipeItemManager.ExitGame();
		pipeHeroManager.ExitGame();
	}

	public void DisposeGame()
	{
		_instance = null;
	}
}
