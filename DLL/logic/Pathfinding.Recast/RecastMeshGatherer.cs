using System;
using System.Collections.Generic;
using Pathfinding.Util;
using Pathfinding.Voxels;
using UnityEngine;

namespace Pathfinding.Recast;

internal class RecastMeshGatherer
{
	private class CapsuleCache
	{
		public int rows;

		public float height;

		public Vector3[] verts;

		public int[] tris;
	}

	private readonly int terrainSampleSize;

	private readonly LayerMask mask;

	private readonly List<string> tagMask;

	private readonly float colliderRasterizeDetail;

	private readonly Bounds bounds;

	private static readonly int[] BoxColliderTris;

	private static readonly Vector3[] BoxColliderVerts;

	private List<CapsuleCache> capsuleCache;

	public RecastMeshGatherer(Bounds bounds, int terrainSampleSize, LayerMask mask, List<string> tagMask, float colliderRasterizeDetail)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		capsuleCache = new List<CapsuleCache>();
		base._002Ector();
		terrainSampleSize = Math.Max(terrainSampleSize, 1);
		this.bounds = bounds;
		this.terrainSampleSize = terrainSampleSize;
		this.mask = mask;
		this.tagMask = tagMask ?? new List<string>();
		this.colliderRasterizeDetail = colliderRasterizeDetail;
	}

	private static List<MeshFilter> FilterMeshes(MeshFilter[] meshFilters, List<string> tagMask, LayerMask layerMask)
	{
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		List<MeshFilter> list = new List<MeshFilter>(meshFilters.Length / 3);
		foreach (MeshFilter val in meshFilters)
		{
			Renderer component = ((Component)val).GetComponent<Renderer>();
			if ((Object)(object)component != (Object)null && (Object)(object)val.sharedMesh != (Object)null && component.enabled && (((1 << ((Component)val).gameObject.layer) & LayerMask.op_Implicit(layerMask)) != 0 || tagMask.Contains(((Component)val).tag)) && (Object)(object)((Component)val).GetComponent<RecastMeshObj>() == (Object)null)
			{
				list.Add(val);
			}
		}
		return list;
	}

	public void CollectSceneMeshes(List<RasterizationMesh> meshes)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_0079: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		if (tagMask.Count <= 0 && LayerMask.op_Implicit(mask) == 0)
		{
			return;
		}
		MeshFilter[] meshFilters = Object.FindObjectsOfType<MeshFilter>();
		List<MeshFilter> list = FilterMeshes(meshFilters, tagMask, mask);
		Dictionary<Mesh, Vector3[]> dictionary = new Dictionary<Mesh, Vector3[]>();
		Dictionary<Mesh, int[]> dictionary2 = new Dictionary<Mesh, int[]>();
		bool flag = false;
		for (int i = 0; i < list.Count; i++)
		{
			MeshFilter val = list[i];
			Renderer component = ((Component)val).GetComponent<Renderer>();
			if (component.isPartOfStaticBatch)
			{
				flag = true;
			}
			else
			{
				Bounds val2 = component.bounds;
				if (((Bounds)(ref val2)).Intersects(bounds))
				{
					Mesh sharedMesh = val.sharedMesh;
					RasterizationMesh rasterizationMesh;
					if (dictionary.ContainsKey(sharedMesh))
					{
						rasterizationMesh = new RasterizationMesh(dictionary[sharedMesh], dictionary2[sharedMesh], component.bounds);
					}
					else
					{
						rasterizationMesh = new RasterizationMesh(sharedMesh.vertices, sharedMesh.triangles, component.bounds);
						dictionary[sharedMesh] = rasterizationMesh.vertices;
						dictionary2[sharedMesh] = rasterizationMesh.triangles;
					}
					rasterizationMesh.matrix = component.localToWorldMatrix;
					rasterizationMesh.original = val;
					meshes.Add(rasterizationMesh);
				}
			}
			if (flag)
			{
				Debug.LogWarning((object)"Some meshes were statically batched. These meshes can not be used for navmesh calculation due to technical constraints.\nDuring runtime scripts cannot access the data of meshes which have been statically batched.\nOne way to solve this problem is to use cached startup (Save & Load tab in the inspector) to only calculate the graph when the game is not playing.");
			}
		}
	}

	public void CollectRecastMeshObjs(List<RasterizationMesh> buffer)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		List<RecastMeshObj> list = ListPool<RecastMeshObj>.Claim();
		RecastMeshObj.GetAllInBounds(list, bounds);
		Dictionary<Mesh, Vector3[]> dictionary = new Dictionary<Mesh, Vector3[]>();
		Dictionary<Mesh, int[]> dictionary2 = new Dictionary<Mesh, int[]>();
		for (int i = 0; i < list.Count; i++)
		{
			MeshFilter meshFilter = list[i].GetMeshFilter();
			Renderer val = (((Object)(object)meshFilter != (Object)null) ? ((Component)meshFilter).GetComponent<Renderer>() : null);
			if ((Object)(object)meshFilter != (Object)null && (Object)(object)val != (Object)null)
			{
				Mesh sharedMesh = meshFilter.sharedMesh;
				RasterizationMesh rasterizationMesh;
				if (dictionary.ContainsKey(sharedMesh))
				{
					rasterizationMesh = new RasterizationMesh(dictionary[sharedMesh], dictionary2[sharedMesh], val.bounds);
				}
				else
				{
					rasterizationMesh = new RasterizationMesh(sharedMesh.vertices, sharedMesh.triangles, val.bounds);
					dictionary[sharedMesh] = rasterizationMesh.vertices;
					dictionary2[sharedMesh] = rasterizationMesh.triangles;
				}
				rasterizationMesh.matrix = val.localToWorldMatrix;
				rasterizationMesh.original = meshFilter;
				rasterizationMesh.area = list[i].area;
				buffer.Add(rasterizationMesh);
				continue;
			}
			Collider collider = list[i].GetCollider();
			if ((Object)(object)collider == (Object)null)
			{
				Debug.LogError((object)("RecastMeshObject (" + ((Object)((Component)list[i]).gameObject).name + ") didn't have a collider or MeshFilter+Renderer attached"), (Object)(object)((Component)list[i]).gameObject);
				continue;
			}
			RasterizationMesh rasterizationMesh2 = RasterizeCollider(collider);
			if (rasterizationMesh2 != null)
			{
				rasterizationMesh2.area = list[i].area;
				buffer.Add(rasterizationMesh2);
			}
		}
		capsuleCache.Clear();
		ListPool<RecastMeshObj>.Release(list);
	}

	public void CollectTerrainMeshes(bool rasterizeTrees, float desiredChunkSize, List<RasterizationMesh> result)
	{
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		Terrain[] activeTerrains = Terrain.activeTerrains;
		if (activeTerrains.Length == 0)
		{
			return;
		}
		for (int i = 0; i < activeTerrains.Length; i++)
		{
			if (!((Object)(object)activeTerrains[i].terrainData == (Object)null))
			{
				GenerateTerrainChunks(activeTerrains[i], bounds, desiredChunkSize, result);
				if (rasterizeTrees)
				{
					CollectTreeMeshes(activeTerrains[i], result);
				}
			}
		}
	}

	private void GenerateTerrainChunks(Terrain terrain, Bounds bounds, float desiredChunkSize, List<RasterizationMesh> result)
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_011c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Unknown result type (might be due to invalid IL or missing references)
		//IL_0129: Unknown result type (might be due to invalid IL or missing references)
		//IL_012e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0130: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_013f: Unknown result type (might be due to invalid IL or missing references)
		//IL_014c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0154: Unknown result type (might be due to invalid IL or missing references)
		//IL_0159: Unknown result type (might be due to invalid IL or missing references)
		//IL_015e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0162: Unknown result type (might be due to invalid IL or missing references)
		//IL_016a: Unknown result type (might be due to invalid IL or missing references)
		//IL_016c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0175: Unknown result type (might be due to invalid IL or missing references)
		//IL_0180: Unknown result type (might be due to invalid IL or missing references)
		//IL_0182: Unknown result type (might be due to invalid IL or missing references)
		TerrainData terrainData = terrain.terrainData;
		if ((Object)(object)terrainData == (Object)null)
		{
			throw new ArgumentException("Terrain contains no terrain data");
		}
		Vector3 position = terrain.GetPosition();
		Vector3 val = position + terrainData.size * 0.5f;
		Bounds val2 = default(Bounds);
		((Bounds)(ref val2))._002Ector(val, terrainData.size);
		if (!((Bounds)(ref val2)).Intersects(bounds))
		{
			return;
		}
		int heightmapResolution = terrainData.heightmapResolution;
		int heightmapResolution2 = terrainData.heightmapResolution;
		float[,] heights = terrainData.GetHeights(0, 0, heightmapResolution, heightmapResolution2);
		Vector3 heightmapScale = terrainData.heightmapScale;
		heightmapScale.y = terrainData.size.y;
		int num = Mathf.CeilToInt(Mathf.Max(desiredChunkSize / (heightmapScale.x * (float)terrainSampleSize), 12f)) * terrainSampleSize;
		int num2 = Mathf.CeilToInt(Mathf.Max(desiredChunkSize / (heightmapScale.z * (float)terrainSampleSize), 12f)) * terrainSampleSize;
		for (int i = 0; i < heightmapResolution2; i += num2)
		{
			for (int j = 0; j < heightmapResolution; j += num)
			{
				int num3 = Mathf.Min(num, heightmapResolution - j);
				int num4 = Mathf.Min(num2, heightmapResolution2 - i);
				Vector3 val3 = position + new Vector3((float)i * heightmapScale.x, 0f, (float)j * heightmapScale.z);
				Vector3 val4 = position + new Vector3((float)(i + num4) * heightmapScale.x, heightmapScale.y, (float)(j + num3) * heightmapScale.z);
				Bounds val5 = default(Bounds);
				((Bounds)(ref val5)).SetMinMax(val3, val4);
				if (((Bounds)(ref val5)).Intersects(bounds))
				{
					RasterizationMesh item = GenerateHeightmapChunk(heights, heightmapScale, position, j, i, num3, num4, terrainSampleSize);
					result.Add(item);
				}
			}
		}
	}

	private static int CeilDivision(int lhs, int rhs)
	{
		return (lhs + rhs - 1) / rhs;
	}

	private RasterizationMesh GenerateHeightmapChunk(float[,] heights, Vector3 sampleSize, Vector3 offset, int x0, int z0, int width, int depth, int stride)
	{
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0171: Unknown result type (might be due to invalid IL or missing references)
		//IL_0177: Unknown result type (might be due to invalid IL or missing references)
		int num = CeilDivision(width, terrainSampleSize) + 1;
		int num2 = CeilDivision(depth, terrainSampleSize) + 1;
		int length = heights.GetLength(0);
		int length2 = heights.GetLength(1);
		int num3 = num * num2;
		Vector3[] array = ArrayPool<Vector3>.Claim(num3);
		for (int i = 0; i < num2; i++)
		{
			for (int j = 0; j < num; j++)
			{
				int num4 = Math.Min(x0 + j * stride, length - 1);
				int num5 = Math.Min(z0 + i * stride, length2 - 1);
				array[i * num + j] = new Vector3((float)num5 * sampleSize.x, heights[num4, num5] * sampleSize.y, (float)num4 * sampleSize.z) + offset;
			}
		}
		int num6 = (num - 1) * (num2 - 1) * 2 * 3;
		int[] array2 = ArrayPool<int>.Claim(num6);
		int num7 = 0;
		for (int k = 0; k < num2 - 1; k++)
		{
			for (int l = 0; l < num - 1; l++)
			{
				array2[num7] = k * num + l;
				array2[num7 + 1] = k * num + l + 1;
				array2[num7 + 2] = (k + 1) * num + l + 1;
				num7 += 3;
				array2[num7] = k * num + l;
				array2[num7 + 1] = (k + 1) * num + l + 1;
				array2[num7 + 2] = (k + 1) * num + l;
				num7 += 3;
			}
		}
		RasterizationMesh rasterizationMesh = new RasterizationMesh(array, array2, default(Bounds));
		rasterizationMesh.numVertices = num3;
		rasterizationMesh.numTriangles = num6;
		rasterizationMesh.pool = true;
		rasterizationMesh.RecalculateBounds();
		return rasterizationMesh;
	}

	private void CollectTreeMeshes(Terrain terrain, List<RasterizationMesh> result)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0112: Unknown result type (might be due to invalid IL or missing references)
		//IL_0120: Unknown result type (might be due to invalid IL or missing references)
		//IL_0122: Unknown result type (might be due to invalid IL or missing references)
		//IL_0127: Unknown result type (might be due to invalid IL or missing references)
		//IL_0129: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f1: Unknown result type (might be due to invalid IL or missing references)
		TerrainData terrainData = terrain.terrainData;
		Bounds val4 = default(Bounds);
		Vector3 val5 = default(Vector3);
		for (int i = 0; i < terrainData.treeInstances.Length; i++)
		{
			TreeInstance val = terrainData.treeInstances[i];
			TreePrototype val2 = terrainData.treePrototypes[val.prototypeIndex];
			if ((Object)(object)val2.prefab == (Object)null)
			{
				continue;
			}
			Collider component = val2.prefab.GetComponent<Collider>();
			Vector3 val3 = ((Component)terrain).transform.position + Vector3.Scale(val.position, terrainData.size);
			if ((Object)(object)component == (Object)null)
			{
				((Bounds)(ref val4))._002Ector(((Component)terrain).transform.position + Vector3.Scale(val.position, terrainData.size), new Vector3(val.widthScale, val.heightScale, val.widthScale));
				Matrix4x4 matrix = Matrix4x4.TRS(val3, Quaternion.identity, new Vector3(val.widthScale, val.heightScale, val.widthScale) * 0.5f);
				RasterizationMesh item = new RasterizationMesh(BoxColliderVerts, BoxColliderTris, val4, matrix);
				result.Add(item);
				continue;
			}
			((Vector3)(ref val5))._002Ector(val.widthScale, val.heightScale, val.widthScale);
			RasterizationMesh rasterizationMesh = RasterizeCollider(component, Matrix4x4.TRS(val3, Quaternion.identity, val5));
			if (rasterizationMesh != null)
			{
				rasterizationMesh.RecalculateBounds();
				result.Add(rasterizationMesh);
			}
		}
	}

	public void CollectColliderMeshes(List<RasterizationMesh> result)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_009d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		Bounds val = bounds;
		Vector3 center = ((Bounds)(ref val)).center;
		val = bounds;
		Vector3 size = ((Bounds)(ref val)).size;
		Collider[] array = Physics.OverlapSphere(center, ((Vector3)(ref size)).magnitude, -1, (QueryTriggerInteraction)1);
		if (tagMask.Count > 0 || LayerMask.op_Implicit(mask) != 0)
		{
			foreach (Collider val2 in array)
			{
				if ((((LayerMask.op_Implicit(mask) >> ((Component)val2).gameObject.layer) & 1) == 0 && !tagMask.Contains(((Component)val2).tag)) || !val2.enabled || val2.isTrigger)
				{
					continue;
				}
				val = val2.bounds;
				if (((Bounds)(ref val)).Intersects(bounds) && (Object)(object)((Component)val2).GetComponent<RecastMeshObj>() == (Object)null)
				{
					RasterizationMesh rasterizationMesh = RasterizeCollider(val2);
					if (rasterizationMesh != null)
					{
						result.Add(rasterizationMesh);
					}
				}
			}
		}
		capsuleCache.Clear();
	}

	private RasterizationMesh RasterizeCollider(Collider col)
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		return RasterizeCollider(col, ((Component)col).transform.localToWorldMatrix);
	}

	private RasterizationMesh RasterizeCollider(Collider col, Matrix4x4 localToWorldMatrix)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_013c: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		RasterizationMesh result = null;
		if (col is BoxCollider)
		{
			result = RasterizeBoxCollider((BoxCollider)(object)((col is BoxCollider) ? col : null), localToWorldMatrix);
		}
		else if (col is SphereCollider || col is CapsuleCollider)
		{
			SphereCollider val = (SphereCollider)(object)((col is SphereCollider) ? col : null);
			CapsuleCollider val2 = (CapsuleCollider)(object)((col is CapsuleCollider) ? col : null);
			float num = (((Object)(object)val != (Object)null) ? val.radius : val2.radius);
			float height = (((Object)(object)val != (Object)null) ? 0f : (val2.height * 0.5f / num - 1f));
			Quaternion val3 = Quaternion.identity;
			if ((Object)(object)val2 != (Object)null)
			{
				val3 = Quaternion.Euler((float)((val2.direction == 2) ? 90 : 0), 0f, (float)((val2.direction == 0) ? 90 : 0));
			}
			Matrix4x4 val4 = Matrix4x4.TRS(((Object)(object)val != (Object)null) ? val.center : val2.center, val3, Vector3.one * num);
			val4 = localToWorldMatrix * val4;
			result = RasterizeCapsuleCollider(num, height, col.bounds, val4);
		}
		else if (col is MeshCollider)
		{
			MeshCollider val5 = (MeshCollider)(object)((col is MeshCollider) ? col : null);
			if ((Object)(object)val5.sharedMesh != (Object)null)
			{
				result = new RasterizationMesh(val5.sharedMesh.vertices, val5.sharedMesh.triangles, ((Collider)val5).bounds, localToWorldMatrix);
			}
		}
		return result;
	}

	private RasterizationMesh RasterizeBoxCollider(BoxCollider collider, Matrix4x4 localToWorldMatrix)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		Matrix4x4 val = Matrix4x4.TRS(collider.center, Quaternion.identity, collider.size * 0.5f);
		val = localToWorldMatrix * val;
		return new RasterizationMesh(BoxColliderVerts, BoxColliderTris, ((Collider)collider).bounds, val);
	}

	private RasterizationMesh RasterizeCapsuleCollider(float radius, float height, Bounds bounds, Matrix4x4 localToWorldMatrix)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_02bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_016a: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_013e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0143: Unknown result type (might be due to invalid IL or missing references)
		float num = colliderRasterizeDetail;
		Vector3 val = ((Matrix4x4)(ref localToWorldMatrix)).MultiplyVector(Vector3.one);
		int num2 = Mathf.Max(4, Mathf.RoundToInt(num * Mathf.Sqrt(((Vector3)(ref val)).magnitude)));
		if (num2 > 100)
		{
			Debug.LogWarning((object)"Very large detail for some collider meshes. Consider decreasing Collider Rasterize Detail (RecastGraph)");
		}
		int num3 = num2;
		CapsuleCache capsuleCache = null;
		for (int i = 0; i < this.capsuleCache.Count; i++)
		{
			CapsuleCache capsuleCache2 = this.capsuleCache[i];
			if (capsuleCache2.rows == num2 && Mathf.Approximately(capsuleCache2.height, height))
			{
				capsuleCache = capsuleCache2;
			}
		}
		Vector3[] array;
		if (capsuleCache == null)
		{
			array = (Vector3[])(object)new Vector3[num2 * num3 + 2];
			List<int> list = new List<int>();
			array[array.Length - 1] = Vector3.up;
			for (int j = 0; j < num2; j++)
			{
				for (int k = 0; k < num3; k++)
				{
					array[k + j * num3] = new Vector3(Mathf.Cos((float)k * MathF.PI * 2f / (float)num3) * Mathf.Sin((float)j * MathF.PI / (float)(num2 - 1)), Mathf.Cos((float)j * MathF.PI / (float)(num2 - 1)) + ((j < num2 / 2) ? height : (0f - height)), Mathf.Sin((float)k * MathF.PI * 2f / (float)num3) * Mathf.Sin((float)j * MathF.PI / (float)(num2 - 1)));
				}
			}
			array[array.Length - 2] = Vector3.down;
			int num4 = 0;
			int item = num3 - 1;
			while (num4 < num3)
			{
				list.Add(array.Length - 1);
				list.Add(item);
				list.Add(num4);
				item = num4++;
			}
			for (int l = 1; l < num2; l++)
			{
				int num5 = 0;
				int num6 = num3 - 1;
				while (num5 < num3)
				{
					list.Add(l * num3 + num5);
					list.Add(l * num3 + num6);
					list.Add((l - 1) * num3 + num5);
					list.Add((l - 1) * num3 + num6);
					list.Add((l - 1) * num3 + num5);
					list.Add(l * num3 + num6);
					num6 = num5++;
				}
			}
			int num7 = 0;
			int num8 = num3 - 1;
			while (num7 < num3)
			{
				list.Add(array.Length - 2);
				list.Add((num2 - 1) * num3 + num8);
				list.Add((num2 - 1) * num3 + num7);
				num8 = num7++;
			}
			capsuleCache = new CapsuleCache();
			capsuleCache.rows = num2;
			capsuleCache.height = height;
			capsuleCache.verts = array;
			capsuleCache.tris = list.ToArray();
			this.capsuleCache.Add(capsuleCache);
		}
		array = capsuleCache.verts;
		int[] tris = capsuleCache.tris;
		return new RasterizationMesh(array, tris, bounds, localToWorldMatrix);
	}

	static RecastMeshGatherer()
	{
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		BoxColliderTris = new int[36]
		{
			-10000, -10000, -10000, -10000, -10000, -10000, -10000, -9999, -9999, -9999,
			-9999, -9999, -9998, -9998, -9998, -9997, -9997, -9997, -9996, -9996,
			-9995, -9995, -9994, -9994, -9993, -9993, -9992, -9991, -9991, -9990,
			-9989, -9989, -9988, -9987, -9986, -9986
		};
		BoxColliderVerts = (Vector3[])(object)new Vector3[8]
		{
			new Vector3(-1f, -1f, -1f),
			new Vector3(1f, -1f, -1f),
			new Vector3(1f, -1f, 1f),
			new Vector3(-1f, -1f, 1f),
			new Vector3(-1f, 1f, -1f),
			new Vector3(1f, 1f, -1f),
			new Vector3(1f, 1f, 1f),
			new Vector3(-1f, 1f, 1f)
		};
	}
}
