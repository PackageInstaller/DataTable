using System;
using System.Collections;
using System.Reflection;

namespace Sirenix.Serialization;

public sealed class WeakGenericCollectionFormatter : WeakBaseFormatter
{
	private readonly Serializer ValueReaderWriter;

	private readonly Type ElementType;

	private readonly PropertyInfo CountProperty;

	private readonly MethodInfo AddMethod;

	public WeakGenericCollectionFormatter(Type collectionType, Type elementType)
		: base(collectionType)
	{
		ElementType = elementType;
		CountProperty = collectionType.GetProperty("Count", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		AddMethod = collectionType.GetMethod("Add", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, new Type[1] { elementType }, null);
		if (AddMethod == null)
		{
			throw new ArgumentException("Cannot treat the type " + collectionType.Name + " as a generic collection since it has no accessible Add method.");
		}
		if (CountProperty == null || CountProperty.PropertyType != typeof(int))
		{
			throw new ArgumentException("Cannot treat the type " + collectionType.Name + " as a generic collection since it has no accessible Count property.");
		}
		if (!GenericCollectionFormatter.CanFormat(collectionType, out var elementType2))
		{
			throw new ArgumentException("Cannot treat the type " + collectionType.Name + " as a generic collection.");
		}
		if (elementType2 != elementType)
		{
			throw new ArgumentException("Type " + elementType.Name + " is not the element type of the generic collection type " + collectionType.Name + ".");
		}
	}

	protected override object GetUninitializedObject()
	{
		return Activator.CreateInstance(SerializedType);
	}

	protected override void DeserializeImplementation(ref object value, IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				for (int i = 0; i < length; i++)
				{
					if (reader.PeekEntry(out name) == EntryType.EndOfArray)
					{
						reader.Context.Config.DebugContext.LogError("Reached end of array after " + i + " elements, when " + length + " elements were expected.");
						break;
					}
					object[] array = new object[1];
					try
					{
						array[0] = ValueReaderWriter.ReadValueWeak(reader);
						AddMethod.Invoke(value, array);
					}
					catch (Exception exception)
					{
						reader.Context.Config.DebugContext.LogException(exception);
					}
					if (!reader.IsInArrayNode)
					{
						reader.Context.Config.DebugContext.LogError("Reading array went wrong. Data dump: " + reader.GetDataDump());
						break;
					}
				}
				return;
			}
			catch (Exception exception2)
			{
				reader.Context.Config.DebugContext.LogException(exception2);
				return;
			}
			finally
			{
				reader.ExitArray();
			}
		}
		reader.SkipEntry();
	}

	protected override void SerializeImplementation(ref object value, IDataWriter writer)
	{
		try
		{
			writer.BeginArrayNode((int)CountProperty.GetValue(value, null));
			foreach (object item in (IEnumerable)value)
			{
				ValueReaderWriter.WriteValueWeak(item, writer);
			}
		}
		finally
		{
			writer.EndArrayNode();
		}
	}
}
