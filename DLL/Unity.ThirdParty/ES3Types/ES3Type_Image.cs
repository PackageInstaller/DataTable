using UnityEngine;
using UnityEngine.Scripting;
using UnityEngine.UI;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"sprite", "overrideSprite", "type", "preserveAspect", "fillCenter", "fillMethod", "fillAmount", "fillClockwise", "fillOrigin", "alphaHitTestMinimumThreshold",
	"useSpriteMesh", "pixelsPerUnitMultiplier", "material", "onCullStateChanged", "maskable", "color", "raycastTarget", "useLegacyMeshGeneration", "useGUILayout", "enabled",
	"hideFlags"
})]
public class ES3Type_Image : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_Image()
		: base(typeof(Image))
	{
		Instance = this;
		priority = 1;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		Image image = (Image)obj;
		writer.WritePropertyByRef("sprite", image.sprite);
		writer.WriteProperty("type", image.type);
		writer.WriteProperty("preserveAspect", image.preserveAspect, ES3Type_bool.Instance);
		writer.WriteProperty("fillCenter", image.fillCenter, ES3Type_bool.Instance);
		writer.WriteProperty("fillMethod", image.fillMethod);
		writer.WriteProperty("fillAmount", image.fillAmount, ES3Type_float.Instance);
		writer.WriteProperty("fillClockwise", image.fillClockwise, ES3Type_bool.Instance);
		writer.WriteProperty("fillOrigin", image.fillOrigin, ES3Type_int.Instance);
		writer.WriteProperty("alphaHitTestMinimumThreshold", image.alphaHitTestMinimumThreshold, ES3Type_float.Instance);
		writer.WriteProperty("useSpriteMesh", image.useSpriteMesh, ES3Type_bool.Instance);
		if (image.material.name.Contains("Default"))
		{
			writer.WriteProperty("material", null);
		}
		else
		{
			writer.WriteProperty("material", image.material);
		}
		writer.WriteProperty("onCullStateChanged", image.onCullStateChanged);
		writer.WriteProperty("maskable", image.maskable, ES3Type_bool.Instance);
		writer.WriteProperty("color", image.color, ES3Type_Color.Instance);
		writer.WriteProperty("raycastTarget", image.raycastTarget, ES3Type_bool.Instance);
		writer.WritePrivateProperty("useLegacyMeshGeneration", image);
		writer.WriteProperty("useGUILayout", image.useGUILayout, ES3Type_bool.Instance);
		writer.WriteProperty("enabled", image.enabled, ES3Type_bool.Instance);
		writer.WriteProperty("hideFlags", image.hideFlags, ES3Type_enum.Instance);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		Image image = (Image)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "sprite":
				image.sprite = reader.Read<Sprite>(ES3Type_Sprite.Instance);
				break;
			case "type":
				image.type = reader.Read<Image.Type>();
				break;
			case "preserveAspect":
				image.preserveAspect = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "fillCenter":
				image.fillCenter = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "fillMethod":
				image.fillMethod = reader.Read<Image.FillMethod>();
				break;
			case "fillAmount":
				image.fillAmount = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "fillClockwise":
				image.fillClockwise = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "fillOrigin":
				image.fillOrigin = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "alphaHitTestMinimumThreshold":
				image.alphaHitTestMinimumThreshold = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "useSpriteMesh":
				image.useSpriteMesh = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "material":
				image.material = reader.Read<Material>(ES3Type_Material.Instance);
				break;
			case "onCullStateChanged":
				image.onCullStateChanged = reader.Read<MaskableGraphic.CullStateChangedEvent>();
				break;
			case "maskable":
				image.maskable = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "color":
				image.color = reader.Read<Color>(ES3Type_Color.Instance);
				break;
			case "raycastTarget":
				image.raycastTarget = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "useLegacyMeshGeneration":
				reader.SetPrivateProperty("useLegacyMeshGeneration", reader.Read<bool>(), image);
				break;
			case "useGUILayout":
				image.useGUILayout = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "enabled":
				image.enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "hideFlags":
				image.hideFlags = reader.Read<HideFlags>(ES3Type_enum.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
