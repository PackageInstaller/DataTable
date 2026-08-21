namespace UnityEngine.Rendering;

public class RTHandle
{
	internal RTHandleSystem m_Owner;

	internal RenderTexture m_RT;

	internal Texture m_ExternalTexture;

	internal RenderTargetIdentifier m_NameID;

	internal bool m_EnableMSAA;

	internal bool m_EnableRandomWrite;

	internal bool m_EnableHWDynamicScale;

	internal string m_Name;

	internal bool m_UseCustomHandleScales;

	internal RTHandleProperties m_CustomHandleProperties;

	internal ScaleFunc scaleFunc;

	public Vector2 scaleFactor { get; internal set; }

	public bool useScaling { get; internal set; }

	public Vector2Int referenceSize { get; internal set; }

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

	public string name => m_Name;

	public bool isMSAAEnabled => m_EnableMSAA;

	public void SetCustomHandleProperties(in RTHandleProperties properties)
	{
		m_UseCustomHandleScales = true;
		m_CustomHandleProperties = properties;
	}

	public void ClearCustomHandleProperties()
	{
		m_UseCustomHandleScales = false;
	}

	internal RTHandle(RTHandleSystem owner)
	{
		m_Owner = owner;
	}

	public static implicit operator RenderTargetIdentifier(RTHandle handle)
	{
		return handle?.nameID ?? default(RenderTargetIdentifier);
	}

	public static implicit operator Texture(RTHandle handle)
	{
		if (handle == null)
		{
			return null;
		}
		if (!(handle.rt != null))
		{
			return handle.m_ExternalTexture;
		}
		return handle.rt;
	}

	public static implicit operator RenderTexture(RTHandle handle)
	{
		return handle?.rt;
	}

	internal void SetRenderTexture(RenderTexture rt)
	{
		m_RT = rt;
		m_ExternalTexture = null;
		m_NameID = new RenderTargetIdentifier(rt);
	}

	internal void SetTexture(Texture tex)
	{
		m_RT = null;
		m_ExternalTexture = tex;
		m_NameID = new RenderTargetIdentifier(tex);
	}

	internal void SetTexture(RenderTargetIdentifier tex)
	{
		m_RT = null;
		m_ExternalTexture = null;
		m_NameID = tex;
	}

	public int GetInstanceID()
	{
		if (m_RT != null)
		{
			return m_RT.GetInstanceID();
		}
		if (m_ExternalTexture != null)
		{
			return m_ExternalTexture.GetInstanceID();
		}
		return m_NameID.GetHashCode();
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

	public Vector2Int GetScaledSize()
	{
		if (!useScaling)
		{
			return referenceSize;
		}
		if (scaleFunc != null)
		{
			return scaleFunc(referenceSize);
		}
		return new Vector2Int(Mathf.RoundToInt(scaleFactor.x * (float)referenceSize.x), Mathf.RoundToInt(scaleFactor.y * (float)referenceSize.y));
	}

	public void SwitchToFastMemory(CommandBuffer cmd, float residencyFraction = 1f, FastMemoryFlags flags = FastMemoryFlags.SpillTop, bool copyContents = false)
	{
		residencyFraction = Mathf.Clamp01(residencyFraction);
		cmd.SwitchIntoFastMemory(m_RT, flags, residencyFraction, copyContents);
	}

	public void CopyToFastMemory(CommandBuffer cmd, float residencyFraction = 1f, FastMemoryFlags flags = FastMemoryFlags.SpillTop)
	{
		SwitchToFastMemory(cmd, residencyFraction, flags, copyContents: true);
	}

	public void SwitchOutFastMemory(CommandBuffer cmd, bool copyContents = true)
	{
		cmd.SwitchOutOfFastMemory(m_RT, copyContents);
	}
}
