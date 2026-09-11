using Sirenix.OdinInspector;
using UnityEngine;

namespace TangramGame;

public class TangramGameStageManager : SerializedMonoBehaviour
{
	public static TangramGameStageManager _instance;

	public TangramTileManager tileManager;

	public TangramGameChipManager chipManager;

	[Header("策划编辑部分")]
	public int width = 20;

	public int height = 20;

	[SerializeField]
	public string stageID;

	[SerializeField]
	public float CUBE_SIZE = 40f;

	public static TangramGameStageManager Instance => _instance;

	public void Awake()
	{
		_instance = this;
	}

	public void Dispose(bool retainTile = false)
	{
		stageID = null;
		tileManager.Dispose(retainTile);
		chipManager.Dispose();
	}

	public void GenerateStage(string stageID, int[] finfishList)
	{
		this.stageID = stageID;
		GetRunTimeStage(finfishList);
	}

	public void GetRunTimeStage(int[] finfishList)
	{
		TangramGamePrefabData tangramGamePrefabData = TangramGameTools.LoadScriptableObject(stageID);
		width = tangramGamePrefabData.baseInfo.width;
		height = tangramGamePrefabData.baseInfo.height;
		tileManager.GenerateStage(tangramGamePrefabData.tileData, width, height);
		tileManager.StartGame();
		chipManager.Init();
		chipManager.GenerateNewChipBySaveData(tangramGamePrefabData.chipData);
		chipManager.StartGame(finfishList);
	}
}
