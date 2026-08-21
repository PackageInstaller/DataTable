using System;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
internal class ES3ReflectedScriptableObjectType : ES3ScriptableObjectType
{
	public ES3ReflectedScriptableObjectType(Type type)
		: base(type)
	{
		isReflectedType = true;
		GetMembers(safe: true);
	}

	protected override void WriteScriptableObject(object obj, ES3Writer writer)
	{
		WriteProperties(obj, writer);
	}

	protected override void ReadScriptableObject<T>(ES3Reader reader, object obj)
	{
		ReadProperties(reader, obj);
	}
}
