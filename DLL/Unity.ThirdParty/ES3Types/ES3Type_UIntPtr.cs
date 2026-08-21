using System;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3Type_UIntPtr : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_UIntPtr()
		: base(typeof(UIntPtr))
	{
		isPrimitive = true;
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		writer.WritePrimitive((ulong)obj);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return reader.Read_ulong();
	}
}
