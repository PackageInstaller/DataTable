using System;
using System.Collections.Generic;
using ES3Internal;

namespace ES3Types;

public class ES33DArrayType : ES3CollectionType
{
	public ES33DArrayType(Type type)
		: base(type)
	{
	}

	public override void Write(object obj, ES3Writer writer, ES3.ReferenceMode memberReferenceMode)
	{
		Array array = (Array)obj;
		if (elementType == null)
		{
			throw new ArgumentNullException("ES3Type argument cannot be null.");
		}
		for (int i = 0; i < array.GetLength(0); i++)
		{
			writer.StartWriteCollectionItem(i);
			writer.StartWriteCollection();
			for (int j = 0; j < array.GetLength(1); j++)
			{
				writer.StartWriteCollectionItem(j);
				writer.StartWriteCollection();
				for (int k = 0; k < array.GetLength(2); k++)
				{
					writer.StartWriteCollectionItem(k);
					writer.Write(array.GetValue(i, j, k), elementType, memberReferenceMode);
					writer.EndWriteCollectionItem(k);
				}
				writer.EndWriteCollection();
				writer.EndWriteCollectionItem(j);
			}
			writer.EndWriteCollection();
			writer.EndWriteCollectionItem(i);
		}
	}

	public override object Read<T>(ES3Reader reader)
	{
		return Read(reader);
	}

	public override object Read(ES3Reader reader)
	{
		if (reader.StartReadCollection())
		{
			return null;
		}
		List<object> list = new List<object>();
		int num = 0;
		int num2 = 0;
		while (reader.StartReadCollectionItem())
		{
			reader.StartReadCollection();
			num++;
			while (reader.StartReadCollectionItem())
			{
				ReadICollection(reader, list, elementType);
				num2++;
				if (reader.EndReadCollectionItem())
				{
					break;
				}
			}
			reader.EndReadCollection();
			if (reader.EndReadCollectionItem())
			{
				break;
			}
		}
		reader.EndReadCollection();
		num2 /= num;
		int num3 = list.Count / num2 / num;
		Array array = ES3Reflection.ArrayCreateInstance(elementType.type, new int[3] { num, num2, num3 });
		for (int i = 0; i < num; i++)
		{
			for (int j = 0; j < num2; j++)
			{
				for (int k = 0; k < num3; k++)
				{
					array.SetValue(list[i * (num2 * num3) + j * num3 + k], i, j, k);
				}
			}
		}
		return array;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		ReadInto(reader, obj);
	}

	public override void ReadInto(ES3Reader reader, object obj)
	{
		Array array = (Array)obj;
		if (reader.StartReadCollection())
		{
			throw new NullReferenceException("The Collection we are trying to load is stored as null, which is not allowed when using ReadInto methods.");
		}
		bool flag = false;
		for (int i = 0; i < array.GetLength(0); i++)
		{
			bool flag2 = false;
			if (!reader.StartReadCollectionItem())
			{
				throw new IndexOutOfRangeException("The collection we are loading is smaller than the collection provided as a parameter.");
			}
			reader.StartReadCollection();
			for (int j = 0; j < array.GetLength(1); j++)
			{
				bool flag3 = false;
				if (!reader.StartReadCollectionItem())
				{
					throw new IndexOutOfRangeException("The collection we are loading is smaller than the collection provided as a parameter.");
				}
				reader.StartReadCollection();
				for (int k = 0; k < array.GetLength(2); k++)
				{
					if (!reader.StartReadCollectionItem())
					{
						throw new IndexOutOfRangeException("The collection we are loading is smaller than the collection provided as a parameter.");
					}
					reader.ReadInto<object>(array.GetValue(i, j, k), elementType);
					flag3 = reader.EndReadCollectionItem();
				}
				if (!flag3)
				{
					throw new IndexOutOfRangeException("The collection we are loading is larger than the collection provided as a parameter.");
				}
				reader.EndReadCollection();
				flag2 = reader.EndReadCollectionItem();
			}
			if (!flag2)
			{
				throw new IndexOutOfRangeException("The collection we are loading is larger than the collection provided as a parameter.");
			}
			reader.EndReadCollection();
			flag = reader.EndReadCollectionItem();
		}
		if (!flag)
		{
			throw new IndexOutOfRangeException("The collection we are loading is larger than the collection provided as a parameter.");
		}
		reader.EndReadCollection();
	}
}
