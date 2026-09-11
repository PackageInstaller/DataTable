using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding.Voxels;

public class Voxelize
{
	public List<RasterizationMesh> inputMeshes;

	public readonly int voxelWalkableClimb;

	public readonly uint voxelWalkableHeight;

	public readonly float cellSize;

	public readonly float cellHeight;

	public int minRegionSize;

	public int borderSize;

	public float maxEdgeLength;

	public float maxSlope;

	public RecastGraph.RelevantGraphSurfaceMode relevantGraphSurfaceMode;

	public Bounds forcedBounds;

	public VoxelArea voxelArea;

	public VoxelContourSet countourSet;

	private GraphTransform transform;

	private VoxelPolygonClipper clipper;

	public int width;

	public int depth;

	private Vector3 voxelOffset;

	public const uint NotConnected = 63u;

	private const int MaxLayers = 65535;

	private const int MaxRegions = 500;

	private const int UnwalkableArea = 0;

	private const ushort BorderReg = 32768;

	private const int RC_BORDER_VERTEX = 65536;

	private const int RC_AREA_BORDER = 131072;

	private const int VERTEX_BUCKET_COUNT = 4096;

	public const int RC_CONTOUR_TESS_WALL_EDGES = 1;

	public const int RC_CONTOUR_TESS_AREA_EDGES = 2;

	public const int RC_CONTOUR_TESS_TILE_EDGES = 4;

	private const int ContourRegMask = 65535;

	private readonly Vector3 cellScale;

	public GraphTransform transformVoxel2Graph { get; private set; }

	public void BuildContours(float maxError, int maxEdgeLength, VoxelContourSet cset, int buildFlags)
	{
		int num = voxelArea.width;
		int num2 = voxelArea.depth;
		int num3 = num * num2;
		int capacity = Mathf.Max(8, 8);
		List<VoxelContour> list = new List<VoxelContour>(capacity);
		ushort[] array = voxelArea.tmpUShortArr;
		if (array.Length < voxelArea.compactSpanCount)
		{
			array = (voxelArea.tmpUShortArr = new ushort[voxelArea.compactSpanCount]);
		}
		for (int i = 0; i < num3; i += voxelArea.width)
		{
			for (int j = 0; j < voxelArea.width; j++)
			{
				CompactVoxelCell compactVoxelCell = voxelArea.compactCells[j + i];
				int k = (int)compactVoxelCell.index;
				for (int num4 = (int)(compactVoxelCell.index + compactVoxelCell.count); k < num4; k++)
				{
					ushort num5 = 0;
					CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[k];
					if (compactVoxelSpan.reg == 0 || (compactVoxelSpan.reg & 0x8000) == 32768)
					{
						array[k] = 0;
						continue;
					}
					for (int l = 0; l < 4; l++)
					{
						int num6 = 0;
						if ((long)compactVoxelSpan.GetConnection(l) != 63)
						{
							int num7 = j + voxelArea.DirectionX[l];
							int num8 = i + voxelArea.DirectionZ[l];
							int num9 = (int)voxelArea.compactCells[num7 + num8].index + compactVoxelSpan.GetConnection(l);
							num6 = voxelArea.compactSpans[num9].reg;
						}
						if (num6 == compactVoxelSpan.reg)
						{
							num5 |= (ushort)(1 << l);
						}
					}
					array[k] = (ushort)(num5 ^ 0xF);
				}
			}
		}
		List<int> list2 = ListPool<int>.Claim(256);
		List<int> list3 = ListPool<int>.Claim(64);
		for (int m = 0; m < num3; m += voxelArea.width)
		{
			for (int n = 0; n < voxelArea.width; n++)
			{
				CompactVoxelCell compactVoxelCell2 = voxelArea.compactCells[n + m];
				int num10 = (int)compactVoxelCell2.index;
				for (int num11 = (int)(compactVoxelCell2.index + compactVoxelCell2.count); num10 < num11; num10++)
				{
					if (array[num10] == 0 || array[num10] == 15)
					{
						array[num10] = 0;
						continue;
					}
					int reg = voxelArea.compactSpans[num10].reg;
					if (reg != 0 && (reg & 0x8000) != 32768)
					{
						int area = voxelArea.areaTypes[num10];
						list2.Clear();
						list3.Clear();
						WalkContour(n, m, num10, array, list2);
						SimplifyContour(list2, list3, maxError, maxEdgeLength, buildFlags);
						RemoveDegenerateSegments(list3);
						VoxelContour item = new VoxelContour
						{
							verts = ArrayPool<int>.Claim(list3.Count)
						};
						for (int num12 = 0; num12 < list3.Count; num12++)
						{
							item.verts[num12] = list3[num12];
						}
						item.nverts = list3.Count / 4;
						item.reg = reg;
						item.area = area;
						list.Add(item);
					}
				}
			}
		}
		ListPool<int>.Release(list2);
		ListPool<int>.Release(list3);
		for (int num13 = 0; num13 < list.Count; num13++)
		{
			VoxelContour cb = list[num13];
			if (CalcAreaOfPolygon2D(cb.verts, cb.nverts) >= 0)
			{
				continue;
			}
			int num14 = -1;
			for (int num15 = 0; num15 < list.Count; num15++)
			{
				if (num13 != num15 && list[num15].nverts > 0 && list[num15].reg == cb.reg && CalcAreaOfPolygon2D(list[num15].verts, list[num15].nverts) > 0)
				{
					num14 = num15;
					break;
				}
			}
			if (num14 == -1)
			{
				Debug.LogError((object)("rcBuildContours: Could not find merge target for bad contour " + num13 + "."));
				continue;
			}
			VoxelContour ca = list[num14];
			int ia = 0;
			int ib = 0;
			GetClosestIndices(ca.verts, ca.nverts, cb.verts, cb.nverts, ref ia, ref ib);
			if (ia == -1 || ib == -1)
			{
				Debug.LogWarning((object)("rcBuildContours: Failed to find merge points for " + num13 + " and " + num14 + "."));
			}
			else if (!MergeContours(ref ca, ref cb, ia, ib))
			{
				Debug.LogWarning((object)("rcBuildContours: Failed to merge contours " + num13 + " and " + num14 + "."));
			}
			else
			{
				list[num14] = ca;
				list[num13] = cb;
			}
		}
		cset.conts = list;
	}

	private void GetClosestIndices(int[] vertsa, int nvertsa, int[] vertsb, int nvertsb, ref int ia, ref int ib)
	{
		int num = 268435455;
		ia = -1;
		ib = -1;
		for (int i = 0; i < nvertsa; i++)
		{
			int num2 = (i + 1) % nvertsa;
			int num3 = (i + nvertsa - 1) % nvertsa;
			int num4 = i * 4;
			int b = num2 * 4;
			int a = num3 * 4;
			for (int j = 0; j < nvertsb; j++)
			{
				int num5 = j * 4;
				if (Ileft(a, num4, num5, vertsa, vertsa, vertsb) && Ileft(num4, b, num5, vertsa, vertsa, vertsb))
				{
					int num6 = vertsb[num5] - vertsa[num4];
					int num7 = vertsb[num5 + 2] / voxelArea.width - vertsa[num4 + 2] / voxelArea.width;
					int num8 = num6 * num6 + num7 * num7;
					if (num8 < num)
					{
						ia = i;
						ib = j;
						num = num8;
					}
				}
			}
		}
	}

	private static void ReleaseContours(VoxelContourSet cset)
	{
		for (int i = 0; i < cset.conts.Count; i++)
		{
			VoxelContour voxelContour = cset.conts[i];
			ArrayPool<int>.Release(ref voxelContour.verts);
			ArrayPool<int>.Release(ref voxelContour.rverts);
		}
		cset.conts = null;
	}

	public static bool MergeContours(ref VoxelContour ca, ref VoxelContour cb, int ia, int ib)
	{
		int num = ca.nverts + cb.nverts + 2;
		int[] array = ArrayPool<int>.Claim(num * 4);
		int num2 = 0;
		for (int i = 0; i <= ca.nverts; i++)
		{
			int num3 = num2 * 4;
			int num4 = (ia + i) % ca.nverts * 4;
			array[num3] = ca.verts[num4];
			array[num3 + 1] = ca.verts[num4 + 1];
			array[num3 + 2] = ca.verts[num4 + 2];
			array[num3 + 3] = ca.verts[num4 + 3];
			num2++;
		}
		for (int j = 0; j <= cb.nverts; j++)
		{
			int num5 = num2 * 4;
			int num6 = (ib + j) % cb.nverts * 4;
			array[num5] = cb.verts[num6];
			array[num5 + 1] = cb.verts[num6 + 1];
			array[num5 + 2] = cb.verts[num6 + 2];
			array[num5 + 3] = cb.verts[num6 + 3];
			num2++;
		}
		ArrayPool<int>.Release(ref ca.verts);
		ArrayPool<int>.Release(ref cb.verts);
		ca.verts = array;
		ca.nverts = num2;
		cb.verts = ArrayPool<int>.Claim(0);
		cb.nverts = 0;
		return true;
	}

	public void SimplifyContour(List<int> verts, List<int> simplified, float maxError, int maxEdgeLenght, int buildFlags)
	{
		bool flag = false;
		for (int i = 0; i < verts.Count; i += 4)
		{
			if ((verts[i + 3] & 0xFFFF) != 0)
			{
				flag = true;
				break;
			}
		}
		if (flag)
		{
			int j = 0;
			for (int num = verts.Count / 4; j < num; j++)
			{
				int num2 = (j + 1) % num;
				bool flag2 = (verts[j * 4 + 3] & 0xFFFF) != (verts[num2 * 4 + 3] & 0xFFFF);
				bool flag3 = (verts[j * 4 + 3] & 0x20000) != (verts[num2 * 4 + 3] & 0x20000);
				if (flag2 | flag3)
				{
					simplified.Add(verts[j * 4]);
					simplified.Add(verts[j * 4 + 1]);
					simplified.Add(verts[j * 4 + 2]);
					simplified.Add(j);
				}
			}
		}
		if (simplified.Count == 0)
		{
			int num3 = verts[0];
			int item = verts[1];
			int num4 = verts[2];
			int item2 = 0;
			int num5 = verts[0];
			int item3 = verts[1];
			int num6 = verts[2];
			int item4 = 0;
			for (int k = 0; k < verts.Count; k += 4)
			{
				int num7 = verts[k];
				int num8 = verts[k + 1];
				int num9 = verts[k + 2];
				if (num7 < num3 || (num7 == num3 && num9 < num4))
				{
					num3 = num7;
					item = num8;
					num4 = num9;
					item2 = k / 4;
				}
				if (num7 > num5 || (num7 == num5 && num9 > num6))
				{
					num5 = num7;
					item3 = num8;
					num6 = num9;
					item4 = k / 4;
				}
			}
			simplified.Add(num3);
			simplified.Add(item);
			simplified.Add(num4);
			simplified.Add(item2);
			simplified.Add(num5);
			simplified.Add(item3);
			simplified.Add(num6);
			simplified.Add(item4);
		}
		int num10 = verts.Count / 4;
		maxError *= maxError;
		int num11 = 0;
		while (num11 < simplified.Count / 4)
		{
			int num12 = (num11 + 1) % (simplified.Count / 4);
			int a = simplified[num11 * 4];
			int a2 = simplified[num11 * 4 + 2];
			int num13 = simplified[num11 * 4 + 3];
			int b = simplified[num12 * 4];
			int b2 = simplified[num12 * 4 + 2];
			int num14 = simplified[num12 * 4 + 3];
			float num15 = 0f;
			int num16 = -1;
			int num17;
			int num18;
			int num19;
			if (b > a || (b == a && b2 > a2))
			{
				num17 = 1;
				num18 = (num13 + num17) % num10;
				num19 = num14;
			}
			else
			{
				num17 = num10 - 1;
				num18 = (num14 + num17) % num10;
				num19 = num13;
				Utility.Swap(ref a, ref b);
				Utility.Swap(ref a2, ref b2);
			}
			if ((verts[num18 * 4 + 3] & 0xFFFF) == 0 || (verts[num18 * 4 + 3] & 0x20000) == 131072)
			{
				while (num18 != num19)
				{
					float num20 = VectorMath.SqrDistancePointSegmentApproximate(verts[num18 * 4], verts[num18 * 4 + 2] / voxelArea.width, a, a2 / voxelArea.width, b, b2 / voxelArea.width);
					if (num20 > num15)
					{
						num15 = num20;
						num16 = num18;
					}
					num18 = (num18 + num17) % num10;
				}
			}
			if (num16 != -1 && num15 > maxError)
			{
				simplified.Add(0);
				simplified.Add(0);
				simplified.Add(0);
				simplified.Add(0);
				int num21 = simplified.Count / 4;
				for (int num22 = num21 - 1; num22 > num11; num22--)
				{
					simplified[num22 * 4] = simplified[(num22 - 1) * 4];
					simplified[num22 * 4 + 1] = simplified[(num22 - 1) * 4 + 1];
					simplified[num22 * 4 + 2] = simplified[(num22 - 1) * 4 + 2];
					simplified[num22 * 4 + 3] = simplified[(num22 - 1) * 4 + 3];
				}
				simplified[(num11 + 1) * 4] = verts[num16 * 4];
				simplified[(num11 + 1) * 4 + 1] = verts[num16 * 4 + 1];
				simplified[(num11 + 1) * 4 + 2] = verts[num16 * 4 + 2];
				simplified[(num11 + 1) * 4 + 3] = num16;
			}
			else
			{
				num11++;
			}
		}
		float num23 = maxEdgeLength / cellSize;
		if (num23 > 0f && (buildFlags & 7) != 0)
		{
			int num24 = 0;
			while (num24 < simplified.Count / 4 && simplified.Count / 4 <= 200)
			{
				int num25 = (num24 + 1) % (simplified.Count / 4);
				int num26 = simplified[num24 * 4];
				int num27 = simplified[num24 * 4 + 2];
				int num28 = simplified[num24 * 4 + 3];
				int num29 = simplified[num25 * 4];
				int num30 = simplified[num25 * 4 + 2];
				int num31 = simplified[num25 * 4 + 3];
				int num32 = -1;
				int num33 = (num28 + 1) % num10;
				bool flag4 = false;
				if ((buildFlags & 1) != 0 && (verts[num33 * 4 + 3] & 0xFFFF) == 0)
				{
					flag4 = true;
				}
				if ((buildFlags & 2) != 0 && (verts[num33 * 4 + 3] & 0x20000) == 131072)
				{
					flag4 = true;
				}
				if ((buildFlags & 4) != 0 && (verts[num33 * 4 + 3] & 0x8000) == 32768)
				{
					flag4 = true;
				}
				if (flag4)
				{
					int num34 = num29 - num26;
					int num35 = num30 / voxelArea.width - num27 / voxelArea.width;
					if ((float)(num34 * num34 + num35 * num35) > num23 * num23)
					{
						int num36 = ((num31 < num28) ? (num31 + num10 - num28) : (num31 - num28));
						if (num36 > 1)
						{
							num32 = ((num29 <= num26 && (num29 != num26 || num30 <= num27)) ? ((num28 + (num36 + 1) / 2) % num10) : ((num28 + num36 / 2) % num10));
						}
					}
				}
				if (num32 != -1)
				{
					simplified.AddRange(new int[4]);
					int num37 = simplified.Count / 4;
					for (int num38 = num37 - 1; num38 > num24; num38--)
					{
						simplified[num38 * 4] = simplified[(num38 - 1) * 4];
						simplified[num38 * 4 + 1] = simplified[(num38 - 1) * 4 + 1];
						simplified[num38 * 4 + 2] = simplified[(num38 - 1) * 4 + 2];
						simplified[num38 * 4 + 3] = simplified[(num38 - 1) * 4 + 3];
					}
					simplified[(num24 + 1) * 4] = verts[num32 * 4];
					simplified[(num24 + 1) * 4 + 1] = verts[num32 * 4 + 1];
					simplified[(num24 + 1) * 4 + 2] = verts[num32 * 4 + 2];
					simplified[(num24 + 1) * 4 + 3] = num32;
				}
				else
				{
					num24++;
				}
			}
		}
		for (int l = 0; l < simplified.Count / 4; l++)
		{
			int num39 = (simplified[l * 4 + 3] + 1) % num10;
			int num40 = simplified[l * 4 + 3];
			simplified[l * 4 + 3] = (verts[num39 * 4 + 3] & 0xFFFF) | (verts[num40 * 4 + 3] & 0x10000);
		}
	}

	public void WalkContour(int x, int z, int i, ushort[] flags, List<int> verts)
	{
		int j;
		for (j = 0; (flags[i] & (ushort)(1 << j)) == 0; j++)
		{
		}
		int num = j;
		int num2 = i;
		int num3 = voxelArea.areaTypes[i];
		int num4 = 0;
		while (num4++ < 40000)
		{
			if ((flags[i] & (ushort)(1 << j)) != 0)
			{
				bool isBorderVertex = false;
				bool flag = false;
				int num5 = x;
				int cornerHeight = GetCornerHeight(x, z, i, j, ref isBorderVertex);
				int num6 = z;
				switch (j)
				{
				case 0:
					num6 += voxelArea.width;
					break;
				case 1:
					num5++;
					num6 += voxelArea.width;
					break;
				case 2:
					num5++;
					break;
				}
				int num7 = 0;
				CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[i];
				if ((long)compactVoxelSpan.GetConnection(j) != 63)
				{
					int num8 = x + voxelArea.DirectionX[j];
					int num9 = z + voxelArea.DirectionZ[j];
					int num10 = (int)voxelArea.compactCells[num8 + num9].index + compactVoxelSpan.GetConnection(j);
					num7 = voxelArea.compactSpans[num10].reg;
					if (num3 != voxelArea.areaTypes[num10])
					{
						flag = true;
					}
				}
				if (isBorderVertex)
				{
					num7 |= 0x10000;
				}
				if (flag)
				{
					num7 |= 0x20000;
				}
				verts.Add(num5);
				verts.Add(cornerHeight);
				verts.Add(num6);
				verts.Add(num7);
				flags[i] = (ushort)(flags[i] & ~(1 << j));
				j = (j + 1) & 3;
			}
			else
			{
				int num11 = -1;
				int num12 = x + voxelArea.DirectionX[j];
				int num13 = z + voxelArea.DirectionZ[j];
				CompactVoxelSpan compactVoxelSpan2 = voxelArea.compactSpans[i];
				if ((long)compactVoxelSpan2.GetConnection(j) != 63)
				{
					CompactVoxelCell compactVoxelCell = voxelArea.compactCells[num12 + num13];
					num11 = (int)compactVoxelCell.index + compactVoxelSpan2.GetConnection(j);
				}
				if (num11 == -1)
				{
					Debug.LogWarning((object)"Degenerate triangles might have been generated.\nUsually this is not a problem, but if you have a static level, try to modify the graph settings slightly to avoid this edge case.");
					break;
				}
				x = num12;
				z = num13;
				i = num11;
				j = (j + 3) & 3;
			}
			if (num2 == i && num == j)
			{
				break;
			}
		}
	}

	public int GetCornerHeight(int x, int z, int i, int dir, ref bool isBorderVertex)
	{
		CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[i];
		int num = compactVoxelSpan.y;
		int num2 = (dir + 1) & 3;
		uint[] array = new uint[4]
		{
			(uint)(voxelArea.compactSpans[i].reg | (voxelArea.areaTypes[i] << 16)),
			0u,
			0u,
			0u
		};
		if ((long)compactVoxelSpan.GetConnection(dir) != 63)
		{
			int num3 = x + voxelArea.DirectionX[dir];
			int num4 = z + voxelArea.DirectionZ[dir];
			int num5 = (int)voxelArea.compactCells[num3 + num4].index + compactVoxelSpan.GetConnection(dir);
			CompactVoxelSpan compactVoxelSpan2 = voxelArea.compactSpans[num5];
			num = Math.Max(num, compactVoxelSpan2.y);
			array[1] = (uint)(compactVoxelSpan2.reg | (voxelArea.areaTypes[num5] << 16));
			if ((long)compactVoxelSpan2.GetConnection(num2) != 63)
			{
				int num6 = num3 + voxelArea.DirectionX[num2];
				int num7 = num4 + voxelArea.DirectionZ[num2];
				int num8 = (int)voxelArea.compactCells[num6 + num7].index + compactVoxelSpan2.GetConnection(num2);
				CompactVoxelSpan compactVoxelSpan3 = voxelArea.compactSpans[num8];
				num = Math.Max(num, compactVoxelSpan3.y);
				array[2] = (uint)(compactVoxelSpan3.reg | (voxelArea.areaTypes[num8] << 16));
			}
		}
		if ((long)compactVoxelSpan.GetConnection(num2) != 63)
		{
			int num9 = x + voxelArea.DirectionX[num2];
			int num10 = z + voxelArea.DirectionZ[num2];
			int num11 = (int)voxelArea.compactCells[num9 + num10].index + compactVoxelSpan.GetConnection(num2);
			CompactVoxelSpan compactVoxelSpan4 = voxelArea.compactSpans[num11];
			num = Math.Max(num, compactVoxelSpan4.y);
			array[3] = (uint)(compactVoxelSpan4.reg | (voxelArea.areaTypes[num11] << 16));
			if ((long)compactVoxelSpan4.GetConnection(dir) != 63)
			{
				int num12 = num9 + voxelArea.DirectionX[dir];
				int num13 = num10 + voxelArea.DirectionZ[dir];
				int num14 = (int)voxelArea.compactCells[num12 + num13].index + compactVoxelSpan4.GetConnection(dir);
				CompactVoxelSpan compactVoxelSpan5 = voxelArea.compactSpans[num14];
				num = Math.Max(num, compactVoxelSpan5.y);
				array[2] = (uint)(compactVoxelSpan5.reg | (voxelArea.areaTypes[num14] << 16));
			}
		}
		for (int j = 0; j < 4; j++)
		{
			int num15 = j;
			int num16 = (j + 1) & 3;
			int num17 = (j + 2) & 3;
			int num18 = (j + 3) & 3;
			bool flag = (array[num15] & array[num16] & 0x8000) != 0 && array[num15] == array[num16];
			bool flag2 = ((array[num17] | array[num18]) & 0x8000) == 0;
			bool flag3 = array[num17] >> 16 == array[num18] >> 16;
			bool flag4 = array[num15] != 0 && array[num16] != 0 && array[num17] != 0 && array[num18] != 0;
			if (flag & flag2 & flag3 & flag4)
			{
				isBorderVertex = true;
				break;
			}
		}
		return num;
	}

	public void RemoveDegenerateSegments(List<int> simplified)
	{
		for (int i = 0; i < simplified.Count / 4; i++)
		{
			int num = i + 1;
			if (num >= simplified.Count / 4)
			{
				num = 0;
			}
			if (simplified[i * 4] == simplified[num * 4] && simplified[i * 4 + 2] == simplified[num * 4 + 2])
			{
				simplified.RemoveRange(i, 4);
			}
		}
	}

	public int CalcAreaOfPolygon2D(int[] verts, int nverts)
	{
		int num = 0;
		int num2 = 0;
		int num3 = nverts - 1;
		while (num2 < nverts)
		{
			int num4 = num2 * 4;
			int num5 = num3 * 4;
			num += verts[num4] * (verts[num5 + 2] / voxelArea.width) - verts[num5] * (verts[num4 + 2] / voxelArea.width);
			num3 = num2++;
		}
		return (num + 1) / 2;
	}

	public static bool Ileft(int a, int b, int c, int[] va, int[] vb, int[] vc)
	{
		return (vb[b] - va[a]) * (vc[c + 2] - va[a + 2]) - (vc[c] - va[a]) * (vb[b + 2] - va[a + 2]) <= 0;
	}

	public static bool Diagonal(int i, int j, int n, int[] verts, int[] indices)
	{
		if (InCone(i, j, n, verts, indices))
		{
			return Diagonalie(i, j, n, verts, indices);
		}
		return false;
	}

	public static bool InCone(int i, int j, int n, int[] verts, int[] indices)
	{
		int num = (indices[i] & 0xFFFFFFF) * 4;
		int num2 = (indices[j] & 0xFFFFFFF) * 4;
		int c = (indices[Next(i, n)] & 0xFFFFFFF) * 4;
		int num3 = (indices[Prev(i, n)] & 0xFFFFFFF) * 4;
		if (LeftOn(num3, num, c, verts))
		{
			if (Left(num, num2, num3, verts))
			{
				return Left(num2, num, c, verts);
			}
			return false;
		}
		if (LeftOn(num, num2, c, verts))
		{
			return !LeftOn(num2, num, num3, verts);
		}
		return true;
	}

	public static bool Left(int a, int b, int c, int[] verts)
	{
		return Area2(a, b, c, verts) < 0;
	}

	public static bool LeftOn(int a, int b, int c, int[] verts)
	{
		return Area2(a, b, c, verts) <= 0;
	}

	public static bool Collinear(int a, int b, int c, int[] verts)
	{
		return Area2(a, b, c, verts) == 0;
	}

	public static int Area2(int a, int b, int c, int[] verts)
	{
		return (verts[b] - verts[a]) * (verts[c + 2] - verts[a + 2]) - (verts[c] - verts[a]) * (verts[b + 2] - verts[a + 2]);
	}

	private static bool Diagonalie(int i, int j, int n, int[] verts, int[] indices)
	{
		int a = (indices[i] & 0xFFFFFFF) * 4;
		int num = (indices[j] & 0xFFFFFFF) * 4;
		for (int k = 0; k < n; k++)
		{
			int num2 = Next(k, n);
			if (k != i && num2 != i && k != j && num2 != j)
			{
				int num3 = (indices[k] & 0xFFFFFFF) * 4;
				int num4 = (indices[num2] & 0xFFFFFFF) * 4;
				if (!Vequal(a, num3, verts) && !Vequal(num, num3, verts) && !Vequal(a, num4, verts) && !Vequal(num, num4, verts) && Intersect(a, num, num3, num4, verts))
				{
					return false;
				}
			}
		}
		return true;
	}

	public static bool Xorb(bool x, bool y)
	{
		return !x ^ !y;
	}

	public static bool IntersectProp(int a, int b, int c, int d, int[] verts)
	{
		if (Collinear(a, b, c, verts) || Collinear(a, b, d, verts) || Collinear(c, d, a, verts) || Collinear(c, d, b, verts))
		{
			return false;
		}
		if (Xorb(Left(a, b, c, verts), Left(a, b, d, verts)))
		{
			return Xorb(Left(c, d, a, verts), Left(c, d, b, verts));
		}
		return false;
	}

	private static bool Between(int a, int b, int c, int[] verts)
	{
		if (!Collinear(a, b, c, verts))
		{
			return false;
		}
		if (verts[a] != verts[b])
		{
			if (verts[a] > verts[c] || verts[c] > verts[b])
			{
				if (verts[a] >= verts[c])
				{
					return verts[c] >= verts[b];
				}
				return false;
			}
			return true;
		}
		if (verts[a + 2] > verts[c + 2] || verts[c + 2] > verts[b + 2])
		{
			if (verts[a + 2] >= verts[c + 2])
			{
				return verts[c + 2] >= verts[b + 2];
			}
			return false;
		}
		return true;
	}

	private static bool Intersect(int a, int b, int c, int d, int[] verts)
	{
		if (IntersectProp(a, b, c, d, verts))
		{
			return true;
		}
		if (Between(a, b, c, verts) || Between(a, b, d, verts) || Between(c, d, a, verts) || Between(c, d, b, verts))
		{
			return true;
		}
		return false;
	}

	private static bool Vequal(int a, int b, int[] verts)
	{
		if (verts[a] == verts[b])
		{
			return verts[a + 2] == verts[b + 2];
		}
		return false;
	}

	public static int Prev(int i, int n)
	{
		if (i - 1 < 0)
		{
			return n - 1;
		}
		return i - 1;
	}

	public static int Next(int i, int n)
	{
		if (i + 1 >= n)
		{
			return 0;
		}
		return i + 1;
	}

	public void BuildPolyMesh(VoxelContourSet cset, int nvp, out VoxelMesh mesh)
	{
		nvp = 3;
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		for (int i = 0; i < cset.conts.Count; i++)
		{
			if (cset.conts[i].nverts >= 3)
			{
				num += cset.conts[i].nverts;
				num2 += cset.conts[i].nverts - 2;
				num3 = Math.Max(num3, cset.conts[i].nverts);
			}
		}
		Int3[] array = ArrayPool<Int3>.Claim(num);
		int[] array2 = ArrayPool<int>.Claim(num2 * nvp);
		int[] array3 = ArrayPool<int>.Claim(num2);
		Memory.MemSet(array2, 255, 4);
		int[] indices = ArrayPool<int>.Claim(num3);
		int[] tris = ArrayPool<int>.Claim(num3 * 3);
		int num4 = 0;
		int num5 = 0;
		int num6 = 0;
		for (int j = 0; j < cset.conts.Count; j++)
		{
			VoxelContour voxelContour = cset.conts[j];
			if (voxelContour.nverts >= 3)
			{
				for (int k = 0; k < voxelContour.nverts; k++)
				{
					indices[k] = k;
					voxelContour.verts[k * 4 + 2] /= voxelArea.width;
				}
				int num7 = Triangulate(voxelContour.nverts, voxelContour.verts, ref indices, ref tris);
				int num8 = num4;
				for (int l = 0; l < num7 * 3; l++)
				{
					array2[num5] = tris[l] + num8;
					num5++;
				}
				for (int m = 0; m < num7; m++)
				{
					array3[num6] = voxelContour.area;
					num6++;
				}
				for (int n = 0; n < voxelContour.nverts; n++)
				{
					array[num4] = new Int3(voxelContour.verts[n * 4], voxelContour.verts[n * 4 + 1], voxelContour.verts[n * 4 + 2]);
					num4++;
				}
			}
		}
		mesh = new VoxelMesh
		{
			verts = Memory.ShrinkArray(array, num4),
			tris = Memory.ShrinkArray(array2, num5),
			areas = Memory.ShrinkArray(array3, num6)
		};
		ArrayPool<Int3>.Release(ref array);
		ArrayPool<int>.Release(ref array2);
		ArrayPool<int>.Release(ref array3);
		ArrayPool<int>.Release(ref indices);
		ArrayPool<int>.Release(ref tris);
	}

	private int Triangulate(int n, int[] verts, ref int[] indices, ref int[] tris)
	{
		int num = 0;
		int[] array = tris;
		int num2 = 0;
		for (int i = 0; i < n; i++)
		{
			int num3 = Next(i, n);
			int j = Next(num3, n);
			if (Diagonal(i, j, n, verts, indices))
			{
				indices[num3] |= 1073741824;
			}
		}
		while (n > 3)
		{
			int num4 = -1;
			int num5 = -1;
			for (int k = 0; k < n; k++)
			{
				int num6 = Next(k, n);
				if ((indices[num6] & 0x40000000) != 0)
				{
					int num7 = (indices[k] & 0xFFFFFFF) * 4;
					int num8 = (indices[Next(num6, n)] & 0xFFFFFFF) * 4;
					int num9 = verts[num8] - verts[num7];
					int num10 = verts[num8 + 2] - verts[num7 + 2];
					int num11 = num9 * num9 + num10 * num10;
					if (num4 < 0 || num11 < num4)
					{
						num4 = num11;
						num5 = k;
					}
				}
			}
			if (num5 == -1)
			{
				Debug.LogWarning((object)"Degenerate triangles might have been generated.\nUsually this is not a problem, but if you have a static level, try to modify the graph settings slightly to avoid this edge case.");
				return -num;
			}
			int num12 = num5;
			int num13 = Next(num12, n);
			int num14 = Next(num13, n);
			array[num2] = indices[num12] & 0xFFFFFFF;
			num2++;
			array[num2] = indices[num13] & 0xFFFFFFF;
			num2++;
			array[num2] = indices[num14] & 0xFFFFFFF;
			num2++;
			num++;
			n--;
			for (int l = num13; l < n; l++)
			{
				indices[l] = indices[l + 1];
			}
			if (num13 >= n)
			{
				num13 = 0;
			}
			num12 = Prev(num13, n);
			if (Diagonal(Prev(num12, n), num13, n, verts, indices))
			{
				indices[num12] |= 1073741824;
			}
			else
			{
				indices[num12] &= 268435455;
			}
			if (Diagonal(num12, Next(num13, n), n, verts, indices))
			{
				indices[num13] |= 1073741824;
			}
			else
			{
				indices[num13] &= 268435455;
			}
		}
		array[num2] = indices[0] & 0xFFFFFFF;
		num2++;
		array[num2] = indices[1] & 0xFFFFFFF;
		num2++;
		array[num2] = indices[2] & 0xFFFFFFF;
		num2++;
		return num + 1;
	}

	public Vector3 CompactSpanToVector(int x, int z, int i)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		return voxelOffset + new Vector3(((float)x + 0.5f) * cellSize, (float)(int)voxelArea.compactSpans[i].y * cellHeight, ((float)z + 0.5f) * cellSize);
	}

	public void VectorToIndex(Vector3 p, out int x, out int z)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		p -= voxelOffset;
		x = Mathf.RoundToInt(p.x / cellSize - 0.5f);
		z = Mathf.RoundToInt(p.z / cellSize - 0.5f);
	}

	public Voxelize(float ch, float cs, float walkableClimb, float walkableHeight, float maxSlope, float maxEdgeLength)
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		cellSize = 0.2f;
		cellHeight = 0.1f;
		minRegionSize = 100;
		this.maxEdgeLength = 20f;
		this.maxSlope = 30f;
		voxelOffset = Vector3.zero;
		base._002Ector();
		cellSize = cs;
		cellHeight = ch;
		this.maxSlope = maxSlope;
		cellScale = new Vector3(cellSize, cellHeight, cellSize);
		voxelWalkableHeight = (uint)(walkableHeight / cellHeight);
		voxelWalkableClimb = Mathf.RoundToInt(walkableClimb / cellHeight);
		this.maxEdgeLength = maxEdgeLength;
	}

	public void Init()
	{
		if (voxelArea == null || voxelArea.width != width || voxelArea.depth != depth)
		{
			voxelArea = new VoxelArea(width, depth);
		}
		else
		{
			voxelArea.Reset();
		}
	}

	public void VoxelizeInput(GraphTransform graphTransform, Bounds graphSpaceBounds)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_015a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0193: Unknown result type (might be due to invalid IL or missing references)
		//IL_0198: Unknown result type (might be due to invalid IL or missing references)
		//IL_019d: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_01cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_01dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0204: Unknown result type (might be due to invalid IL or missing references)
		//IL_020b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0212: Unknown result type (might be due to invalid IL or missing references)
		//IL_0221: Unknown result type (might be due to invalid IL or missing references)
		//IL_0228: Unknown result type (might be due to invalid IL or missing references)
		//IL_022f: Unknown result type (might be due to invalid IL or missing references)
		//IL_023e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0245: Unknown result type (might be due to invalid IL or missing references)
		//IL_024c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0261: Unknown result type (might be due to invalid IL or missing references)
		//IL_0268: Unknown result type (might be due to invalid IL or missing references)
		//IL_026f: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fa: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0200: Unknown result type (might be due to invalid IL or missing references)
		//IL_0202: Unknown result type (might be due to invalid IL or missing references)
		//IL_0314: Unknown result type (might be due to invalid IL or missing references)
		//IL_0316: Unknown result type (might be due to invalid IL or missing references)
		//IL_0318: Unknown result type (might be due to invalid IL or missing references)
		//IL_031d: Unknown result type (might be due to invalid IL or missing references)
		//IL_031f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0321: Unknown result type (might be due to invalid IL or missing references)
		//IL_0326: Unknown result type (might be due to invalid IL or missing references)
		//IL_032b: Unknown result type (might be due to invalid IL or missing references)
		//IL_032f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0334: Unknown result type (might be due to invalid IL or missing references)
		//IL_0352: Unknown result type (might be due to invalid IL or missing references)
		//IL_035b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0364: Unknown result type (might be due to invalid IL or missing references)
		Matrix4x4 val = Matrix4x4.TRS(((Bounds)(ref graphSpaceBounds)).min, Quaternion.identity, Vector3.one) * Matrix4x4.Scale(new Vector3(cellSize, cellHeight, cellSize));
		transformVoxel2Graph = new GraphTransform(val);
		transform = graphTransform * val * Matrix4x4.TRS(new Vector3(0.5f, 0f, 0.5f), Quaternion.identity, Vector3.one);
		int num = (int)(((Bounds)(ref graphSpaceBounds)).size.y / cellHeight);
		float num2 = Mathf.Cos(Mathf.Atan(Mathf.Tan(maxSlope * (MathF.PI / 180f)) * (cellSize / cellHeight)));
		float[] array = new float[9];
		float[] array2 = new float[21];
		float[] array3 = new float[21];
		float[] array4 = new float[21];
		float[] array5 = new float[21];
		if (inputMeshes == null)
		{
			throw new NullReferenceException("inputMeshes not set");
		}
		int num3 = 0;
		for (int i = 0; i < inputMeshes.Count; i++)
		{
			num3 = Math.Max(inputMeshes[i].vertices.Length, num3);
		}
		Vector3[] array6 = (Vector3[])(object)new Vector3[num3];
		for (int j = 0; j < inputMeshes.Count; j++)
		{
			RasterizationMesh rasterizationMesh = inputMeshes[j];
			Matrix4x4 matrix = rasterizationMesh.matrix;
			bool flag = VectorMath.ReversesFaceOrientations(matrix);
			Vector3[] vertices = rasterizationMesh.vertices;
			int[] triangles = rasterizationMesh.triangles;
			int numTriangles = rasterizationMesh.numTriangles;
			for (int k = 0; k < vertices.Length; k++)
			{
				array6[k] = transform.InverseTransform(((Matrix4x4)(ref matrix)).MultiplyPoint3x4(vertices[k]));
			}
			int area = rasterizationMesh.area;
			for (int l = 0; l < numTriangles; l += 3)
			{
				Vector3 val2 = array6[triangles[l]];
				Vector3 val3 = array6[triangles[l + 1]];
				Vector3 val4 = array6[triangles[l + 2]];
				if (flag)
				{
					Vector3 val5 = val2;
					val2 = val4;
					val4 = val5;
				}
				int num4 = (int)Utility.Min(val2.x, val3.x, val4.x);
				int num5 = (int)Utility.Min(val2.z, val3.z, val4.z);
				int num6 = (int)Math.Ceiling(Utility.Max(val2.x, val3.x, val4.x));
				int num7 = (int)Math.Ceiling(Utility.Max(val2.z, val3.z, val4.z));
				num4 = Mathf.Clamp(num4, 0, voxelArea.width - 1);
				num6 = Mathf.Clamp(num6, 0, voxelArea.width - 1);
				num5 = Mathf.Clamp(num5, 0, voxelArea.depth - 1);
				num7 = Mathf.Clamp(num7, 0, voxelArea.depth - 1);
				if (num4 >= voxelArea.width || num5 >= voxelArea.depth || num6 <= 0 || num7 <= 0)
				{
					continue;
				}
				Vector3 val6 = Vector3.Cross(val3 - val2, val4 - val2);
				float num8 = Vector3.Dot(((Vector3)(ref val6)).normalized, Vector3.up);
				int area2 = ((!(num8 < num2)) ? (1 + area) : 0);
				Utility.CopyVector(array, 0, val2);
				Utility.CopyVector(array, 3, val3);
				Utility.CopyVector(array, 6, val4);
				for (int m = num4; m <= num6; m++)
				{
					int num9 = clipper.ClipPolygon(array, 3, array2, 1f, (float)(-m) + 0.5f, 0);
					if (num9 < 3)
					{
						continue;
					}
					num9 = clipper.ClipPolygon(array2, num9, array3, -1f, (float)m + 0.5f, 0);
					if (num9 < 3)
					{
						continue;
					}
					float num10 = array3[2];
					float num11 = array3[2];
					for (int n = 1; n < num9; n++)
					{
						float val7 = array3[n * 3 + 2];
						num10 = Math.Min(num10, val7);
						num11 = Math.Max(num11, val7);
					}
					int num12 = Mathf.Clamp((int)Math.Round(num10), 0, voxelArea.depth - 1);
					int num13 = Mathf.Clamp((int)Math.Round(num11), 0, voxelArea.depth - 1);
					for (int num14 = num12; num14 <= num13; num14++)
					{
						int num15 = clipper.ClipPolygon(array3, num9, array4, 1f, (float)(-num14) + 0.5f, 2);
						if (num15 < 3)
						{
							continue;
						}
						num15 = clipper.ClipPolygonY(array4, num15, array5, -1f, (float)num14 + 0.5f, 2);
						if (num15 >= 3)
						{
							float num16 = array5[1];
							float num17 = array5[1];
							for (int num18 = 1; num18 < num15; num18++)
							{
								float val8 = array5[num18 * 3 + 1];
								num16 = Math.Min(num16, val8);
								num17 = Math.Max(num17, val8);
							}
							int num19 = (int)Math.Ceiling(num17);
							if (num19 >= 0 && num16 <= (float)num)
							{
								int num20 = Math.Max(0, (int)num16);
								num19 = Math.Max(num20 + 1, num19);
								voxelArea.AddLinkedSpan(num14 * voxelArea.width + m, (uint)num20, (uint)num19, area2, voxelWalkableClimb);
							}
						}
					}
				}
			}
		}
	}

	public void DebugDrawSpans()
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0102: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		int num = voxelArea.width * voxelArea.depth;
		Vector3 min = ((Bounds)(ref forcedBounds)).min;
		LinkedVoxelSpan[] linkedSpans = voxelArea.linkedSpans;
		int num2 = 0;
		int num3 = 0;
		while (num2 < num)
		{
			for (int i = 0; i < voxelArea.width; i++)
			{
				int num4 = num2 + i;
				while (num4 != -1 && linkedSpans[num4].bottom != uint.MaxValue)
				{
					uint top = linkedSpans[num4].top;
					uint num5 = ((linkedSpans[num4].next != -1) ? linkedSpans[linkedSpans[num4].next].bottom : 65536u);
					if (top > num5)
					{
						Debug.Log((object)(top + " " + num5));
						Debug.DrawLine(new Vector3((float)i * cellSize, (float)top * cellHeight, (float)num3 * cellSize) + min, new Vector3((float)i * cellSize, (float)num5 * cellHeight, (float)num3 * cellSize) + min, Color.yellow, 1f);
					}
					_ = num5 - top;
					_ = voxelWalkableHeight;
					num4 = linkedSpans[num4].next;
				}
			}
			num2 += voxelArea.width;
			num3++;
		}
	}

	public void BuildCompactField()
	{
		int spanCount = voxelArea.GetSpanCount();
		voxelArea.compactSpanCount = spanCount;
		if (voxelArea.compactSpans == null || voxelArea.compactSpans.Length < spanCount)
		{
			voxelArea.compactSpans = new CompactVoxelSpan[spanCount];
			voxelArea.areaTypes = new int[spanCount];
		}
		uint num = 0u;
		int num2 = voxelArea.width;
		int num3 = voxelArea.depth;
		int num4 = num2 * num3;
		if (voxelWalkableHeight >= 65535)
		{
			Debug.LogWarning((object)"Too high walkable height to guarantee correctness. Increase voxel height or lower walkable height.");
		}
		LinkedVoxelSpan[] linkedSpans = voxelArea.linkedSpans;
		int num5 = 0;
		int num6 = 0;
		while (num5 < num4)
		{
			for (int i = 0; i < num2; i++)
			{
				int num7 = i + num5;
				if (linkedSpans[num7].bottom == uint.MaxValue)
				{
					voxelArea.compactCells[i + num5] = new CompactVoxelCell(0u, 0u);
					continue;
				}
				uint i2 = num;
				uint num8 = 0u;
				while (num7 != -1)
				{
					if (linkedSpans[num7].area != 0)
					{
						int top = (int)linkedSpans[num7].top;
						int next = linkedSpans[num7].next;
						int num9 = (int)((next != -1) ? linkedSpans[next].bottom : 65536);
						voxelArea.compactSpans[num] = new CompactVoxelSpan((ushort)((top > 65535) ? 65535u : ((uint)top)), (num9 - top > 65535) ? 65535u : ((uint)(num9 - top)));
						voxelArea.areaTypes[num] = linkedSpans[num7].area;
						num++;
						num8++;
					}
					num7 = linkedSpans[num7].next;
				}
				voxelArea.compactCells[i + num5] = new CompactVoxelCell(i2, num8);
			}
			num5 += num2;
			num6++;
		}
	}

	public void BuildVoxelConnections()
	{
		int num = voxelArea.width * voxelArea.depth;
		CompactVoxelSpan[] compactSpans = voxelArea.compactSpans;
		CompactVoxelCell[] compactCells = voxelArea.compactCells;
		int num2 = 0;
		int num3 = 0;
		while (num2 < num)
		{
			for (int i = 0; i < voxelArea.width; i++)
			{
				CompactVoxelCell compactVoxelCell = compactCells[i + num2];
				int j = (int)compactVoxelCell.index;
				for (int num4 = (int)(compactVoxelCell.index + compactVoxelCell.count); j < num4; j++)
				{
					CompactVoxelSpan compactVoxelSpan = compactSpans[j];
					compactSpans[j].con = uint.MaxValue;
					for (int k = 0; k < 4; k++)
					{
						int num5 = i + voxelArea.DirectionX[k];
						int num6 = num2 + voxelArea.DirectionZ[k];
						if (num5 < 0 || num6 < 0 || num6 >= num || num5 >= voxelArea.width)
						{
							continue;
						}
						CompactVoxelCell compactVoxelCell2 = compactCells[num5 + num6];
						int l = (int)compactVoxelCell2.index;
						for (int num7 = (int)(compactVoxelCell2.index + compactVoxelCell2.count); l < num7; l++)
						{
							CompactVoxelSpan compactVoxelSpan2 = compactSpans[l];
							int num8 = Math.Max(compactVoxelSpan.y, compactVoxelSpan2.y);
							int num9 = Math.Min((int)(compactVoxelSpan.y + compactVoxelSpan.h), (int)(compactVoxelSpan2.y + compactVoxelSpan2.h));
							if (num9 - num8 >= voxelWalkableHeight && Math.Abs(compactVoxelSpan2.y - compactVoxelSpan.y) <= voxelWalkableClimb)
							{
								uint num10 = (uint)l - compactVoxelCell2.index;
								if (num10 <= 65535)
								{
									compactSpans[j].SetConnection(k, num10);
									break;
								}
								Debug.LogError((object)"Too many layers");
							}
						}
					}
				}
			}
			num2 += voxelArea.width;
			num3++;
		}
	}

	private void DrawLine(int a, int b, int[] indices, int[] verts, Color color)
	{
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		int num = (indices[a] & 0xFFFFFFF) * 4;
		int num2 = (indices[b] & 0xFFFFFFF) * 4;
		Debug.DrawLine(VoxelToWorld(verts[num], verts[num + 1], verts[num + 2]), VoxelToWorld(verts[num2], verts[num2 + 1], verts[num2 + 2]), color);
	}

	public Vector3 VoxelToWorld(int x, int y, int z)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		return Vector3.Scale(new Vector3((float)x, (float)y, (float)z), cellScale) + voxelOffset;
	}

	public Int3 VoxelToWorldInt3(Int3 voxelPosition)
	{
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		Int3 @int = voxelPosition * 1000;
		@int = new Int3(Mathf.RoundToInt((float)@int.x * cellScale.x), Mathf.RoundToInt((float)@int.y * cellScale.y), Mathf.RoundToInt((float)@int.z * cellScale.z));
		return @int + (Int3)voxelOffset;
	}

	private Vector3 ConvertPosWithoutOffset(int x, int y, int z)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		return Vector3.Scale(new Vector3((float)x, (float)y, (float)z / (float)voxelArea.width), cellScale) + voxelOffset;
	}

	private Vector3 ConvertPosition(int x, int z, int i)
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[i];
		return new Vector3((float)x * cellSize, (float)(int)compactVoxelSpan.y * cellHeight, (float)z / (float)voxelArea.width * cellSize) + voxelOffset;
	}

	public void ErodeWalkableArea(int radius)
	{
		ushort[] array = voxelArea.tmpUShortArr;
		if (array == null || array.Length < voxelArea.compactSpanCount)
		{
			array = (voxelArea.tmpUShortArr = new ushort[voxelArea.compactSpanCount]);
		}
		Memory.MemSet(array, ushort.MaxValue, 2);
		CalculateDistanceField(array);
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] < radius * 2)
			{
				voxelArea.areaTypes[i] = 0;
			}
		}
	}

	public void BuildDistanceField()
	{
		ushort[] array = voxelArea.tmpUShortArr;
		if (array == null || array.Length < voxelArea.compactSpanCount)
		{
			array = (voxelArea.tmpUShortArr = new ushort[voxelArea.compactSpanCount]);
		}
		Memory.MemSet(array, ushort.MaxValue, 2);
		voxelArea.maxDistance = CalculateDistanceField(array);
		ushort[] array2 = voxelArea.dist;
		if (array2 == null || array2.Length < voxelArea.compactSpanCount)
		{
			array2 = new ushort[voxelArea.compactSpanCount];
		}
		array2 = BoxBlur(array, array2);
		voxelArea.dist = array2;
	}

	[Obsolete("This function is not complete and should not be used")]
	public void ErodeVoxels(int radius)
	{
		if (radius > 255)
		{
			Debug.LogError((object)"Max Erode Radius is 255");
			radius = 255;
		}
		int num = voxelArea.width * voxelArea.depth;
		int[] array = new int[voxelArea.compactSpanCount];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = 255;
		}
		for (int j = 0; j < num; j += voxelArea.width)
		{
			for (int k = 0; k < voxelArea.width; k++)
			{
				CompactVoxelCell compactVoxelCell = voxelArea.compactCells[k + j];
				int l = (int)compactVoxelCell.index;
				for (int num2 = (int)(compactVoxelCell.index + compactVoxelCell.count); l < num2; l++)
				{
					if (voxelArea.areaTypes[l] == 0)
					{
						continue;
					}
					CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[l];
					int num3 = 0;
					for (int m = 0; m < 4; m++)
					{
						if ((long)compactVoxelSpan.GetConnection(m) != 63)
						{
							num3++;
						}
					}
					if (num3 != 4)
					{
						array[l] = 0;
					}
				}
			}
		}
	}

	public void FilterLowHeightSpans(uint voxelWalkableHeight, float cs, float ch)
	{
		int num = voxelArea.width * voxelArea.depth;
		LinkedVoxelSpan[] linkedSpans = voxelArea.linkedSpans;
		int num2 = 0;
		int num3 = 0;
		while (num2 < num)
		{
			for (int i = 0; i < voxelArea.width; i++)
			{
				int num4 = num2 + i;
				while (num4 != -1 && linkedSpans[num4].bottom != uint.MaxValue)
				{
					uint top = linkedSpans[num4].top;
					uint num5 = ((linkedSpans[num4].next != -1) ? linkedSpans[linkedSpans[num4].next].bottom : 65536u);
					if (num5 - top < voxelWalkableHeight)
					{
						linkedSpans[num4].area = 0;
					}
					num4 = linkedSpans[num4].next;
				}
			}
			num2 += voxelArea.width;
			num3++;
		}
	}

	public void FilterLedges(uint voxelWalkableHeight, int voxelWalkableClimb, float cs, float ch)
	{
		int num = voxelArea.width * voxelArea.depth;
		LinkedVoxelSpan[] linkedSpans = voxelArea.linkedSpans;
		int[] directionX = voxelArea.DirectionX;
		int[] directionZ = voxelArea.DirectionZ;
		int num2 = voxelArea.width;
		int num3 = 0;
		int num4 = 0;
		while (num3 < num)
		{
			for (int i = 0; i < num2; i++)
			{
				if (linkedSpans[i + num3].bottom == uint.MaxValue)
				{
					continue;
				}
				for (int num5 = i + num3; num5 != -1; num5 = linkedSpans[num5].next)
				{
					if (linkedSpans[num5].area != 0)
					{
						int top = (int)linkedSpans[num5].top;
						int val = (int)((linkedSpans[num5].next != -1) ? linkedSpans[linkedSpans[num5].next].bottom : 65536);
						int num6 = 65536;
						int num7 = (int)linkedSpans[num5].top;
						int num8 = num7;
						for (int j = 0; j < 4; j++)
						{
							int num9 = i + directionX[j];
							int num10 = num3 + directionZ[j];
							if (num9 < 0 || num10 < 0 || num10 >= num || num9 >= num2)
							{
								linkedSpans[num5].area = 0;
								break;
							}
							int num11 = num9 + num10;
							int num12 = -voxelWalkableClimb;
							int val2 = (int)((linkedSpans[num11].bottom != uint.MaxValue) ? linkedSpans[num11].bottom : 65536);
							if (Math.Min(val, val2) - Math.Max(top, num12) > voxelWalkableHeight)
							{
								num6 = Math.Min(num6, num12 - top);
							}
							if (linkedSpans[num11].bottom == uint.MaxValue)
							{
								continue;
							}
							for (int num13 = num11; num13 != -1; num13 = linkedSpans[num13].next)
							{
								num12 = (int)linkedSpans[num13].top;
								val2 = (int)((linkedSpans[num13].next != -1) ? linkedSpans[linkedSpans[num13].next].bottom : 65536);
								if (Math.Min(val, val2) - Math.Max(top, num12) > voxelWalkableHeight)
								{
									num6 = Math.Min(num6, num12 - top);
									if (Math.Abs(num12 - top) <= voxelWalkableClimb)
									{
										if (num12 < num7)
										{
											num7 = num12;
										}
										if (num12 > num8)
										{
											num8 = num12;
										}
									}
								}
							}
						}
						if (num6 < -voxelWalkableClimb || num8 - num7 > voxelWalkableClimb)
						{
							linkedSpans[num5].area = 0;
						}
					}
				}
			}
			num3 += num2;
			num4++;
		}
	}

	public ushort[] ExpandRegions(int maxIterations, uint level, ushort[] srcReg, ushort[] srcDist, ushort[] dstReg, ushort[] dstDist, List<int> stack)
	{
		int num = voxelArea.width;
		int num2 = voxelArea.depth;
		int num3 = num * num2;
		stack.Clear();
		int num4 = 0;
		int num5 = 0;
		while (num4 < num3)
		{
			for (int i = 0; i < voxelArea.width; i++)
			{
				CompactVoxelCell compactVoxelCell = voxelArea.compactCells[num4 + i];
				int j = (int)compactVoxelCell.index;
				for (int num6 = (int)(compactVoxelCell.index + compactVoxelCell.count); j < num6; j++)
				{
					if (voxelArea.dist[j] >= level && srcReg[j] == 0 && voxelArea.areaTypes[j] != 0)
					{
						stack.Add(i);
						stack.Add(num4);
						stack.Add(j);
					}
				}
			}
			num4 += num;
			num5++;
		}
		int num7 = 0;
		int count = stack.Count;
		if (count > 0)
		{
			while (true)
			{
				int num8 = 0;
				Buffer.BlockCopy(srcReg, 0, dstReg, 0, srcReg.Length * 2);
				Buffer.BlockCopy(srcDist, 0, dstDist, 0, dstDist.Length * 2);
				for (int k = 0; k < count && k < count; k += 3)
				{
					int num9 = stack[k];
					int num10 = stack[k + 1];
					int num11 = stack[k + 2];
					if (num11 < 0)
					{
						num8++;
						continue;
					}
					ushort num12 = srcReg[num11];
					ushort num13 = ushort.MaxValue;
					CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[num11];
					int num14 = voxelArea.areaTypes[num11];
					for (int l = 0; l < 4; l++)
					{
						if ((long)compactVoxelSpan.GetConnection(l) != 63)
						{
							int num15 = num9 + voxelArea.DirectionX[l];
							int num16 = num10 + voxelArea.DirectionZ[l];
							int num17 = (int)voxelArea.compactCells[num15 + num16].index + compactVoxelSpan.GetConnection(l);
							if (num14 == voxelArea.areaTypes[num17] && srcReg[num17] > 0 && (srcReg[num17] & 0x8000) == 0 && srcDist[num17] + 2 < num13)
							{
								num12 = srcReg[num17];
								num13 = (ushort)(srcDist[num17] + 2);
							}
						}
					}
					if (num12 != 0)
					{
						stack[k + 2] = -1;
						dstReg[num11] = num12;
						dstDist[num11] = num13;
					}
					else
					{
						num8++;
					}
				}
				ushort[] array = srcReg;
				srcReg = dstReg;
				dstReg = array;
				array = srcDist;
				srcDist = dstDist;
				dstDist = array;
				if (num8 * 3 >= count)
				{
					break;
				}
				if (level != 0)
				{
					num7++;
					if (num7 >= maxIterations)
					{
						break;
					}
				}
			}
		}
		return srcReg;
	}

	public bool FloodRegion(int x, int z, int i, uint level, ushort r, ushort[] srcReg, ushort[] srcDist, List<int> stack)
	{
		int num = voxelArea.areaTypes[i];
		stack.Clear();
		stack.Add(x);
		stack.Add(z);
		stack.Add(i);
		srcReg[i] = r;
		srcDist[i] = 0;
		int num2 = (int)((level >= 2) ? (level - 2) : 0);
		int num3 = 0;
		while (stack.Count > 0)
		{
			int num4 = stack[stack.Count - 1];
			stack.RemoveAt(stack.Count - 1);
			int num5 = stack[stack.Count - 1];
			stack.RemoveAt(stack.Count - 1);
			int num6 = stack[stack.Count - 1];
			stack.RemoveAt(stack.Count - 1);
			CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[num4];
			ushort num7 = 0;
			for (int j = 0; j < 4; j++)
			{
				if ((long)compactVoxelSpan.GetConnection(j) == 63)
				{
					continue;
				}
				int num8 = num6 + voxelArea.DirectionX[j];
				int num9 = num5 + voxelArea.DirectionZ[j];
				int num10 = (int)voxelArea.compactCells[num8 + num9].index + compactVoxelSpan.GetConnection(j);
				if (voxelArea.areaTypes[num10] != num)
				{
					continue;
				}
				ushort num11 = srcReg[num10];
				if ((num11 & 0x8000) == 32768)
				{
					continue;
				}
				if (num11 != 0 && num11 != r)
				{
					num7 = num11;
					break;
				}
				CompactVoxelSpan compactVoxelSpan2 = voxelArea.compactSpans[num10];
				int num12 = (j + 1) & 3;
				if ((long)compactVoxelSpan2.GetConnection(num12) == 63)
				{
					continue;
				}
				int num13 = num8 + voxelArea.DirectionX[num12];
				int num14 = num9 + voxelArea.DirectionZ[num12];
				int num15 = (int)voxelArea.compactCells[num13 + num14].index + compactVoxelSpan2.GetConnection(num12);
				if (voxelArea.areaTypes[num15] == num)
				{
					ushort num16 = srcReg[num15];
					if (num16 != 0 && num16 != r)
					{
						num7 = num16;
						break;
					}
				}
			}
			if (num7 != 0)
			{
				srcReg[num4] = 0;
				continue;
			}
			num3++;
			for (int k = 0; k < 4; k++)
			{
				if ((long)compactVoxelSpan.GetConnection(k) != 63)
				{
					int num17 = num6 + voxelArea.DirectionX[k];
					int num18 = num5 + voxelArea.DirectionZ[k];
					int num19 = (int)voxelArea.compactCells[num17 + num18].index + compactVoxelSpan.GetConnection(k);
					if (voxelArea.areaTypes[num19] == num && voxelArea.dist[num19] >= num2 && srcReg[num19] == 0)
					{
						srcReg[num19] = r;
						srcDist[num19] = 0;
						stack.Add(num17);
						stack.Add(num18);
						stack.Add(num19);
					}
				}
			}
		}
		return num3 > 0;
	}

	public void MarkRectWithRegion(int minx, int maxx, int minz, int maxz, ushort region, ushort[] srcReg)
	{
		int num = maxz * voxelArea.width;
		for (int i = minz * voxelArea.width; i < num; i += voxelArea.width)
		{
			for (int j = minx; j < maxx; j++)
			{
				CompactVoxelCell compactVoxelCell = voxelArea.compactCells[i + j];
				int k = (int)compactVoxelCell.index;
				for (int num2 = (int)(compactVoxelCell.index + compactVoxelCell.count); k < num2; k++)
				{
					if (voxelArea.areaTypes[k] != 0)
					{
						srcReg[k] = region;
					}
				}
			}
		}
	}

	public ushort CalculateDistanceField(ushort[] src)
	{
		int num = voxelArea.width * voxelArea.depth;
		for (int i = 0; i < num; i += voxelArea.width)
		{
			for (int j = 0; j < voxelArea.width; j++)
			{
				CompactVoxelCell compactVoxelCell = voxelArea.compactCells[j + i];
				int k = (int)compactVoxelCell.index;
				for (int num2 = (int)(compactVoxelCell.index + compactVoxelCell.count); k < num2; k++)
				{
					CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[k];
					int num3 = 0;
					for (int l = 0; l < 4 && (long)compactVoxelSpan.GetConnection(l) != 63; l++)
					{
						num3++;
					}
					if (num3 != 4)
					{
						src[k] = 0;
					}
				}
			}
		}
		for (int m = 0; m < num; m += voxelArea.width)
		{
			for (int n = 0; n < voxelArea.width; n++)
			{
				CompactVoxelCell compactVoxelCell2 = voxelArea.compactCells[n + m];
				int num4 = (int)compactVoxelCell2.index;
				for (int num5 = (int)(compactVoxelCell2.index + compactVoxelCell2.count); num4 < num5; num4++)
				{
					CompactVoxelSpan compactVoxelSpan2 = voxelArea.compactSpans[num4];
					if ((long)compactVoxelSpan2.GetConnection(0) != 63)
					{
						int num6 = n + voxelArea.DirectionX[0];
						int num7 = m + voxelArea.DirectionZ[0];
						int num8 = (int)(voxelArea.compactCells[num6 + num7].index + compactVoxelSpan2.GetConnection(0));
						if (src[num8] + 2 < src[num4])
						{
							src[num4] = (ushort)(src[num8] + 2);
						}
						CompactVoxelSpan compactVoxelSpan3 = voxelArea.compactSpans[num8];
						if ((long)compactVoxelSpan3.GetConnection(3) != 63)
						{
							int num9 = num6 + voxelArea.DirectionX[3];
							int num10 = num7 + voxelArea.DirectionZ[3];
							int num11 = (int)(voxelArea.compactCells[num9 + num10].index + compactVoxelSpan3.GetConnection(3));
							if (src[num11] + 3 < src[num4])
							{
								src[num4] = (ushort)(src[num11] + 3);
							}
						}
					}
					if ((long)compactVoxelSpan2.GetConnection(3) == 63)
					{
						continue;
					}
					int num12 = n + voxelArea.DirectionX[3];
					int num13 = m + voxelArea.DirectionZ[3];
					int num14 = (int)(voxelArea.compactCells[num12 + num13].index + compactVoxelSpan2.GetConnection(3));
					if (src[num14] + 2 < src[num4])
					{
						src[num4] = (ushort)(src[num14] + 2);
					}
					CompactVoxelSpan compactVoxelSpan4 = voxelArea.compactSpans[num14];
					if ((long)compactVoxelSpan4.GetConnection(2) != 63)
					{
						int num15 = num12 + voxelArea.DirectionX[2];
						int num16 = num13 + voxelArea.DirectionZ[2];
						int num17 = (int)(voxelArea.compactCells[num15 + num16].index + compactVoxelSpan4.GetConnection(2));
						if (src[num17] + 3 < src[num4])
						{
							src[num4] = (ushort)(src[num17] + 3);
						}
					}
				}
			}
		}
		for (int num18 = num - voxelArea.width; num18 >= 0; num18 -= voxelArea.width)
		{
			for (int num19 = voxelArea.width - 1; num19 >= 0; num19--)
			{
				CompactVoxelCell compactVoxelCell3 = voxelArea.compactCells[num19 + num18];
				int num20 = (int)compactVoxelCell3.index;
				for (int num21 = (int)(compactVoxelCell3.index + compactVoxelCell3.count); num20 < num21; num20++)
				{
					CompactVoxelSpan compactVoxelSpan5 = voxelArea.compactSpans[num20];
					if ((long)compactVoxelSpan5.GetConnection(2) != 63)
					{
						int num22 = num19 + voxelArea.DirectionX[2];
						int num23 = num18 + voxelArea.DirectionZ[2];
						int num24 = (int)(voxelArea.compactCells[num22 + num23].index + compactVoxelSpan5.GetConnection(2));
						if (src[num24] + 2 < src[num20])
						{
							src[num20] = (ushort)(src[num24] + 2);
						}
						CompactVoxelSpan compactVoxelSpan6 = voxelArea.compactSpans[num24];
						if ((long)compactVoxelSpan6.GetConnection(1) != 63)
						{
							int num25 = num22 + voxelArea.DirectionX[1];
							int num26 = num23 + voxelArea.DirectionZ[1];
							int num27 = (int)(voxelArea.compactCells[num25 + num26].index + compactVoxelSpan6.GetConnection(1));
							if (src[num27] + 3 < src[num20])
							{
								src[num20] = (ushort)(src[num27] + 3);
							}
						}
					}
					if ((long)compactVoxelSpan5.GetConnection(1) == 63)
					{
						continue;
					}
					int num28 = num19 + voxelArea.DirectionX[1];
					int num29 = num18 + voxelArea.DirectionZ[1];
					int num30 = (int)(voxelArea.compactCells[num28 + num29].index + compactVoxelSpan5.GetConnection(1));
					if (src[num30] + 2 < src[num20])
					{
						src[num20] = (ushort)(src[num30] + 2);
					}
					CompactVoxelSpan compactVoxelSpan7 = voxelArea.compactSpans[num30];
					if ((long)compactVoxelSpan7.GetConnection(0) != 63)
					{
						int num31 = num28 + voxelArea.DirectionX[0];
						int num32 = num29 + voxelArea.DirectionZ[0];
						int num33 = (int)(voxelArea.compactCells[num31 + num32].index + compactVoxelSpan7.GetConnection(0));
						if (src[num33] + 3 < src[num20])
						{
							src[num20] = (ushort)(src[num33] + 3);
						}
					}
				}
			}
		}
		ushort num34 = 0;
		for (int num35 = 0; num35 < voxelArea.compactSpanCount; num35++)
		{
			num34 = Math.Max(src[num35], num34);
		}
		return num34;
	}

	public ushort[] BoxBlur(ushort[] src, ushort[] dst)
	{
		ushort num = 20;
		int num2 = voxelArea.width * voxelArea.depth;
		for (int num3 = num2 - voxelArea.width; num3 >= 0; num3 -= voxelArea.width)
		{
			for (int num4 = voxelArea.width - 1; num4 >= 0; num4--)
			{
				CompactVoxelCell compactVoxelCell = voxelArea.compactCells[num4 + num3];
				int i = (int)compactVoxelCell.index;
				for (int num5 = (int)(compactVoxelCell.index + compactVoxelCell.count); i < num5; i++)
				{
					CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[i];
					ushort num6 = src[i];
					if (num6 < num)
					{
						dst[i] = num6;
						continue;
					}
					int num7 = num6;
					for (int j = 0; j < 4; j++)
					{
						if ((long)compactVoxelSpan.GetConnection(j) != 63)
						{
							int num8 = num4 + voxelArea.DirectionX[j];
							int num9 = num3 + voxelArea.DirectionZ[j];
							int num10 = (int)(voxelArea.compactCells[num8 + num9].index + compactVoxelSpan.GetConnection(j));
							num7 += src[num10];
							CompactVoxelSpan compactVoxelSpan2 = voxelArea.compactSpans[num10];
							int num11 = (j + 1) & 3;
							if ((long)compactVoxelSpan2.GetConnection(num11) != 63)
							{
								int num12 = num8 + voxelArea.DirectionX[num11];
								int num13 = num9 + voxelArea.DirectionZ[num11];
								int num14 = (int)(voxelArea.compactCells[num12 + num13].index + compactVoxelSpan2.GetConnection(num11));
								num7 += src[num14];
							}
							else
							{
								num7 += num6;
							}
						}
						else
						{
							num7 += num6 * 2;
						}
					}
					dst[i] = (ushort)((float)(num7 + 5) / 9f);
				}
			}
		}
		return dst;
	}

	private void FloodOnes(List<Int3> st1, ushort[] regs, uint level, ushort reg)
	{
		for (int i = 0; i < st1.Count; i++)
		{
			int x = st1[i].x;
			int y = st1[i].y;
			int z = st1[i].z;
			regs[y] = reg;
			CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[y];
			int num = voxelArea.areaTypes[y];
			for (int j = 0; j < 4; j++)
			{
				if ((long)compactVoxelSpan.GetConnection(j) != 63)
				{
					int num2 = x + voxelArea.DirectionX[j];
					int num3 = z + voxelArea.DirectionZ[j];
					int num4 = (int)voxelArea.compactCells[num2 + num3].index + compactVoxelSpan.GetConnection(j);
					if (num == voxelArea.areaTypes[num4] && regs[num4] == 1)
					{
						regs[num4] = reg;
						st1.Add(new Int3(num2, num4, num3));
					}
				}
			}
		}
	}

	public void BuildRegions()
	{
		int num = voxelArea.width;
		int num2 = voxelArea.depth;
		int num3 = num * num2;
		int compactSpanCount = voxelArea.compactSpanCount;
		int num4 = 8;
		List<int> list = ListPool<int>.Claim(1024);
		ushort[] array = new ushort[compactSpanCount];
		ushort[] array2 = new ushort[compactSpanCount];
		ushort[] array3 = new ushort[compactSpanCount];
		ushort[] array4 = new ushort[compactSpanCount];
		ushort num5 = 2;
		MarkRectWithRegion(0, borderSize, 0, num2, (ushort)(num5 | 0x8000), array);
		num5++;
		MarkRectWithRegion(num - borderSize, num, 0, num2, (ushort)(num5 | 0x8000), array);
		num5++;
		MarkRectWithRegion(0, num, 0, borderSize, (ushort)(num5 | 0x8000), array);
		num5++;
		MarkRectWithRegion(0, num, num2 - borderSize, num2, (ushort)(num5 | 0x8000), array);
		num5++;
		uint num6 = (uint)((voxelArea.maxDistance + 1) & -2);
		int num7 = 0;
		while (num6 != 0)
		{
			num6 = ((num6 >= 2) ? (num6 - 2) : 0u);
			if (ExpandRegions(num4, num6, array, array2, array3, array4, list) != array)
			{
				ushort[] array5 = array;
				array = array3;
				array3 = array5;
				array5 = array2;
				array2 = array4;
				array4 = array5;
			}
			int num8 = 0;
			int num9 = 0;
			while (num8 < num3)
			{
				for (int i = 0; i < voxelArea.width; i++)
				{
					CompactVoxelCell compactVoxelCell = voxelArea.compactCells[num8 + i];
					int j = (int)compactVoxelCell.index;
					for (int num10 = (int)(compactVoxelCell.index + compactVoxelCell.count); j < num10; j++)
					{
						if (voxelArea.dist[j] >= num6 && array[j] == 0 && voxelArea.areaTypes[j] != 0 && FloodRegion(i, num8, j, num6, num5, array, array2, list))
						{
							num5++;
						}
					}
				}
				num8 += num;
				num9++;
			}
			num7++;
		}
		if (ExpandRegions(num4 * 8, 0u, array, array2, array3, array4, list) != array)
		{
			ushort[] array6 = array;
			array = array3;
			array3 = array6;
			array6 = array2;
			array2 = array4;
			array4 = array6;
		}
		voxelArea.maxRegions = num5;
		FilterSmallRegions(array, minRegionSize, voxelArea.maxRegions);
		for (int k = 0; k < voxelArea.compactSpanCount; k++)
		{
			voxelArea.compactSpans[k].reg = array[k];
		}
		ListPool<int>.Release(list);
	}

	private static int union_find_find(int[] arr, int x)
	{
		if (arr[x] < 0)
		{
			return x;
		}
		return arr[x] = union_find_find(arr, arr[x]);
	}

	private static void union_find_union(int[] arr, int a, int b)
	{
		a = union_find_find(arr, a);
		b = union_find_find(arr, b);
		if (a != b)
		{
			if (arr[a] > arr[b])
			{
				int num = a;
				a = b;
				b = num;
			}
			arr[a] += arr[b];
			arr[b] = a;
		}
	}

	public void FilterSmallRegions(ushort[] reg, int minRegionSize, int maxRegions)
	{
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dd: Unknown result type (might be due to invalid IL or missing references)
		RelevantGraphSurface relevantGraphSurface = RelevantGraphSurface.Root;
		bool flag = relevantGraphSurface != null && relevantGraphSurfaceMode != RecastGraph.RelevantGraphSurfaceMode.DoNotRequire;
		if (!flag && minRegionSize <= 0)
		{
			return;
		}
		int[] array = new int[maxRegions];
		ushort[] array2 = voxelArea.tmpUShortArr;
		if (array2 == null || array2.Length < maxRegions)
		{
			array2 = (voxelArea.tmpUShortArr = new ushort[maxRegions]);
		}
		Memory.MemSet(array, -1, 4);
		Memory.MemSet(array2, (ushort)0, maxRegions, 2);
		int num = array.Length;
		int num2 = voxelArea.width * voxelArea.depth;
		int num3 = 2 | ((relevantGraphSurfaceMode == RecastGraph.RelevantGraphSurfaceMode.OnlyForCompletelyInsideTile) ? 1 : 0);
		if (flag)
		{
			while (relevantGraphSurface != null)
			{
				VectorToIndex(relevantGraphSurface.Position, out var x, out var z);
				if (x < 0 || z < 0 || x >= voxelArea.width || z >= voxelArea.depth)
				{
					relevantGraphSurface = relevantGraphSurface.Next;
					continue;
				}
				int num4 = (int)((relevantGraphSurface.Position.y - voxelOffset.y) / cellHeight);
				int num5 = (int)(relevantGraphSurface.maxRange / cellHeight);
				CompactVoxelCell compactVoxelCell = voxelArea.compactCells[x + z * voxelArea.width];
				for (int i = (int)compactVoxelCell.index; i < compactVoxelCell.index + compactVoxelCell.count; i++)
				{
					CompactVoxelSpan compactVoxelSpan = voxelArea.compactSpans[i];
					if (Math.Abs(compactVoxelSpan.y - num4) <= num5 && reg[i] != 0)
					{
						array2[union_find_find(array, reg[i] & -32769)] |= 2;
					}
				}
				relevantGraphSurface = relevantGraphSurface.Next;
			}
		}
		int num6 = 0;
		int num7 = 0;
		while (num6 < num2)
		{
			for (int j = 0; j < voxelArea.width; j++)
			{
				CompactVoxelCell compactVoxelCell2 = voxelArea.compactCells[j + num6];
				for (int k = (int)compactVoxelCell2.index; k < compactVoxelCell2.index + compactVoxelCell2.count; k++)
				{
					CompactVoxelSpan compactVoxelSpan2 = voxelArea.compactSpans[k];
					int num8 = reg[k];
					if ((num8 & -32769) == 0)
					{
						continue;
					}
					if (num8 >= num)
					{
						array2[union_find_find(array, num8 & -32769)] |= 1;
						continue;
					}
					int num9 = union_find_find(array, num8);
					array[num9]--;
					for (int l = 0; l < 4; l++)
					{
						if ((long)compactVoxelSpan2.GetConnection(l) == 63)
						{
							continue;
						}
						int num10 = j + voxelArea.DirectionX[l];
						int num11 = num6 + voxelArea.DirectionZ[l];
						int num12 = (int)voxelArea.compactCells[num10 + num11].index + compactVoxelSpan2.GetConnection(l);
						int num13 = reg[num12];
						if (num8 != num13 && (num13 & -32769) != 0)
						{
							if ((num13 & 0x8000) != 0)
							{
								array2[num9] |= 1;
							}
							else
							{
								union_find_union(array, num9, num13);
							}
						}
					}
				}
			}
			num6 += voxelArea.width;
			num7++;
		}
		for (int m = 0; m < array.Length; m++)
		{
			array2[union_find_find(array, m)] |= array2[m];
		}
		for (int n = 0; n < array.Length; n++)
		{
			int num14 = union_find_find(array, n);
			if ((array2[num14] & 1) != 0)
			{
				array[num14] = -minRegionSize - 2;
			}
			if (flag && (array2[num14] & num3) == 0)
			{
				array[num14] = -1;
			}
		}
		for (int num15 = 0; num15 < voxelArea.compactSpanCount; num15++)
		{
			int num16 = reg[num15];
			if (num16 < num && array[union_find_find(array, num16)] >= -minRegionSize - 1)
			{
				reg[num15] = 0;
			}
		}
	}
}
