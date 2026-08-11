using System;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3Type_DateTime : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_DateTime()
		: base(typeof(DateTime))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WriteProperty("ticks", ((DateTime)obj).Ticks, ES3Type_long.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		reader.ReadPropertyName();
		return new DateTime(reader.Read<long>(ES3Type_long.Instance));
	}
}
