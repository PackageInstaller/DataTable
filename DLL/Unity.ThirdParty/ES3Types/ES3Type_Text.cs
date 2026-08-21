using UnityEngine;
using UnityEngine.Scripting;
using UnityEngine.UI;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"font", "text", "supportRichText", "resizeTextForBestFit", "resizeTextMinSize", "resizeTextMaxSize", "alignment", "alignByGeometry", "fontSize", "horizontalOverflow",
	"verticalOverflow", "lineSpacing", "fontStyle", "onCullStateChanged", "maskable", "color", "raycastTarget", "material", "useGUILayout", "enabled",
	"tag", "name", "hideFlags"
})]
public class ES3Type_Text : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_Text()
		: base(typeof(Text))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		Text text = (Text)obj;
		writer.WriteProperty("text", text.text);
		writer.WriteProperty("supportRichText", text.supportRichText);
		writer.WriteProperty("resizeTextForBestFit", text.resizeTextForBestFit);
		writer.WriteProperty("resizeTextMinSize", text.resizeTextMinSize);
		writer.WriteProperty("resizeTextMaxSize", text.resizeTextMaxSize);
		writer.WriteProperty("alignment", text.alignment);
		writer.WriteProperty("alignByGeometry", text.alignByGeometry);
		writer.WriteProperty("fontSize", text.fontSize);
		writer.WriteProperty("horizontalOverflow", text.horizontalOverflow);
		writer.WriteProperty("verticalOverflow", text.verticalOverflow);
		writer.WriteProperty("lineSpacing", text.lineSpacing);
		writer.WriteProperty("fontStyle", text.fontStyle);
		writer.WriteProperty("onCullStateChanged", text.onCullStateChanged);
		writer.WriteProperty("maskable", text.maskable);
		writer.WriteProperty("color", text.color);
		writer.WriteProperty("raycastTarget", text.raycastTarget);
		if (text.material.name.Contains("Default"))
		{
			writer.WriteProperty("material", null);
		}
		else
		{
			writer.WriteProperty("material", text.material);
		}
		writer.WriteProperty("useGUILayout", text.useGUILayout);
		writer.WriteProperty("enabled", text.enabled);
		writer.WriteProperty("hideFlags", text.hideFlags);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		//IL_0507: Unknown result type (might be due to invalid IL or missing references)
		//IL_053a: Unknown result type (might be due to invalid IL or missing references)
		//IL_056d: Unknown result type (might be due to invalid IL or missing references)
		//IL_054b: Unknown result type (might be due to invalid IL or missing references)
		Text text = (Text)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "m_FontData":
				reader.SetPrivateField("m_FontData", reader.Read<FontData>(), text);
				break;
			case "m_LastTrackedFont":
				reader.SetPrivateField("m_LastTrackedFont", reader.Read<Font>(), text);
				break;
			case "m_Text":
				reader.SetPrivateField("m_Text", reader.Read<string>(), text);
				break;
			case "m_TextCache":
				reader.SetPrivateField("m_TextCache", reader.Read<TextGenerator>(), text);
				break;
			case "m_TextCacheForLayout":
				reader.SetPrivateField("m_TextCacheForLayout", reader.Read<TextGenerator>(), text);
				break;
			case "m_Material":
				reader.SetPrivateField("m_Material", reader.Read<Material>(), text);
				break;
			case "font":
				text.font = reader.Read<Font>();
				break;
			case "text":
				text.text = reader.Read<string>();
				break;
			case "supportRichText":
				text.supportRichText = reader.Read<bool>();
				break;
			case "resizeTextForBestFit":
				text.resizeTextForBestFit = reader.Read<bool>();
				break;
			case "resizeTextMinSize":
				text.resizeTextMinSize = reader.Read<int>();
				break;
			case "resizeTextMaxSize":
				text.resizeTextMaxSize = reader.Read<int>();
				break;
			case "alignment":
				text.alignment = reader.Read<TextAnchor>();
				break;
			case "alignByGeometry":
				text.alignByGeometry = reader.Read<bool>();
				break;
			case "fontSize":
				text.fontSize = reader.Read<int>();
				break;
			case "horizontalOverflow":
				text.horizontalOverflow = reader.Read<HorizontalWrapMode>();
				break;
			case "verticalOverflow":
				text.verticalOverflow = reader.Read<VerticalWrapMode>();
				break;
			case "lineSpacing":
				text.lineSpacing = reader.Read<float>();
				break;
			case "fontStyle":
				text.fontStyle = reader.Read<FontStyle>();
				break;
			case "onCullStateChanged":
				text.onCullStateChanged = reader.Read<MaskableGraphic.CullStateChangedEvent>();
				break;
			case "maskable":
				text.maskable = reader.Read<bool>();
				break;
			case "color":
				text.color = reader.Read<Color>();
				break;
			case "raycastTarget":
				text.raycastTarget = reader.Read<bool>();
				break;
			case "material":
				text.material = reader.Read<Material>();
				break;
			case "useGUILayout":
				text.useGUILayout = reader.Read<bool>();
				break;
			case "enabled":
				text.enabled = reader.Read<bool>();
				break;
			case "hideFlags":
				text.hideFlags = reader.Read<HideFlags>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
