using System;
using System.Collections;
using System.Collections.Generic;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3ArrayType : ES3CollectionType
{
	public ES3ArrayType(Type type)
		: base(type)
	{
	}

	public ES3ArrayType(Type type, ES3Type elementType)
		: base(type, elementType)
	{
	}

	public override void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode)
	{
		Array array = (Array)obj;
		if (elementType == null)
		{
			throw new ArgumentNullException("ES3Type argument cannot be null.");
		}
		for (int i = 0; i < array.Length; i++)
		{
			writer.StartWriteCollectionItem(i);
			writer.Write(array.GetValue(i), elementType, memberReferenceMode);
			writer.EndWriteCollectionItem(i);
		}
	}

	public override object Read(ES3Reader reader)
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

	public override object Read<T>(ES3Reader reader)
	{
		return Read(reader);
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		ReadICollectionInto(reader, (ICollection)obj, elementType);
	}

	public override void ReadInto(ES3Reader reader, object obj)
	{
		IList list = (IList)obj;
		if (list.Count == 0)
		{
			ES3Debug.LogWarning("LoadInto/ReadInto expects a collection containing instances to load data in to, but the collection is empty.");
		}
		if (reader.StartReadCollection())
		{
			throw new NullReferenceException("The Collection we are trying to load is stored as null, which is not allowed when using ReadInto methods.");
		}
		int num = 0;
		foreach (object item in list)
		{
			num++;
			if (!reader.StartReadCollectionItem())
			{
				break;
			}
			reader.ReadInto<object>(item, elementType);
			if (reader.EndReadCollectionItem())
			{
				break;
			}
			if (num == list.Count)
			{
				throw new IndexOutOfRangeException("The collection we are loading is longer than the collection provided as a parameter.");
			}
		}
		if (num != list.Count)
		{
			throw new IndexOutOfRangeException("The collection we are loading is shorter than the collection provided as a parameter.");
		}
		reader.EndReadCollection();
	}
}
