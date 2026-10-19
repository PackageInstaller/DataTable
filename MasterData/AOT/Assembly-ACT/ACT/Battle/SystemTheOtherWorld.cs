using System;
using System.Collections.Generic;
using ACT.Model;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class SystemTheOtherWorld : ECSSystem
{
	private const float EffectRadius = 1.5f;

	private const int EffectSegments = 48;

	private GameObject _effect;

	private Filter _filter;

	public override Filter MajorFilter { get; }

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompStateObject>().Build();
	}

	public override void FixedUpdate()
	{
		if (Model<TheOtherWorldModel>.HasInstance())
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (Model<TheOtherWorldModel>.Interface.ActiveFollowClairvoyance)
			{
				float fixedDeltaTime = mainEntity.GetCompTime().fixedDeltaTime;
				Model<TheOtherWorldModel>.Interface.ReduceClairvoyance(fixedDeltaTime);
			}
		}
	}

	public override void Update()
	{
		SyncEffect();
	}

	private void CreateEffect()
	{
		_effect = new GameObject();
		_effect.name = "ClairvoyanceEffect";
		_effect.AddComponent<MeshFilter>().sharedMesh = CreateDiskMesh(1.5f, 48);
		MeshRenderer meshRenderer = _effect.AddComponent<MeshRenderer>();
		Material material = new Material(Shader.Find("ACT/ShaderACTNew"));
		material.SetColor("_Color", new Color(1f, 1f, 1f, 0.1f));
		meshRenderer.SetMaterials(new List<Material> { material });
	}

	private static Mesh CreateDiskMesh(float radius, int segments)
	{
		segments = Mathf.Max(3, segments);
		List<Vector3> list = new List<Vector3>(segments + 1) { Vector3.zero };
		List<Vector2> list2 = new List<Vector2>(segments + 1)
		{
			new Vector2(0.5f, 0.5f)
		};
		int[] array = new int[segments * 3];
		for (int i = 0; i < segments; i++)
		{
			float f = MathF.PI * 2f * (float)i / (float)segments;
			float num = Mathf.Cos(f) * radius;
			float num2 = Mathf.Sin(f) * radius;
			list.Add(new Vector3(num, num2, 0f));
			list2.Add(new Vector2(num / (radius * 2f) + 0.5f, num2 / (radius * 2f) + 0.5f));
		}
		for (int j = 0; j < segments; j++)
		{
			int num3 = j * 3;
			array[num3] = 0;
			array[num3 + 1] = ((j == segments - 1) ? 1 : (j + 2));
			array[num3 + 2] = j + 1;
		}
		Mesh mesh = new Mesh();
		mesh.name = "ClairvoyanceDisk";
		mesh.vertices = list.ToArray();
		mesh.uv = list2.ToArray();
		mesh.triangles = array;
		mesh.RecalculateNormals();
		mesh.RecalculateBounds();
		return mesh;
	}

	public void EnableFollowClairvoyance()
	{
		if (!_effect)
		{
			CreateEffect();
		}
		else
		{
			_effect.SetActive(value: true);
			SyncEffect();
		}
		RefreshStateObjectLayer();
	}

	public void DisableFollowClairvoyance()
	{
		_effect?.SetActive(value: false);
		RefreshStateObjectLayer();
	}

	private void SyncEffect()
	{
		if ((bool)_effect)
		{
			GameObject model = MonoECS.instance.mainEntity.GetModel();
			if ((bool)model)
			{
				_effect.transform.position = model.transform.position;
			}
		}
	}

	private void RefreshStateObjectLayer()
	{
		_filter.ForEach((Entity entity, CompStateObject compStateObject) =>
		{
			if (compStateObject.StateWorldAssetData.theOtherWorldOwnerShip != TheOtherWorldModel.TheOtherWorldOwnerShip.Both)
			{
				compStateObject.StateObjectBase.RefreshOtherWorldLogic();
			}
		});
	}

	public void EnterTheOtherWorld()
	{
		RefreshStateObjectLayer();
	}

	public void EnterNormalWorld()
	{
		RefreshStateObjectLayer();
	}
}
