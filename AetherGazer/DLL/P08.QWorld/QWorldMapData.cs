using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

[Serializable]
public class QWorldMapData : SerializedScriptableObject
{
	public string mapdataName;

	[SerializeField]
	public int maxGroupIndex;

	[SerializeField]
	public string[] group_names;

	[SerializeField]
	public List<QWorldMapEntityData> mapEntityDatas = new List<QWorldMapEntityData>();

	[SerializeField]
	public List<QWorldThingEntityData> thingEntityDatas = new List<QWorldThingEntityData>();

	[SerializeField]
	public List<QWorldTeleportEntityData> teleportEntityDatas = new List<QWorldTeleportEntityData>();

	[SerializeField]
	public List<QWorldPatrolPathDeviceEntityData> patrolPathEntityDatas = new List<QWorldPatrolPathDeviceEntityData>();

	[SerializeField]
	public List<QWorldBirdGroupData> birdDatas = new List<QWorldBirdGroupData>();

	[SerializeField]
	public List<QWorldWalkingPeopleGroupData> walkingPeopleDatas = new List<QWorldWalkingPeopleGroupData>();

	[SerializeField]
	public List<QWorldPopMsgPeopleGroupData> popMsgPeopleDatas = new List<QWorldPopMsgPeopleGroupData>();

	[SerializeField]
	public List<QWorldBubbleMgrData> npcTalkingData = new List<QWorldBubbleMgrData>();

	public void Clear()
	{
		mapEntityDatas.Clear();
		thingEntityDatas.Clear();
		teleportEntityDatas.Clear();
		patrolPathEntityDatas.Clear();
		birdDatas.Clear();
		walkingPeopleDatas.Clear();
		popMsgPeopleDatas.Clear();
		npcTalkingData.Clear();
	}
}
