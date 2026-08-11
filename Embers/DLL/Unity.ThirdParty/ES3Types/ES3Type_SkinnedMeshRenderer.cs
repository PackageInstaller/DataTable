using ES3Internal;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"bones", "rootBone", "quality", "sharedMesh", "updateWhenOffscreen", "skinnedMotionVectors", "localBounds", "enabled", "shadowCastingMode", "receiveShadows",
	"sharedMaterials", "lightmapIndex", "realtimeLightmapIndex", "lightmapScaleOffset", "motionVectorGenerationMode", "realtimeLightmapScaleOffset", "lightProbeUsage", "lightProbeProxyVolumeOverride", "probeAnchor", "reflectionProbeUsage",
	"sortingLayerName", "sortingLayerID", "sortingOrder"
})]
public class ES3Type_SkinnedMeshRenderer : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_SkinnedMeshRenderer()
		: base(typeof(SkinnedMeshRenderer))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		SkinnedMeshRenderer skinnedMeshRenderer = (SkinnedMeshRenderer)obj;
		writer.WriteProperty("bones", skinnedMeshRenderer.bones);
		writer.WriteProperty("rootBone", skinnedMeshRenderer.rootBone);
		writer.WriteProperty("quality", skinnedMeshRenderer.quality);
		writer.WriteProperty("sharedMesh", skinnedMeshRenderer.sharedMesh);
		writer.WriteProperty("updateWhenOffscreen", skinnedMeshRenderer.updateWhenOffscreen, ES3Type_bool.Instance);
		writer.WriteProperty("skinnedMotionVectors", skinnedMeshRenderer.skinnedMotionVectors, ES3Type_bool.Instance);
		writer.WriteProperty("localBounds", skinnedMeshRenderer.localBounds, ES3Type_Bounds.Instance);
		writer.WriteProperty("enabled", skinnedMeshRenderer.enabled, ES3Type_bool.Instance);
		writer.WriteProperty("shadowCastingMode", skinnedMeshRenderer.shadowCastingMode);
		writer.WriteProperty("receiveShadows", skinnedMeshRenderer.receiveShadows, ES3Type_bool.Instance);
		writer.WriteProperty("sharedMaterials", skinnedMeshRenderer.sharedMaterials);
		writer.WriteProperty("lightmapIndex", skinnedMeshRenderer.lightmapIndex, ES3Type_int.Instance);
		writer.WriteProperty("realtimeLightmapIndex", skinnedMeshRenderer.realtimeLightmapIndex, ES3Type_int.Instance);
		writer.WriteProperty("lightmapScaleOffset", skinnedMeshRenderer.lightmapScaleOffset, ES3Type_Vector4.Instance);
		writer.WriteProperty("motionVectorGenerationMode", skinnedMeshRenderer.motionVectorGenerationMode);
		writer.WriteProperty("realtimeLightmapScaleOffset", skinnedMeshRenderer.realtimeLightmapScaleOffset, ES3Type_Vector4.Instance);
		writer.WriteProperty("lightProbeUsage", skinnedMeshRenderer.lightProbeUsage);
		writer.WriteProperty("lightProbeProxyVolumeOverride", skinnedMeshRenderer.lightProbeProxyVolumeOverride);
		writer.WriteProperty("probeAnchor", skinnedMeshRenderer.probeAnchor);
		writer.WriteProperty("reflectionProbeUsage", skinnedMeshRenderer.reflectionProbeUsage);
		writer.WriteProperty("sortingLayerName", skinnedMeshRenderer.sortingLayerName, ES3Type_string.Instance);
		writer.WriteProperty("sortingLayerID", skinnedMeshRenderer.sortingLayerID, ES3Type_int.Instance);
		writer.WriteProperty("sortingOrder", skinnedMeshRenderer.sortingOrder, ES3Type_int.Instance);
		if (skinnedMeshRenderer.sharedMesh != null)
		{
			float[] array = new float[skinnedMeshRenderer.sharedMesh.blendShapeCount];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = skinnedMeshRenderer.GetBlendShapeWeight(i);
			}
			writer.WriteProperty("blendShapeWeights", array, ES3Type_floatArray.Instance);
		}
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		SkinnedMeshRenderer skinnedMeshRenderer = (SkinnedMeshRenderer)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "bones":
				skinnedMeshRenderer.bones = reader.Read<Transform[]>();
				break;
			case "rootBone":
				skinnedMeshRenderer.rootBone = reader.Read<Transform>(ES3Type_Transform.Instance);
				break;
			case "quality":
				skinnedMeshRenderer.quality = reader.Read<SkinQuality>();
				break;
			case "sharedMesh":
				skinnedMeshRenderer.sharedMesh = reader.Read<Mesh>(ES3Type_Mesh.Instance);
				break;
			case "updateWhenOffscreen":
				skinnedMeshRenderer.updateWhenOffscreen = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "skinnedMotionVectors":
				skinnedMeshRenderer.skinnedMotionVectors = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "localBounds":
				skinnedMeshRenderer.localBounds = reader.Read<Bounds>(ES3Type_Bounds.Instance);
				break;
			case "enabled":
				skinnedMeshRenderer.enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "shadowCastingMode":
				skinnedMeshRenderer.shadowCastingMode = reader.Read<ShadowCastingMode>();
				break;
			case "receiveShadows":
				skinnedMeshRenderer.receiveShadows = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "sharedMaterials":
				skinnedMeshRenderer.sharedMaterials = reader.Read<Material[]>();
				break;
			case "lightmapIndex":
				skinnedMeshRenderer.lightmapIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "realtimeLightmapIndex":
				skinnedMeshRenderer.realtimeLightmapIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "lightmapScaleOffset":
				skinnedMeshRenderer.lightmapScaleOffset = reader.Read<Vector4>(ES3Type_Vector4.Instance);
				break;
			case "motionVectorGenerationMode":
				skinnedMeshRenderer.motionVectorGenerationMode = reader.Read<MotionVectorGenerationMode>();
				break;
			case "realtimeLightmapScaleOffset":
				skinnedMeshRenderer.realtimeLightmapScaleOffset = reader.Read<Vector4>(ES3Type_Vector4.Instance);
				break;
			case "lightProbeUsage":
				skinnedMeshRenderer.lightProbeUsage = reader.Read<LightProbeUsage>();
				break;
			case "lightProbeProxyVolumeOverride":
				skinnedMeshRenderer.lightProbeProxyVolumeOverride = reader.Read<GameObject>(ES3Type_GameObject.Instance);
				break;
			case "probeAnchor":
				skinnedMeshRenderer.probeAnchor = reader.Read<Transform>(ES3Type_Transform.Instance);
				break;
			case "reflectionProbeUsage":
				skinnedMeshRenderer.reflectionProbeUsage = reader.Read<ReflectionProbeUsage>();
				break;
			case "sortingLayerName":
				skinnedMeshRenderer.sortingLayerName = reader.Read<string>(ES3Type_string.Instance);
				break;
			case "sortingLayerID":
				skinnedMeshRenderer.sortingLayerID = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "sortingOrder":
				skinnedMeshRenderer.sortingOrder = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "blendShapeWeights":
			{
				float[] array = reader.Read<float[]>(ES3Type_floatArray.Instance);
				if (!(skinnedMeshRenderer.sharedMesh == null))
				{
					if (array.Length != skinnedMeshRenderer.sharedMesh.blendShapeCount)
					{
						ES3Debug.LogError("The number of blend shape weights we are loading does not match the number of blend shapes in this SkinnedMeshRenderer's Mesh");
					}
					for (int i = 0; i < array.Length; i++)
					{
						skinnedMeshRenderer.SetBlendShapeWeight(i, array[i]);
					}
				}
				break;
			}
			default:
				reader.Skip();
				break;
			}
		}
	}
}
