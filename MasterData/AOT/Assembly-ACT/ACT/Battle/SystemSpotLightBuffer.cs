using System;
using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class SystemSpotLightBuffer : EntitySystem
{
	private const float LightIntensity = 2f;

	private const float PosThreshold = 0.5f;

	private const float BiasAngle = MathF.PI / 6f;

	private const int NumSegments = 50;

	private uint m_ColorIndex;

	public static readonly Color[] Colors = new Color[6]
	{
		Color.red,
		Color.green,
		Color.blue,
		Color.cyan,
		Color.magenta,
		Color.yellow
	};

	private Filter _abilityFilter;

	private EntityAction _collectEntityAction;

	private EntityAction _collectInViewEntityAction;

	private Comparison<Entity> _entityComparison;

	private CompSpotLightBuffer _currentSpotLightBuffer;

	private Filter _filter;

	private readonly List<Entity> _entities = new List<Entity>(256);

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_abilityFilter = World.NewFilter().All<CompAbility>().Build();
		_filter = World.NewFilter().Any<CompSpotLightBuffer>().Build();
		_collectEntityAction = CollectEntity;
		_collectInViewEntityAction = CollectInViewEntity;
		_entityComparison = CompareEntities;
	}

	private void Spawn(Entity entity, CompSpotLightBuffer compSpotLightBuffer)
	{
		compSpotLightBuffer.colorIndex = m_ColorIndex;
		compSpotLightBuffer.halfAngle = Mathf.Atan(compSpotLightBuffer.radius / compSpotLightBuffer.height) * 180f / MathF.PI;
		if (++m_ColorIndex == Colors.Length)
		{
			m_ColorIndex = 0u;
		}
		GameObject root = entity.GetRoot();
		CreateLight(compSpotLightBuffer, root);
		ConeGenerator(compSpotLightBuffer.radius, compSpotLightBuffer.height, entity.GetRoot());
		compSpotLightBuffer.spawn = true;
	}

	public override void FixedUpdate()
	{
		_entities.Clear();
		_filter.ForEach(_collectEntityAction);
		if (_entities.Count == 0)
		{
			return;
		}
		if (_entities.Count > 1)
		{
			_entities.Sort(_entityComparison);
		}
		int num = 1;
		Entity mainEntity = MonoECS.instance.mainEntity;
		for (int i = 0; i < _entities.Count; i++)
		{
			Entity entity = _entities[i];
			CompSpotLightBuffer compSpotLightBuffer = entity.GetCompSpotLightBuffer();
			if (!compSpotLightBuffer.spawn)
			{
				Spawn(entity, compSpotLightBuffer);
			}
			UpdateSpotLightVolume(entity, compSpotLightBuffer);
			UpdateFollowPlayer(entity, compSpotLightBuffer, mainEntity.GetCompTransform().physicsPosition);
			if (i == 0)
			{
				continue;
			}
			bool flag = InLowDistance(_entities[i - 1].GetCompSpotLightBuffer(), compSpotLightBuffer);
			if (flag)
			{
				num++;
			}
			if (num > 1 && (!flag || i == _entities.Count - 1))
			{
				float num2 = (float)(num - 1) / 2f;
				for (int j = 0; j < num; j++)
				{
					_entities[i - j].GetCompSpotLightBuffer().biasAngle = (num2 - (float)j) * (MathF.PI / 6f);
				}
				num = 1;
			}
		}
	}

	private void CollectEntity(Entity entity)
	{
		_entities.Add(entity);
	}

	private int CompareEntities(Entity x, Entity y)
	{
		CompSpotLightBuffer compSpotLightBuffer = x.GetCompSpotLightBuffer();
		CompSpotLightBuffer compSpotLightBuffer2 = y.GetCompSpotLightBuffer();
		if (!InLowDistance(compSpotLightBuffer, compSpotLightBuffer2))
		{
			return compSpotLightBuffer.pos.x.CompareTo(compSpotLightBuffer2.pos.x);
		}
		return x.Id.Index.CompareTo(y.Id.Index);
	}

	private bool InLowDistance(CompSpotLightBuffer lData, CompSpotLightBuffer rData)
	{
		return Mathf.Abs(rData.pos.x - lData.pos.x) < 0.5f;
	}

	private void CreateLight(CompSpotLightBuffer compSpotLightBuffer, GameObject root)
	{
		Light light = root.AddComponent<Light>();
		light.type = LightType.Spot;
		light.intensity = 2f * compSpotLightBuffer.height * compSpotLightBuffer.height;
		light.color = Colors[m_ColorIndex];
		light.range = compSpotLightBuffer.height * 2f;
		light.spotAngle = compSpotLightBuffer.halfAngle * 2f;
		light.innerSpotAngle = compSpotLightBuffer.halfAngle * 2f;
		MeshRenderer meshRenderer = root.AddComponent<MeshRenderer>();
		meshRenderer.material = AssetStationManager.BattleStation.Load<Material>(GameLoader.meta.spotLightVolumeMatAssetID).As<Material>();
		MaterialPropertyBlock materialPropertyBlock = new MaterialPropertyBlock();
		materialPropertyBlock.SetColor("_TintColor", Colors[m_ColorIndex]);
		meshRenderer.SetPropertyBlock(materialPropertyBlock);
	}

	private void ConeGenerator(float radius, float height, GameObject gameObject)
	{
		Mesh mesh = (gameObject.AddComponent<MeshFilter>().mesh = new Mesh());
		Vector3[] array = new Vector3[52];
		Vector2[] array2 = new Vector2[52];
		int[] array3 = new int[300];
		array[0] = new Vector3(0f, 0f, 0f);
		array2[0] = new Vector2(1f, 1f);
		for (int i = 0; i < 50; i++)
		{
			float f = MathF.PI * 2f * (float)i / 50f;
			float x = Mathf.Cos(f) * radius;
			float y = Mathf.Sin(f) * radius;
			array[i + 1] = new Vector3(x, y, height);
			array2[i + 1] = new Vector2(0f, 0f);
		}
		array[51] = new Vector3(0f, 0f, height);
		array2[51] = new Vector2(0f, 0f);
		int num = 0;
		for (int j = 0; j < 50; j++)
		{
			array3[num] = 0;
			array3[num + 1] = j + 1;
			array3[num + 2] = (j + 1) % 50 + 1;
			num += 3;
			array3[num] = 51;
			array3[num + 1] = (j + 1) % 50 + 1;
			array3[num + 2] = j + 1;
			num += 3;
		}
		mesh.vertices = array;
		mesh.triangles = array3;
		mesh.uv = array2;
		mesh.RecalculateNormals();
	}

	private void UpdateSpotLightVolume(Entity entityBehave, CompSpotLightBuffer comp)
	{
		comp.inViewEr.Clear();
		_currentSpotLightBuffer = comp;
		_abilityFilter.ForEach(_collectInViewEntityAction);
		_currentSpotLightBuffer = null;
	}

	private void CollectInViewEntity(Entity entity)
	{
		if (entity.IsLogicAvailable() && entity.IsActive() && entity.TryGetCompTransform(out CompTransform component) && Mathf.Abs(component.physicsPosition.x - _currentSpotLightBuffer.pos.x) <= _currentSpotLightBuffer.radius)
		{
			_currentSpotLightBuffer.inViewEr.Add(entity);
		}
	}

	public void SetFollowPlayer(Entity entity, CompSpotLightBuffer comp, bool follow, float time, float velocity)
	{
		comp.followPlayer = follow;
		if (follow)
		{
			comp.followTime = time;
			comp.followVelocity = velocity;
		}
	}

	private void UpdateFollowPlayer(Entity entity, CompSpotLightBuffer comp, Vector3 targetPosition)
	{
		if (comp.followPlayer)
		{
			CompTime? compTime = entity.GetCompTime();
			float f = targetPosition.x - comp.pos.x;
			float motionFixedDeltaTime = compTime.motionFixedDeltaTime;
			comp.followTime -= motionFixedDeltaTime;
			if (comp.followTime > 0f)
			{
				comp.pos.x += Mathf.Sign(f) * Mathf.Clamp(comp.followVelocity * motionFixedDeltaTime, 0f, Mathf.Abs(f));
			}
		}
	}
}
