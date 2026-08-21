using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public static class TowerFloorDataUtils
{
	private static void GetRandomPoint(Dictionary<int, Vector4> pointDic, FloorNodeData[] floorNodeData)
	{
		foreach (FloorNodeData floorNodeData2 in floorNodeData)
		{
			if (!floorNodeData2.IsRandom && pointDic.ContainsKey(floorNodeData2.PointIndex))
			{
				pointDic.Remove(floorNodeData2.PointIndex);
			}
		}
	}

	private static void GetRandomPoint(Dictionary<int, Vector4> pointDic, List<FloorNodeData> floorNodeData)
	{
		for (int i = 0; i < floorNodeData.Count; i++)
		{
			FloorNodeData floorNodeData2 = floorNodeData[i];
			if (!floorNodeData2.IsRandom && pointDic.ContainsKey(floorNodeData2.PointIndex))
			{
				pointDic.Remove(floorNodeData2.PointIndex);
			}
		}
	}

	public static List<Vector4> GetRandomPoint(this TowerFloorData data)
	{
		List<Vector4> list = null;
		Dictionary<int, Vector4> dictionary = new Dictionary<int, Vector4>(data.ScenePoints.Length);
		for (int i = 0; i < data.ScenePoints.Length; i++)
		{
			dictionary.Add(i, data.ScenePoints[i]);
		}
		GetRandomPoint(dictionary, data.BattleEndNodes);
		list = dictionary.Values.ToList();
		System.Random random = new System.Random();
		for (int num = list.Count - 1; num > 0; num--)
		{
			int index = random.Next(0, num + 1);
			Vector4 value = list[num];
			list[num] = list[index];
			list[index] = value;
		}
		return list;
	}

	public static List<Vector4> GetWaveScenePoint(this TowerFloorData data, int waveIndex)
	{
		List<Vector4> list = null;
		Dictionary<int, Vector4> dictionary = CollectionPool<Dictionary<int, Vector4>, KeyValuePair<int, Vector4>>.Get();
		for (int i = 0; i < data.ScenePoints.Length; i++)
		{
			dictionary.Add(i, data.ScenePoints[i]);
		}
		if (data.NewBattleConfig.MonsterWaves.Count > waveIndex)
		{
			GetRandomPoint(dictionary, data.NewBattleConfig.MonsterWaves[waveIndex].MonsterNodes);
		}
		GetRandomPoint(dictionary, data.NewBattleConfig.InteractNodes);
		list = dictionary.Values.ToList();
		CollectionPool<Dictionary<int, Vector4>, KeyValuePair<int, Vector4>>.Release(dictionary);
		return list;
	}
}
