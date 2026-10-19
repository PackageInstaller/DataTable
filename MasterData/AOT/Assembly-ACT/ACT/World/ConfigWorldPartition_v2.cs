using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.World.Asset;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.World;

[CreateAssetMenu]
public class ConfigWorldPartition_v2 : ConfigWorldChunkStoreBase, IConfigWorldPartition, IBakedWorldData
{
	[SerializeField]
	private int _id;

	[SerializeField]
	[HideInInspector]
	private bool _hasWorldBlueprintAssetRef;

	[SerializeField]
	private YooAssetReference _blueprintAssetRef;

	[SerializeField]
	[HideInInspector]
	private bool _useSpawnPosition;

	[SerializeField]
	private Vector3 _spawnPosition;

	[OdinSerialize]
	protected List<InteractRule> _rules;

	[OdinSerialize]
	protected Dictionary<int, Dictionary<int, MaterialTrackTransferData>> _enemyType2MaterialTrackTransferData;

	private static readonly List<InteractRule> EmptyRules = new List<InteractRule>();

	private static readonly Dictionary<int, MaterialTrackTransferData> EmptyDict = new Dictionary<int, MaterialTrackTransferData>();

	public bool UseSpawnPosition => _useSpawnPosition;

	public Vector3 SpawnPosition => _spawnPosition;

	public bool HasWorldBlueprint
	{
		get
		{
			if (_hasWorldBlueprintAssetRef)
			{
				return _blueprintAssetRef.IsValid();
			}
			return false;
		}
	}

	public List<InteractRule> Rules => _rules ?? EmptyRules;

	public int Id => _id;

	public Dictionary<int, NPCPointData> NpcStateAssetDatas { get; } = new Dictionary<int, NPCPointData>();

	public List<RoomData> RoomDatas { get; } = new List<RoomData>();

	public Dictionary<int, int> NpcDictionary { get; } = new Dictionary<int, int>();

	public YooAssetReference WorldBluePrintAssetID => _blueprintAssetRef;

	protected void Setup(int worldIndex)
	{
		_id = worldIndex;
	}

	internal void GenerateMaterialTrackTransferData()
	{
		_enemyType2MaterialTrackTransferData = GenerateMaterialTrackTransferData(this);
	}

	internal static Dictionary<int, Dictionary<int, MaterialTrackTransferData>> GenerateMaterialTrackTransferData(ConfigWorldPartition_v2 partitionData)
	{
		Dictionary<int, Dictionary<int, MaterialTrackTransferData>> dictionary = new Dictionary<int, Dictionary<int, MaterialTrackTransferData>>();
		Dictionary<int, StateWorldAssetDataInfo<StateWorldAssetData>> allStateWorldAssetDataInPartition = partitionData.GetAllStateWorldAssetDataInPartition();
		Dictionary<int, StateWorldAssetDataInfo<PortalData>> allStateWorldAssetDataInPartition2 = partitionData.GetAllStateWorldAssetDataInPartition<PortalData>();
		foreach (KeyValuePair<int, StateWorldAssetDataInfo<MonsterPointData>> item in partitionData.GetAllStateWorldAssetDataInPartition<MonsterPointData>())
		{
			MonsterPointData data = item.Value.Data;
			EnemySpawn data2 = CoreUtils.GetData(data.monsterPointId, RuntimeConfigs.data.enemySpawns);
			if (data2 == null)
			{
				Debug.LogError($"怪点状态物->{data.stateWorldAssetUid}的怪点id->{data.monsterPointId}，不在enemySpawns表中了，请检查表和怪点配置");
				continue;
			}
			foreach (Maybe item2 in data2.enemy)
			{
				EntityEnemyData data3 = CoreUtils.GetData(item2.id, RuntimeConfigs.data.entityEnemyDatas);
				if (data3 == null)
				{
					continue;
				}
				int enemyType = data3.enemyType;
				if (enemyType != 0)
				{
					var (num, transferMapArea, _) = GetNearestTransfer(data, allStateWorldAssetDataInPartition2);
					if (!dictionary.TryGetValue(enemyType, out var value))
					{
						value = new Dictionary<int, MaterialTrackTransferData>();
						dictionary.Add(enemyType, value);
					}
					if (!value.ContainsKey(num))
					{
						Vector3 transferWorldPos = (allStateWorldAssetDataInPartition.TryGetValue(num, out var value2) ? value2.Data.initPos : Vector3.zero);
						MaterialTrackTransferData materialTrackTransferData = new MaterialTrackTransferData
						{
							enemyTypeId = enemyType,
							transferId = num,
							transferMapArea = transferMapArea,
							transferWorldPos = transferWorldPos
						};
						value.Add(num, materialTrackTransferData);
						materialTrackTransferData.AddMonsterPoint(data);
					}
				}
			}
		}
		return dictionary;
	}

	private static (int transferId, MapArea mapArea, float distance) GetNearestTransfer(MonsterPointData monsterPointData, Dictionary<int, StateWorldAssetDataInfo<PortalData>> dict)
	{
		float num = float.MaxValue;
		int item = 0;
		MapArea item2 = MapArea.None;
		foreach (KeyValuePair<int, StateWorldAssetDataInfo<PortalData>> item3 in dict)
		{
			StateWorldAssetDataInfo<PortalData> value = item3.Value;
			PortalData data = item3.Value.Data;
			float num2 = Vector3.Distance(data.initPos, monsterPointData.initPos);
			if (num2 < num)
			{
				num = num2;
				item = data.stateWorldAssetUid;
				item2 = (MapArea)value.MapAreaId;
			}
		}
		return (transferId: item, mapArea: item2, distance: num);
	}

	public Dictionary<int, MaterialTrackTransferData> GetTransferRangeByEnemyType(int enemyType)
	{
		if (_enemyType2MaterialTrackTransferData == null || !_enemyType2MaterialTrackTransferData.TryGetValue(enemyType, out var value))
		{
			return EmptyDict;
		}
		return value;
	}
}
