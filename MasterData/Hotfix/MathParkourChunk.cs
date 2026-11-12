using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class MathParkourChunk : MonoBehaviour
{
	private readonly struct GridKey(int laneIndex, int rowIndex)
	{
		public readonly int LaneIndex = laneIndex;

		public readonly int RowIndex = rowIndex;
	}

	private sealed class GridSpawnState
	{
		public bool HasCenterObject;

		public bool HasWall;
	}

	private sealed class HiddenObjectUi
	{
		public readonly GameObject Instance;

		public readonly Canvas[] Canvases;

		public readonly int FirstCheckFrame;

		public HiddenObjectUi(GameObject instance, Canvas[] canvases, int firstCheckFrame)
		{
			Instance = instance;
			Canvases = canvases;
			FirstCheckFrame = firstCheckFrame;
		}
	}

	private const int LaneCount = 5;

	private const int CenterLaneIndex = 2;

	[Header("对象生成")]
	[SerializeField]
	private Transform objectParent;

	[SerializeField]
	[Min(0.01f)]
	private float laneWidth = 1.7f;

	[SerializeField]
	[Min(0.01f)]
	private float rowLength = 1.7f;

	[SerializeField]
	[Min(0.01f)]
	private float chunkLength = 20.4f;

	[Header("对象显示")]
	[SerializeField]
	[Tooltip("对象弯曲后的世界坐标 Y 到达该值后才显示其 World Space UI。设为较小值可保持始终显示。")]
	private float objectVisibleMinWorldY = -1f;

	private List<MathParkourAreaConfig> areaConfigs;

	private TSRandom random;

	private readonly List<GameObject> spawnedObjects = new List<GameObject>();

	private readonly List<HiddenObjectUi> hiddenObjectUis = new List<HiddenObjectUi>();

	private readonly List<MathParkourCombatEntity> combatEntities = new List<MathParkourCombatEntity>();

	private long nextEntityId;

	public float ChunkLength => chunkLength;

	public long NextEntityId => nextEntityId;

	public float RowLength => rowLength;

	public IReadOnlyList<MathParkourCombatEntity> CombatEntities => combatEntities;

	public void Init(List<MathParkourAreaConfig> areaConfigs, TSRandom random)
	{
		Init(areaConfigs, random, 2L);
	}

	public void Init(List<MathParkourAreaConfig> areaConfigs, TSRandom random, long entityIdStart)
	{
		this.areaConfigs = areaConfigs;
		this.random = random;
		nextEntityId = entityIdStart;
		GenerateObjects();
	}

	public void ClearObjects()
	{
		for (int i = 0; i < spawnedObjects.Count; i++)
		{
			if (spawnedObjects.get_Item(i) != null)
			{
				Object.Destroy(spawnedObjects.get_Item(i));
			}
		}
		spawnedObjects.Clear();
		hiddenObjectUis.Clear();
		combatEntities.Clear();
	}

	public void Recycle()
	{
		ClearObjects();
		areaConfigs = null;
		random = null;
	}

	private void OnDestroy()
	{
		Recycle();
	}

	private void Update()
	{
		for (int num = hiddenObjectUis.Count - 1; num >= 0; num--)
		{
			HiddenObjectUi hiddenObjectUi = hiddenObjectUis.get_Item(num);
			GameObject instance = hiddenObjectUi.Instance;
			if (instance == null)
			{
				hiddenObjectUis.RemoveAt(num);
			}
			else if (Time.frameCount > hiddenObjectUi.FirstCheckFrame && !(instance.transform.position.y < objectVisibleMinWorldY))
			{
				for (int i = 0; i < hiddenObjectUi.Canvases.Length; i++)
				{
					if (hiddenObjectUi.Canvases[i] != null)
					{
						hiddenObjectUi.Canvases[i].enabled = true;
					}
				}
				hiddenObjectUis.RemoveAt(num);
			}
		}
	}

	private void GenerateObjects()
	{
		ClearObjects();
		if (areaConfigs == null || random == null)
		{
			Debug.LogError("[MathParkour] 区块生成失败：配置或随机数生成器为空。", this);
			return;
		}
		areaConfigs.Sort(CompareAreaConfig);
		Dictionary<GridKey, GridSpawnState> dictionary = new Dictionary<GridKey, GridSpawnState>();
		for (int i = 0; i < areaConfigs.Count; i++)
		{
			MathParkourAreaConfig mathParkourAreaConfig = areaConfigs.get_Item(i);
			if (!IsValidLane(mathParkourAreaConfig.LaneIndex) || mathParkourAreaConfig.RowIndex < 0)
			{
				Debug.LogError($"[MathParkour] 区域配置 {mathParkourAreaConfig.Id} 的格子坐标非法：Lane={mathParkourAreaConfig.LaneIndex}, Row={mathParkourAreaConfig.RowIndex}。", this);
				continue;
			}
			MathParkourObject spawnObjectConfig = GetSpawnObjectConfig(mathParkourAreaConfig);
			if (spawnObjectConfig == null)
			{
				continue;
			}
			GridKey key = new GridKey(mathParkourAreaConfig.LaneIndex, mathParkourAreaConfig.RowIndex);
			if (!dictionary.TryGetValue(key, out var value))
			{
				value = new GridSpawnState();
				dictionary.Add(key, value);
			}
			bool flag = spawnObjectConfig.ObjType == 8;
			if (flag ? value.HasWall : value.HasCenterObject)
			{
				Debug.LogError(string.Format("[MathParkour] 格子 Lane={0}, Row={1} 存在重复{2}配置，已跳过对象 {3}。", mathParkourAreaConfig.LaneIndex, mathParkourAreaConfig.RowIndex, flag ? "墙" : "中心对象", spawnObjectConfig.Id), this);
			}
			else
			{
				SpawnObject(spawnObjectConfig, mathParkourAreaConfig, flag);
				if (flag)
				{
					value.HasWall = true;
				}
				else
				{
					value.HasCenterObject = true;
				}
			}
		}
	}

	private MathParkourObject GetSpawnObjectConfig(MathParkourAreaConfig areaConfig)
	{
		if (areaConfig.ObjectGroupId > 0)
		{
			MathParkourItemGroup mathParkourItemGroup = Singleton<HotfixDataController>.Instance.GetMathParkourItemGroup(areaConfig.ObjectGroupId);
			if (mathParkourItemGroup == null)
			{
				Debug.LogError($"[MathParkour] 找不到随机对象组 {areaConfig.ObjectGroupId}。", this);
				return null;
			}
			int num = PickWeightedObjectId(mathParkourItemGroup);
			if (num <= 0)
			{
				return null;
			}
			return Singleton<HotfixDataController>.Instance.GetMathParkourObject(num);
		}
		if (areaConfig.ObjectId <= 0)
		{
			return null;
		}
		return Singleton<HotfixDataController>.Instance.GetMathParkourObject(areaConfig.ObjectId);
	}

	private int PickWeightedObjectId(MathParkourItemGroup groupConfig)
	{
		if (groupConfig.ObjectList.Count == 0 || groupConfig.ObjectList.Count != groupConfig.ObjWeightList.Count)
		{
			Debug.LogError($"[MathParkour] 随机对象组 {groupConfig.Id} 的对象列表与权重列表数量不一致。", this);
			return 0;
		}
		int num = 0;
		for (int i = 0; i < groupConfig.ObjWeightList.Count; i++)
		{
			if (groupConfig.ObjWeightList.get_Item(i) > 0)
			{
				num += groupConfig.ObjWeightList.get_Item(i);
			}
		}
		if (num <= 0)
		{
			Debug.LogError($"[MathParkour] 随机对象组 {groupConfig.Id} 的总权重必须大于 0。", this);
			return 0;
		}
		int num2 = random.Next(0, num);
		for (int j = 0; j < groupConfig.ObjectList.Count; j++)
		{
			int num3 = groupConfig.ObjWeightList.get_Item(j);
			if (num3 > 0)
			{
				num2 -= num3;
				if (num2 < 0)
				{
					return groupConfig.ObjectList.get_Item(j);
				}
			}
		}
		return 0;
	}

	private void SpawnObject(MathParkourObject objectConfig, MathParkourAreaConfig areaConfig, bool isWall)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/" + objectConfig.AssetPath + ".prefab", typeof(GameObject)) as GameObject;
		if (gameObject == null)
		{
			Debug.LogError($"[MathParkour] 找不到对象 {objectConfig.Id} 的资源：{objectConfig.AssetPath}。", this);
			return;
		}
		Transform parent = ((objectParent != null) ? objectParent : transform);
		GameObject gameObject2 = Object.Instantiate(gameObject, parent, worldPositionStays: false);
		gameObject2.name = $"MathParkour_{objectConfig.Id}_{areaConfig.LaneIndex}_{areaConfig.RowIndex}";
		gameObject2.transform.localPosition = GetGridLocalPosition(areaConfig.LaneIndex, areaConfig.RowIndex, isWall);
		gameObject2.transform.localRotation = Quaternion.identity;
		spawnedObjects.Add(gameObject2);
		long entityId = nextEntityId++;
		TryAddCombatEntity(gameObject2, objectConfig, entityId, areaConfig);
		TryAddBuffItemEntity(gameObject2, objectConfig, entityId);
		TryHideObjectUntilVisible(gameObject2);
	}

	private void TryHideObjectUntilVisible(GameObject instance)
	{
		Canvas[] componentsInChildren = instance.GetComponentsInChildren<Canvas>(includeInactive: true);
		if (componentsInChildren.Length != 0)
		{
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].enabled = false;
			}
			hiddenObjectUis.Add(new HiddenObjectUi(instance, componentsInChildren, Time.frameCount + 1));
		}
	}

	private void TryAddCombatEntity(GameObject instance, MathParkourObject objectConfig, long entityId, MathParkourAreaConfig areaConfig)
	{
		HotfixEnum.MathParkourObjectType objType = (HotfixEnum.MathParkourObjectType)objectConfig.ObjType;
		if (objType != HotfixEnum.MathParkourObjectType.Enemy && objType != HotfixEnum.MathParkourObjectType.Boss && objType != HotfixEnum.MathParkourObjectType.TrappedActor)
		{
			return;
		}
		if (!StringParamHelper.TryParseStringParamToInt(objectConfig.Param1, out var intValue) || intValue <= 0)
		{
			Debug.LogError($"[MathParkour] 战斗对象 {objectConfig.Id} 配置非法：Param1(Hp)={objectConfig.Param1}。", this);
			return;
		}
		MathParkourCombatEntity mathParkourCombatEntity = instance.GetComponent<MathParkourCombatEntity>();
		if (mathParkourCombatEntity == null)
		{
			mathParkourCombatEntity = instance.AddComponent<MathParkourCombatEntity>();
		}
		mathParkourCombatEntity.Init(entityId, objectConfig.Id, intValue, this, areaConfig.LaneIndex, areaConfig.RowIndex);
		combatEntities.Add(mathParkourCombatEntity);
	}

	private void TryAddBuffItemEntity(GameObject instance, MathParkourObject objectConfig, long entityId)
	{
		HotfixEnum.MathParkourObjectType objType = (HotfixEnum.MathParkourObjectType)objectConfig.ObjType;
		if (objType == HotfixEnum.MathParkourObjectType.BenefitItem || objType == HotfixEnum.MathParkourObjectType.AccelerationConveyor || objType == HotfixEnum.MathParkourObjectType.DecelerationConveyor || objType == HotfixEnum.MathParkourObjectType.SpecialConveyor)
		{
			MathParkourEffectItemEntity mathParkourEffectItemEntity = instance.GetComponent<MathParkourEffectItemEntity>();
			if (mathParkourEffectItemEntity == null)
			{
				mathParkourEffectItemEntity = instance.AddComponent<MathParkourEffectItemEntity>();
			}
			mathParkourEffectItemEntity.Init(entityId, objectConfig.Id);
		}
	}

	private Vector3 GetGridLocalPosition(int laneIndex, int rowIndex, bool isWall)
	{
		float num = (float)(laneIndex - 2) * laneWidth;
		if (isWall)
		{
			num -= laneWidth * 0.5f;
		}
		return new Vector3(num, 0f, (float)rowIndex * rowLength + rowLength * 0.5f);
	}

	private bool IsValidLane(int laneIndex)
	{
		if (laneIndex >= 0)
		{
			return laneIndex < 5;
		}
		return false;
	}

	private int CompareAreaConfig(MathParkourAreaConfig left, MathParkourAreaConfig right)
	{
		int num = left.RowIndex.CompareTo(right.RowIndex);
		if (num != 0)
		{
			return num;
		}
		num = left.LaneIndex.CompareTo(right.LaneIndex);
		if (num == 0)
		{
			return left.Id.CompareTo(right.Id);
		}
		return num;
	}
}
