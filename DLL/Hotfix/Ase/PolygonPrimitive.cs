using System.Collections.Generic;
using GameFramework;
using PrimitiveDetection;
using UnityEngine;

namespace Ase;

public class PolygonPrimitive : BasePrimitive
{
	private Vector3[] TransformVers;

	public Vector3[] Vertices { get; private set; }

	public int[] verSort { get; private set; }

	public static PolygonPrimitive Create(List<Vector3> vertices, Vector3 origin, Quaternion quaternion)
	{
		PolygonPrimitive polygonPrimitive = ReferencePool.Acquire<PolygonPrimitive>();
		polygonPrimitive.Vertices = new Vector3[vertices.Count];
		polygonPrimitive.TransformVers = new Vector3[vertices.Count];
		polygonPrimitive.verSort = new int[vertices.Count];
		vertices.CopyTo(polygonPrimitive.Vertices, 0);
		polygonPrimitive.Transform.SetOrientationAndPos(quaternion, origin);
		polygonPrimitive.PolygonTransform(polygonPrimitive.Transform);
		return polygonPrimitive;
	}

	public void PolygonTransform(Matrix4 matrix)
	{
		for (int i = 0; i < Vertices.Length; i++)
		{
			TransformVers[i] = matrix.TransformInverse(Vertices[i]);
		}
		PolygonPointSort();
	}

	private void PolygonPointSort()
	{
		if (verSort.Length < 3)
		{
			for (int i = 0; i < verSort.Length; i++)
			{
				verSort[i] = i;
			}
			return;
		}
		PolyVer[] lst = new PolyVer[verSort.Length - 1];
		int num = 0;
		for (int j = 0; j < TransformVers.Length; j++)
		{
			if (TransformVers[num].x < TransformVers[j].x)
			{
				num = j;
			}
			else if (TransformVers[num].x < TransformVers[j].x && TransformVers[j].y > TransformVers[num].y)
			{
				num = j;
			}
		}
		for (int k = 0; k < TransformVers.Length; k++)
		{
			if (k == num)
			{
				continue;
			}
			if (TransformVers[k].x == TransformVers[num].x)
			{
				if (k == TransformVers.Length - 1)
				{
					lst[num] = new PolyVer
					{
						Slope = double.MaxValue,
						SortIndex = k
					};
				}
				else
				{
					lst[k] = new PolyVer
					{
						Slope = double.MaxValue,
						SortIndex = k
					};
				}
			}
			else if (k == TransformVers.Length - 1)
			{
				lst[num] = new PolyVer
				{
					Slope = (TransformVers[k].z - TransformVers[num].z) / (TransformVers[num].x - TransformVers[k].x),
					SortIndex = k
				};
			}
			else
			{
				lst[k] = new PolyVer
				{
					Slope = (TransformVers[k].z - TransformVers[num].z) / (TransformVers[num].x - TransformVers[k].x),
					SortIndex = k
				};
			}
		}
		verSort[0] = num;
		Sort(ref lst, 0, lst.Length - 1);
		for (int l = 0; l < lst.Length; l++)
		{
			verSort[l + 1] = lst[l].SortIndex;
		}
	}

	private void Sort(ref PolyVer[] lst, int start, int end)
	{
		if (start < end)
		{
			int num = UnitSort(ref lst, start, end);
			Sort(ref lst, start, num - 1);
			Sort(ref lst, num + 1, end);
		}
	}

	private int UnitSort(ref PolyVer[] l1, int start, int end)
	{
		PolyVer polyVer = l1[start];
		while (start != end)
		{
			while (start < end && l1[end].CompareTo(polyVer) >= 0)
			{
				end--;
			}
			l1[start].Copy(l1[end]);
			while (start < end && l1[start].CompareTo(polyVer) < 0)
			{
				start++;
			}
			l1[end].Copy(l1[start]);
		}
		l1[start] = polyVer;
		return start;
	}

	public void XAxisSymmetric()
	{
		for (int i = 0; i < TransformVers.Length; i++)
		{
			TransformVers[i] = PrimitiveExtension.symmetricMatrix * TransformVers[i];
			Vertices[i] = Transform.Transform(TransformVers[i]);
		}
	}

	public override bool InternalCheckPrimitive()
	{
		return true;
	}

	public override void OnDispose()
	{
		ReferencePool.Release(this);
	}

	public override void Clear()
	{
		base.Clear();
		Vertices = null;
		TransformVers = null;
		verSort = null;
	}
}
