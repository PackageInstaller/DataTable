namespace UnityEngine.UI;

public class EmptyRaycast : MaskableGraphic
{
	protected EmptyRaycast()
	{
		base.useLegacyMeshGeneration = false;
	}

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		vh.Clear();
	}
}
