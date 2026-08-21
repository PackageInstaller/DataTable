using System;
using System.Collections.Generic;
using System.Linq;
using Unity.Profiling;
using UnityEngine;

public class QWorldMapCull
{
	public struct QWorldCullResult
	{
		public bool visible;

		public bool radiusVisible;

		public int lod;

		public float distanceSqr;

		public QWorldCullResult(bool mVisible, float distSqr)
		{
			this = default(QWorldCullResult);
			visible = mVisible;
			lod = GetLod(distSqr);
			distanceSqr = distSqr;
		}
	}

	private static ProfilerMarker CalcPlane = new ProfilerMarker("QWorldMap::GetCullResult: calc planes");

	private static ProfilerMarker FrustumCull = new ProfilerMarker("QWorldMap::GetCullResult: frustum cull");

	public const float CullRadius = 10f;

	private static bool pauseCull;

	private static Plane[] _planes;

	private static float[] _lodDistSqr;

	private static Vector3 lastCullCamPos;

	public static float[] lodDistSqr => _lodDistSqr;

	public static void Init()
	{
		_planes = new Plane[6];
		_lodDistSqr = new float[3] { 2.9181935E+32f, 8.737747E-10f, 4.8917225E+33f };
		pauseCull = false;
	}

	public static void Clean(QWorldMap map = null)
	{
		pauseCull = true;
		_planes = null;
		_lodDistSqr = null;
	}

	public static QWorldCullResult GetCullResult<T>(Vector3 cameraPos, in T cullable, QWCullFunction cullFunc = QWCullFunction.Frustum) where T : IQWorldCullable
	{
		Vector3 position = cullable.GetPosition();
		float boundSphereRadius = cullable.GetBoundSphereRadius();
		return GetCullResult(cameraPos, position, boundSphereRadius, cullFunc);
	}

	public static QWorldCullResult GetCullResult(Vector3 cameraPos, Vector3 pos, float radius, QWCullFunction cullFunc = QWCullFunction.Frustum)
	{
		float sqrMagnitude = (cameraPos - pos).sqrMagnitude;
		return new QWorldCullResult(cullFunc switch
		{
			QWCullFunction.Frustum => !FrustumCulling(_planes, pos, radius), 
			QWCullFunction.Radius => !RadiusCulling(cameraPos, pos), 
			_ => false, 
		}, sqrMagnitude);
	}

	internal static void PrepareCamFrustumPlanes(Camera camera)
	{
		GeometryUtility.CalculateFrustumPlanes(camera, _planes);
	}

	internal static void GetCullResult<T>(Span<QWorldCullResult> result, IEnumerable<T> entities, QWCullFunction cullFunc = QWCullFunction.Frustum, bool updateCachedMainCamFrustumPlanes = false) where T : IQWorldCullable
	{
		Camera mainCamera = QWorldCameraManager.Instance.MainCamera;
		if (updateCachedMainCamFrustumPlanes)
		{
			PrepareCamFrustumPlanes(mainCamera);
		}
		Vector3 position = mainCamera.transform.position;
		int num = 0;
		foreach (T entity in entities)
		{
			T cullable = entity;
			result[num++] = GetCullResult(position, in cullable, cullFunc);
		}
	}

	public static QWorldCullResult[] GetCullResult<T>(IEnumerable<T> entities, QWCullFunction cullFunc = QWCullFunction.Frustum, bool updateCachedMainCamFrustumPlanes = false) where T : IQWorldCullable
	{
		QWorldCullResult[] array = new QWorldCullResult[entities.Count()];
		GetCullResult(array, entities, cullFunc, updateCachedMainCamFrustumPlanes);
		return array;
	}

	private static QWorldCullResult CalcCullAABB(Vector3 pos, Plane[] _planes, Bounds bound)
	{
		return new QWorldCullResult(FrustumCullingBoundingBox(_planes, bound), bound.SqrDistance(pos));
	}

	internal static QWorldCullResult CalcCullAABB(Bounds bound)
	{
		return CalcCullAABB(lastCullCamPos, _planes, bound);
	}

	internal static void PrepareCullCamera(Camera camera)
	{
		lastCullCamPos = camera.transform.position;
		PrepareCamFrustumPlanes(camera);
	}

	private static int GetLod(float distanceSqr)
	{
		float[] array = lodDistSqr;
		if (distanceSqr > array[0])
		{
			if (distanceSqr > array[1])
			{
				if (!(distanceSqr > array[2]))
				{
					return 2;
				}
				return 3;
			}
			return 1;
		}
		return 0;
	}

	private static bool FrustumCulling(Plane[] planes, Vector3 center, float radius)
	{
		for (int i = 0; i < 6; i++)
		{
			if (0f - planes[i].GetDistanceToPoint(center) > radius)
			{
				return true;
			}
		}
		return false;
	}

	private static bool FrustumCullingBoundingBox(Plane[] planes, Bounds bounds)
	{
		if (planes != null)
		{
			for (int i = 0; i < 6; i++)
			{
				Plane plane = planes[i];
				float distanceToPoint = plane.GetDistanceToPoint(bounds.center);
				float num = Vector3.Dot(bounds.extents, new Vector3(Mathf.Abs(plane.normal.x), Mathf.Abs(plane.normal.y), Mathf.Abs(plane.normal.z)));
				if (distanceToPoint + num < 0f)
				{
					return false;
				}
			}
		}
		return true;
	}

	private static bool RadiusCulling(Vector3 origin, Vector3 center)
	{
		return false;
	}
}
