namespace UnityEngine.Rendering;

public class RTHandle
{
	internal RTHandleSystem m_Owner;

	internal RenderTexture m_RT;

	internal Texture m_ExternalTexture;

	internal RenderTargetIdentifier m_NameID;

	internal bool m_EnableMSAA;

	internal bool m_EnableRandomWrite;

	internal string m_Name;

	internal bool m_UseCustomHandleScales;

	internal RTHandleProperties m_CustomHandleProperties;

	internal ScaleFunc scaleFunc;

	public Vector2 scaleFactor { get; }

	public bool useScaling { get; internal set; }

	internal Vector2Int referenceSize { set; }

	public RTHandleProperties rtHandleProperties
	{
		get
		{
			if (!m_UseCustomHandleScales)
			{
				return m_Owner.rtHandleProperties;
			}
			return m_CustomHandleProperties;
		}
	}

	public RenderTexture rt => m_RT;

	public RenderTargetIdentifier nameID => m_NameID;

	internal RTHandle(RTHandleSystem owner)
	{
		m_Owner = owner;
	}

	internal void SetRenderTexture(RenderTexture rt)
	{
		m_RT = rt;
		m_ExternalTexture = null;
		m_NameID = new RenderTargetIdentifier(rt);
	}

	public void Release()
	{
		m_Owner.Remove(this);
		CoreUtils.Destroy(m_RT);
		m_NameID = BuiltinRenderTextureType.None;
		m_RT = null;
		m_ExternalTexture = null;
	}

	public Vector2Int GetScaledSize(Vector2Int refSize)
	{
		if (!useScaling)
		{
			return refSize;
		}
		if (scaleFunc != null)
		{
			return scaleFunc(refSize);
		}
		return new Vector2Int(Mathf.RoundToInt(scaleFactor.x * (float)refSize.x), Mathf.RoundToInt(scaleFactor.y * (float)refSize.y));
	}
}
