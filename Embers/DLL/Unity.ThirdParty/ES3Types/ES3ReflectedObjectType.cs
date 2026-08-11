using System;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
internal class ES3ReflectedObjectType : ES3ObjectType
{
	public ES3ReflectedObjectType(Type type)
		: base(type)
	{
		isReflectedType = true;
		GetMembers(safe: true);
	}

	protected override void WriteObject(object obj, ES3Writer writer)
	{
		WriteProperties(obj, writer);
	}

	protected override object ReadObject<T>(ES3Reader reader)
	{
		object obj = ES3Reflection.CreateInstance(type);
		ReadProperties(reader, obj);
		return obj;
	}

	protected override void ReadObject<T>(ES3Reader reader, object obj)
	{
		ReadProperties(reader, obj);
	}
}
