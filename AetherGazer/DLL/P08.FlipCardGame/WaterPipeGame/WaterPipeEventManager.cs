using System.Collections.Generic;
using UnityEngine;

namespace WaterPipeGame;

public class WaterPipeEventManager : MonoBehaviour
{
	public List<pipeEventPrefab> pipeEventList;

	[HideInInspector]
	public Dictionary<PipeType, GameObject> pipeEventDict = new Dictionary<PipeType, GameObject>();

	private void Awake()
	{
		for (int i = 0; i < pipeEventList.Count; i++)
		{
			pipeEventDict.Add(pipeEventList[i].pipeType, pipeEventList[i].prefab);
		}
	}

	public GameObject CreateEventEntityByEventType(PipeType pipeType)
	{
		if (pipeEventDict.ContainsKey(pipeType))
		{
			return pipeEventDict[pipeType];
		}
		return pipeEventDict[PipeType.NONE];
	}
}
