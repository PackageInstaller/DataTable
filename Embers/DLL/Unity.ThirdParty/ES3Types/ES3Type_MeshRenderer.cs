using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[]
{
	"additionalVertexStreams", "enabled", "shadowCastingMode", "receiveShadows", "sharedMaterials", "lightmapIndex", "realtimeLightmapIndex", "lightmapScaleOffset", "motionVectorGenerationMode", "realtimeLightmapScaleOffset",
	"lightProbeUsage", "lightProbeProxyVolumeOverride", "probeAnchor", "reflectionProbeUsage", "sortingLayerName", "sortingLayerID", "sortingOrder"
})]
[Preserve]
public class ES3Type_MeshRenderer : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_MeshRenderer()
		: base(typeof(MeshRenderer))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		MeshRenderer meshRenderer = (MeshRenderer)obj;
		writer.WriteProperty("additionalVertexStreams", meshRenderer.additionalVertexStreams, ES3Type_Mesh.Instance);
		writer.WriteProperty("enabled", meshRenderer.enabled, ES3Type_bool.Instance);
		writer.WriteProperty("shadowCastingMode", meshRenderer.shadowCastingMode);
		writer.WriteProperty("receiveShadows", meshRenderer.receiveShadows, ES3Type_bool.Instance);
		writer.WriteProperty("sharedMaterials", meshRenderer.sharedMaterials, ES3Type_MaterialArray.Instance);
		writer.WriteProperty("lightmapIndex", meshRenderer.lightmapIndex, ES3Type_int.Instance);
		writer.WriteProperty("realtimeLightmapIndex", meshRenderer.realtimeLightmapIndex, ES3Type_int.Instance);
		writer.WriteProperty("lightmapScaleOffset", meshRenderer.lightmapScaleOffset, ES3Type_Vector4.Instance);
		writer.WriteProperty("motionVectorGenerationMode", meshRenderer.motionVectorGenerationMode);
		writer.WriteProperty("realtimeLightmapScaleOffset", meshRenderer.realtimeLightmapScaleOffset, ES3Type_Vector4.Instance);
		writer.WriteProperty("lightProbeUsage", meshRenderer.lightProbeUsage);
		writer.WriteProperty("lightProbeProxyVolumeOverride", meshRenderer.lightProbeProxyVolumeOverride);
		writer.WriteProperty("probeAnchor", meshRenderer.probeAnchor, ES3Type_Transform.Instance);
		writer.WriteProperty("reflectionProbeUsage", meshRenderer.reflectionProbeUsage);
		writer.WriteProperty("sortingLayerName", meshRenderer.sortingLayerName, ES3Type_string.Instance);
		writer.WriteProperty("sortingLayerID", meshRenderer.sortingLayerID, ES3Type_int.Instance);
		writer.WriteProperty("sortingOrder", meshRenderer.sortingOrder, ES3Type_int.Instance);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		MeshRenderer meshRenderer = (MeshRenderer)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "additionalVertexStreams":
				meshRenderer.additionalVertexStreams = reader.Read<Mesh>(ES3Type_Mesh.Instance);
				break;
			case "enabled":
				meshRenderer.enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "shadowCastingMode":
				meshRenderer.shadowCastingMode = reader.Read<ShadowCastingMode>();
				break;
			case "receiveShadows":
				meshRenderer.receiveShadows = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "sharedMaterials":
				meshRenderer.sharedMaterials = reader.Read<Material[]>();
				break;
			case "lightmapIndex":
				meshRenderer.lightmapIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "realtimeLightmapIndex":
				meshRenderer.realtimeLightmapIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "lightmapScaleOffset":
				meshRenderer.lightmapScaleOffset = reader.Read<Vector4>(ES3Type_Vector4.Instance);
				break;
			case "motionVectorGenerationMode":
				meshRenderer.motionVectorGenerationMode = reader.Read<MotionVectorGenerationMode>();
				break;
			case "realtimeLightmapScaleOffset":
				meshRenderer.realtimeLightmapScaleOffset = reader.Read<Vector4>(ES3Type_Vector4.Instance);
				break;
			case "lightProbeUsage":
				meshRenderer.lightProbeUsage = reader.Read<LightProbeUsage>();
				break;
			case "lightProbeProxyVolumeOverride":
				meshRenderer.lightProbeProxyVolumeOverride = reader.Read<GameObject>(ES3Type_GameObject.Instance);
				break;
			case "probeAnchor":
				meshRenderer.probeAnchor = reader.Read<Transform>(ES3Type_Transform.Instance);
				break;
			case "reflectionProbeUsage":
				meshRenderer.reflectionProbeUsage = reader.Read<ReflectionProbeUsage>();
				break;
			case "sortingLayerName":
				meshRenderer.sortingLayerName = reader.Read<string>(ES3Type_string.Instance);
				break;
			case "sortingLayerID":
				meshRenderer.sortingLayerID = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "sortingOrder":
				meshRenderer.sortingOrder = reader.Read<int>(ES3Type_int.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
