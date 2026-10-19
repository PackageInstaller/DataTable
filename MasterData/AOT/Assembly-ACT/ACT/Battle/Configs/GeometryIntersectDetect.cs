using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public static class GeometryIntersectDetect
{
	private class CylinderSectorInfo
	{
		private const int LatSegment = 8;

		private const GeometryUtils.Direction Direction = GeometryUtils.Direction.X;

		private float _radius;

		private float _height;

		private int _sectorAngle;

		public readonly List<Vector3> vertices = new List<Vector3>();

		public readonly List<int> indices = new List<int>();

		public void Update(float radius, float height, int sectorAngle)
		{
			if (!Mathf.Approximately(_radius, radius) || !Mathf.Approximately(_height, height) || _sectorAngle != sectorAngle)
			{
				_radius = radius;
				_height = height;
				_sectorAngle = sectorAngle;
				vertices.Clear();
				indices.Clear();
				GeometryUtils.GenerateSectorCylinder(sectorAngle, radius * 0.5f, height, 8, GeometryUtils.Direction.X, vertices, indices);
			}
		}
	}

	private class CapsuleInfo
	{
		private const int LatSegments = 2;

		private const int LonSegments = 5;

		private float _height;

		private float _radius;

		private GeometryUtils.Direction _direction;

		public readonly List<Vector3> vertices = new List<Vector3>();

		public readonly List<int> indices = new List<int>();

		public void Update(float radius, float height, int direction)
		{
			if (!Mathf.Approximately(_radius, radius) || !Mathf.Approximately(_height, height) || _direction != (GeometryUtils.Direction)direction)
			{
				_radius = radius;
				_height = height;
				_direction = (GeometryUtils.Direction)direction;
				vertices.Clear();
				indices.Clear();
				GeometryUtils.GenerateCapsule(radius, height, 2, 5, _direction, vertices, indices);
			}
		}
	}

	private static CylinderSectorInfo _cylinderSectorInfo;

	private static CapsuleInfo _capsuleInfo;

	public static bool CheckCylinderSectorToCapsule(ref Matrix4x4 sectorTRS, ref TargetSectorBounds targetSectorBounds, CapsuleCollider capsule, List<Vector3> debugOutput = null)
	{
		Bounds bounds = targetSectorBounds.bounds;
		int sectorAngle = targetSectorBounds.sectorAngle;
		float radius = Mathf.Min(bounds.size.y, bounds.size.z);
		float x = bounds.size.x;
		if (_cylinderSectorInfo == null)
		{
			_cylinderSectorInfo = new CylinderSectorInfo();
		}
		_cylinderSectorInfo.Update(radius, x, sectorAngle);
		if (_capsuleInfo == null)
		{
			_capsuleInfo = new CapsuleInfo();
		}
		_capsuleInfo.Update(capsule.radius, capsule.height, capsule.direction);
		Transform transform = capsule.transform;
		Matrix4x4 trs_b = Matrix4x4.TRS(transform.position, transform.rotation, transform.lossyScale);
		return TheoremSAT.IntersectDetect(_cylinderSectorInfo.vertices, _cylinderSectorInfo.indices, sectorTRS, _capsuleInfo.vertices, _capsuleInfo.indices, trs_b, debugOutput);
	}
}
