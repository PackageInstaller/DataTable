using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding.Util;

public class RetainedGizmos
{
	public struct Hasher
	{
		private ulong hash;

		private bool includePathSearchInfo;

		private PathHandler debugData;

		public ulong Hash => hash;

		public Hasher(AstarPath active)
		{
			hash = 0uL;
			debugData = active.debugPathData;
			includePathSearchInfo = debugData != null && (active.debugMode == GraphDebugMode.F || active.debugMode == GraphDebugMode.G || active.debugMode == GraphDebugMode.H || active.showSearchTree);
			AddHash((int)active.debugMode);
			AddHash(active.debugFloor.GetHashCode());
			AddHash(active.debugRoof.GetHashCode());
		}

		public void AddHash(int hash)
		{
			this.hash = (1572869 * this.hash) ^ (ulong)hash;
		}

		public void HashNode(GraphNode node)
		{
			AddHash(node.GetGizmoHashCode());
			if (includePathSearchInfo)
			{
				PathNode pathNode = debugData.GetPathNode(node.NodeIndex);
				AddHash(pathNode.pathID);
				AddHash((pathNode.pathID == debugData.PathID) ? 1 : 0);
				AddHash((int)pathNode.F);
			}
		}
	}

	public class Builder : IAstarPooledObject
	{
		private List<Vector3> lines = new List<Vector3>();

		private List<Color32> lineColors = new List<Color32>();

		private List<Mesh> meshes = new List<Mesh>();

		public void DrawMesh(RetainedGizmos gizmos, Vector3[] vertices, List<int> triangles, Color[] colors)
		{
			Mesh mesh = gizmos.GetMesh();
			mesh.vertices = vertices;
			mesh.SetTriangles(triangles, 0);
			mesh.colors = colors;
			mesh.UploadMeshData(false);
			meshes.Add(mesh);
		}

		public void DrawWireCube(GraphTransform tr, Bounds bounds, Color color)
		{
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000a: Unknown result type (might be due to invalid IL or missing references)
			//IL_000f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0012: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			//IL_001e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0024: Unknown result type (might be due to invalid IL or missing references)
			//IL_0029: Unknown result type (might be due to invalid IL or missing references)
			//IL_002f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0035: Unknown result type (might be due to invalid IL or missing references)
			//IL_003b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0041: Unknown result type (might be due to invalid IL or missing references)
			//IL_0046: Unknown result type (might be due to invalid IL or missing references)
			//IL_004b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0053: Unknown result type (might be due to invalid IL or missing references)
			//IL_0059: Unknown result type (might be due to invalid IL or missing references)
			//IL_005f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0065: Unknown result type (might be due to invalid IL or missing references)
			//IL_006a: Unknown result type (might be due to invalid IL or missing references)
			//IL_0070: Unknown result type (might be due to invalid IL or missing references)
			//IL_0076: Unknown result type (might be due to invalid IL or missing references)
			//IL_007c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0082: Unknown result type (might be due to invalid IL or missing references)
			//IL_0087: Unknown result type (might be due to invalid IL or missing references)
			//IL_008c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0094: Unknown result type (might be due to invalid IL or missing references)
			//IL_009a: Unknown result type (might be due to invalid IL or missing references)
			//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
			//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
			//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
			//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
			//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
			//IL_00c8: Unknown result type (might be due to invalid IL or missing references)
			//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
			//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
			//IL_00db: Unknown result type (might be due to invalid IL or missing references)
			//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
			//IL_00e7: Unknown result type (might be due to invalid IL or missing references)
			//IL_00ec: Unknown result type (might be due to invalid IL or missing references)
			//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
			//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
			//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
			//IL_0104: Unknown result type (might be due to invalid IL or missing references)
			//IL_0109: Unknown result type (might be due to invalid IL or missing references)
			//IL_010e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0116: Unknown result type (might be due to invalid IL or missing references)
			//IL_011c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0122: Unknown result type (might be due to invalid IL or missing references)
			//IL_0128: Unknown result type (might be due to invalid IL or missing references)
			//IL_012d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0133: Unknown result type (might be due to invalid IL or missing references)
			//IL_0139: Unknown result type (might be due to invalid IL or missing references)
			//IL_013f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0145: Unknown result type (might be due to invalid IL or missing references)
			//IL_014a: Unknown result type (might be due to invalid IL or missing references)
			//IL_014f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0157: Unknown result type (might be due to invalid IL or missing references)
			//IL_015d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0163: Unknown result type (might be due to invalid IL or missing references)
			//IL_0169: Unknown result type (might be due to invalid IL or missing references)
			//IL_016e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0174: Unknown result type (might be due to invalid IL or missing references)
			//IL_017a: Unknown result type (might be due to invalid IL or missing references)
			//IL_0180: Unknown result type (might be due to invalid IL or missing references)
			//IL_0186: Unknown result type (might be due to invalid IL or missing references)
			//IL_018b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0190: Unknown result type (might be due to invalid IL or missing references)
			//IL_0198: Unknown result type (might be due to invalid IL or missing references)
			//IL_019e: Unknown result type (might be due to invalid IL or missing references)
			//IL_01a4: Unknown result type (might be due to invalid IL or missing references)
			//IL_01aa: Unknown result type (might be due to invalid IL or missing references)
			//IL_01af: Unknown result type (might be due to invalid IL or missing references)
			//IL_01b5: Unknown result type (might be due to invalid IL or missing references)
			//IL_01bb: Unknown result type (might be due to invalid IL or missing references)
			//IL_01c1: Unknown result type (might be due to invalid IL or missing references)
			//IL_01c7: Unknown result type (might be due to invalid IL or missing references)
			//IL_01cc: Unknown result type (might be due to invalid IL or missing references)
			//IL_01d1: Unknown result type (might be due to invalid IL or missing references)
			//IL_01d9: Unknown result type (might be due to invalid IL or missing references)
			//IL_01df: Unknown result type (might be due to invalid IL or missing references)
			//IL_01e5: Unknown result type (might be due to invalid IL or missing references)
			//IL_01eb: Unknown result type (might be due to invalid IL or missing references)
			//IL_01f0: Unknown result type (might be due to invalid IL or missing references)
			//IL_01f6: Unknown result type (might be due to invalid IL or missing references)
			//IL_01fc: Unknown result type (might be due to invalid IL or missing references)
			//IL_0202: Unknown result type (might be due to invalid IL or missing references)
			//IL_0208: Unknown result type (might be due to invalid IL or missing references)
			//IL_020d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0212: Unknown result type (might be due to invalid IL or missing references)
			//IL_021a: Unknown result type (might be due to invalid IL or missing references)
			//IL_0220: Unknown result type (might be due to invalid IL or missing references)
			//IL_0226: Unknown result type (might be due to invalid IL or missing references)
			//IL_022c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0231: Unknown result type (might be due to invalid IL or missing references)
			//IL_0237: Unknown result type (might be due to invalid IL or missing references)
			//IL_023d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0243: Unknown result type (might be due to invalid IL or missing references)
			//IL_0249: Unknown result type (might be due to invalid IL or missing references)
			//IL_024e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0253: Unknown result type (might be due to invalid IL or missing references)
			//IL_025b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0261: Unknown result type (might be due to invalid IL or missing references)
			//IL_0267: Unknown result type (might be due to invalid IL or missing references)
			//IL_026d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0272: Unknown result type (might be due to invalid IL or missing references)
			//IL_0278: Unknown result type (might be due to invalid IL or missing references)
			//IL_027e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0284: Unknown result type (might be due to invalid IL or missing references)
			//IL_028a: Unknown result type (might be due to invalid IL or missing references)
			//IL_028f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0294: Unknown result type (might be due to invalid IL or missing references)
			//IL_029c: Unknown result type (might be due to invalid IL or missing references)
			//IL_02a2: Unknown result type (might be due to invalid IL or missing references)
			//IL_02a8: Unknown result type (might be due to invalid IL or missing references)
			//IL_02ae: Unknown result type (might be due to invalid IL or missing references)
			//IL_02b3: Unknown result type (might be due to invalid IL or missing references)
			//IL_02b9: Unknown result type (might be due to invalid IL or missing references)
			//IL_02bf: Unknown result type (might be due to invalid IL or missing references)
			//IL_02c5: Unknown result type (might be due to invalid IL or missing references)
			//IL_02cb: Unknown result type (might be due to invalid IL or missing references)
			//IL_02d0: Unknown result type (might be due to invalid IL or missing references)
			//IL_02d5: Unknown result type (might be due to invalid IL or missing references)
			//IL_02dd: Unknown result type (might be due to invalid IL or missing references)
			//IL_02e3: Unknown result type (might be due to invalid IL or missing references)
			//IL_02e9: Unknown result type (might be due to invalid IL or missing references)
			//IL_02ef: Unknown result type (might be due to invalid IL or missing references)
			//IL_02f4: Unknown result type (might be due to invalid IL or missing references)
			//IL_02fa: Unknown result type (might be due to invalid IL or missing references)
			//IL_0300: Unknown result type (might be due to invalid IL or missing references)
			//IL_0306: Unknown result type (might be due to invalid IL or missing references)
			//IL_030c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0311: Unknown result type (might be due to invalid IL or missing references)
			//IL_0316: Unknown result type (might be due to invalid IL or missing references)
			Vector3 min = ((Bounds)(ref bounds)).min;
			Vector3 max = ((Bounds)(ref bounds)).max;
			DrawLine(tr.Transform(new Vector3(min.x, min.y, min.z)), tr.Transform(new Vector3(max.x, min.y, min.z)), color);
			DrawLine(tr.Transform(new Vector3(max.x, min.y, min.z)), tr.Transform(new Vector3(max.x, min.y, max.z)), color);
			DrawLine(tr.Transform(new Vector3(max.x, min.y, max.z)), tr.Transform(new Vector3(min.x, min.y, max.z)), color);
			DrawLine(tr.Transform(new Vector3(min.x, min.y, max.z)), tr.Transform(new Vector3(min.x, min.y, min.z)), color);
			DrawLine(tr.Transform(new Vector3(min.x, max.y, min.z)), tr.Transform(new Vector3(max.x, max.y, min.z)), color);
			DrawLine(tr.Transform(new Vector3(max.x, max.y, min.z)), tr.Transform(new Vector3(max.x, max.y, max.z)), color);
			DrawLine(tr.Transform(new Vector3(max.x, max.y, max.z)), tr.Transform(new Vector3(min.x, max.y, max.z)), color);
			DrawLine(tr.Transform(new Vector3(min.x, max.y, max.z)), tr.Transform(new Vector3(min.x, max.y, min.z)), color);
			DrawLine(tr.Transform(new Vector3(min.x, min.y, min.z)), tr.Transform(new Vector3(min.x, max.y, min.z)), color);
			DrawLine(tr.Transform(new Vector3(max.x, min.y, min.z)), tr.Transform(new Vector3(max.x, max.y, min.z)), color);
			DrawLine(tr.Transform(new Vector3(max.x, min.y, max.z)), tr.Transform(new Vector3(max.x, max.y, max.z)), color);
			DrawLine(tr.Transform(new Vector3(min.x, min.y, max.z)), tr.Transform(new Vector3(min.x, max.y, max.z)), color);
		}

		public void DrawLine(Vector3 start, Vector3 end, Color color)
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_0012: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			//IL_0019: Unknown result type (might be due to invalid IL or missing references)
			//IL_001e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0025: Unknown result type (might be due to invalid IL or missing references)
			//IL_0031: Unknown result type (might be due to invalid IL or missing references)
			lines.Add(start);
			lines.Add(end);
			Color32 item = Color32.op_Implicit(color);
			lineColors.Add(item);
			lineColors.Add(item);
		}

		public void Submit(RetainedGizmos gizmos, Hasher hasher)
		{
			SubmitLines(gizmos, hasher.Hash);
			SubmitMeshes(gizmos, hasher.Hash);
		}

		private void SubmitMeshes(RetainedGizmos gizmos, ulong hash)
		{
			for (int i = 0; i < meshes.Count; i++)
			{
				gizmos.meshes.Add(new MeshWithHash
				{
					hash = hash,
					mesh = meshes[i],
					lines = false
				});
				gizmos.existingHashes.Add(hash);
			}
		}

		private void SubmitLines(RetainedGizmos gizmos, ulong hash)
		{
			//IL_008a: Unknown result type (might be due to invalid IL or missing references)
			//IL_008f: Unknown result type (might be due to invalid IL or missing references)
			//IL_0093: Unknown result type (might be due to invalid IL or missing references)
			//IL_009c: Unknown result type (might be due to invalid IL or missing references)
			//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
			//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
			//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
			//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
			//IL_010a: Unknown result type (might be due to invalid IL or missing references)
			//IL_0117: Unknown result type (might be due to invalid IL or missing references)
			//IL_011c: Unknown result type (might be due to invalid IL or missing references)
			//IL_0121: Unknown result type (might be due to invalid IL or missing references)
			//IL_0125: Unknown result type (might be due to invalid IL or missing references)
			//IL_012e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0137: Unknown result type (might be due to invalid IL or missing references)
			//IL_0140: Unknown result type (might be due to invalid IL or missing references)
			int num = (lines.Count + 32766 - 1) / 32766;
			for (int i = 0; i < num; i++)
			{
				int num2 = 32766 * i;
				int num3 = Mathf.Min(num2 + 32766, lines.Count);
				int num4 = num3 - num2;
				List<Vector3> list = ListPool<Vector3>.Claim(num4 * 2);
				List<Color32> list2 = ListPool<Color32>.Claim(num4 * 2);
				List<Vector3> list3 = ListPool<Vector3>.Claim(num4 * 2);
				List<Vector2> list4 = ListPool<Vector2>.Claim(num4 * 2);
				List<int> list5 = ListPool<int>.Claim(num4 * 3);
				for (int j = num2; j < num3; j++)
				{
					Vector3 item = lines[j];
					list.Add(item);
					list.Add(item);
					Color32 item2 = lineColors[j];
					list2.Add(item2);
					list2.Add(item2);
					list4.Add(new Vector2(0f, 0f));
					list4.Add(new Vector2(1f, 0f));
				}
				for (int k = num2; k < num3; k += 2)
				{
					Vector3 item3 = lines[k + 1] - lines[k];
					list3.Add(item3);
					list3.Add(item3);
					list3.Add(item3);
					list3.Add(item3);
				}
				int num5 = 0;
				int num6 = 0;
				while (num5 < num4 * 3)
				{
					list5.Add(num6);
					list5.Add(num6 + 1);
					list5.Add(num6 + 2);
					list5.Add(num6 + 1);
					list5.Add(num6 + 3);
					list5.Add(num6 + 2);
					num5 += 6;
					num6 += 4;
				}
				Mesh mesh = gizmos.GetMesh();
				mesh.SetVertices(list);
				mesh.SetTriangles(list5, 0);
				mesh.SetColors(list2);
				mesh.SetNormals(list3);
				mesh.SetUVs(0, list4);
				mesh.UploadMeshData(false);
				ListPool<Vector3>.Release(list);
				ListPool<Color32>.Release(list2);
				ListPool<Vector3>.Release(list3);
				ListPool<Vector2>.Release(list4);
				ListPool<int>.Release(list5);
				gizmos.meshes.Add(new MeshWithHash
				{
					hash = hash,
					mesh = mesh,
					lines = true
				});
				gizmos.existingHashes.Add(hash);
			}
		}

		void IAstarPooledObject.OnEnterPool()
		{
			lines.Clear();
			lineColors.Clear();
			meshes.Clear();
		}
	}

	private struct MeshWithHash
	{
		public ulong hash;

		public Mesh mesh;

		public bool lines;
	}

	private List<MeshWithHash> meshes = new List<MeshWithHash>();

	private HashSet<ulong> usedHashes = new HashSet<ulong>();

	private HashSet<ulong> existingHashes = new HashSet<ulong>();

	private Stack<Mesh> cachedMeshes = new Stack<Mesh>();

	public Material surfaceMaterial;

	public Material lineMaterial;

	public GraphGizmoHelper GetSingleFrameGizmoHelper(AstarPath active)
	{
		Hasher hasher = default(Hasher);
		hasher.AddHash(Time.realtimeSinceStartup.GetHashCode());
		Draw(hasher);
		return GetGizmoHelper(active, hasher);
	}

	public GraphGizmoHelper GetGizmoHelper(AstarPath active, Hasher hasher)
	{
		GraphGizmoHelper graphGizmoHelper = ObjectPool<GraphGizmoHelper>.Claim();
		graphGizmoHelper.Init(active, hasher, this);
		return graphGizmoHelper;
	}

	private void PoolMesh(Mesh mesh)
	{
		mesh.Clear();
		cachedMeshes.Push(mesh);
	}

	private Mesh GetMesh()
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Expected O, but got Unknown
		if (cachedMeshes.Count > 0)
		{
			return cachedMeshes.Pop();
		}
		return new Mesh
		{
			hideFlags = (HideFlags)52
		};
	}

	public bool HasCachedMesh(Hasher hasher)
	{
		return existingHashes.Contains(hasher.Hash);
	}

	public bool Draw(Hasher hasher)
	{
		usedHashes.Add(hasher.Hash);
		return HasCachedMesh(hasher);
	}

	public void DrawExisting()
	{
		for (int i = 0; i < meshes.Count; i++)
		{
			usedHashes.Add(meshes[i].hash);
		}
	}

	public void FinalizeDraw()
	{
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		RemoveUnusedMeshes(meshes);
		Camera current = Camera.current;
		Plane[] array = GeometryUtility.CalculateFrustumPlanes(current);
		if ((Object)(object)surfaceMaterial == (Object)null || (Object)(object)lineMaterial == (Object)null)
		{
			return;
		}
		for (int i = 0; i <= 1; i++)
		{
			Material val = ((i == 0) ? surfaceMaterial : lineMaterial);
			for (int j = 0; j < val.passCount; j++)
			{
				val.SetPass(j);
				for (int k = 0; k < meshes.Count; k++)
				{
					if (meshes[k].lines == ((Object)(object)val == (Object)(object)lineMaterial) && GeometryUtility.TestPlanesAABB(array, meshes[k].mesh.bounds))
					{
						Graphics.DrawMeshNow(meshes[k].mesh, Matrix4x4.identity);
					}
				}
			}
		}
		usedHashes.Clear();
	}

	public void ClearCache()
	{
		usedHashes.Clear();
		RemoveUnusedMeshes(meshes);
		while (cachedMeshes.Count > 0)
		{
			Object.DestroyImmediate((Object)(object)cachedMeshes.Pop());
		}
	}

	private void RemoveUnusedMeshes(List<MeshWithHash> meshList)
	{
		int num = 0;
		int num2 = 0;
		while (num < meshList.Count)
		{
			if (num2 == meshList.Count)
			{
				num2--;
				meshList.RemoveAt(num2);
			}
			else if (usedHashes.Contains(meshList[num2].hash))
			{
				meshList[num] = meshList[num2];
				num++;
				num2++;
			}
			else
			{
				PoolMesh(meshList[num2].mesh);
				existingHashes.Remove(meshList[num2].hash);
				num2++;
			}
		}
	}
}
