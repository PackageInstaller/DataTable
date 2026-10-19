using System;

namespace UnityEngine.Localization.Metadata;

[HideInInspector]
internal class AssetTypeMetadata : SharedTableCollectionMetadata
{
	[HideInInspector]
	[SerializeField]
	internal string m_TypeString;

	public Type Type { get; set; }

	public override void OnBeforeSerialize()
	{
		base.OnBeforeSerialize();
		m_TypeString = Type?.AssemblyQualifiedName;
	}

	public override void OnAfterDeserialize()
	{
		base.OnAfterDeserialize();
		if (!string.IsNullOrEmpty(m_TypeString))
		{
			Type = Type.GetType(m_TypeString);
		}
	}
}
