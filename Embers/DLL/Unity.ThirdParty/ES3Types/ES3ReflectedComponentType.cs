using System;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
internal class ES3ReflectedComponentType : ES3ComponentType
{
	public ES3ReflectedComponentType(Type type)
		: base(type)
	{
		isReflectedType = true;
		GetMembers(safe: true);
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		WriteProperties(obj, writer);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		ReadProperties(reader, obj);
	}
}
