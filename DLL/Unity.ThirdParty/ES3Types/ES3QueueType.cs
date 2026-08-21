using System;
using System.Collections;
using System.Collections.Generic;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3QueueType : ES3CollectionType
{
	public ES3QueueType(Type type)
		: base(type)
	{
	}

	public override void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode)
	{
		ICollection obj2 = (ICollection)obj;
		if (elementType == null)
		{
			throw new ArgumentNullException("ES3Type argument cannot be null.");
		}
		int num = 0;
		foreach (object item in obj2)
		{
			writer.StartWriteCollectionItem(num);
			writer.Write(item, elementType, memberReferenceMode);
			writer.EndWriteCollectionItem(num);
			num++;
		}
	}

	public override object Read<T>(ES3Reader reader)
	{
		return Read(reader);
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		if (reader.StartReadCollection())
		{
			throw new NullReferenceException("The Collection we are trying to load is stored as null, which is not allowed when using ReadInto methods.");
		}
		int num = 0;
		Queue<T> queue = (Queue<T>)obj;
		foreach (T item in queue)
		{
			num++;
			if (!reader.StartReadCollectionItem())
			{
				break;
			}
			reader.ReadInto<T>(item, elementType);
			if (reader.EndReadCollectionItem())
			{
				break;
			}
			if (num == queue.Count)
			{
				throw new IndexOutOfRangeException("The collection we are loading is longer than the collection provided as a parameter.");
			}
		}
		if (num != queue.Count)
		{
			throw new IndexOutOfRangeException("The collection we are loading is shorter than the collection provided as a parameter.");
		}
		reader.EndReadCollection();
	}

	public override object Read(ES3Reader reader)
	{
		IList list = (IList)ES3Reflection.CreateInstance(ES3Reflection.MakeGenericType(typeof(List<>), elementType.type));
		if (reader.StartReadCollection())
		{
			return null;
		}
		while (reader.StartReadCollectionItem())
		{
			list.Add(reader.Read<object>(elementType));
			if (reader.EndReadCollectionItem())
			{
				break;
			}
		}
		reader.EndReadCollection();
		return ES3Reflection.CreateInstance(type, list);
	}

	public override void ReadInto(ES3Reader reader, object obj)
	{
		if (reader.StartReadCollection())
		{
			throw new NullReferenceException("The Collection we are trying to load is stored as null, which is not allowed when using ReadInto methods.");
		}
		int num = 0;
		ICollection collection = (ICollection)obj;
		foreach (object item in collection)
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
			if (num == collection.Count)
			{
				throw new IndexOutOfRangeException("The collection we are loading is longer than the collection provided as a parameter.");
			}
		}
		if (num != collection.Count)
		{
			throw new IndexOutOfRangeException("The collection we are loading is shorter than the collection provided as a parameter.");
		}
		reader.EndReadCollection();
	}
}
