using UnityEngine;

[AddComponentMenu("Game/Adventure/Gizmo/Spawn Plan")]
public class SpawnPlanGizmo : MonoBehaviour
{
	public Weather weather;

	public TimeOfDay timeOfDay;

	public Vector2Int floorRange;

	public void Initialize(int waveIndex)
	{
		int num = 0;
		SpawnGroupGizmo[] array = Object.FindObjectsOfType<SpawnGroupGizmo>();
		foreach (SpawnGroupGizmo spawnGroupGizmo in array)
		{
			if (spawnGroupGizmo.isActiveAndEnabled)
			{
				spawnGroupGizmo.Initialize(waveIndex, num);
				num++;
			}
		}
	}
}
