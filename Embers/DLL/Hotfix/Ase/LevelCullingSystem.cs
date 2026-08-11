using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class LevelCullingSystem : BaseSystem
{
	public float m_occlusionCapsuleHeight = 0.9f;

	public float m_occlusionCapsuleRadius = 0.3f;

	public LayerMask m_layerMask = 1 << LayerMask.NameToLayer("CullingObject");

	private readonly List<Cullable> m_occludingObjects = new List<Cullable>();

	private readonly List<Vector3> _importantPositions = new List<Vector3>();

	private readonly List<Cullable> _newOccludingObjects = new List<Cullable>();

	private CameraSystem cameraSystem;

	private EntitySystem entitySystem;

	private readonly Collider[] _cullingColliders = (Collider[])(object)new Collider[32];

	protected override bool IsLogicSystem => false;

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		cameraSystem = GetSystem<CameraSystem>();
		entitySystem = GetSystem<EntitySystem>();
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (entitySystem != null && cameraSystem != null && cameraSystem.BattleCamera != null)
		{
			FindImportantPositions();
			FindOccludingObjects();
			SetOccludingObjects();
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		entitySystem = null;
		cameraSystem = null;
		foreach (Cullable occludingObject in m_occludingObjects)
		{
			if ((bool)occludingObject)
			{
				occludingObject.Occluding = false;
			}
		}
		m_occludingObjects.Clear();
	}

	private void FindImportantPositions()
	{
		_importantPositions.Clear();
		foreach (HeroEntity item in entitySystem.GetTeamHero())
		{
			_importantPositions.Add(item.transform.position);
		}
	}

	private void FindOccludingObjects()
	{
		_newOccludingObjects.Clear();
		Camera battleCamera = cameraSystem.BattleCamera;
		foreach (Vector3 importantPosition in _importantPositions)
		{
			Vector3 current = importantPosition;
			current.y += m_occlusionCapsuleHeight;
			if (Physics.OverlapCapsuleNonAlloc(current, battleCamera.transform.position, m_occlusionCapsuleRadius, _cullingColliders, (int)m_layerMask) <= 0)
			{
				continue;
			}
			Collider[] cullingColliders = _cullingColliders;
			foreach (Collider val in cullingColliders)
			{
				if (!((Object)(object)val == null))
				{
					Cullable component = ((Component)(object)val).GetComponent<Cullable>();
					if (!_newOccludingObjects.Contains(component))
					{
						_newOccludingObjects.Add(component);
					}
				}
			}
			for (int j = 0; j < _cullingColliders.Length; j++)
			{
				_cullingColliders[j] = null;
			}
		}
	}

	private void SetOccludingObjects()
	{
		foreach (Cullable newOccludingObject in _newOccludingObjects)
		{
			if (!(newOccludingObject == null))
			{
				int num = m_occludingObjects.IndexOf(newOccludingObject);
				if (num < 0)
				{
					newOccludingObject.Occluding = true;
				}
				else
				{
					m_occludingObjects.RemoveAt(num);
				}
			}
		}
		foreach (Cullable occludingObject in m_occludingObjects)
		{
			occludingObject.Occluding = false;
		}
		m_occludingObjects.Clear();
		for (int i = 0; i < _newOccludingObjects.Count; i++)
		{
			m_occludingObjects.Add(_newOccludingObjects[i]);
		}
		_newOccludingObjects.Clear();
	}
}
