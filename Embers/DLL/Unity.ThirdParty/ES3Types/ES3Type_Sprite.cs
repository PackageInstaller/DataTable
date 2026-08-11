using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "texture", "rect", "pivot", "pixelsPerUnit", "border" })]
public class ES3Type_Sprite : ES3UnityObjectType
{
	public static ES3Type Instance;

	public ES3Type_Sprite()
		: base(typeof(Sprite))
	{
		Instance = this;
	}

	protected override void WriteUnityObject(object obj, ES3Writer writer)
	{
		Sprite sprite = (Sprite)obj;
		writer.WriteProperty("texture", sprite.texture, ES3Type_Texture2D.Instance);
		writer.WriteProperty("rect", sprite.rect, ES3Type_Rect.Instance);
		writer.WriteProperty("pivot", new Vector2(sprite.pivot.x / (float)sprite.texture.width, sprite.pivot.y / (float)sprite.texture.height), ES3Type_Vector2.Instance);
		writer.WriteProperty("pixelsPerUnit", sprite.pixelsPerUnit, ES3Type_float.Instance);
		writer.WriteProperty("border", sprite.border, ES3Type_Vector4.Instance);
	}

	protected override void ReadUnityObject<T>(ES3Reader reader, object obj)
	{
		foreach (string property in reader.Properties)
		{
			_ = property;
			reader.Skip();
		}
	}

	protected override object ReadUnityObject<T>(ES3Reader reader)
	{
		Texture2D texture = null;
		Rect rect = Rect.zero;
		Vector2 pivot = Vector2.zero;
		float pixelsPerUnit = 0f;
		Vector4 border = Vector4.zero;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "texture":
				texture = reader.Read<Texture2D>(ES3Type_Texture2D.Instance);
				break;
			case "textureRect":
			case "rect":
				rect = reader.Read<Rect>(ES3Type_Rect.Instance);
				break;
			case "pivot":
				pivot = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "pixelsPerUnit":
				pixelsPerUnit = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "border":
				border = reader.Read<Vector4>(ES3Type_Vector4.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return Sprite.Create(texture, rect, pivot, pixelsPerUnit, 0u, SpriteMeshType.Tight, border);
	}
}
