using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using ES3Internal;
using ES3Types;
using UnityEngine;

public abstract class ES3Writer : IDisposable
{
	public ES3Settings settings;

	protected HashSet<string> keysToDelete = new HashSet<string>();

	internal bool writeHeaderAndFooter = true;

	internal bool overwriteKeys = true;

	protected int serializationDepth;

	internal abstract void WriteNull();

	internal virtual void StartWriteFile()
	{
		serializationDepth++;
	}

	internal virtual void EndWriteFile()
	{
		serializationDepth--;
	}

	internal virtual void StartWriteObject(string name)
	{
		serializationDepth++;
	}

	internal virtual void EndWriteObject(string name)
	{
		serializationDepth--;
	}

	internal virtual void StartWriteProperty(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("Key or field name cannot be NULL when saving data.");
		}
		ES3Debug.Log("<b>" + name + "</b> (writing property)", null, serializationDepth);
	}

	internal virtual void EndWriteProperty(string name)
	{
	}

	internal virtual void StartWriteCollection()
	{
		serializationDepth++;
	}

	internal virtual void EndWriteCollection()
	{
		serializationDepth--;
	}

	internal abstract void StartWriteCollectionItem(int index);

	internal abstract void EndWriteCollectionItem(int index);

	internal abstract void StartWriteDictionary();

	internal abstract void EndWriteDictionary();

	internal abstract void StartWriteDictionaryKey(int index);

	internal abstract void EndWriteDictionaryKey(int index);

	internal abstract void StartWriteDictionaryValue(int index);

	internal abstract void EndWriteDictionaryValue(int index);

	public abstract void Dispose();

	internal abstract void WriteRawProperty(string name, byte[] bytes);

	internal abstract void WritePrimitive(int value);

	internal abstract void WritePrimitive(float value);

	internal abstract void WritePrimitive(bool value);

	internal abstract void WritePrimitive(decimal value);

	internal abstract void WritePrimitive(double value);

	internal abstract void WritePrimitive(long value);

	internal abstract void WritePrimitive(ulong value);

	internal abstract void WritePrimitive(uint value);

	internal abstract void WritePrimitive(byte value);

	internal abstract void WritePrimitive(sbyte value);

	internal abstract void WritePrimitive(short value);

	internal abstract void WritePrimitive(ushort value);

	internal abstract void WritePrimitive(char value);

	internal abstract void WritePrimitive(string value);

	internal abstract void WritePrimitive(byte[] value);

	protected ES3Writer(ES3Settings settings, bool writeHeaderAndFooter, bool overwriteKeys)
	{
		this.settings = settings;
		this.writeHeaderAndFooter = writeHeaderAndFooter;
		this.overwriteKeys = overwriteKeys;
	}

	internal virtual void Write(string key, Type type, byte[] value)
	{
		StartWriteProperty(key);
		StartWriteObject(key);
		WriteType(type);
		WriteRawProperty("value", value);
		EndWriteObject(key);
		EndWriteProperty(key);
		MarkKeyForDeletion(key);
	}

	public virtual void Write<T>(string key, object value)
	{
		if (typeof(T) == typeof(object))
		{
			Write(value.GetType(), key, value);
		}
		else
		{
			Write(typeof(T), key, value);
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void Write(Type type, string key, object value)
	{
		StartWriteProperty(key);
		StartWriteObject(key);
		WriteType(type);
		WriteProperty("value", value, ES3TypeMgr.GetOrCreateES3Type(type), settings.referenceMode);
		EndWriteObject(key);
		EndWriteProperty(key);
		MarkKeyForDeletion(key);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void Write(object value, ES3.ReferenceMode memberReferenceMode = ES3.ReferenceMode.ByRef)
	{
		if (value == null)
		{
			WriteNull();
			return;
		}
		ES3Type orCreateES3Type = ES3TypeMgr.GetOrCreateES3Type(value.GetType());
		Write(value, orCreateES3Type, memberReferenceMode);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void Write(object value, ES3Type type, ES3.ReferenceMode memberReferenceMode = ES3.ReferenceMode.ByRef)
	{
		if (value == null || (ES3Reflection.IsAssignableFrom(typeof(UnityEngine.Object), value.GetType()) && value as UnityEngine.Object == null))
		{
			WriteNull();
			return;
		}
		if (type == null || type.type == typeof(object))
		{
			Type type2 = value.GetType();
			type = ES3TypeMgr.GetOrCreateES3Type(type2);
			if (type == null)
			{
				throw new NotSupportedException("Types of " + type2?.ToString() + " are not supported. Please see the Supported Types guide for more information: https://docs.moodkie.com/easy-save-3/es3-supported-types/");
			}
			if (!type.isCollection && !type.isDictionary)
			{
				StartWriteObject(null);
				WriteType(type2);
				type.Write(value, this);
				EndWriteObject(null);
				return;
			}
		}
		if (type == null)
		{
			throw new ArgumentNullException("ES3Type argument cannot be null.");
		}
		if (type.isUnsupported)
		{
			if (type.isCollection || type.isDictionary)
			{
				throw new NotSupportedException(type.type?.ToString() + " is not supported because it's element type is not supported. Please see the Supported Types guide for more information: https://docs.moodkie.com/easy-save-3/es3-supported-types/");
			}
			throw new NotSupportedException("Types of " + type.type?.ToString() + " are not supported. Please see the Supported Types guide for more information: https://docs.moodkie.com/easy-save-3/es3-supported-types/");
		}
		if (type.isPrimitive || type.isEnum)
		{
			type.Write(value, this);
			return;
		}
		if (type.isCollection)
		{
			StartWriteCollection();
			((ES3CollectionType)type).Write(value, this, memberReferenceMode);
			EndWriteCollection();
			return;
		}
		if (type.isDictionary)
		{
			StartWriteDictionary();
			((ES3DictionaryType)type).Write(value, this, memberReferenceMode);
			EndWriteDictionary();
			return;
		}
		if (type.type == typeof(GameObject))
		{
			((ES3Type_GameObject)type).saveChildren = settings.saveChildren;
		}
		StartWriteObject(null);
		if (type.isES3TypeUnityObject)
		{
			((ES3UnityObjectType)type).WriteObject(value, this, memberReferenceMode);
		}
		else
		{
			type.Write(value, this);
		}
		EndWriteObject(null);
	}

	internal virtual void WriteRef(UnityEngine.Object obj)
	{
		ES3ReferenceMgrBase current = ES3ReferenceMgrBase.Current;
		if (current == null)
		{
			throw new InvalidOperationException("An Easy Save 3 Manager is required to save references. To add one to your scene, exit playmode and go to Tools > Easy Save 3 > Add Manager to Scene");
		}
		long num = current.Get(obj);
		if (num == -1)
		{
			num = current.Add(obj);
		}
		WriteProperty("_ES3Ref", num.ToString());
	}

	public virtual void WriteProperty(string name, object value)
	{
		WriteProperty(name, value, settings.memberReferenceMode);
	}

	public virtual void WriteProperty(string name, object value, ES3.ReferenceMode memberReferenceMode)
	{
		if (!SerializationDepthLimitExceeded())
		{
			StartWriteProperty(name);
			Write(value, memberReferenceMode);
			EndWriteProperty(name);
		}
	}

	public virtual void WriteProperty<T>(string name, object value)
	{
		WriteProperty(name, value, ES3TypeMgr.GetOrCreateES3Type(typeof(T)), settings.memberReferenceMode);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void WriteProperty(string name, object value, ES3Type type)
	{
		WriteProperty(name, value, type, settings.memberReferenceMode);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void WriteProperty(string name, object value, ES3Type type, ES3.ReferenceMode memberReferenceMode)
	{
		if (!SerializationDepthLimitExceeded())
		{
			StartWriteProperty(name);
			Write(value, type, memberReferenceMode);
			EndWriteProperty(name);
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void WritePropertyByRef(string name, UnityEngine.Object value)
	{
		if (!SerializationDepthLimitExceeded())
		{
			StartWriteProperty(name);
			if (value == null)
			{
				WriteNull();
				return;
			}
			StartWriteObject(name);
			WriteRef(value);
			EndWriteObject(name);
			EndWriteProperty(name);
		}
	}

	public void WritePrivateProperty(string name, object objectContainingProperty)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedProperty = ES3Reflection.GetES3ReflectedProperty(objectContainingProperty.GetType(), name);
		if (eS3ReflectedProperty.IsNull)
		{
			throw new MissingMemberException("A private property named " + name + " does not exist in the type " + objectContainingProperty.GetType());
		}
		WriteProperty(name, eS3ReflectedProperty.GetValue(objectContainingProperty), ES3TypeMgr.GetOrCreateES3Type(eS3ReflectedProperty.MemberType));
	}

	public void WritePrivateField(string name, object objectContainingField)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedMember = ES3Reflection.GetES3ReflectedMember(objectContainingField.GetType(), name);
		if (eS3ReflectedMember.IsNull)
		{
			throw new MissingMemberException("A private field named " + name + " does not exist in the type " + objectContainingField.GetType());
		}
		WriteProperty(name, eS3ReflectedMember.GetValue(objectContainingField), ES3TypeMgr.GetOrCreateES3Type(eS3ReflectedMember.MemberType));
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public void WritePrivateProperty(string name, object objectContainingProperty, ES3Type type)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedProperty = ES3Reflection.GetES3ReflectedProperty(objectContainingProperty.GetType(), name);
		if (eS3ReflectedProperty.IsNull)
		{
			throw new MissingMemberException("A private property named " + name + " does not exist in the type " + objectContainingProperty.GetType());
		}
		WriteProperty(name, eS3ReflectedProperty.GetValue(objectContainingProperty), type);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public void WritePrivateField(string name, object objectContainingField, ES3Type type)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedMember = ES3Reflection.GetES3ReflectedMember(objectContainingField.GetType(), name);
		if (eS3ReflectedMember.IsNull)
		{
			throw new MissingMemberException("A private field named " + name + " does not exist in the type " + objectContainingField.GetType());
		}
		WriteProperty(name, eS3ReflectedMember.GetValue(objectContainingField), type);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public void WritePrivatePropertyByRef(string name, object objectContainingProperty)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedProperty = ES3Reflection.GetES3ReflectedProperty(objectContainingProperty.GetType(), name);
		if (eS3ReflectedProperty.IsNull)
		{
			throw new MissingMemberException("A private property named " + name + " does not exist in the type " + objectContainingProperty.GetType());
		}
		WritePropertyByRef(name, (UnityEngine.Object)eS3ReflectedProperty.GetValue(objectContainingProperty));
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public void WritePrivateFieldByRef(string name, object objectContainingField)
	{
		ES3Reflection.ES3ReflectedMember eS3ReflectedMember = ES3Reflection.GetES3ReflectedMember(objectContainingField.GetType(), name);
		if (eS3ReflectedMember.IsNull)
		{
			throw new MissingMemberException("A private field named " + name + " does not exist in the type " + objectContainingField.GetType());
		}
		WritePropertyByRef(name, (UnityEngine.Object)eS3ReflectedMember.GetValue(objectContainingField));
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public void WriteType(Type type)
	{
		WriteProperty("__type", ES3Reflection.GetTypeString(type));
	}

	public static ES3Writer Create(string filePath, ES3Settings settings)
	{
		return Create(new ES3Settings(filePath, settings));
	}

	public static ES3Writer Create(ES3Settings settings)
	{
		return Create(settings, writeHeaderAndFooter: true, overwriteKeys: true, append: false);
	}

	internal static ES3Writer Create(ES3Settings settings, bool writeHeaderAndFooter, bool overwriteKeys, bool append)
	{
		Stream stream = ES3Stream.CreateStream(settings, (!append) ? ES3FileMode.Write : ES3FileMode.Append);
		if (stream == null)
		{
			return null;
		}
		return Create(stream, settings, writeHeaderAndFooter, overwriteKeys);
	}

	internal static ES3Writer Create(Stream stream, ES3Settings settings, bool writeHeaderAndFooter, bool overwriteKeys)
	{
		if (stream.GetType() == typeof(MemoryStream))
		{
			settings = (ES3Settings)settings.Clone();
			settings.location = ES3.Location.InternalMS;
		}
		if (settings.format == ES3.Format.JSON)
		{
			return new ES3JSONWriter(stream, settings, writeHeaderAndFooter, overwriteKeys);
		}
		return null;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	protected bool SerializationDepthLimitExceeded()
	{
		if (serializationDepth > settings.serializationDepthLimit)
		{
			ES3Debug.LogWarning("Serialization depth limit of " + settings.serializationDepthLimit + " has been exceeded, indicating that there may be a circular reference.\nIf this is not a circular reference, you can increase the depth by going to Window > Easy Save 3 > Settings > Advanced Settings > Serialization Depth Limit");
			return true;
		}
		return false;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public virtual void MarkKeyForDeletion(string key)
	{
		keysToDelete.Add(key);
	}

	protected void Merge()
	{
		using ES3Reader eS3Reader = ES3Reader.Create(settings);
		if (eS3Reader != null)
		{
			Merge(eS3Reader);
		}
	}

	protected void Merge(ES3Reader reader)
	{
		foreach (KeyValuePair<string, ES3Data> item in reader.RawEnumerator)
		{
			if (!keysToDelete.Contains(item.Key) || item.Value.type == null)
			{
				Write(item.Key, item.Value.type.type, item.Value.bytes);
			}
		}
	}

	public virtual void Save()
	{
		Save(overwriteKeys);
	}

	public virtual void Save(bool overwriteKeys)
	{
		if (overwriteKeys)
		{
			Merge();
		}
		EndWriteFile();
		Dispose();
		if (settings.location == ES3.Location.File || settings.location == ES3.Location.PlayerPrefs)
		{
			ES3IO.CommitBackup(settings);
		}
	}
}
