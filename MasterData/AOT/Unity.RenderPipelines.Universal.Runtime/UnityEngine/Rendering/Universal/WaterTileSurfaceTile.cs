namespace UnityEngine.Rendering.Universal;

public sealed class WaterTileSurfaceTile : MonoBehaviour
{
	[SerializeField]
	private WaterTileSurface m_Owner;

	public WaterTileSurface Owner => m_Owner;

	public void Initialize(WaterTileSurface owner)
	{
		m_Owner = owner;
	}
}
