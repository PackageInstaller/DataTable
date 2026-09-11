using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class QWorldWalkingPeopleGroupData : QWorldEntityData<QWorldWalkingPeopleGroup>
{
	public float fadeRange = 1f;

	public ActorPrefab[] peoplePrefabs;

	public int walkingPeopleLimit = 5;

	public float genPeopleCooldownSec = -1f;

	public Vector2 genPeopleCooldownRndRange = new Vector2(1f, 1f);

	public float walkSpeed = 1.5f;

	public List<CinemachineSmoothPath.Waypoint[]> waypoints;

	public CustomActorQualityByDistance customActorQualityByDistance;

	public UpDir walkingPeopleGetUpDirFunc;
}
