using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "hideFlags" })]
public class ES3Type_Flare : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Flare()
		: base(typeof(Flare))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Flare flare = (Flare)obj;
		writer.WriteProperty("hideFlags", flare.hideFlags);
	}

	public override object Read<T>(ES3Reader reader)
	{
		Flare flare = new Flare();
		ReadInto<T>(reader, flare);
		return flare;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		Flare flare = (Flare)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			if (text == "hideFlags")
			{
				flare.hideFlags = reader.Read<HideFlags>();
			}
			else
			{
				reader.Skip();
			}
		}
	}
}
