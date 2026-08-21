using System;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
internal class ES3ReflectedValueType : ES3Type
{
	public ES3ReflectedValueType(Type type)
		: base(type)
	{
		isReflectedType = true;
		GetMembers(safe: true);
	}

	public override void Write(object obj, ES3Writer writer)
	{
		WriteProperties(obj, writer);
	}

	public override object Read<T>(ES3Reader reader)
	{
		object obj = ES3Reflection.CreateInstance(type);
		if (obj == null)
		{
			throw new NotSupportedException("Cannot create an instance of " + type?.ToString() + ". However, you may be able to add support for it using a custom ES3Type file. For more information see: http://docs.moodkie.com/easy-save-3/es3-guides/controlling-serialization-using-es3types/");
		}
		return ReadProperties(reader, obj);
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		throw new NotSupportedException("Cannot perform self-assigning load on a value type.");
	}
}
