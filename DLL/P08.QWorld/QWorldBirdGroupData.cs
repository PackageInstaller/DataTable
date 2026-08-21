using P08.QWorld.Misc;
using UnityEngine;

public class QWorldBirdGroupData : QWorldEntityData<QWorldBirdsOnGround>
{
	public IAreaDistribution areaDistribution;

	public float speed = 1f;

	public float step = 0.5f;

	public int count = 12;

	public float rndMoveFactor = 1.5f;

	public string prefabPath;

	[Range(0f, 4f)]
	public float activeRange = 2.5f;

	public float activeFactor = 1f;

	public CustomActorQualityByDistance customActorQualityByDistance;
}
