using System;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[Serializable]
public class ProviderLoadRequestOptions
{
	[SerializeField]
	private bool m_IgnoreFailures;

	private int m_WebRequestTimeout;

	public bool IgnoreFailures
	{
		get
		{
			return m_IgnoreFailures;
		}
		set
		{
			m_IgnoreFailures = value;
		}
	}

	public int WebRequestTimeout
	{
		get
		{
			return m_WebRequestTimeout;
		}
		set
		{
			m_WebRequestTimeout = value;
		}
	}

	public ProviderLoadRequestOptions Copy()
	{
		return (ProviderLoadRequestOptions)MemberwiseClone();
	}
}
