using System;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
[ExecuteInEditMode]
[RequireComponent(typeof(Renderer))]
public class PointSpreader : MonoBehaviour
{
	public enum Mode
	{
		Display,
		Spread,
		Erase
	}

	[Serializable]
	public struct SpreadObj(Mesh mesh, Material material)
	{
		public Mesh mesh = mesh;

		public Material material = material;

		public Vector3 pointPosition = default;

		public Quaternion pointRotation = default;

		public Vector3 pointScale = Vector3.one;

		public bool isNormAlign = false;

		public List<Vector3> spreadPoints = new List<Vector3>();

		public List<Vector3> spreadNorms = new List<Vector3>();
	}

	public Mode mode;

	public List<SpreadObj> spreadObjs = new List<SpreadObj>();

	public float brushSize = 1f;

	public int currentSpreadIndex;

	private List<Ray> _rays = new List<Ray>();

	private List<RaycastHit> _hits = new List<RaycastHit>();

	private Mesh _mesh;

	private Renderer _renderer;

	private Vector2 _mousePos;

	private void OnEnable()
	{
		_renderer = GetComponent<Renderer>();
		if ((bool)_renderer)
		{
			if (_renderer is SkinnedMeshRenderer skinnedMeshRenderer)
			{
				_mesh = skinnedMeshRenderer.sharedMesh;
			}
			else
			{
				_mesh = GetComponent<MeshFilter>().sharedMesh;
			}
		}
	}

	private void OnDisable()
	{
	}

	private void RenderSpreadPoints()
	{
		foreach (SpreadObj spreadObj in spreadObjs)
		{
			Mesh mesh = spreadObj.mesh;
			if (!mesh)
			{
				continue;
			}
			Material material = spreadObj.material;
			if (!material)
			{
				continue;
			}
			RenderParams rparams = new RenderParams(material);
			List<Vector3> spreadPoints = spreadObj.spreadPoints;
			if (spreadPoints == null || spreadPoints.Count == 0)
			{
				continue;
			}
			List<Vector3> spreadNorms = spreadObj.spreadNorms;
			if (spreadNorms == null || spreadNorms.Count == 0)
			{
				continue;
			}
			if (material.enableInstancing)
			{
				Matrix4x4[] array = new Matrix4x4[spreadPoints.Count];
				for (int i = 0; i < spreadPoints.Count; i++)
				{
					Quaternion q = (spreadObj.isNormAlign ? Quaternion.LookRotation(spreadNorms[i], Vector3.up) : Quaternion.identity) * spreadObj.pointRotation;
					array[i] = Matrix4x4.TRS(spreadObj.pointPosition, Quaternion.identity, spreadObj.pointScale);
					array[i] = Matrix4x4.Rotate(q) * array[i];
					array[i] = Matrix4x4.Translate(transform.localToWorldMatrix * spreadPoints[i]) * array[i];
				}
				Graphics.RenderMeshInstanced(in rparams, mesh, 0, array);
			}
			else
			{
				for (int j = 0; j < spreadPoints.Count && j < spreadNorms.Count; j++)
				{
					Quaternion q2 = (spreadObj.isNormAlign ? Quaternion.LookRotation(spreadNorms[j], Vector3.up) : Quaternion.identity) * spreadObj.pointRotation;
					Matrix4x4 matrix4x = Matrix4x4.TRS(spreadObj.pointPosition, Quaternion.identity, spreadObj.pointScale);
					matrix4x = Matrix4x4.Rotate(q2) * matrix4x;
					matrix4x = Matrix4x4.Translate(transform.localToWorldMatrix * spreadPoints[j]) * matrix4x;
					Graphics.RenderMesh(in rparams, mesh, 0, matrix4x);
				}
			}
		}
	}

	private static float RealScrPosY(Camera camera, float y)
	{
		return (float)camera.pixelHeight - y;
	}

	private static Vector3 RealScrPos(Camera camera, float x, float y, float z)
	{
		return new Vector3(x, RealScrPosY(camera, y), z);
	}

	private static float SceneGUIHandlesDepth(Camera camera)
	{
		return MathF.Max(camera.nearClipPlane, 10f);
	}

	private void Update()
	{
		RenderSpreadPoints();
	}
}
