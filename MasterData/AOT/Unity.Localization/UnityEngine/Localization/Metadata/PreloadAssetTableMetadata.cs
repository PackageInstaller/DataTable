using System;

namespace UnityEngine.Localization.Metadata;

[Serializable]
[Metadata(AllowedTypes = (MetadataType.SharedTableData | MetadataType.AssetTable), MenuItem = "Preload Assets")]
public class PreloadAssetTableMetadata : IMetadata
{
	public enum PreloadBehaviour
	{
		NoPreload,
		PreloadAll
	}

	[SerializeField]
	private PreloadBehaviour m_PreloadBehaviour;

	public PreloadBehaviour Behaviour
	{
		get
		{
			return m_PreloadBehaviour;
		}
		set
		{
			m_PreloadBehaviour = value;
		}
	}
}
