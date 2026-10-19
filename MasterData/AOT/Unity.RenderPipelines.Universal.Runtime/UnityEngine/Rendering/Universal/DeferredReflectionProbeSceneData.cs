using System;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

[CreateAssetMenu(fileName = "DeferredReflectionProbeSceneData", menuName = "Rendering/Deferred Reflection Probe Scene Data")]
public sealed class DeferredReflectionProbeSceneData : ScriptableObject
{
	public const int CurrentFormatVersion = 3;

	public const int AtlasSize = 320;

	public const int AtlasMipCount = 9;

	public const int MaxSampleMip = 6;

	public const int MaxLocalProbeCount = 32;

	public const GraphicsFormat AtlasGraphicsFormat = GraphicsFormat.E5B9G9R9_UFloatPack32;

	internal const string ImportedBuilderVersion = "ZMD EXR Importer";

	[SerializeField]
	private Texture2DArray m_Atlas;

	[SerializeField]
	private DeferredReflectionProbeGpuData[] m_Probes = Array.Empty<DeferredReflectionProbeGpuData>();

	[SerializeField]
	private int m_LocalProbeCount;

	[SerializeField]
	private int m_FormatVersion = 3;

	[SerializeField]
	private string m_BuilderVersion;

	[SerializeField]
	private string m_SceneGuid;

	[SerializeField]
	private string m_ContentHash;

	[SerializeField]
	private int m_AtlasSize = 320;

	[SerializeField]
	private int m_AtlasMipCount = 9;

	[SerializeField]
	private int m_MaxSampleMip = 6;

	[SerializeField]
	private int m_AtlasLayerCount;

	[SerializeField]
	private GraphicsFormat m_AtlasGraphicsFormat = GraphicsFormat.E5B9G9R9_UFloatPack32;

	[SerializeField]
	private bool m_StripSourceProbesInPlayer;

	public Texture2DArray atlas => m_Atlas;

	public DeferredReflectionProbeGpuData[] probes => m_Probes;

	public int localProbeCount => m_LocalProbeCount;

	public int formatVersion => m_FormatVersion;

	public string builderVersion => m_BuilderVersion;

	public string sceneGuid => m_SceneGuid;

	public string contentHash => m_ContentHash;

	public int atlasSize => m_AtlasSize;

	public int atlasMipCount => m_AtlasMipCount;

	public int maxSampleMip => m_MaxSampleMip;

	public int atlasLayerCount => m_AtlasLayerCount;

	public GraphicsFormat atlasGraphicsFormat => m_AtlasGraphicsFormat;

	public bool stripSourceProbesInPlayer => m_StripSourceProbesInPlayer;

	internal bool isImportedData => m_BuilderVersion == "ZMD EXR Importer";

	internal bool HasResources()
	{
		if (m_Atlas != null)
		{
			return m_Probes != null;
		}
		return false;
	}
}
