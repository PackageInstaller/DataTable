namespace UnityEngine.Rendering;

public struct BatchFilterSettings
{
	public uint renderingLayerMask;

	public byte layer;

	private byte m_motionMode;

	private byte m_shadowMode;

	private byte m_receiveShadows;

	private byte m_staticShadowCaster;

	private byte m_allDepthSorted;
}
