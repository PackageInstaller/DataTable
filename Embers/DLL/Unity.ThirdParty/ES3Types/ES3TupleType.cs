using System;
using ES3Internal;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
public class ES3TupleType : ES3Type
{
	public ES3Type[] es3Types;

	public Type[] types;

	protected ES3Reflection.ES3ReflectedMethod readMethod;

	protected ES3Reflection.ES3ReflectedMethod readIntoMethod;

	public ES3TupleType(Type type)
		: base(type)
	{
		types = ES3Reflection.GetElementTypes(type);
		es3Types = new ES3Type[types.Length];
		for (int i = 0; i < types.Length; i++)
		{
			es3Types[i] = ES3TypeMgr.GetOrCreateES3Type(types[i], throwException: false);
			if (es3Types[i] == null)
			{
				isUnsupported = true;
			}
		}
		isTuple = true;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Write(obj, writer, writer.settings.memberReferenceMode);
	}

	public void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode)
	{
		if (obj == null)
		{
			writer.WriteNull();
			return;
		}
		writer.StartWriteCollection();
		for (int i = 0; i < es3Types.Length; i++)
		{
			object value = ES3Reflection.GetProperty(type, "Item" + (i + 1)).GetValue(obj);
			writer.StartWriteCollectionItem(i);
			writer.Write(value, es3Types[i], memberReferenceMode);
			writer.EndWriteCollectionItem(i);
		}
		writer.EndWriteCollection();
	}

	public override object Read<T>(ES3Reader reader)
	{
		object[] array = new object[types.Length];
		if (reader.StartReadCollection())
		{
			return null;
		}
		for (int i = 0; i < types.Length; i++)
		{
			reader.StartReadCollectionItem();
			array[i] = reader.Read<object>(es3Types[i]);
			reader.EndReadCollectionItem();
		}
		reader.EndReadCollection();
		return type.GetConstructor(types).Invoke(array);
	}
}
