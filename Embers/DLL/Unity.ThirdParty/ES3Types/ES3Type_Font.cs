using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "material", "name" })]
public class ES3Type_Font : ES3UnityObjectType
{
	public static ES3Type Instance;

	public ES3Type_Font()
		: base(typeof(Font))
	{
		Instance = this;
	}

	protected override void WriteUnityObject(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		Font val = (Font)obj;
		writer.WriteProperty("name", ((Object)(object)val).name, ES3Type_string.Instance);
		writer.WriteProperty("material", val.material);
	}

	protected override void ReadUnityObject<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		Font val = (Font)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			if (text == "material")
			{
				val.material = reader.Read<Material>(ES3Type_Material.Instance);
			}
			else
			{
				reader.Skip();
			}
		}
	}

	protected override object ReadUnityObject<T>(ES3Reader reader)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Expected O, but got Unknown
		Font val = new Font(reader.ReadProperty<string>(ES3Type_string.Instance));
		ReadObject<T>(reader, val);
		return val;
	}
}
