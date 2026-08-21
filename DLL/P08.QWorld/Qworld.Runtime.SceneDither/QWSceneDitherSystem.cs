using System.Collections.Generic;
using Unity.Mathematics;
using UnityEngine;
using Vella.Common;
using Vella.UnityNativeHull;

namespace Qworld.Runtime.SceneDither;

public class QWSceneDitherSystem
{
	public static QWSceneDitherSystem Instance;

	[HideInInspector]
	public OBB obb;

	private Rect3D rect;

	private TestShape frustumHull;

	private RigidTransform frustumRigid;

	private MortonChunk<QWSceneDitherComponennt> chunk;

	private HashSet<QWSceneDitherComponennt> inDither;

	private HashSet<QWSceneDitherComponennt> visDither;

	private uint compVersion = 1u;

	private bool drawHullGizmos;

	private bool pause;

	public MortonChunk<QWSceneDitherComponennt> Chunk => chunk;

	public void Init()
	{
		drawHullGizmos = false;
		Instance = this;
		chunk = new MortonChunk<QWSceneDitherComponennt>(Vector3.zero, new Vector3(300f, 1000f, 300f), 4);
		frustumRigid = new RigidTransform(Quaternion.identity, Vector3.zero);
		inDither = new HashSet<QWSceneDitherComponennt>();
		visDither = new HashSet<QWSceneDitherComponennt>();
		compVersion = 1u;
	}

	public void ChangeDrawHullGizmosVisiable()
	{
		drawHullGizmos = !drawHullGizmos;
	}

	public void PauseSceneDither(bool _pause)
	{
		if (_pause)
		{
			foreach (QWSceneDitherComponennt item in inDither)
			{
				item.SetDither(isInDither: false);
			}
			inDither.Clear();
		}
		pause = _pause;
	}

	public virtual Camera GetMainCamera()
	{
		return QWorldCameraManager.Instance.MainCamera;
	}

	public virtual void GetObb()
	{
		HullHelper.GetClipSpaceOBBFromCapsuleCollider(QWorldScene.Scene.Agent.CharacterBlackboard.BodyCollider, ref obb);
	}

	public virtual MortonTreeLeafNode GetPlayerChunck()
	{
		Vector3 position = QWorldScene.Scene.Agent.Position;
		return chunk.GetMortonChunk(position);
	}

	public virtual MortonTreeLeafNode GetCameraChunck()
	{
		return chunk.GetMortonChunk(QWorldCameraManager.Instance.MainCamera.transform.position);
	}

	public void LateTick()
	{
		if (pause)
		{
			return;
		}
		foreach (QWSceneDitherComponennt item in inDither)
		{
			visDither.Add(item);
		}
		Camera mainCamera = GetMainCamera();
		GetObb();
		Vector2 zero = Vector2.zero;
		Vector2 one = Vector2.one;
		float num = 100f;
		float num2 = 100f;
		bool flag = true;
		for (int i = 0; i < 8; i++)
		{
			Vector3 vector = mainCamera.WorldToViewportPoint(obb.rect.get_Item(i));
			if (flag)
			{
				num = vector.z;
				num2 = vector.z;
				flag = false;
			}
			else
			{
				num = Mathf.Min(num, vector.z);
				num2 = Mathf.Max(num2, vector.z);
			}
			zero.x = Mathf.Max(zero.x, vector.x);
			zero.y = Mathf.Max(zero.y, vector.y);
			one.x = Mathf.Min(one.x, vector.x);
			one.y = Mathf.Min(one.y, vector.y);
		}
		float z = (num2 + num) / 2f;
		rect.set_Item(0, mainCamera.ViewportToWorldPoint(new Vector4(one.x, one.y, z, 1f)));
		rect.set_Item(1, mainCamera.ViewportToWorldPoint(new Vector4(one.x, zero.y, z, 1f)));
		rect.set_Item(2, mainCamera.ViewportToWorldPoint(new Vector4(zero.x, zero.y, z, 1f)));
		rect.set_Item(3, mainCamera.ViewportToWorldPoint(new Vector4(zero.x, one.y, z, 1f)));
		rect.set_Item(4, mainCamera.ViewportToWorldPoint(new Vector4(one.x, one.y, mainCamera.nearClipPlane, 1f)));
		rect.set_Item(5, mainCamera.ViewportToWorldPoint(new Vector4(one.x, zero.y, mainCamera.nearClipPlane, 1f)));
		rect.set_Item(6, mainCamera.ViewportToWorldPoint(new Vector4(zero.x, zero.y, mainCamera.nearClipPlane, 1f)));
		rect.set_Item(7, mainCamera.ViewportToWorldPoint(new Vector4(zero.x, one.y, mainCamera.nearClipPlane, 1f)));
		frustumHull = HullHelper.GetTestShapeFromRect3D(rect, Quaternion.identity, Vector3.zero);
		if (!frustumHull.Hull.IsValid)
		{
			return;
		}
		if (drawHullGizmos)
		{
			HullDrawingUtility.DrawDebugHull(frustumHull.Hull, frustumRigid);
			DebugDrawer.DrawWireCube(frustumHull.BoundingBox.Center(), frustumHull.BoundingBox.Size(), Color.blue);
		}
		MortonTreeLeafNode playerChunck = GetPlayerChunck();
		MortonTreeLeafNode cameraChunck = GetCameraChunck();
		SolveChunk(playerChunck);
		SolveChunk(cameraChunck);
		if (frustumHull.Hull.IsValid)
		{
			frustumHull.Hull.Dispose();
		}
		foreach (QWSceneDitherComponennt item2 in visDither)
		{
			item2.SetDither(isInDither: false);
			inDither.Remove(item2);
		}
		visDither.Clear();
	}

	public void SolveChunk(MortonTreeLeafNode chunk)
	{
		if (chunk == null)
		{
			return;
		}
		for (IMortonTreeObject mortonTreeObject = chunk.Datas.head; mortonTreeObject != null; mortonTreeObject = mortonTreeObject.nextEntity)
		{
			QWSceneDitherComponennt qWSceneDitherComponennt = mortonTreeObject as QWSceneDitherComponennt;
			qWSceneDitherComponennt.TryInit();
			if (qWSceneDitherComponennt.TestCollide(ref frustumHull, ref frustumRigid, drawHullGizmos))
			{
				qWSceneDitherComponennt.SetDither(isInDither: true);
				if (visDither.Contains(qWSceneDitherComponennt))
				{
					visDither.Remove(qWSceneDitherComponennt);
				}
				inDither.Add(qWSceneDitherComponennt);
			}
			else
			{
				qWSceneDitherComponennt.SetDither(isInDither: false);
				if (visDither.Contains(qWSceneDitherComponennt))
				{
					visDither.Remove(qWSceneDitherComponennt);
				}
				inDither.Remove(qWSceneDitherComponennt);
			}
		}
	}

	public void Register(QWSceneDitherComponennt component)
	{
		chunk.Add(component);
	}

	public void UnRegister(QWSceneDitherComponennt component)
	{
		chunk.Remove(component);
		if (inDither.Contains(component))
		{
			inDither.Remove(component);
		}
	}

	public uint GetComponentVersion()
	{
		return compVersion++;
	}

	public void Dispose()
	{
		if (frustumHull.Hull.IsCreated)
		{
			frustumHull.Hull.Dispose();
		}
		Instance = null;
	}

	public void ChangeGizmosDrawToggle()
	{
		drawHullGizmos = !drawHullGizmos;
	}
}
