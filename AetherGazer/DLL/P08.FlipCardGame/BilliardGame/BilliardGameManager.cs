using BilliardGame.Runtime;
using UnityEngine;

namespace BilliardGame;

public class BilliardGameManager
{
	public static BilliardGameManager Instance;

	public StageData stageData;

	public void Init()
	{
		Instance = this;
		Debug.Log("PinballGameDebugger: Manager:Init");
	}

	public void LoadBilliardMap()
	{
		_ = BilliardGameScene.Context;
	}

	public void Dispose()
	{
		Instance = null;
	}
}
