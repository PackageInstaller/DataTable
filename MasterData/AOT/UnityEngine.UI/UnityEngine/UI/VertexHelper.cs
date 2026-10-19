using System;
using System.Collections.Generic;
using UnityEngine.Pool;

namespace UnityEngine.UI;

public class VertexHelper : IDisposable
{
	private List<Vector3> m_Positions;

	private List<Color32> m_Colors;

	private List<Vector4> m_Uv0S;

	private List<Vector4> m_Uv1S;

	private List<Vector4> m_Uv2S;

	private List<Vector4> m_Uv3S;

	private List<Vector3> m_Normals;

	private List<Vector4> m_Tangents;

	private List<int> m_Indices;

	private static readonly Vector4 s_DefaultTangent = new Vector4(1f, 0f, 0f, -1f);

	private static readonly Vector3 s_DefaultNormal = Vector3.back;

	private bool m_ListsInitalized;

	public int currentVertCount
	{
		get
		{
			if (m_Positions == null)
			{
				return 0;
			}
			return m_Positions.Count;
		}
	}

	public int currentIndexCount
	{
		get
		{
			if (m_Indices == null)
			{
				return 0;
			}
			return m_Indices.Count;
		}
	}

	public VertexHelper()
	{
	}

	public VertexHelper(Mesh m)
	{
		InitializeListIfRequired();
		m_Positions.AddRange(m.vertices);
		m_Colors.AddRange(m.colors32);
		List<Vector4> list = new List<Vector4>();
		m.GetUVs(0, list);
		m_Uv0S.AddRange(list);
		m.GetUVs(1, list);
		m_Uv1S.AddRange(list);
		m.GetUVs(2, list);
		m_Uv2S.AddRange(list);
		m.GetUVs(3, list);
		m_Uv3S.AddRange(list);
		m_Normals.AddRange(m.normals);
		m_Tangents.AddRange(m.tangents);
		m_Indices.AddRange(m.GetIndices(0));
	}

	private void InitializeListIfRequired()
	{
		if (!m_ListsInitalized)
		{
			m_Positions = CollectionPool<List<Vector3>, Vector3>.Get();
			m_Colors = CollectionPool<List<Color32>, Color32>.Get();
			m_Uv0S = CollectionPool<List<Vector4>, Vector4>.Get();
			m_Uv1S = CollectionPool<List<Vector4>, Vector4>.Get();
			m_Uv2S = CollectionPool<List<Vector4>, Vector4>.Get();
			m_Uv3S = CollectionPool<List<Vector4>, Vector4>.Get();
			m_Normals = CollectionPool<List<Vector3>, Vector3>.Get();
			m_Tangents = CollectionPool<List<Vector4>, Vector4>.Get();
			m_Indices = CollectionPool<List<int>, int>.Get();
			m_ListsInitalized = true;
		}
	}

	public void Dispose()
	{
		if (m_ListsInitalized)
		{
			CollectionPool<List<Vector3>, Vector3>.Release(m_Positions);
			CollectionPool<List<Color32>, Color32>.Release(m_Colors);
			CollectionPool<List<Vector4>, Vector4>.Release(m_Uv0S);
			CollectionPool<List<Vector4>, Vector4>.Release(m_Uv1S);
			CollectionPool<List<Vector4>, Vector4>.Release(m_Uv2S);
			CollectionPool<List<Vector4>, Vector4>.Release(m_Uv3S);
			CollectionPool<List<Vector3>, Vector3>.Release(m_Normals);
			CollectionPool<List<Vector4>, Vector4>.Release(m_Tangents);
			CollectionPool<List<int>, int>.Release(m_Indices);
			m_Positions = null;
			m_Colors = null;
			m_Uv0S = null;
			m_Uv1S = null;
			m_Uv2S = null;
			m_Uv3S = null;
			m_Normals = null;
			m_Tangents = null;
			m_Indices = null;
			m_ListsInitalized = false;
		}
	}

	public void Clear()
	{
		if (m_ListsInitalized)
		{
			m_Positions.Clear();
			m_Colors.Clear();
			m_Uv0S.Clear();
			m_Uv1S.Clear();
			m_Uv2S.Clear();
			m_Uv3S.Clear();
			m_Normals.Clear();
			m_Tangents.Clear();
			m_Indices.Clear();
		}
	}

	public void PopulateUIVertex(ref UIVertex vertex, int i)
	{
		InitializeListIfRequired();
		vertex.position = m_Positions[i];
		vertex.color = m_Colors[i];
		vertex.uv0 = m_Uv0S[i];
		vertex.uv1 = m_Uv1S[i];
		vertex.uv2 = m_Uv2S[i];
		vertex.uv3 = m_Uv3S[i];
		vertex.normal = m_Normals[i];
		vertex.tangent = m_Tangents[i];
	}

	public void SetUIVertex(UIVertex vertex, int i)
	{
		InitializeListIfRequired();
		m_Positions[i] = vertex.position;
		m_Colors[i] = vertex.color;
		m_Uv0S[i] = vertex.uv0;
		m_Uv1S[i] = vertex.uv1;
		m_Uv2S[i] = vertex.uv2;
		m_Uv3S[i] = vertex.uv3;
		m_Normals[i] = vertex.normal;
		m_Tangents[i] = vertex.tangent;
	}

	public void FillMesh(Mesh mesh)
	{
		InitializeListIfRequired();
		mesh.Clear();
		if (m_Positions.Count >= 65000)
		{
			throw new ArgumentException("Mesh can not have more than 65000 vertices");
		}
		mesh.SetVertices(m_Positions);
		mesh.SetColors(m_Colors);
		mesh.SetUVs(0, m_Uv0S);
		mesh.SetUVs(1, m_Uv1S);
		mesh.SetUVs(2, m_Uv2S);
		mesh.SetUVs(3, m_Uv3S);
		mesh.SetNormals(m_Normals);
		mesh.SetTangents(m_Tangents);
		mesh.SetTriangles(m_Indices, 0);
		mesh.RecalculateBounds();
	}

	public void AddVert(Vector3 position, Color32 color, Vector4 uv0, Vector4 uv1, Vector4 uv2, Vector4 uv3, Vector3 normal, Vector4 tangent)
	{
		InitializeListIfRequired();
		m_Positions.Add(position);
		m_Colors.Add(color);
		m_Uv0S.Add(uv0);
		m_Uv1S.Add(uv1);
		m_Uv2S.Add(uv2);
		m_Uv3S.Add(uv3);
		m_Normals.Add(normal);
		m_Tangents.Add(tangent);
	}

	public void AddVert(Vector3 position, Color32 color, Vector4 uv0, Vector4 uv1, Vector3 normal, Vector4 tangent)
	{
		AddVert(position, color, uv0, uv1, Vector4.zero, Vector4.zero, normal, tangent);
	}

	public void AddVert(Vector3 position, Color32 color, Vector4 uv0)
	{
		AddVert(position, color, uv0, Vector4.zero, s_DefaultNormal, s_DefaultTangent);
	}

	public void AddVert(UIVertex v)
	{
		AddVert(v.position, v.color, v.uv0, v.uv1, v.uv2, v.uv3, v.normal, v.tangent);
	}

	public void AddTriangle(int idx0, int idx1, int idx2)
	{
		InitializeListIfRequired();
		m_Indices.Add(idx0);
		m_Indices.Add(idx1);
		m_Indices.Add(idx2);
	}

	public void AddUIVertexQuad(UIVertex[] verts)
	{
		int num = currentVertCount;
		for (int i = 0; i < 4; i++)
		{
			AddVert(verts[i].position, verts[i].color, verts[i].uv0, verts[i].uv1, verts[i].normal, verts[i].tangent);
		}
		AddTriangle(num, num + 1, num + 2);
		AddTriangle(num + 2, num + 3, num);
	}

	public void AddUIVertexStream(List<UIVertex> verts, List<int> indices)
	{
		InitializeListIfRequired();
		if (verts != null)
		{
			CanvasRenderer.AddUIVertexStream(verts, m_Positions, m_Colors, m_Uv0S, m_Uv1S, m_Uv2S, m_Uv3S, m_Normals, m_Tangents);
		}
		if (indices != null)
		{
			m_Indices.AddRange(indices);
		}
	}

	public void AddUIVertexTriangleStream(List<UIVertex> verts)
	{
		if (verts != null)
		{
			InitializeListIfRequired();
			CanvasRenderer.SplitUIVertexStreams(verts, m_Positions, m_Colors, m_Uv0S, m_Uv1S, m_Uv2S, m_Uv3S, m_Normals, m_Tangents, m_Indices);
		}
	}

	public void GetUIVertexStream(List<UIVertex> stream)
	{
		if (stream != null)
		{
			InitializeListIfRequired();
			CanvasRenderer.CreateUIVertexStream(stream, m_Positions, m_Colors, m_Uv0S, m_Uv1S, m_Uv2S, m_Uv3S, m_Normals, m_Tangents, m_Indices);
		}
	}
}
