namespace UnityEngine.UI;

[AddComponentMenu("UI/Effects/Position As UV1", 82)]
public class PositionAsUV1 : BaseMeshEffect
{
	protected PositionAsUV1()
	{
	}

	public override void ModifyMesh(VertexHelper vh)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		UIVertex vertex = default(UIVertex);
		for (int i = 0; i < vh.currentVertCount; i++)
		{
			vh.PopulateUIVertex(ref vertex, i);
			vertex.uv1 = new Vector2(vertex.position.x, vertex.position.y);
			vh.SetUIVertex(vertex, i);
		}
	}
}
