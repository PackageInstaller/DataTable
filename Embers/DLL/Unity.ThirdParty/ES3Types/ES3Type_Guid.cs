using System;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "value" })]
public class ES3Type_Guid : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Guid()
		: base(typeof(Guid))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WriteProperty("value", ((Guid)obj/*cast due to constrained. prefix*/).ToString(), ES3Type_string.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return Guid.Parse(reader.ReadProperty<string>(ES3Type_string.Instance));
	}
}
