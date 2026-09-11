using System;
using System.Collections.Generic;
using System.Linq;
using Unity.Mathematics;
using UnityEngine;
using Vella.Common;
using Vella.UnityNativeHull;

namespace Qworld.Runtime.SceneDither;

public class QWSceneDitherComponennt : MortonMono
{
	private static float ditherRatio = 0.5f;

	private static string ditherKeyword = "SIM_DITHERING";

	public MeshRenderer cacheRenderer;

	public BoxCollider mCollider;

	public List<BoxCollider> additiveColliders;

	[NonSerialized]
	private List<TestShape> additiveShapes;

	private Bounds mBounds;

	private Material instanceMaterial;

	private Material sharedMaterial;

	private bool isInDither;

	private bool isInit;

	public bool isRegist;

	public bool lateRecover;

	public bool frameVisited;

	public Vector3 transformOffset;

	[NonSerialized]
	private uint version;

	public void TryInit()
	{
		if (!mCollider || isInit || !(cacheRenderer != null) || QWSceneDitherSystem.Instance == null)
		{
			return;
		}
		additiveShapes = new List<TestShape>();
		isInit = true;
		additiveColliders = mCollider.GetComponents<BoxCollider>().ToList();
		additiveShapes.Add(HullHelper.GetTestShapeFromBoxCollider(mCollider));
		sharedMaterial = cacheRenderer.sharedMaterial;
		instanceMaterial = cacheRenderer.material;
		instanceMaterial.SetFloat("_DitherAlpha", ditherRatio);
		SetKeyword(instanceMaterial, ditherKeyword, state: true);
		cacheRenderer.sharedMaterial = sharedMaterial;
		mBounds = mCollider.bounds;
		version = QWSceneDitherSystem.Instance.GetComponentVersion();
		if (additiveColliders == null || additiveColliders.Count <= 0)
		{
			return;
		}
		foreach (BoxCollider additiveCollider in additiveColliders)
		{
			if (!(additiveCollider == mCollider))
			{
				mBounds.Encapsulate(additiveCollider.bounds);
				additiveShapes.Add(HullHelper.GetTestShapeFromBoxCollider(additiveCollider));
			}
		}
	}

	public static TestShape GetTestShapeFromBoxColliderWithoutScale(BoxCollider box)
	{
		BoundingBox boundingBox = default(BoundingBox);
		Vector3 lossyScale = box.transform.lossyScale;
		NativeHull hull = HullFactory.CreateBox(new float3(box.size.x * Mathf.Abs(lossyScale.x), box.size.y * Mathf.Abs(lossyScale.y), box.size.z * Mathf.Abs(lossyScale.z)), Vector3.zero);
		boundingBox.Min = box.bounds.min;
		boundingBox.Max = box.bounds.max;
		Vector4 vector = box.transform.localToWorldMatrix * box.center;
		return new TestShape
		{
			BoundingBox = boundingBox,
			BoundingSphere = boundingBox.ToSphere(),
			Transform = new RigidTransform(box.transform.rotation, box.transform.position + new Vector3(vector.x, vector.y, vector.z)),
			Hull = hull
		};
	}

	public void SetDither(bool isInDither)
	{
		if (this.isInDither != isInDither && (bool)sharedMaterial)
		{
			cacheRenderer.sharedMaterial = (isInDither ? instanceMaterial : sharedMaterial);
			this.isInDither = isInDither;
		}
	}

	protected void SetKeyword(Material m, string keyword, bool state)
	{
		if (state)
		{
			m.EnableKeyword(keyword);
		}
		else
		{
			m.DisableKeyword(keyword);
		}
	}

	public void OnEnable()
	{
		TryInit();
		if (isInit)
		{
			QWSceneDitherSystem.Instance?.Register(this);
			isRegist = true;
		}
	}

	public void OnDisable()
	{
		if (isInit)
		{
			QWSceneDitherSystem.Instance?.UnRegister(this);
			isRegist = false;
		}
	}

	public override Bounds GetBounds()
	{
		return mBounds;
	}

	public bool TestCollide(ref TestShape frustumHull, ref RigidTransform frustumRigid, bool drawHullGizmos)
	{
		bool flag = false;
		for (int i = 0; i < additiveShapes.Count; i++)
		{
			TestShape testShape = additiveShapes[i];
			bool num = frustumHull.BoundingSphere.IntersectsSphere(testShape.BoundingSphere);
			bool flag2 = frustumHull.BoundingBox.IntersectsSphere(testShape.BoundingSphere);
			bool flag3 = frustumHull.BoundingBox.IntersectsAABB(testShape.BoundingBox);
			if (num & flag2 & flag3)
			{
				bool flag4 = HullCollision.IsColliding(testShape.Transform, testShape.Hull, frustumRigid, frustumHull.Hull);
				if (drawHullGizmos)
				{
					HullDrawingUtility.DrawDebugHull(testShape.Hull, testShape.Transform, DebugHullFlags.All, flag4 ? Color.green : Color.red);
					DebugDrawer.DrawWireCube(testShape.BoundingBox.Center(), testShape.BoundingBox.Size(), Color.blue);
				}
				flag |= flag4;
				if (flag4)
				{
					break;
				}
			}
		}
		return flag;
	}

	private void OnDestroy()
	{
		if (additiveShapes != null)
		{
			foreach (TestShape additiveShape in additiveShapes)
			{
				additiveShape.Hull.Dispose();
			}
			additiveShapes.Clear();
		}
		UnityEngine.Object.DestroyImmediate(instanceMaterial);
	}

	public override uint GetComponentVersion()
	{
		return version;
	}
}
