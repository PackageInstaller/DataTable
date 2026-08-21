using System;
using System.Collections;
using System.Collections.Generic;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public abstract class ES3CollectionType : ES3Type
{
	public ES3Type elementType;

	public abstract object Read(ES3Reader reader);

	public abstract void ReadInto(ES3Reader reader, object obj);

	public abstract void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode);

	public ES3CollectionType(Type type)
		: base(type)
	{
		elementType = ES3TypeMgr.GetOrCreateES3Type(ES3Reflection.GetElementTypes(type)[0], throwException: false);
		isCollection = true;
		if (elementType == null)
		{
			isUnsupported = true;
		}
	}

	public ES3CollectionType(Type type, ES3Type elementType)
		: base(type)
	{
		this.elementType = elementType;
		isCollection = true;
	}

	[Preserve]
	public override void Write(object obj, ES3Writer writer)
	{
		Write(obj, writer, ES3.ReferenceMode.ByRefAndValue);
	}

	protected virtual bool ReadICollection<T>(ES3Reader reader, ICollection<T> collection, ES3Type elementType)
	{
		if (reader.StartReadCollection())
		{
			return false;
		}
		while (reader.StartReadCollectionItem())
		{
			collection.Add(reader.Read<T>(elementType));
			if (reader.EndReadCollectionItem())
			{
				break;
			}
		}
		reader.EndReadCollection();
		return true;
	}

	protected virtual void ReadICollectionInto<T>(ES3Reader reader, ICollection<T> collection, ES3Type elementType)
	{
		ReadICollectionInto(reader, collection, elementType);
	}

	[Preserve]
	protected virtual void ReadICollectionInto(ES3Reader reader, ICollection collection, ES3Type elementType)
	{
		if (reader.StartReadCollection())
		{
			throw new NullReferenceException("The Collection we are trying to load is stored as null, which is not allowed when using ReadInto methods.");
		}
		int num = 0;
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
