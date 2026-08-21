using System;
using ES3Internal;
using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
internal class ES3ReflectedType : ES3Type
{
	public ES3ReflectedType(Type type)
		: base(type)
	{
		isReflectedType = true;
	}

	public ES3ReflectedType(Type type, string[] members)
		: this(type)
	{
		GetMembers(safe: false, members);
	}

	public override void Write(object obj, ES3Writer writer)
	{
		if (obj == null)
		{
			writer.WriteNull();
			return;
		}
		UnityEngine.Object obj2 = obj as UnityEngine.Object;
		bool flag = obj2 != null;
		Type type = obj.GetType();
		if (type != base.type)
		{
			writer.WriteType(type);
			ES3TypeMgr.GetOrCreateES3Type(type).Write(obj, writer);
			return;
		}
		if (flag)
		{
			writer.WriteRef(obj2);
		}
		if (members == null)
		{
			GetMembers(writer.settings.safeReflection);
		}
		for (int i = 0; i < members.Length; i++)
		{
			ES3Member eS3Member = members[i];
			if (ES3Reflection.IsAssignableFrom(typeof(UnityEngine.Object), eS3Member.type))
			{
				object value = eS3Member.reflectedMember.GetValue(obj);
				UnityEngine.Object value2 = ((value == null) ? null : ((UnityEngine.Object)value));
				writer.WritePropertyByRef(eS3Member.name, value2);
			}
			else
			{
				writer.WriteProperty(eS3Member.name, eS3Member.reflectedMember.GetValue(obj), ES3TypeMgr.GetOrCreateES3Type(eS3Member.type));
			}
		}
	}

	public override object Read<T>(ES3Reader reader)
	{
		if (members == null)
		{
			GetMembers(reader.settings.safeReflection);
		}
		string text = reader.ReadPropertyName();
		if (text == "__type")
		{
			return ES3TypeMgr.GetOrCreateES3Type(reader.ReadType()).Read<T>(reader);
		}
		object obj;
		if (text == "_ES3Ref")
		{
			long id = reader.Read_ref();
			obj = ES3ReferenceMgrBase.Current.Get(id, type);
			if (obj == null)
			{
				obj = ES3Reflection.CreateInstance(type);
				ES3ReferenceMgrBase.Current.Add((UnityEngine.Object)obj, id);
			}
		}
		else
		{
			reader.overridePropertiesName = text;
			obj = ES3Reflection.CreateInstance(type);
		}
		ReadProperties(reader, obj);
		return obj;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		if (members == null)
		{
			GetMembers(reader.settings.safeReflection);
		}
		string text = reader.ReadPropertyName();
		if (text == "__type")
		{
			ES3TypeMgr.GetOrCreateES3Type(reader.ReadType()).ReadInto<T>(reader, obj);
			return;
		}
		reader.overridePropertiesName = text;
		ReadProperties(reader, obj);
	}
}
