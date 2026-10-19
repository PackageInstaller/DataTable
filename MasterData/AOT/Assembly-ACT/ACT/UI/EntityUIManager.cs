using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.AssetField;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EntityUIManager : Singleton<EntityUIManager>
{
	private class EntityUIPool
	{
		public AssetLoadHandle handle;

		public GameObject prefab;

		public int capacity = 10;

		public int count;

		public Stack<IEntityUI> inactiveUis = new Stack<IEntityUI>(10);
	}

	private const int EntityUIPoolCapacity = 10;

	private Dictionary<EntityId, IEntityUI> m_EntityUis = new Dictionary<EntityId, IEntityUI>();

	private Dictionary<EntityId, (Entity entity, Vector3 eulerAngles)> m_PendingEntityUis = new Dictionary<EntityId, (Entity, Vector3)>();

	private Dictionary<EntityType, EntityUIPool> m_EntityUIPools = new Dictionary<EntityType, EntityUIPool>();

	private Transform m_EntityUIRoot;

	public bool EntityUIHide { get; set; }

	public override void Init()
	{
		if (m_EntityUIPools.Count > 0)
		{
			return;
		}
		CreateEntityUIPool(EntityType.Elite, GameLoader.meta.eliteMonsterCustomUIReferenceAssetID.GUID);
		CreateEntityUIPool(EntityType.Monster, GameLoader.meta.monsterCustomUIReferenceAssetID.GUID);
		CreateEntityUIPool(EntityType.Trajectory, GameLoader.meta.trajectoryCustomUIReferenceAssetID.GUID);
		CreateEntityUIPool(EntityType.AssistNpc, GameLoader.meta.assistNpcCustomUIReferenceAssetID.GUID);
		foreach (EntityUIPool value in m_EntityUIPools.Values)
		{
			value.handle.WaitForCompletion();
			value.prefab = value.handle.AsGameObject();
		}
	}

	public override void UnInit()
	{
		foreach (EntityUIPool value in m_EntityUIPools.Values)
		{
			AssetStationManager.Root.Release(value.handle);
		}
		m_EntityUIPools.Clear();
	}

	private void CreateEntityUIPool(EntityType entityType, string assetKey)
	{
		EntityUIPool entityUIPool = new EntityUIPool();
		entityUIPool.handle = AssetStationManager.Root.LoadAsync<GameObject>(assetKey);
		m_EntityUIPools.Add(entityType, entityUIPool);
	}

	public void SetEntityUIRoot(Transform root)
	{
		if (!(root == null))
		{
			m_EntityUIRoot = root;
			if (m_PendingEntityUis.Count != 0)
			{
				RegisterPendingEntityUis();
			}
		}
	}

	private void RegisterPendingEntityUis()
	{
		if (m_EntityUIRoot == null)
		{
			return;
		}
		foreach (KeyValuePair<EntityId, (Entity, Vector3)> pendingEntityUi in m_PendingEntityUis)
		{
			Entity item = pendingEntityUi.Value.Item1;
			if (item.IsValid && item.IsAlive())
			{
				Register(item, pendingEntityUi.Value.Item2);
			}
		}
		m_PendingEntityUis.Clear();
	}

	public void Register(Entity er, Vector3 eulerAngles = default(Vector3))
	{
		if (!er.IsValid || !er.IsAlive())
		{
			return;
		}
		EntityType entityType = er.GetEntityType();
		if (entityType != EntityType.Elite && entityType != EntityType.Monster && entityType != EntityType.Trajectory && entityType != EntityType.AssistNpc)
		{
			return;
		}
		if (m_EntityUis.TryGetValue(er.Id, out var value))
		{
			value.Show = true;
			return;
		}
		if (m_EntityUIRoot == null)
		{
			m_PendingEntityUis[er.Id] = (er, eulerAngles);
			return;
		}
		EntityType entityType2 = er.GetEntityType();
		if (!m_EntityUIPools.TryGetValue(entityType2, out var value2) || value2.prefab == null)
		{
			Debug.LogError($"EntityUI预制体加载失败，EntityType:{entityType2}");
			return;
		}
		if (value2.inactiveUis.Count > 0)
		{
			value = value2.inactiveUis.Pop();
			(value as Component)?.gameObject.SetActive(value: true);
		}
		else
		{
			if (value2.count >= value2.capacity)
			{
				value2.capacity += 10;
			}
			value = UnityEngine.Object.Instantiate(value2.prefab, m_EntityUIRoot, worldPositionStays: false).GetComponent<IEntityUI>();
			value2.count++;
		}
		value.Init(er, show: true, eulerAngles);
		m_EntityUis[er.Id] = value;
		CompAbility? compAbility = er.GetCompAbility();
		compAbility.onDie += new Action<Entity>(OnEntityDie);
		compAbility.onRelase += new Action<Entity>(OnEntityRelease);
	}

	public void ReBuild(Entity er)
	{
		if (er.IsValid && er.IsAlive() && m_EntityUis.TryGetValue(er.Id, out var value))
		{
			RecycleEntityUI(er.Id, er.GetEntityType(), value);
			CompAbility? compAbility = er.GetCompAbility();
			compAbility.onDie -= new Action<Entity>(OnEntityDie);
			compAbility.onRelase -= new Action<Entity>(OnEntityRelease);
			Register(er);
		}
	}

	private void RecycleEntityUI(EntityId entityId, EntityType entityType, IEntityUI entityUI)
	{
		if (m_EntityUis.TryGetValue(entityId, out var value) && value == entityUI)
		{
			entityUI.OnRelease();
			m_EntityUis.Remove(entityId);
			m_EntityUIPools[entityType].inactiveUis.Push(entityUI);
		}
	}

	public void RefreshEntityUIPos()
	{
		if (EntityUIHide)
		{
			return;
		}
		foreach (IEntityUI value in m_EntityUis.Values)
		{
			if (value.Show)
			{
				value.UpdatePos();
			}
		}
	}

	public void OnEntityDie(Entity entity)
	{
		if (!m_EntityUis.TryGetValue(entity.Id, out var value))
		{
			return;
		}
		if (entity.IsMonster())
		{
			MonsterCustomUI monsterUI = value as MonsterCustomUI;
			if ((object)monsterUI != null)
			{
				monsterUI.PlayDieHide(() =>
				{
					RecycleEntityUI(monsterUI.entityUIInfo.entityId, monsterUI.entityUIInfo.entityType, monsterUI);
				});
				return;
			}
		}
		RecycleEntityUI(entity.Id, entity.GetEntityType(), value);
	}

	public void OnEntityRelease(Entity entity)
	{
		if (m_EntityUis.TryGetValue(entity.Id, out var value) && !(value is MonsterCustomUI { isDieHiding: not false }))
		{
			RecycleEntityUI(entity.Id, entity.GetEntityType(), value);
		}
	}

	public void SetUIActive(Entity entity, bool active)
	{
		if (m_EntityUis.TryGetValue(entity.Id, out var value))
		{
			if (value is MonsterCustomUI monsterCustomUI)
			{
				monsterCustomUI.SetUIActive(active);
			}
			else
			{
				value.Show = active;
			}
		}
	}

	public void Release()
	{
		foreach (IEntityUI value in m_EntityUis.Values)
		{
			value.OnRelease();
			UnityEngine.Object.Destroy((value as Component)?.gameObject);
		}
		m_EntityUis.Clear();
		m_PendingEntityUis.Clear();
		foreach (EntityUIPool value2 in m_EntityUIPools.Values)
		{
			while (value2.inactiveUis.Count > 0)
			{
				UnityEngine.Object.Destroy((value2.inactiveUis.Pop() as Component)?.gameObject);
			}
			value2.capacity = 10;
			value2.count = 0;
		}
		m_EntityUIRoot = null;
	}
}
