using System;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.Util;
using UnityEngine.Serialization;

namespace UnityEngine.ResourceManagement.ResourceProviders;

[Serializable]
public class AssetBundleRequestOptions : ILocationSizeData
{
	[SerializeField]
	[FormerlySerializedAs("m_hash")]
	private string m_Hash = "";

	[FormerlySerializedAs("m_crc")]
	[SerializeField]
	private uint m_Crc;

	[FormerlySerializedAs("m_timeout")]
	[SerializeField]
	private int m_Timeout;

	[FormerlySerializedAs("m_chunkedTransfer")]
	[SerializeField]
	private bool m_ChunkedTransfer;

	[FormerlySerializedAs("m_redirectLimit")]
	[SerializeField]
	private int m_RedirectLimit = -1;

	[FormerlySerializedAs("m_retryCount")]
	[SerializeField]
	private int m_RetryCount;

	[SerializeField]
	private string m_BundleName;

	[SerializeField]
	private AssetLoadMode m_AssetLoadMode;

	[SerializeField]
	private long m_BundleSize;

	[SerializeField]
	private bool m_UseCrcForCachedBundles;

	[SerializeField]
	private bool m_UseUWRForLocalBundles;

	[SerializeField]
	private bool m_ClearOtherCachedVersionsWhenLoaded;

	public string Hash
	{
		get
		{
			return m_Hash;
		}
		set
		{
			m_Hash = value;
		}
	}

	public uint Crc
	{
		get
		{
			return m_Crc;
		}
		set
		{
			m_Crc = value;
		}
	}

	public int Timeout
	{
		get
		{
			return m_Timeout;
		}
		set
		{
			m_Timeout = value;
		}
	}

	public bool ChunkedTransfer
	{
		get
		{
			return m_ChunkedTransfer;
		}
		set
		{
			m_ChunkedTransfer = value;
		}
	}

	public int RedirectLimit
	{
		get
		{
			if (m_RedirectLimit <= 128)
			{
				return m_RedirectLimit;
			}
			return 128;
		}
		set
		{
			m_RedirectLimit = value;
		}
	}

	public int RetryCount
	{
		get
		{
			return m_RetryCount;
		}
		set
		{
			m_RetryCount = value;
		}
	}

	public string BundleName
	{
		get
		{
			return m_BundleName;
		}
		set
		{
			m_BundleName = value;
		}
	}

	public AssetLoadMode AssetLoadMode
	{
		get
		{
			return m_AssetLoadMode;
		}
		set
		{
			m_AssetLoadMode = value;
		}
	}

	public long BundleSize
	{
		get
		{
			return m_BundleSize;
		}
		set
		{
			m_BundleSize = value;
		}
	}

	public bool UseCrcForCachedBundle
	{
		get
		{
			return m_UseCrcForCachedBundles;
		}
		set
		{
			m_UseCrcForCachedBundles = value;
		}
	}

	public bool UseUnityWebRequestForLocalBundles
	{
		get
		{
			return m_UseUWRForLocalBundles;
		}
		set
		{
			m_UseUWRForLocalBundles = value;
		}
	}

	public bool ClearOtherCachedVersionsWhenLoaded
	{
		get
		{
			return m_ClearOtherCachedVersionsWhenLoaded;
		}
		set
		{
			m_ClearOtherCachedVersionsWhenLoaded = value;
		}
	}

	public virtual long ComputeSize(IResourceLocation location, ResourceManager resourceManager)
	{
		if (!ResourceManagerConfig.IsPathRemote((resourceManager == null) ? location.InternalId : resourceManager.TransformInternalId(location)))
		{
			return 0L;
		}
		Hash128 hash = Hash128.Parse(Hash);
		if (hash.isValid)
		{
			if (Caching.IsVersionCached(new CachedAssetBundle(BundleName, hash)))
			{
				return 0L;
			}
			return BundleSize;
		}
		return BundleSize;
	}
}
