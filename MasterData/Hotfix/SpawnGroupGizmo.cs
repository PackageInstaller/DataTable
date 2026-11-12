using TrueSync;
using UnityEngine;
using UnityEngine.Serialization;

[AddComponentMenu("Game/Adventure/Gizmo/Spawn Group")]
public class SpawnGroupGizmo : MonoBehaviour
{
	[FormerlySerializedAs("_enableDelayActiveCondition")]
	public bool enableDelayActiveCondition;

	[FormerlySerializedAs("_delaySpawnDuration")]
	public FP delaySpawnDuration = 0f;

	[Range(0f, 10f)]
	public float radius;

	public bool isActivated;

	public int allMonsterCount;

	public int waveIndex;

	public int groupIndex;

	public void Initialize(int waveIndex, int groupIndex)
	{
		this.waveIndex = waveIndex;
		this.groupIndex = groupIndex;
	}

	public void LogicUpdate()
	{
	}
}
