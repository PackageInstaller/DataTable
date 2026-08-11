using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

[ExecuteAlways]
public class InstancedIndirectGrassRenderer : MonoBehaviour
{
	private struct CellInfo
	{
		public int memoryOffset;

		public List<Vector3> grassPos;
	}

	[Header("Settings")]
	public float triggerOffset = 42f;

	public Material instanceMaterial;

	[Header("Internal")]
	public ComputeShader cullingComputeShader;

	[NonSerialized]
	public List<Vector3> allGrassPos = new List<Vector3>();

	private int cellCountX = -1;

	private int cellCountZ = -1;

	private int cacheXID = -1;

	private int cacheZID = -1;

	private float cellSizeX = 15f;

	private float cellSizeZ = 15f;

	private int instanceCountCache = -1;

	private ComputeBuffer allInstancesPosWSBuffer;

	private ComputeBuffer visibleInstancesOnlyPosWSIDBuffer;

	private ComputeBuffer argsBuffer;

	private List<CellInfo> cellPosWSsList;

	private float minX;

	private float minZ;

	private float maxX;

	private float maxZ;

	private Mesh cachedGrassMesh;

	private Camera mainCamera;

	private void LateUpdate()
	{
		Camera camera = GetCamera();
		if (!camera || !UpdateAllInstanceTransformBufferIfNeeded())
		{
			return;
		}
		Vector3 vector = camera.transform.position + camera.transform.forward * triggerOffset;
		float num = 10f;
		if (vector.x - maxX > num || minX - vector.x > num || vector.z - maxZ > num || minZ - vector.z > num)
		{
			return;
		}
		int num2 = Mathf.Min(cellCountX - 1, Mathf.FloorToInt(Mathf.InverseLerp(minX, maxX, vector.x) * (float)cellCountX));
		int num3 = Mathf.Min(cellCountZ - 1, Mathf.FloorToInt(Mathf.InverseLerp(minZ, maxZ, vector.z) * (float)cellCountZ));
		Bounds bounds = default(Bounds);
		bounds.SetMinMax(new Vector3(minX, 0f, minZ), new Vector3(maxX, 0f, maxZ));
		if (cacheXID == num2 && cacheZID == num3)
		{
			Graphics.DrawMeshInstancedIndirect(GetGrassMeshCache(), 0, instanceMaterial, bounds, argsBuffer);
			return;
		}
		cacheXID = num2;
		cacheZID = num3;
		visibleInstancesOnlyPosWSIDBuffer.SetCounterValue(0u);
		cullingComputeShader.SetBuffer(0, "_VisibleInstancesOnlyPosWSIDBuffer", visibleInstancesOnlyPosWSIDBuffer);
		int kernelIndex = cullingComputeShader.FindKernel("CSMain");
		int count = cellPosWSsList.Count;
		int num4 = 1;
		for (int i = -num4; i <= num4; i++)
		{
			int num5 = 0;
			for (int j = -num4; j <= num4; j++)
			{
				int num6 = num2 + j + (num3 + i) * cellCountX;
				if (num6 >= 0 && num6 < count)
				{
					num5 += cellPosWSsList[num6].grassPos.Count;
				}
			}
			int num7 = num2 - num4 + (num3 + i) * cellCountX;
			if (num7 < 0)
			{
				num7 = 0;
			}
			if (num7 >= cellCountX * cellCountZ)
			{
				num7 = cellCountX * cellCountZ - 1;
			}
			int memoryOffset = cellPosWSsList[num7].memoryOffset;
			cullingComputeShader.SetInt("_StartOffset", memoryOffset);
			int num8 = Mathf.FloorToInt((float)num5 / 4f);
			if (num8 > 0)
			{
				cullingComputeShader.Dispatch(kernelIndex, num8, 1, 1);
			}
		}
		ComputeBuffer.CopyCount(visibleInstancesOnlyPosWSIDBuffer, argsBuffer, 4);
		Graphics.DrawMeshInstancedIndirect(GetGrassMeshCache(), 0, instanceMaterial, bounds, argsBuffer);
	}

	private void OnDisable()
	{
		if (allInstancesPosWSBuffer != null)
		{
			allInstancesPosWSBuffer.Release();
		}
		allInstancesPosWSBuffer = null;
		if (visibleInstancesOnlyPosWSIDBuffer != null)
		{
			visibleInstancesOnlyPosWSIDBuffer.Release();
		}
		visibleInstancesOnlyPosWSIDBuffer = null;
		if (argsBuffer != null)
		{
			argsBuffer.Release();
		}
		argsBuffer = null;
	}

	private Camera GetCamera()
	{
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		if (mainCamera == null)
		{
			Camera[] array = UnityEngine.Object.FindObjectsOfType<Camera>();
			foreach (Camera camera in array)
			{
				if ((int)CameraExtensions.GetUniversalAdditionalCameraData(camera).renderType == 0)
				{
					mainCamera = camera;
					break;
				}
			}
		}
		return mainCamera;
	}

	private Mesh GetGrassMeshCache()
	{
		if (!cachedGrassMesh)
		{
			cachedGrassMesh = new Mesh();
			Vector3[] vertices = new Vector3[4]
			{
				new Vector3(-0.25f, 0f),
				new Vector3(0.25f, 0f),
				new Vector3(-0.25f, 1f),
				new Vector3(0.25f, 1f)
			};
			int[] triangles = new int[6] { 2, 1, 0, 3, 1, 2 };
			cachedGrassMesh.SetVertices(vertices);
			cachedGrassMesh.SetTriangles(triangles, 0);
			Vector2[] uv = new Vector2[4]
			{
				new Vector2(0f, 0f),
				new Vector2(1f, 0f),
				new Vector2(0f, 1f),
				new Vector2(1f, 1f)
			};
			cachedGrassMesh.uv = uv;
		}
		return cachedGrassMesh;
	}

	private bool UpdateAllInstanceTransformBufferIfNeeded()
	{
		if (instanceCountCache == allGrassPos.Count && argsBuffer != null && allInstancesPosWSBuffer != null && visibleInstancesOnlyPosWSIDBuffer != null)
		{
			return true;
		}
		cacheXID = -1;
		cacheZID = -1;
		if (allGrassPos.Count < 1)
		{
			return false;
		}
		int count = allGrassPos.Count;
		if (allInstancesPosWSBuffer != null)
		{
			allInstancesPosWSBuffer.Release();
		}
		allInstancesPosWSBuffer = new ComputeBuffer(count, 12);
		if (visibleInstancesOnlyPosWSIDBuffer != null)
		{
			visibleInstancesOnlyPosWSIDBuffer.Release();
		}
		visibleInstancesOnlyPosWSIDBuffer = new ComputeBuffer(count, 4, ComputeBufferType.Append);
		minX = float.MaxValue;
		minZ = float.MaxValue;
		maxX = float.MinValue;
		maxZ = float.MinValue;
		for (int i = 0; i < allGrassPos.Count; i++)
		{
			Vector3 vector = allGrassPos[i];
			minX = Mathf.Min(vector.x, minX);
			minZ = Mathf.Min(vector.z, minZ);
			maxX = Mathf.Max(vector.x, maxX);
			maxZ = Mathf.Max(vector.z, maxZ);
		}
		cellCountX = Mathf.CeilToInt((maxX - minX) / cellSizeX);
		cellCountZ = Mathf.CeilToInt((maxZ - minZ) / cellSizeZ);
		int num = cellCountX * cellCountZ;
		cellPosWSsList = new List<CellInfo>(num);
		for (int j = 0; j < num; j++)
		{
			CellInfo item = new CellInfo
			{
				grassPos = new List<Vector3>()
			};
			cellPosWSsList.Add(item);
		}
		for (int k = 0; k < allGrassPos.Count; k++)
		{
			Vector3 item2 = allGrassPos[k];
			int num2 = Mathf.Min(cellCountX - 1, Mathf.FloorToInt(Mathf.InverseLerp(minX, maxX, item2.x) * (float)cellCountX));
			int num3 = Mathf.Min(cellCountZ - 1, Mathf.FloorToInt(Mathf.InverseLerp(minZ, maxZ, item2.z) * (float)cellCountZ));
			cellPosWSsList[num2 + num3 * cellCountX].grassPos.Add(item2);
		}
		int num4 = 0;
		Vector3[] array = new Vector3[allGrassPos.Count];
		for (int l = 0; l < cellPosWSsList.Count; l++)
		{
			CellInfo value = cellPosWSsList[l];
			value.memoryOffset = num4;
			cellPosWSsList[l] = value;
			for (int m = 0; m < value.grassPos.Count; m++)
			{
				array[num4] = value.grassPos[m];
				num4++;
			}
		}
		allInstancesPosWSBuffer.SetData(array);
		instanceMaterial.SetBuffer("_AllInstancesTransformBuffer", allInstancesPosWSBuffer);
		instanceMaterial.SetBuffer("_VisibleInstanceOnlyTransformIDBuffer", visibleInstancesOnlyPosWSIDBuffer);
		if (argsBuffer != null)
		{
			argsBuffer.Release();
		}
		uint[] array2 = new uint[5];
		argsBuffer = new ComputeBuffer(1, array2.Length * 4, ComputeBufferType.DrawIndirect);
		array2[0] = GetGrassMeshCache().GetIndexCount(0);
		array2[1] = (uint)allGrassPos.Count;
		array2[2] = GetGrassMeshCache().GetIndexStart(0);
		array2[3] = GetGrassMeshCache().GetBaseVertex(0);
		array2[4] = 0u;
		argsBuffer.SetData(array2);
		instanceCountCache = allGrassPos.Count;
		return true;
	}
}
