using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using ES3Internal;
using ES3Types;

public abstract class ES3Reader : IDisposable
{
	[EditorBrowsable(EditorBrowsableState.Never)]
	public class ES3ReaderPropertyEnumerator
	{
		public ES3Reader reader;

		public ES3ReaderPropertyEnumerator(ES3Reader reader)
		{
			this.reader = reader;
		}

		public IEnumerator GetEnumerator()
		{
			while (true)
			{
				if (reader.overridePropertiesName != null)
				{
					string overridePropertiesName = reader.overridePropertiesName;
					reader.overridePropertiesName = null;
					yield return overridePropertiesName;
					continue;
				}
				string text;
				if ((text = reader.ReadPropertyName()) == null)
				{
					break;
				}
				yield return text;
			}
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public class ES3ReaderRawEnumerator
	{
		public ES3Reader reader;

		public ES3ReaderRawEnumerator(ES3Reader reader)
		{
			this.reader = reader;
		}

		public IEnumerator GetEnumerator()
		{
			while (true)
			{
				string text = reader.ReadPropertyName();
				if (text == null)
				{
					break;
				}
				Type type = reader.ReadTypeFromHeader<object>();
				byte[] bytes = reader.ReadElement();
				reader.ReadKeySuffix();
				if (type != null)
				{
					yield return new KeyValuePair<string, ES3Data>(text, new ES3Data(type, bytes));
				}
			}
		}
	}

	public ES3Settings settings;

	protected int serializationDepth;

	internal string overridePropertiesName;

	public virtual ES3ReaderPropertyEnumerator Properties => new ES3ReaderPropertyEnumerator(this);

	internal virtual ES3ReaderRawEnumerator RawEnumerator => new ES3ReaderRawEnumerator(this);

	internal abstract int Read_int();

	internal abstract float Read_float();

	internal abstract bool Read_bool();

	internal abstract char Read_char();

	internal abstract decimal Read_decimal();

	internal abstract double Read_double();

	internal abstract long Read_long();

	internal abstract ulong Read_ulong();

	internal abstract byte Read_byte();

	internal abstract sbyte Read_sbyte();

	internal abstract short Read_short();

	internal abstract ushort Read_ushort();

	internal abstract uint Read_uint();

	internal abstract string Read_string();

	internal abstract byte[] Read_byteArray();

	internal abstract long Read_ref();

	[EditorBrowsable(EditorBrowsableState.Never)]
	public abstract string ReadPropertyName();

	protected abstract Type ReadKeyPrefix(bool ignore = false);

	protected abstract void ReadKeySuffix();

	internal abstract byte[] ReadElement(bool skip = false);

	public abstract void Dispose();

	internal virtual bool Goto(string key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("Key cannot be NULL when loading data.");
		}
		string text;
		while ((text = ReadPropertyName()) != key)
		{
			if (text == null)
			{
				return false;
			}
			Skip();
		}
		return true;
	}

	internal virtual bool StartReadObject()
	{
		serializationDepth++;
		return false;
	}

	internal virtual void EndReadObject()
	{
		serializationDepth--;
	}

	internal abstract bool StartReadDictionary();

	internal abstract void EndReadDictionary();

	internal abstract bool StartReadDictionaryKey();

	internal abstract void EndReadDictionaryKey();

	internal abstract void StartReadDictionaryValue();

	internal abstract bool EndReadDictionaryValue();

	internal abstract bool StartReadCollection();

	internal abstract void EndReadCollection();

	internal abstract bool StartReadCollectionItem();

	internal abstract bool EndReadCollectionItem();

	internal ES3Reader(ES3Settings settings, bool readHeaderAndFooter = true)
	{
		this.settings = settings;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void Skip()
	{
		ReadElement(skip: true);
	}

	public virtual T Read<T>()
	{
		return Read<T>(ES3TypeMgr.GetOrCreateES3Type(typeof(T)));
	}

	public virtual void ReadInto<T>(object obj)
	{
		ReadInto<T>(obj, ES3TypeMgr.GetOrCreateES3Type(typeof(T)));
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public T ReadProperty<T>()
	{
		return ReadProperty<T>(ES3TypeMgr.GetOrCreateES3Type(typeof(T)));
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public T ReadProperty<T>(ES3Type type)
	{
		ReadPropertyName();
		return Read<T>(type);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public long ReadRefProperty()
	{
		ReadPropertyName();
		return Read_ref();
	}

	internal Type ReadType()
	{
		return ES3Reflection.GetType(Read<string>(ES3Type_string.Instance));
	}

	public object SetPrivateProperty(string name, object value, object objectContainingProperty)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedProperty = ES3Reflection.GetES3ReflectedProperty(objectContainingProperty.GetType(), name);
		if (eS3ReflectedProperty.IsNull)
		{
			throw new MissingMemberException("A private property named " + name + " does not exist in the type " + objectContainingProperty.GetType());
		}
		eS3ReflectedProperty.SetValue(objectContainingProperty, value);
		return objectContainingProperty;
	}

	public object SetPrivateField(string name, object value, object objectContainingField)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedMember = ES3Reflection.GetES3ReflectedMember(objectContainingField.GetType(), name);
		if (eS3ReflectedMember.IsNull)
		{
			throw new MissingMemberException("A private field named " + name + " does not exist in the type " + objectContainingField.GetType());
		}
		eS3ReflectedMember.SetValue(objectContainingField, value);
		return objectContainingField;
	}

	public virtual T Read<T>(string key)
	{
		if (!Goto(key))
		{
			throw new KeyNotFoundException("Key \"" + key + "\" was not found in file \"" + settings.FullPath + "\". Use Load<T>(key, defaultValue) if you want to return a default value if the key does not exist.");
		}
		Type type = ReadTypeFromHeader<T>();
		return Read<T>(ES3TypeMgr.GetOrCreateES3Type(type));
	}

	public virtual T Read<T>(string key, T defaultValue)
	{
		if (!Goto(key))
		{
			return defaultValue;
		}
		Type type = ReadTypeFromHeader<T>();
		return Read<T>(ES3TypeMgr.GetOrCreateES3Type(type));
	}

	public virtual void ReadInto<T>(string key, T obj) where T : class
	{
		if (!Goto(key))
		{
			throw new KeyNotFoundException("Key \"" + key + "\" was not found in file \"" + settings.FullPath + "\"");
		}
		Type type = ReadTypeFromHeader<T>();
		ReadInto<T>(obj, ES3TypeMgr.GetOrCreateES3Type(type));
	}

	protected virtual void ReadObject<T>(object obj, ES3Type type)
	{
		if (!StartReadObject())
		{
			type.ReadInto<T>(this, obj);
			EndReadObject();
		}
	}

	protected virtual T ReadObject<T>(ES3Type type)
	{
		if (StartReadObject())
		{
			return default(T);
		}
		object obj = type.Read<T>(this);
		EndReadObject();
		return (T)obj;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual T Read<T>(ES3Type type)
	{
		if (type == null || type.isUnsupported)
		{
			throw new NotSupportedException("Type of " + type?.ToString() + " is not currently supported, and could not be loaded using reflection.");
		}
		if (type.isPrimitive)
		{
			return (T)type.Read<T>(this);
		}
		if (type.isCollection)
		{
			return (T)((ES3CollectionType)type).Read(this);
		}
		if (type.isDictionary)
		{
			return (T)((ES3DictionaryType)type).Read(this);
		}
		return ReadObject<T>(type);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void ReadInto<T>(object obj, ES3Type type)
	{
		if (type == null || type.isUnsupported)
		{
			throw new NotSupportedException("Type of " + obj.GetType()?.ToString() + " is not currently supported, and could not be loaded using reflection.");
		}
		if (type.isCollection)
		{
			((ES3CollectionType)type).ReadInto(this, obj);
		}
		else if (type.isDictionary)
		{
			((ES3DictionaryType)type).ReadInto(this, obj);
		}
		else
		{
			ReadObject<T>(obj, type);
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal Type ReadTypeFromHeader<T>()
	{
		if (typeof(T) == typeof(object))
		{
			return ReadKeyPrefix();
		}
		if (settings.typeChecking)
		{
			Type type = ReadKeyPrefix();
			if (type != typeof(T))
			{
				throw new InvalidOperationException("Trying to load data of type " + typeof(T)?.ToString() + ", but data contained in file is type of " + type?.ToString() + ".");
			}
			return type;
		}
		ReadKeyPrefix(ignore: true);
		return typeof(T);
	}

	public static ES3Reader Create()
	{
		return Create(new ES3Settings());
	}

	public static ES3Reader Create(string filePath)
	{
		return Create(new ES3Settings(filePath));
	}

	public static ES3Reader Create(string filePath, ES3Settings settings)
	{
		return Create(new ES3Settings(filePath, settings));
	}

	public static ES3Reader Create(ES3Settings settings)
	{
		Stream stream = ES3Stream.CreateStream(settings, ES3FileMode.Read);
		if (stream == null)
		{
			return null;
		}
		if (settings.format == ES3.Format.JSON)
		{
			return new ES3JSONReader(stream, settings);
		}
		return null;
	}

	public static ES3Reader Create(byte[] bytes)
	{
		return Create(bytes, new ES3Settings());
	}

	public static ES3Reader Create(byte[] bytes, ES3Settings settings)
	{
		Stream stream = ES3Stream.CreateStream(new MemoryStream(bytes), settings, ES3FileMode.Read);
		if (stream == null)
		{
			return null;
		}
		if (settings.format == ES3.Format.JSON)
		{
			return new ES3JSONReader(stream, settings);
		}
		return null;
	}

	internal static ES3Reader Create(Stream stream, ES3Settings settings)
	{
		stream = ES3Stream.CreateStream(stream, settings, ES3FileMode.Read);
		if (settings.format == ES3.Format.JSON)
		{
			return new ES3JSONReader(stream, settings);
		}
		return null;
	}

	internal static ES3Reader Create(Stream stream, ES3Settings settings, bool readHeaderAndFooter)
	{
		if (settings.format == ES3.Format.JSON)
		{
			return new ES3JSONReader(stream, settings, readHeaderAndFooter);
		}
		return null;
	}
}
