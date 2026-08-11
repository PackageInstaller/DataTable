using System;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
internal class ES3ReflectedUnityObjectType : ES3UnityObjectType
{
	public ES3ReflectedUnityObjectType(Type type)
		: base(type)
	{
		isReflectedType = true;
		GetMembers(safe: true);
	}

	protected override void WriteUnityObject(object obj, ES3Writer writer)
	{
		WriteProperties(obj, writer);
	}

	protected override object ReadUnityObject<T>(ES3Reader reader)
	{
		object obj = ES3Reflection.CreateInstance(type);
		ReadProperties(reader, obj);
		return obj;
	}

	protected override void ReadUnityObject<T>(ES3Reader reader, object obj)
	{
		ReadProperties(reader, obj);
	}
}
