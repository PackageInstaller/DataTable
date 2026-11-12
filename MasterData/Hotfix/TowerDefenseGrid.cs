using UnityEngine;

public class TowerDefenseGrid : MonoBehaviour
{
	public enum GridWalkableType
	{
		Default,
		Walkable
	}

	public enum GridDeployType
	{
		Default,
		MonsterSpawnPoint,
		PlayerSpawnPoint,
		TrapSpawnPoint,
		Pothole,
		Deephole,
		LighterTower,
		Backup1,
		Backup2,
		Backup3
	}

	public enum GridAttribute
	{
		Default,
		Fire,
		Backup1,
		Backup2,
		Backup3
	}
}
