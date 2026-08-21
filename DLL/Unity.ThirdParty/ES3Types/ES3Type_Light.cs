using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"type", "color", "intensity", "bounceIntensity", "shadows", "shadowStrength", "shadowResolution", "shadowCustomResolution", "shadowBias", "shadowNormalBias",
	"shadowNearPlane", "range", "spotAngle", "cookieSize", "cookie", "flare", "renderMode", "cullingMask", "areaSize", "lightmappingMode",
	"enabled", "hideFlags"
})]
public class ES3Type_Light : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_Light()
		: base(typeof(Light))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		Light light = (Light)obj;
		writer.WriteProperty("type", light.type);
		writer.WriteProperty("color", light.color, ES3Type_Color.Instance);
		writer.WriteProperty("intensity", light.intensity, ES3Type_float.Instance);
		writer.WriteProperty("bounceIntensity", light.bounceIntensity, ES3Type_float.Instance);
		writer.WriteProperty("shadows", light.shadows);
		writer.WriteProperty("shadowStrength", light.shadowStrength, ES3Type_float.Instance);
		writer.WriteProperty("shadowResolution", light.shadowResolution);
		writer.WriteProperty("shadowCustomResolution", light.shadowCustomResolution, ES3Type_int.Instance);
		writer.WriteProperty("shadowBias", light.shadowBias, ES3Type_float.Instance);
		writer.WriteProperty("shadowNormalBias", light.shadowNormalBias, ES3Type_float.Instance);
		writer.WriteProperty("shadowNearPlane", light.shadowNearPlane, ES3Type_float.Instance);
		writer.WriteProperty("range", light.range, ES3Type_float.Instance);
		writer.WriteProperty("spotAngle", light.spotAngle, ES3Type_float.Instance);
		writer.WriteProperty("cookieSize", light.cookieSize, ES3Type_float.Instance);
		writer.WriteProperty("cookie", light.cookie, ES3Type_Texture2D.Instance);
		writer.WriteProperty("flare", light.flare, ES3Type_Texture2D.Instance);
		writer.WriteProperty("renderMode", light.renderMode);
		writer.WriteProperty("cullingMask", light.cullingMask, ES3Type_int.Instance);
		writer.WriteProperty("enabled", light.enabled, ES3Type_bool.Instance);
		writer.WriteProperty("hideFlags", light.hideFlags);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		Light light = (Light)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "type":
				light.type = reader.Read<LightType>();
				break;
			case "color":
				light.color = reader.Read<Color>(ES3Type_Color.Instance);
				break;
			case "intensity":
				light.intensity = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "bounceIntensity":
				light.bounceIntensity = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "shadows":
				light.shadows = reader.Read<LightShadows>();
				break;
			case "shadowStrength":
				light.shadowStrength = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "shadowResolution":
				light.shadowResolution = reader.Read<LightShadowResolution>();
				break;
			case "shadowCustomResolution":
				light.shadowCustomResolution = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "shadowBias":
				light.shadowBias = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "shadowNormalBias":
				light.shadowNormalBias = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "shadowNearPlane":
				light.shadowNearPlane = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "range":
				light.range = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "spotAngle":
				light.spotAngle = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "cookieSize":
				light.cookieSize = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "cookie":
				light.cookie = reader.Read<Texture>();
				break;
			case "flare":
				light.flare = reader.Read<Flare>();
				break;
			case "renderMode":
				light.renderMode = reader.Read<LightRenderMode>();
				break;
			case "cullingMask":
				light.cullingMask = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "enabled":
				light.enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "hideFlags":
				light.hideFlags = reader.Read<HideFlags>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
