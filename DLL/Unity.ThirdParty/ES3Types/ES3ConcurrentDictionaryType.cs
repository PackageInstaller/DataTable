using System;
using System.Collections;
using System.Collections.Generic;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3ConcurrentDictionaryType : ES3Type
{
	public ES3Type keyType;

	public ES3Type valueType;

	protected ES3Reflection.ES3ReflectedMethod readMethod;

	protected ES3Reflection.ES3ReflectedMethod readIntoMethod;

	public ES3ConcurrentDictionaryType(Type type)
		: base(type)
	{
		Type[] elementTypes = ES3Reflection.GetElementTypes(type);
		keyType = ES3TypeMgr.GetOrCreateES3Type(elementTypes[0], throwException: false);
		valueType = ES3TypeMgr.GetOrCreateES3Type(elementTypes[1], throwException: false);
		if (keyType == null || valueType == null)
		{
			isUnsupported = true;
		}
		isDictionary = true;
	}

	public ES3ConcurrentDictionaryType(Type type, ES3Type keyType, ES3Type valueType)
		: base(type)
	{
		this.keyType = keyType;
		this.valueType = valueType;
		if (keyType == null || valueType == null)
		{
			isUnsupported = true;
		}
		isDictionary = true;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Write(obj, writer, writer.settings.memberReferenceMode);
	}

	public void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode)
	{
		IDictionary obj2 = (IDictionary)obj;
		int num = 0;
		foreach (DictionaryEntry item in obj2)
		{
			writer.StartWriteDictionaryKey(num);
			writer.Write(item.Key, keyType, memberReferenceMode);
			writer.EndWriteDictionaryKey(num);
			writer.StartWriteDictionaryValue(num);
			writer.Write(item.Value, valueType, memberReferenceMode);
			writer.EndWriteDictionaryValue(num);
			num++;
		}
	}

	public override object Read<T>(ES3Reader reader)
	{
		return Read(reader);
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		ReadInto(reader, obj);
	}

	public object Read(ES3Reader reader)
	{
		if (reader.StartReadDictionary())
		{
			return null;
		}
		IDictionary dictionary = (IDictionary)ES3Reflection.CreateInstance(type);
		do
		{
			if (!reader.StartReadDictionaryKey())
			{
				return dictionary;
			}
			object key = reader.Read<object>(keyType);
			reader.EndReadDictionaryKey();
			reader.StartReadDictionaryValue();
			object value = reader.Read<object>(valueType);
			dictionary.Add(key, value);
		}
		while (!reader.EndReadDictionaryValue());
		reader.EndReadDictionary();
		return dictionary;
	}

	public void ReadInto(ES3Reader reader, object obj)
	{
		if (reader.StartReadDictionary())
		{
			throw new NullReferenceException("The Dictionary we are trying to load is stored as null, which is not allowed when using ReadInto methods.");
		}
		IDictionary dictionary = (IDictionary)obj;
		do
		{
			if (!reader.StartReadDictionaryKey())
			{
				return;
			}
			object obj2 = reader.Read<object>(keyType);
			if (!dictionary.Contains(obj2))
			{
				throw new KeyNotFoundException("The key \"" + obj2?.ToString() + "\" in the Dictionary we are loading does not exist in the Dictionary we are loading into");
			}
			object obj3 = dictionary[obj2];
			reader.EndReadDictionaryKey();
			reader.StartReadDictionaryValue();
			reader.ReadInto<object>(obj3, valueType);
		}
		while (!reader.EndReadDictionaryValue());
		reader.EndReadDictionary();
	}
}
