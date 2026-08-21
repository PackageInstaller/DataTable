using UnityEngine;
using UnityEngine.Scripting;
using UnityEngine.UI;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"texture", "uvRect", "onCullStateChanged", "maskable", "color", "raycastTarget", "useLegacyMeshGeneration", "material", "useGUILayout", "enabled",
	"hideFlags"
})]
public class ES3Type_RawImage : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_RawImage()
		: base(typeof(RawImage))
	{
		Instance = this;
		priority = 1;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		RawImage rawImage = (RawImage)obj;
		writer.WritePropertyByRef("texture", rawImage.texture);
		writer.WriteProperty("uvRect", rawImage.uvRect, ES3Type_Rect.Instance);
		writer.WriteProperty("onCullStateChanged", rawImage.onCullStateChanged);
		writer.WriteProperty("maskable", rawImage.maskable, ES3Type_bool.Instance);
		writer.WriteProperty("color", rawImage.color, ES3Type_Color.Instance);
		writer.WriteProperty("raycastTarget", rawImage.raycastTarget, ES3Type_bool.Instance);
		writer.WritePrivateProperty("useLegacyMeshGeneration", rawImage);
		if (rawImage.material.name.Contains("Default"))
		{
			writer.WriteProperty("material", null);
		}
		else
		{
			writer.WriteProperty("material", rawImage.material);
		}
		writer.WriteProperty("useGUILayout", rawImage.useGUILayout, ES3Type_bool.Instance);
		writer.WriteProperty("enabled", rawImage.enabled, ES3Type_bool.Instance);
		writer.WriteProperty("hideFlags", rawImage.hideFlags);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		RawImage rawImage = (RawImage)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "texture":
				rawImage.texture = reader.Read<Texture>(ES3Type_Texture.Instance);
				break;
			case "uvRect":
				rawImage.uvRect = reader.Read<Rect>(ES3Type_Rect.Instance);
				break;
			case "onCullStateChanged":
				rawImage.onCullStateChanged = reader.Read<MaskableGraphic.CullStateChangedEvent>();
				break;
			case "maskable":
				rawImage.maskable = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "color":
				rawImage.color = reader.Read<Color>(ES3Type_Color.Instance);
				break;
			case "raycastTarget":
				rawImage.raycastTarget = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "useLegacyMeshGeneration":
				reader.SetPrivateProperty("useLegacyMeshGeneration", reader.Read<bool>(), rawImage);
				break;
			case "material":
				rawImage.material = reader.Read<Material>(ES3Type_Material.Instance);
				break;
			case "useGUILayout":
				rawImage.useGUILayout = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "enabled":
				rawImage.enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "hideFlags":
				rawImage.hideFlags = reader.Read<HideFlags>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
