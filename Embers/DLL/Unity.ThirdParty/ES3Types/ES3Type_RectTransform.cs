using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"anchorMin", "anchorMax", "anchoredPosition", "sizeDelta", "pivot", "offsetMin", "offsetMax", "localPosition", "localRotation", "localScale",
	"parent", "hideFlags"
})]
public class ES3Type_RectTransform : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_RectTransform()
		: base(typeof(RectTransform))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		RectTransform rectTransform = (RectTransform)obj;
		writer.WritePropertyByRef("parent", rectTransform.parent);
		writer.WriteProperty("anchorMin", rectTransform.anchorMin, ES3Type_Vector2.Instance);
		writer.WriteProperty("anchorMax", rectTransform.anchorMax, ES3Type_Vector2.Instance);
		writer.WriteProperty("anchoredPosition", rectTransform.anchoredPosition, ES3Type_Vector2.Instance);
		writer.WriteProperty("sizeDelta", rectTransform.sizeDelta, ES3Type_Vector2.Instance);
		writer.WriteProperty("pivot", rectTransform.pivot, ES3Type_Vector2.Instance);
		writer.WriteProperty("offsetMin", rectTransform.offsetMin, ES3Type_Vector2.Instance);
		writer.WriteProperty("offsetMax", rectTransform.offsetMax, ES3Type_Vector2.Instance);
		writer.WriteProperty("localPosition", rectTransform.localPosition, ES3Type_Vector3.Instance);
		writer.WriteProperty("localRotation", rectTransform.localRotation, ES3Type_Quaternion.Instance);
		writer.WriteProperty("localScale", rectTransform.localScale, ES3Type_Vector3.Instance);
		writer.WriteProperty("hideFlags", rectTransform.hideFlags);
		writer.WriteProperty("siblingIndex", rectTransform.GetSiblingIndex());
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		if (obj.GetType() == typeof(Transform))
		{
			obj = ((Transform)obj).gameObject.AddComponent<RectTransform>();
		}
		RectTransform rectTransform = (RectTransform)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "anchorMin":
				rectTransform.anchorMin = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "anchorMax":
				rectTransform.anchorMax = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "anchoredPosition":
				rectTransform.anchoredPosition = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "sizeDelta":
				rectTransform.sizeDelta = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "pivot":
				rectTransform.pivot = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "offsetMin":
				rectTransform.offsetMin = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "offsetMax":
				rectTransform.offsetMax = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "localPosition":
				rectTransform.localPosition = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "localRotation":
				rectTransform.localRotation = reader.Read<Quaternion>(ES3Type_Quaternion.Instance);
				break;
			case "localScale":
				rectTransform.localScale = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "parent":
				rectTransform.SetParent(reader.Read<Transform>(ES3Type_Transform.Instance));
				break;
			case "hierarchyCapacity":
				rectTransform.hierarchyCapacity = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "hideFlags":
				rectTransform.hideFlags = reader.Read<HideFlags>();
				break;
			case "siblingIndex":
				rectTransform.SetSiblingIndex(reader.Read<int>());
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
