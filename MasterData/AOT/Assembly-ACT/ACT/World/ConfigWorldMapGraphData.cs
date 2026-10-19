using System;
using System.Collections.Generic;
using System.Linq;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World;

[Serializable]
[CreateAssetMenu(menuName = "")]
public class ConfigWorldMapGraphData : LuminSerializedScriptableObject, IBakedWorldData
{
	[FormerlySerializedAs("_worldId")]
	[SerializeField]
	[HideInInspector]
	private int id;

	[SerializeField]
	[HideInInspector]
	private List<MapArea> _areasMapIconDataIndices = new List<MapArea>();

	[NonSerialized]
	[OdinSerialize]
	[HideInInspector]
	private HashSet<BakeStaticMapIconData>[] _areasMapIconDataSets;

	[SerializeField]
	[HideInInspector]
	private List<MapArea> _areasRewardBoxDataIndices = new List<MapArea>();

	[NonSerialized]
	[OdinSerialize]
	[HideInInspector]
	private HashSet<BakeStaticMapIconData>[] _areasRewardBoxDataSets;

	[SerializeField]
	[HideInInspector]
	private List<MapArea> _areasBoundIndices = new List<MapArea>();

	[SerializeField]
	[HideInInspector]
	private Bounds[] _areasBoundsSets;

	[SerializeField]
	[HideInInspector]
	private List<int> _materialTrackTransferDataIndices;

	[NonSerialized]
	[OdinSerialize]
	[HideInInspector]
	private Dictionary<int, MaterialTrackTransferData>[] _materialTrackTransferData;

	[SerializeField]
	[HideInInspector]
	private List<int> _collectionTrackDataIndices;

	[NonSerialized]
	[OdinSerialize]
	[HideInInspector]
	private List<CollectionTrackPointData>[] _collectionTrackData;

	[SerializeField]
	[HideInInspector]
	private List<int> _monsterTrackDataIndices;

	[NonSerialized]
	[OdinSerialize]
	[HideInInspector]
	private List<MonsterTrackPointData>[] _monsterTrackData;

	public int Id => id;

	public HashSet<BakeStaticMapIconData> GetMapIconDataBy(MapArea mapArea)
	{
		int num = _areasMapIconDataIndices.IndexOf(mapArea);
		if (num >= 0)
		{
			return _areasMapIconDataSets[num];
		}
		return null;
	}

	public HashSet<BakeStaticMapIconData> GetRewardBoxDataBy(MapArea mapArea)
	{
		int num = _areasRewardBoxDataIndices.IndexOf(mapArea);
		if (num >= 0)
		{
			return _areasRewardBoxDataSets[num];
		}
		return null;
	}

	public float GetMapAreaZOffset(MapArea mapArea)
	{
		int num = _areasMapIconDataIndices.IndexOf(mapArea);
		if (num < 0)
		{
			return 0f;
		}
		float result = 0f;
		using (HashSet<BakeStaticMapIconData>.Enumerator enumerator = _areasMapIconDataSets[num].GetEnumerator())
		{
			if (enumerator.MoveNext())
			{
				result = enumerator.Current.initPos.z;
			}
		}
		return result;
	}

	public Dictionary<int, MaterialTrackTransferData> GetTransferRangeByEnemyType(int enemyType)
	{
		int num = _materialTrackTransferDataIndices.IndexOf(enemyType);
		if (num >= 0)
		{
			return _materialTrackTransferData[num];
		}
		return null;
	}

	public List<CollectionTrackPointData> GetCollectionPointsByConfigId(int collectionPointConfigId)
	{
		if (_collectionTrackDataIndices == null)
		{
			return null;
		}
		int num = _collectionTrackDataIndices.IndexOf(collectionPointConfigId);
		if (num >= 0)
		{
			return _collectionTrackData[num];
		}
		return null;
	}

	public List<int> GetAllCollectionPointConfigIds()
	{
		return _collectionTrackDataIndices;
	}

	public List<MonsterTrackPointData> GetMonsterPointsByEntityEnemyId(int entityEnemyId)
	{
		if (_monsterTrackDataIndices == null)
		{
			return null;
		}
		int num = _monsterTrackDataIndices.IndexOf(entityEnemyId);
		if (num >= 0)
		{
			return _monsterTrackData[num];
		}
		return null;
	}

	public List<int> GetAllMonsterEntityIds()
	{
		return _monsterTrackDataIndices;
	}

	public Bounds GetAreaBoundBy(MapArea mapArea)
	{
		int num = _areasBoundIndices.IndexOf(mapArea);
		if (num >= 0)
		{
			return _areasBoundsSets[num];
		}
		return default;
	}

	public bool IsStaticMapIcon(int uid)
	{
		if (_areasMapIconDataIndices == null)
		{
			return false;
		}
		bool flag = false;
		foreach (MapArea areasMapIconDataIndex in _areasMapIconDataIndices)
		{
			HashSet<BakeStaticMapIconData> mapIconDataBy = GetMapIconDataBy(areasMapIconDataIndex);
			if (mapIconDataBy != null)
			{
				flag = mapIconDataBy.Any((BakeStaticMapIconData bakeData) => bakeData.uid == uid);
				if (flag)
				{
					return true;
				}
			}
		}
		return flag;
	}
}
