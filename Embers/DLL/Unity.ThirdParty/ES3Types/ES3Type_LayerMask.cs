using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "colorKeys", "alphaKeys", "mode" })]
[Preserve]
public class ES3Type_LayerMask : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_LayerMask()
		: base(typeof(LayerMask))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WriteProperty("value", ((LayerMask)obj).value, ES3Type_int.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		LayerMask layerMask = default(LayerMask);
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			if (text == "value")
			{
				layerMask = reader.Read<int>(ES3Type_int.Instance);
			}
			else
			{
				reader.Skip();
			}
		}
		return layerMask;
	}
}
