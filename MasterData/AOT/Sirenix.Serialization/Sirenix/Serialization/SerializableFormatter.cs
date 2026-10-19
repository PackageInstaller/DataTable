using System;
using System.Reflection;
using System.Runtime.Serialization;

namespace Sirenix.Serialization;

public sealed class SerializableFormatter<T> : BaseFormatter<T> where T : ISerializable
{
	private static readonly Func<SerializationInfo, StreamingContext, T> ISerializableConstructor;

	private static readonly ReflectionFormatter<T> ReflectionFormatter;

	static SerializableFormatter()
	{
		Type type = typeof(T);
		ConstructorInfo constructor = null;
		do
		{
			constructor = type.GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, new Type[2]
			{
				typeof(SerializationInfo),
				typeof(StreamingContext)
			}, null);
			type = type.BaseType;
		}
		while (constructor == null && type != typeof(object) && type != null);
		if (constructor != null)
		{
			ISerializableConstructor = (SerializationInfo info, StreamingContext context) =>
			{
				T val = (T)FormatterServices.GetUninitializedObject(typeof(T));
				constructor.Invoke(val, new object[2] { info, context });
				return val;
			};
		}
		else
		{
			DefaultLoggers.DefaultLogger.LogWarning("Type " + typeof(T).Name + " implements the interface ISerializable but does not implement the required constructor with signature " + typeof(T).Name + "(SerializationInfo info, StreamingContext context). The interface declaration will be ignored, and the formatter fallbacks to reflection.");
			ReflectionFormatter = new ReflectionFormatter<T>();
		}
	}

	protected override T GetUninitializedObject()
	{
		return default;
	}

	protected override void DeserializeImplementation(ref T value, IDataReader reader)
	{
		if (ISerializableConstructor != null)
		{
			SerializationInfo serializationInfo = ReadSerializationInfo(reader);
			if (serializationInfo == null)
			{
				return;
			}
			try
			{
				value = ISerializableConstructor(serializationInfo, reader.Context.StreamingContext);
				InvokeOnDeserializingCallbacks(ref value, reader.Context);
				if (!BaseFormatter<T>.IsValueType)
				{
					RegisterReferenceID(value, reader);
				}
				return;
			}
			catch (Exception exception)
			{
				reader.Context.Config.DebugContext.LogException(exception);
				return;
			}
		}
		value = ReflectionFormatter.Deserialize(reader);
		InvokeOnDeserializingCallbacks(ref value, reader.Context);
		if (!BaseFormatter<T>.IsValueType)
		{
			RegisterReferenceID(value, reader);
		}
	}

	protected override void SerializeImplementation(ref T value, IDataWriter writer)
	{
		if (ISerializableConstructor != null)
		{
			ISerializable serializable = value;
			SerializationInfo info = new SerializationInfo(value.GetType(), writer.Context.FormatterConverter);
			try
			{
				serializable.GetObjectData(info, writer.Context.StreamingContext);
			}
			catch (Exception exception)
			{
				writer.Context.Config.DebugContext.LogException(exception);
			}
			WriteSerializationInfo(info, writer);
		}
		else
		{
			ReflectionFormatter.Serialize(value, writer);
		}
	}

	private SerializationInfo ReadSerializationInfo(IDataReader reader)
	{
		EntryType entryType = reader.PeekEntry(out var name);
		if (entryType == EntryType.StartOfArray)
		{
			try
			{
				reader.EnterArray(out var length);
				SerializationInfo serializationInfo = new SerializationInfo(typeof(T), reader.Context.FormatterConverter);
				for (int i = 0; i < length; i++)
				{
					Type type = null;
					entryType = reader.PeekEntry(out name);
					if (entryType == EntryType.String && name == "type")
					{
						reader.ReadString(out var value);
						type = reader.Context.Binder.BindToType(value, reader.Context.Config.DebugContext);
					}
					if (type == null)
					{
						reader.SkipEntry();
					}
					else
					{
						entryType = reader.PeekEntry(out name);
						Serializer serializer = Serializer.Get(type);
						object value2 = serializer.ReadValueWeak(reader);
						serializationInfo.AddValue(name, value2);
					}
				}
				return serializationInfo;
			}
			finally
			{
				reader.ExitArray();
			}
		}
		return null;
	}

	private void WriteSerializationInfo(SerializationInfo info, IDataWriter writer)
	{
		try
		{
			writer.BeginArrayNode(info.MemberCount);
			foreach (SerializationEntry item in info)
			{
				try
				{
					writer.WriteString("type", writer.Context.Binder.BindToName(item.ObjectType, writer.Context.Config.DebugContext));
					Serializer serializer = Serializer.Get(item.ObjectType);
					serializer.WriteValueWeak(item.Name, item.Value, writer);
				}
				catch (Exception exception)
				{
					writer.Context.Config.DebugContext.LogException(exception);
				}
			}
		}
		finally
		{
			writer.EndArrayNode();
		}
	}
}
