using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

internal class MeshGizmo : IDisposable
{
	public static readonly int vertexCountPerCube = 24;

	public Mesh mesh;

	private List<Vector3> vertices;

	private List<int> indices;

	private List<Color> colors;

	private Material wireMaterial;

	private Material dottedWireMaterial;

	private Material solidMaterial;

	public MeshGizmo(int capacity = 0)
	{
		vertices = new List<Vector3>(capacity);
		indices = new List<int>(capacity);
		colors = new List<Color>(capacity);
		mesh = new Mesh
		{
			indexFormat = IndexFormat.UInt32,
			hideFlags = HideFlags.HideAndDontSave
		};
	}

	public void Clear()
	{
		vertices.Clear();
		indices.Clear();
		colors.Clear();
	}

	public void AddWireCube(Vector3 center, Vector3 size, Color color)
	{
		Vector3 vector = size / 2f;
		Vector3 vector2 = new Vector3(vector.x, vector.y, vector.z);
		Vector3 vector3 = new Vector3(0f - vector.x, vector.y, vector.z);
		Vector3 vector4 = new Vector3(0f - vector.x, 0f - vector.y, vector.z);
		Vector3 vector5 = new Vector3(vector.x, 0f - vector.y, vector.z);
		Vector3 vector6 = new Vector3(vector.x, vector.y, 0f - vector.z);
		Vector3 vector7 = new Vector3(0f - vector.x, vector.y, 0f - vector.z);
		Vector3 vector8 = new Vector3(0f - vector.x, 0f - vector.y, 0f - vector.z);
		Vector3 vector9 = new Vector3(vector.x, 0f - vector.y, 0f - vector.z);
		AddEdge(center + vector2, center + vector3);
		AddEdge(center + vector3, center + vector4);
		AddEdge(center + vector4, center + vector5);
		AddEdge(center + vector5, center + vector2);
		AddEdge(center + vector6, center + vector7);
		AddEdge(center + vector7, center + vector8);
		AddEdge(center + vector8, center + vector9);
		AddEdge(center + vector9, center + vector6);
		AddEdge(center + vector2, center + vector6);
		AddEdge(center + vector3, center + vector7);
		AddEdge(center + vector4, center + vector8);
		AddEdge(center + vector5, center + vector9);
		void AddEdge(Vector3 p1, Vector3 p2)
		{
			vertices.Add(p1);
			vertices.Add(p2);
			indices.Add(indices.Count);
			indices.Add(indices.Count);
			colors.Add(color);
			colors.Add(color);
		}
	}

	private void DrawMesh(Matrix4x4 trs, Material mat, MeshTopology topology, CompareFunction depthTest, string gizmoName)
	{
		mesh.Clear();
		mesh.SetVertices(vertices);
		mesh.SetColors(colors);
		mesh.SetIndices(indices, topology, 0);
		mat.SetFloat("_HandleZTest", (float)depthTest);
		CommandBuffer commandBuffer = CommandBufferPool.Get(gizmoName ?? "Mesh Gizmo Rendering");
		commandBuffer.DrawMesh(mesh, trs, mat, 0, 0);
		Graphics.ExecuteCommandBuffer(commandBuffer);
	}

	public void RenderWireframe(Matrix4x4 trs, CompareFunction depthTest = CompareFunction.LessEqual, string gizmoName = null)
	{
		DrawMesh(trs, wireMaterial, MeshTopology.Lines, depthTest, gizmoName);
	}

	public void Dispose()
	{
		CoreUtils.Destroy(mesh);
	}
}
