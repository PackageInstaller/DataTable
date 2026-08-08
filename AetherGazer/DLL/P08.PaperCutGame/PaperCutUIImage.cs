using UnityEngine;
using UnityEngine.UI;

public class PaperCutUIImage : Image
{
	public Texture texture;

	public Mesh mesh;

	public override Texture mainTexture => texture;

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		if (mesh != null)
		{
			vh.Clear();
			int[] triangles = mesh.triangles;
			Vector3[] vertices = mesh.vertices;
			Vector2[] uv = mesh.uv;
			Vector2[] uv2 = mesh.uv2;
			Vector2[] uv3 = mesh.uv3;
			for (int i = 0; i < vertices.Length; i++)
			{
				UIVertex uIVertex = new UIVertex
				{
					position = vertices[i],
					uv0 = uv[i],
					uv1 = uv2[i],
					uv2 = uv3[i]
				};
				vh.AddVert(uIVertex);
				vh.SetUIVertex(uIVertex, i);
			}
			for (int j = 0; j < triangles.Length; j += 3)
			{
				vh.AddTriangle(triangles[j], triangles[j + 1], triangles[j + 2]);
			}
		}
	}

	public void SetPaperCutMesh(Mesh resultMesh)
	{
		mesh = resultMesh;
	}

	public void SetPaperCutTexture(Texture mainTex, Texture displayAreaTex, Texture backGroundTex)
	{
		texture = mainTex;
		material.SetTexture("_MainTex", mainTex);
		material.SetTexture("_DisplayAreaTex", displayAreaTex);
		material.SetTexture("_BgTexture", backGroundTex);
		SetAllDirty();
	}
}
