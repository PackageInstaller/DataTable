using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.AI;

namespace Ase.ECS;

public class PathfindingSystem : BaseSystem
{
	private Dictionary<int, int> cacheAgents = new Dictionary<int, int>();

	private Dictionary<int, NavMeshSurface> navMeshDataInstances = new Dictionary<int, NavMeshSurface>();

	private bool usedOriginNavMesh;

	private int agentTypeID;

	private int activeNavMeshId;

	private NavMeshData m_NavMesh;

	private AsyncOperation m_Operation;

	private NavMeshDataInstance m_Instance;

	private List<NavMeshBuildSource> navMeshBuildSources = new List<NavMeshBuildSource>();

	public Vector3 m_Size = new Vector3(90f, 30f, 90f);

	private Vector3 currentPosition;

	protected override bool IsLogicSystem => true;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		WorldData worldData = data as WorldData;
		agentTypeID = await SwitchNavMesh(worldData.NavMeshId);
		return agentTypeID != 0;
	}

	public int GetAgentTypeId()
	{
		return agentTypeID;
	}

	public bool HasNavMesh(int navMeshId)
	{
		return cacheAgents.ContainsKey(navMeshId);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		GenerateNavMesh();
	}

	public Task<int> GenerateNavMesh(int navMeshId)
	{
		return GenerateNavMesh(navMeshId, addData: true);
	}

	private async Task<int> GenerateNavMesh(int navMeshId, bool addData)
	{
		if (world.IsStoryWorld && !usedOriginNavMesh)
		{
			NavMeshBuildSettings settingsByIndex = NavMesh.GetSettingsByIndex(1);
			return ((NavMeshBuildSettings)(ref settingsByIndex)).agentTypeID;
		}
		if (HasNavMesh(navMeshId))
		{
			return GetNavMesh(navMeshId);
		}
		GameObject gameObject = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(AssetUtility.GetEntityAsset($"NavMesh/NavMesh-{navMeshId}"));
		if (gameObject == null)
		{
			return 0;
		}
		GameObject gameObject2 = Object.Instantiate(gameObject, world.NavMeshRoot, worldPositionStays: true);
		NavMeshSurface[] componentsInChildren = gameObject2.GetComponentsInChildren<NavMeshSurface>(includeInactive: true);
		NavMeshSurface surface = gameObject2.GetComponent<NavMeshSurface>() ?? GetDefaultNavMeshSurface(componentsInChildren);
		if ((Object)(object)surface == null)
		{
			Object.Destroy(gameObject2);
			return 0;
		}
		NavMeshSurface[] array = componentsInChildren;
		for (int i = 0; i < array.Length; i++)
		{
			DisableNavMeshSurface(array[i]);
		}
		if (addData)
		{
			EnableNavMeshSurface(surface);
		}
		navMeshDataInstances.Add(navMeshId, surface);
		cacheAgents.Add(navMeshId, surface.agentTypeID);
		GroundMeshCollider[] componentsInChildren2 = gameObject2.GetComponentsInChildren<GroundMeshCollider>(includeInactive: true);
		GroundMeshCollider[] array2 = componentsInChildren2;
		for (int j = 0; j < array2.Length; j++)
		{
			await array2[j].Init();
		}
		return surface.agentTypeID;
	}

	public async Task<int> SwitchNavMesh(int navMeshId)
	{
		int num = await GenerateNavMesh(navMeshId, addData: false);
		if (num == 0)
		{
			return 0;
		}
		if (world.IsStoryWorld && !usedOriginNavMesh)
		{
			agentTypeID = num;
			activeNavMeshId = navMeshId;
			return agentTypeID;
		}
		if (activeNavMeshId == navMeshId)
		{
			agentTypeID = num;
			return agentTypeID;
		}
		if (!navMeshDataInstances.TryGetValue(navMeshId, out var value))
		{
			return 0;
		}
		if (activeNavMeshId != 0 && navMeshDataInstances.TryGetValue(activeNavMeshId, out var value2))
		{
			DisableNavMeshSurface(value2);
		}
		DisableSiblingNavMeshSurfaces(value);
		EnableNavMeshSurface(value);
		activeNavMeshId = navMeshId;
		agentTypeID = num;
		return agentTypeID;
	}

	public int SwitchNavMeshSurface(string navMeshSurfaceName)
	{
		navMeshSurfaceName = NormalizeNavMeshSurfaceName(navMeshSurfaceName);
		if (string.IsNullOrEmpty(navMeshSurfaceName))
		{
			return 0;
		}
		NavMeshSurface val = FindLoadedNavMeshSurface(navMeshSurfaceName);
		if ((Object)(object)val == null)
		{
			return 0;
		}
		if (activeNavMeshId != 0 && navMeshDataInstances.TryGetValue(activeNavMeshId, out var value))
		{
			DisableNavMeshSurface(value);
			activeNavMeshId = 0;
		}
		DisableSiblingNavMeshSurfaces(val, changeGameObjectActive: true);
		EnableNavMeshSurface(val, changeGameObjectActive: true);
		agentTypeID = val.agentTypeID;
		return agentTypeID;
	}

	private NavMeshSurface FindLoadedNavMeshSurface(string navMeshSurfaceName)
	{
		if (world == null || world.NavMeshRoot == null)
		{
			return null;
		}
		NavMeshSurface[] componentsInChildren = world.NavMeshRoot.GetComponentsInChildren<NavMeshSurface>(includeInactive: true);
		foreach (NavMeshSurface val in componentsInChildren)
		{
			if ((Object)(object)val != null && NormalizeNavMeshSurfaceName(((Component)(object)val).gameObject.name) == navMeshSurfaceName)
			{
				return val;
			}
		}
		return null;
	}

	private static NavMeshSurface GetDefaultNavMeshSurface(NavMeshSurface[] surfaces)
	{
		if (surfaces == null || surfaces.Length == 0)
		{
			return null;
		}
		foreach (NavMeshSurface val in surfaces)
		{
			if ((Object)(object)val != null && ((Component)(object)val).gameObject.activeSelf)
			{
				return val;
			}
		}
		return surfaces[0];
	}

	private void DisableSiblingNavMeshSurfaces(NavMeshSurface activeSurface, bool changeGameObjectActive = false)
	{
		if ((Object)(object)activeSurface == null || ((Component)(object)activeSurface).transform.parent == null)
		{
			return;
		}
		NavMeshSurface[] componentsInChildren = ((Component)(object)activeSurface).transform.parent.GetComponentsInChildren<NavMeshSurface>(includeInactive: true);
		foreach (NavMeshSurface val in componentsInChildren)
		{
			if ((Object)(object)val != null && (Object)(object)val != (Object)(object)activeSurface)
			{
				DisableNavMeshSurface(val, changeGameObjectActive);
			}
		}
	}

	private static void EnableNavMeshSurface(NavMeshSurface surface, bool changeGameObjectActive = false)
	{
		if (!((Object)(object)surface == null))
		{
			if (changeGameObjectActive)
			{
				((Component)(object)surface).gameObject.SetActive(value: true);
			}
			((Behaviour)(object)surface).enabled = true;
			surface.RemoveData();
			surface.AddData();
		}
	}

	private static void DisableNavMeshSurface(NavMeshSurface surface, bool changeGameObjectActive = false)
	{
		if (!((Object)(object)surface == null))
		{
			surface.RemoveData();
			((Behaviour)(object)surface).enabled = false;
			if (changeGameObjectActive)
			{
				((Component)(object)surface).gameObject.SetActive(value: false);
			}
		}
	}

	private static string NormalizeNavMeshSurfaceName(string navMeshSurfaceName)
	{
		if (!string.IsNullOrWhiteSpace(navMeshSurfaceName))
		{
			return navMeshSurfaceName.Trim();
		}
		return string.Empty;
	}

	public void ClearNavMesh(int navMeshId)
	{
		navMeshDataInstances.TryGetValue(navMeshId, out var value);
		if ((Object)(object)value != null)
		{
			value.RemoveData();
			Object.Destroy(((Component)(object)value).gameObject);
			navMeshDataInstances.Remove(navMeshId);
		}
		if (cacheAgents.ContainsKey(navMeshId))
		{
			cacheAgents.Remove(navMeshId);
		}
		if (activeNavMeshId == navMeshId)
		{
			activeNavMeshId = 0;
			agentTypeID = 0;
		}
	}

	public IEnumerable<NavMeshSurface> GetNavMeshSurfaces()
	{
		List<NavMeshSurface> list = new List<NavMeshSurface>();
		foreach (NavMeshSurface value in navMeshDataInstances.Values)
		{
			if ((Object)(object)value != null && !list.Contains(value))
			{
				list.Add(value);
			}
		}
		if (world != null && world.NavMeshRoot != null)
		{
			NavMeshSurface[] componentsInChildren = world.NavMeshRoot.GetComponentsInChildren<NavMeshSurface>(includeInactive: true);
			foreach (NavMeshSurface val in componentsInChildren)
			{
				if ((Object)(object)val != null && !list.Contains(val))
				{
					list.Add(val);
				}
			}
		}
		return list;
	}

	public NavMeshPath CalculatePath(int navMeshId, Vector3 sourcePosition, Vector3 targetPosition)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Expected O, but got Unknown
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		int navMesh = GetNavMesh(navMeshId);
		NavMeshPath val = new NavMeshPath();
		val.ClearCorners();
		if (navMesh == 0)
		{
			return val;
		}
		NavMeshQueryFilter val2 = default(NavMeshQueryFilter);
		((NavMeshQueryFilter)(ref val2)).agentTypeID = navMesh;
		((NavMeshQueryFilter)(ref val2)).areaMask = -1;
		NavMeshQueryFilter val3 = val2;
		NavMesh.CalculatePath(sourcePosition, targetPosition, val3, val);
		return val;
	}

	private int GetNavMesh(int navMeshId)
	{
		if (!HasNavMesh(navMeshId))
		{
			return 0;
		}
		return cacheAgents[navMeshId];
	}

	public override void OnDispose()
	{
		GameResourceSystem system = world.GetSystem<GameResourceSystem>();
		base.OnDispose();
		foreach (KeyValuePair<int, NavMeshSurface> navMeshDataInstance in navMeshDataInstances)
		{
			navMeshDataInstance.Value.RemoveData();
			system.UnloadAsset(AssetUtility.GetEntityAsset($"NavMesh/NavMesh-{navMeshDataInstance.Key}"));
		}
		navMeshDataInstances.Clear();
		cacheAgents.Clear();
		navMeshBuildSources.Clear();
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		OnNavMeshUpdate();
	}

	public void GenerateNavMesh()
	{
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Expected O, but got Unknown
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		if (!usedOriginNavMesh && world != null && world.IsStoryWorld)
		{
			m_NavMesh = new NavMeshData();
			m_Instance = NavMesh.AddNavMeshData(m_NavMesh);
			UpdateNavMesh();
		}
	}

	public void OnNavMeshUpdate()
	{
		if (!usedOriginNavMesh && world.IsStoryWorld && (m_Operation == null || m_Operation.isDone))
		{
			UpdateNavMesh(asyncUpdate: true);
		}
	}

	private void UpdateNavMesh(bool asyncUpdate = false)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		if (CheckPosition())
		{
			NavMeshBuildSettings settingsByID = NavMesh.GetSettingsByID(agentTypeID);
			Bounds bounds = QuantizedBounds();
			if (asyncUpdate)
			{
				m_Operation = NavMeshBuilder.UpdateNavMeshDataAsync(m_NavMesh, settingsByID, navMeshBuildSources, bounds);
			}
			else
			{
				NavMeshBuilder.UpdateNavMeshData(m_NavMesh, settingsByID, navMeshBuildSources, bounds);
			}
		}
	}

	public bool CheckPosition()
	{
		Vector3 vector = Vector3.zero;
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(world.ActorId);
		if (entity != null)
		{
			vector = entity.transform.position;
		}
		float sqrMagnitude = (currentPosition - vector).sqrMagnitude;
		float num = new Vector3(m_Size.x, 0f, m_Size.z).sqrMagnitude * (1f / 64f);
		bool num2 = sqrMagnitude > num;
		if (num2)
		{
			currentPosition = vector;
		}
		return num2;
	}

	private Bounds QuantizedBounds()
	{
		Vector3 center = Vector3.zero;
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(world.ActorId);
		if (entity != null)
		{
			center = entity.transform.position;
		}
		return new Bounds(center, m_Size);
	}

	public void Add(List<NavMeshBuildSource> sources)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		foreach (NavMeshBuildSource source in sources)
		{
			if (!navMeshBuildSources.Contains(source))
			{
				navMeshBuildSources.Add(source);
			}
		}
	}

	public void Remove(List<NavMeshBuildSource> sources)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		foreach (NavMeshBuildSource source in sources)
		{
			if (navMeshBuildSources.Contains(source))
			{
				navMeshBuildSources.Remove(source);
			}
		}
	}

	public bool GetVaildPoint(Vector3 transformPosition, out Vector3 position)
	{
		position = transformPosition;
		NavMeshHit val = default(NavMeshHit);
		if (NavMesh.SamplePosition(transformPosition, ref val, 20f, -1))
		{
			position = ((NavMeshHit)(ref val)).position;
			return true;
		}
		return false;
	}
}
