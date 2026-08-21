using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"sprite", "color", "flipX", "flipY", "enabled", "shadowCastingMode", "receiveShadows", "sharedMaterials", "lightmapIndex", "realtimeLightmapIndex",
	"lightmapScaleOffset", "motionVectorGenerationMode", "realtimeLightmapScaleOffset", "lightProbeUsage", "lightProbeProxyVolumeOverride", "probeAnchor", "reflectionProbeUsage", "sortingLayerName", "sortingLayerID", "sortingOrder"
})]
public class ES3Type_SpriteRenderer : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_SpriteRenderer()
		: base(typeof(SpriteRenderer))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		SpriteRenderer spriteRenderer = (SpriteRenderer)obj;
		writer.WriteProperty("sprite", spriteRenderer.sprite);
		writer.WriteProperty("color", spriteRenderer.color, ES3Type_Color.Instance);
		writer.WriteProperty("flipX", spriteRenderer.flipX, ES3Type_bool.Instance);
		writer.WriteProperty("flipY", spriteRenderer.flipY, ES3Type_bool.Instance);
		writer.WriteProperty("enabled", spriteRenderer.enabled, ES3Type_bool.Instance);
		writer.WriteProperty("shadowCastingMode", spriteRenderer.shadowCastingMode);
		writer.WriteProperty("receiveShadows", spriteRenderer.receiveShadows, ES3Type_bool.Instance);
		writer.WriteProperty("sharedMaterials", spriteRenderer.sharedMaterials);
		writer.WriteProperty("lightmapIndex", spriteRenderer.lightmapIndex, ES3Type_int.Instance);
		writer.WriteProperty("realtimeLightmapIndex", spriteRenderer.realtimeLightmapIndex, ES3Type_int.Instance);
		writer.WriteProperty("lightmapScaleOffset", spriteRenderer.lightmapScaleOffset, ES3Type_Vector4.Instance);
		writer.WriteProperty("motionVectorGenerationMode", spriteRenderer.motionVectorGenerationMode);
		writer.WriteProperty("realtimeLightmapScaleOffset", spriteRenderer.realtimeLightmapScaleOffset, ES3Type_Vector4.Instance);
		writer.WriteProperty("lightProbeUsage", spriteRenderer.lightProbeUsage);
		writer.WriteProperty("lightProbeProxyVolumeOverride", spriteRenderer.lightProbeProxyVolumeOverride, ES3Type_GameObject.Instance);
		writer.WriteProperty("probeAnchor", spriteRenderer.probeAnchor, ES3Type_Transform.Instance);
		writer.WriteProperty("reflectionProbeUsage", spriteRenderer.reflectionProbeUsage);
		writer.WriteProperty("sortingLayerName", spriteRenderer.sortingLayerName, ES3Type_string.Instance);
		writer.WriteProperty("sortingLayerID", spriteRenderer.sortingLayerID, ES3Type_int.Instance);
		writer.WriteProperty("sortingOrder", spriteRenderer.sortingOrder, ES3Type_int.Instance);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		SpriteRenderer spriteRenderer = (SpriteRenderer)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "sprite":
				spriteRenderer.sprite = reader.Read<Sprite>(ES3Type_Sprite.Instance);
				break;
			case "color":
				spriteRenderer.color = reader.Read<Color>(ES3Type_Color.Instance);
				break;
			case "flipX":
				spriteRenderer.flipX = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "flipY":
				spriteRenderer.flipY = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "enabled":
				spriteRenderer.enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "shadowCastingMode":
				spriteRenderer.shadowCastingMode = reader.Read<ShadowCastingMode>();
				break;
			case "receiveShadows":
				spriteRenderer.receiveShadows = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "sharedMaterials":
				spriteRenderer.sharedMaterials = reader.Read<Material[]>();
				break;
			case "lightmapIndex":
				spriteRenderer.lightmapIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "realtimeLightmapIndex":
				spriteRenderer.realtimeLightmapIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "lightmapScaleOffset":
				spriteRenderer.lightmapScaleOffset = reader.Read<Vector4>(ES3Type_Vector4.Instance);
				break;
			case "motionVectorGenerationMode":
				spriteRenderer.motionVectorGenerationMode = reader.Read<MotionVectorGenerationMode>();
				break;
			case "realtimeLightmapScaleOffset":
				spriteRenderer.realtimeLightmapScaleOffset = reader.Read<Vector4>(ES3Type_Vector4.Instance);
				break;
			case "lightProbeUsage":
				spriteRenderer.lightProbeUsage = reader.Read<LightProbeUsage>();
				break;
			case "lightProbeProxyVolumeOverride":
				spriteRenderer.lightProbeProxyVolumeOverride = reader.Read<GameObject>(ES3Type_GameObject.Instance);
				break;
			case "probeAnchor":
				spriteRenderer.probeAnchor = reader.Read<Transform>(ES3Type_Transform.Instance);
				break;
			case "reflectionProbeUsage":
				spriteRenderer.reflectionProbeUsage = reader.Read<ReflectionProbeUsage>();
				break;
			case "sortingLayerName":
				spriteRenderer.sortingLayerName = reader.Read<string>(ES3Type_string.Instance);
				break;
			case "sortingLayerID":
				spriteRenderer.sortingLayerID = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "sortingOrder":
				spriteRenderer.sortingOrder = reader.Read<int>(ES3Type_int.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
