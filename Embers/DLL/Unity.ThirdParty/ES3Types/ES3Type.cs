using System;
using System.Collections;
using System.ComponentModel;
using System.Reflection;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[EditorBrowsable(EditorBrowsableState.Never)]
[Preserve]
public abstract class ES3Type
{
	public const string typeFieldName = "__type";

	public ES3Member[] members;

	public Type type;

	public bool isPrimitive;

	public bool isValueType;

	public bool isCollection;

	public bool isDictionary;

	public bool isTuple;

	public bool isEnum;

	public bool isES3TypeUnityObject;

	public bool isReflectedType;

	public bool isUnsupported;

	public int priority;

	protected ES3Type(Type type)
	{
		ES3TypeMgr.Add(type, this);
		this.type = type;
		isValueType = ES3Reflection.IsValueType(type);
	}

	public abstract void Write(object obj, ES3Writer writer);

	public abstract object Read<T>(ES3Reader reader);

	public virtual void ReadInto<T>(ES3Reader reader, object obj)
	{
		throw new NotImplementedException("Self-assigning Read is not implemented or supported on this type.");
	}

	protected bool WriteUsingDerivedType(object obj, ES3Writer writer)
	{
		Type type = obj.GetType();
		if (type != this.type)
		{
			writer.WriteType(type);
			ES3TypeMgr.GetOrCreateES3Type(type).Write(obj, writer);
			return true;
		}
		return false;
	}

	protected void ReadUsingDerivedType<T>(ES3Reader reader, object obj)
	{
		ES3TypeMgr.GetOrCreateES3Type(reader.ReadType()).ReadInto<T>(reader, obj);
	}

	internal string ReadPropertyName(ES3Reader reader)
	{
		if (reader.overridePropertiesName != null)
		{
			string overridePropertiesName = reader.overridePropertiesName;
			reader.overridePropertiesName = null;
			return overridePropertiesName;
		}
		return reader.ReadPropertyName();
	}

	protected void WriteProperties(object obj, ES3Writer writer)
	{
		if (members == null)
		{
			GetMembers(writer.settings.safeReflection);
		}
		for (int i = 0; i < members.Length; i++)
		{
			ES3Member eS3Member = members[i];
			writer.WriteProperty(eS3Member.name, eS3Member.reflectedMember.GetValue(obj), ES3TypeMgr.GetOrCreateES3Type(eS3Member.type), writer.settings.memberReferenceMode);
		}
	}

	protected object ReadProperties(ES3Reader reader, object obj)
	{
		foreach (string property in reader.Properties)
		{
			ES3Member eS3Member = null;
			for (int i = 0; i < members.Length; i++)
			{
				if (members[i].name == property)
				{
					eS3Member = members[i];
					break;
				}
			}
			if (property == "_Values")
			{
				ES3Type orCreateES3Type = ES3TypeMgr.GetOrCreateES3Type(ES3Reflection.BaseType(obj.GetType()));
				if (orCreateES3Type.isDictionary)
				{
					IDictionary dictionary = (IDictionary)obj;
					foreach (DictionaryEntry item in (IDictionary)orCreateES3Type.Read<IDictionary>(reader))
					{
						dictionary[item.Key] = item.Value;
					}
				}
				else if (orCreateES3Type.isCollection)
				{
					IEnumerable enumerable = (IEnumerable)orCreateES3Type.Read<IEnumerable>(reader);
					Type type = orCreateES3Type.GetType();
					if (type == typeof(ES3ListType))
					{
						foreach (object item2 in enumerable)
						{
							((IList)obj).Add(item2);
						}
					}
					else if (type == typeof(ES3QueueType))
					{
						MethodInfo method = orCreateES3Type.type.GetMethod("Enqueue");
						foreach (object item3 in enumerable)
						{
							method.Invoke(obj, new object[1] { item3 });
						}
					}
					else if (type == typeof(ES3StackType))
					{
						MethodInfo method2 = orCreateES3Type.type.GetMethod("Push");
						foreach (object item4 in enumerable)
						{
							method2.Invoke(obj, new object[1] { item4 });
						}
					}
					else if (type == typeof(ES3HashSetType))
					{
						MethodInfo method3 = orCreateES3Type.type.GetMethod("Add");
						foreach (object item5 in enumerable)
						{
							method3.Invoke(obj, new object[1] { item5 });
						}
					}
				}
			}
			if (eS3Member == null)
			{
				reader.Skip();
				continue;
			}
			ES3Type orCreateES3Type2 = ES3TypeMgr.GetOrCreateES3Type(eS3Member.type);
			if (ES3Reflection.IsAssignableFrom(typeof(ES3DictionaryType), orCreateES3Type2.GetType()))
			{
				eS3Member.reflectedMember.SetValue(obj, ((ES3DictionaryType)orCreateES3Type2).Read(reader));
				continue;
			}
			if (ES3Reflection.IsAssignableFrom(typeof(ES3CollectionType), orCreateES3Type2.GetType()))
			{
				eS3Member.reflectedMember.SetValue(obj, ((ES3CollectionType)orCreateES3Type2).Read(reader));
				continue;
			}
			object value = reader.Read<object>(orCreateES3Type2);
			eS3Member.reflectedMember.SetValue(obj, value);
		}
		return obj;
	}

	protected void GetMembers(bool safe)
	{
		GetMembers(safe, null);
	}

	protected void GetMembers(bool safe, string[] memberNames)
	{
		ES3Reflection.ES3ReflectedMember[] serializableMembers = ES3Reflection.GetSerializableMembers(type, safe, memberNames);
		members = new ES3Member[serializableMembers.Length];
		for (int i = 0; i < serializableMembers.Length; i++)
		{
			members[i] = new ES3Member(serializableMembers[i]);
		}
	}
}
