using P08.QWorld.Misc;
using UnityEngine;

public class QWorldPopMsgPeopleGroupData : QWorldEntityData<QWorldPopMsgPeopleGroup>
{
	public enum Mode
	{
		[InspectorName("随机")]
		Random,
		[InspectorName("循环")]
		Cycle
	}

	public IAreaDistribution areaDistribution;

	public ActorPrefab[] peoplePrefabs;

	public Mode mode;

	public QWorldBubbleMgrData bubbleMgrData;

	public CustomActorQualityByDistance customActorQualityByDistance;
}
