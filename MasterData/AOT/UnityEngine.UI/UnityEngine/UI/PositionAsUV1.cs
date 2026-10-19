namespace UnityEngine.UI;

[AddComponentMenu("UI/Effects/Position As UV1", 82)]
public class PositionAsUV1 : BaseMeshEffect
{
	protected PositionAsUV1()
	{
	}

	public override void ModifyMesh(VertexHelper vh)
	{
		UIVertex vertex = default;
		for (int i = 0; i < vh.currentVertCount; i++)
		{
			vh.PopulateUIVertex(ref vertex, i);
			vertex.uv1 = new Vector2(vertex.position.x, vertex.position.y);
			vh.SetUIVertex(vertex, i);
		}
	}
}
