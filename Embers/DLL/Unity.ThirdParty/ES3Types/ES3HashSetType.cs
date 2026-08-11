using System;
using System.Collections;
using System.Collections.Generic;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3HashSetType : ES3CollectionType
{
	public ES3HashSetType(Type type)
		: base(type)
	{
	}

	public override void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode)
	{
		if (obj == null)
		{
			writer.WriteNull();
			return;
		}
		IEnumerable enumerable = (IEnumerable)obj;
		if (elementType == null)
		{
			throw new ArgumentNullException("ES3Type argument cannot be null.");
		}
		int num = 0;
		foreach (object item in enumerable)
		{
			_ = item;
			num++;
		}
		int num2 = 0;
		foreach (object item2 in enumerable)
		{
			writer.StartWriteCollectionItem(num2);
			writer.Write(item2, elementType, memberReferenceMode);
			writer.EndWriteCollectionItem(num2);
			num2++;
		}
	}

	public override object Read<T>(ES3Reader reader)
	{
		object obj = Read(reader);
		if (obj == null)
		{
			return default(T);
		}
		return (T)obj;
	}

	public override object Read(ES3Reader reader)
	{
		Type genericParam = ES3Reflection.GetGenericArguments(type)[0];
		IList list = (IList)ES3Reflection.CreateInstance(ES3Reflection.MakeGenericType(typeof(List<>), genericParam));
		if (!reader.StartReadCollection())
		{
			while (reader.StartReadCollectionItem())
			{
				list.Add(reader.Read<object>(elementType));
				if (reader.EndReadCollectionItem())
				{
					break;
				}
			}
			reader.EndReadCollection();
		}
		return ES3Reflection.CreateInstance(type, list);
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		ReadInto(reader, obj);
	}

	public override void ReadInto(ES3Reader reader, object obj)
	{
		throw new NotImplementedException("Cannot use LoadInto/ReadInto with HashSet because HashSets do not maintain the order of elements");
	}
}
