using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ES3Internal;
using Unity.Collections;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3NativeArrayType : ES3CollectionType
{
	public ES3NativeArrayType(Type type)
		: base(type)
	{
	}

	public ES3NativeArrayType(Type type, ES3Type elementType)
		: base(type, elementType)
	{
	}

	public override void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode)
	{
		if (elementType == null)
		{
			throw new ArgumentNullException("ES3Type argument cannot be null.");
		}
		IEnumerable obj2 = (IEnumerable)obj;
		int num = 0;
		foreach (object item in obj2)
		{
			writer.StartWriteCollectionItem(num);
			writer.Write(item, elementType, memberReferenceMode);
			writer.EndWriteCollectionItem(num);
			num++;
		}
	}

	public override object Read(ES3Reader reader)
	{
		Array array = ReadAsArray(reader);
		return ES3Reflection.CreateInstance(type, array, Allocator.Persistent);
	}

	public override object Read<T>(ES3Reader reader)
	{
		return Read(reader);
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		ReadInto(reader, obj);
	}

	public override void ReadInto(ES3Reader reader, object obj)
	{
		Array array = ReadAsArray(reader);
		ES3Reflection.GetMethods(type, "CopyFrom").First((MethodInfo m) => ES3Reflection.TypeIsArray(m.GetParameters()[0].GetType())).Invoke(obj, new object[1] { array });
	}

	private Array ReadAsArray(ES3Reader reader)
	{
		List<object> list = new List<object>();
		if (!ReadICollection(reader, list, elementType))
		{
			return null;
		}
		Array array = ES3Reflection.ArrayCreateInstance(elementType.type, list.Count);
		int num = 0;
		foreach (object item in list)
		{
			array.SetValue(item, num);
			num++;
		}
		return array;
	}
}
