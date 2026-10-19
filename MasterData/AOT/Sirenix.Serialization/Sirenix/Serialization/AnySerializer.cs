using System;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public sealed class AnySerializer : Serializer
{
	private static readonly ISerializationPolicy UnityPolicy = SerializationPolicies.Unity;

	private static readonly ISerializationPolicy StrictPolicy = SerializationPolicies.Strict;

	private static readonly ISerializationPolicy EverythingPolicy = SerializationPolicies.Everything;

	private readonly Type SerializedType;

	private readonly bool IsEnum;

	private readonly bool IsValueType;

	private readonly bool MayBeBoxedValueType;

	private readonly bool IsAbstract;

	private readonly bool IsNullable;

	private readonly bool AllowDeserializeInvalidData;

	private IFormatter UnityPolicyFormatter;

	private IFormatter StrictPolicyFormatter;

	private IFormatter EverythingPolicyFormatter;

	private readonly Dictionary<ISerializationPolicy, IFormatter> FormattersByPolicy = new Dictionary<ISerializationPolicy, IFormatter>(ReferenceEqualityComparer<ISerializationPolicy>.Default);

	private readonly object FormattersByPolicy_LOCK = new object();

	public AnySerializer(Type serializedType)
	{
		SerializedType = serializedType;
		IsEnum = SerializedType.IsEnum;
		IsValueType = SerializedType.IsValueType;
		MayBeBoxedValueType = SerializedType.IsInterface || SerializedType == typeof(object) || SerializedType == typeof(ValueType) || SerializedType == typeof(Enum);
		IsAbstract = SerializedType.IsAbstract || SerializedType.IsInterface;
		IsNullable = SerializedType.IsGenericType && SerializedType.GetGenericTypeDefinition() == typeof(Nullable<>);
		AllowDeserializeInvalidData = SerializedType.IsDefined(typeof(AllowDeserializeInvalidDataAttribute), inherit: true);
	}

	public override object ReadValueWeak(IDataReader reader)
	{
		if (IsEnum)
		{
			EntryType entryType = reader.PeekEntry(out var name);
			if (entryType == EntryType.Integer)
			{
				if (!reader.ReadUInt64(out var value))
				{
					reader.Context.Config.DebugContext.LogWarning("Failed to read entry '" + name + "' of type " + entryType);
				}
				return Enum.ToObject(SerializedType, value);
			}
			reader.Context.Config.DebugContext.LogWarning("Expected entry of type " + EntryType.Integer.ToString() + ", but got entry '" + name + "' of type " + entryType);
			reader.SkipEntry();
			return Activator.CreateInstance(SerializedType);
		}
		DeserializationContext context = reader.Context;
		if (!context.Config.SerializationPolicy.AllowNonSerializableTypes && !SerializedType.IsSerializable)
		{
			context.Config.DebugContext.LogError("The type " + SerializedType.Name + " is not marked as serializable.");
			if (!IsValueType)
			{
				return null;
			}
			return Activator.CreateInstance(SerializedType);
		}
		bool flag = true;
		EntryType entryType2 = reader.PeekEntry(out var name2);
		if (IsValueType)
		{
			switch (entryType2)
			{
			case EntryType.Null:
				context.Config.DebugContext.LogWarning("Expecting complex struct of type " + SerializedType.GetNiceFullName() + " but got null value.");
				reader.ReadNull();
				return Activator.CreateInstance(SerializedType);
			default:
				context.Config.DebugContext.LogWarning("Unexpected entry '" + name2 + "' of type " + entryType2.ToString() + ", when " + EntryType.StartOfNode.ToString() + " was expected. A value has likely been lost.");
				reader.SkipEntry();
				return Activator.CreateInstance(SerializedType);
			case EntryType.StartOfNode:
				try
				{
					Type serializedType = SerializedType;
					if (reader.EnterNode(out var type))
					{
						if (type != serializedType)
						{
							if (type != null)
							{
								context.Config.DebugContext.LogWarning("Expected complex struct value " + serializedType.Name + " but the serialized value is of type " + type.Name + ".");
								if (type.IsCastableTo(serializedType))
								{
									object obj = FormatterLocator.GetFormatter(type, context.Config.SerializationPolicy).Deserialize(reader);
									bool flag2 = type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>);
									Func<object, object> func = ((!IsNullable && !flag2) ? type.GetCastMethodDelegate(serializedType) : null);
									if (func != null)
									{
										return func(obj);
									}
									return obj;
								}
								if (AllowDeserializeInvalidData || reader.Context.Config.AllowDeserializeInvalidData)
								{
									context.Config.DebugContext.LogWarning("Can't cast serialized type " + type.GetNiceFullName() + " into expected type " + serializedType.GetNiceFullName() + ". Attempting to deserialize with possibly invalid data. Value may be lost or corrupted for node '" + name2 + "'.");
									return GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
								}
								context.Config.DebugContext.LogWarning("Can't cast serialized type " + type.GetNiceFullName() + " into expected type " + serializedType.GetNiceFullName() + ". Value lost for node '" + name2 + "'.");
								return Activator.CreateInstance(SerializedType);
							}
							if (AllowDeserializeInvalidData || reader.Context.Config.AllowDeserializeInvalidData)
							{
								context.Config.DebugContext.LogWarning("Expected complex struct value " + serializedType.GetNiceFullName() + " but the serialized type could not be resolved. Attempting to deserialize with possibly invalid data. Value may be lost or corrupted for node '" + name2 + "'.");
								return GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
							}
							context.Config.DebugContext.LogWarning("Expected complex struct value " + serializedType.Name + " but the serialized type could not be resolved. Value lost for node '" + name2 + "'.");
							return Activator.CreateInstance(SerializedType);
						}
						return GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
					}
					context.Config.DebugContext.LogError("Failed to enter node '" + name2 + "'.");
					return Activator.CreateInstance(SerializedType);
				}
				catch (SerializationAbortException ex)
				{
					flag = false;
					throw ex;
				}
				catch (Exception exception)
				{
					context.Config.DebugContext.LogException(exception);
					return Activator.CreateInstance(SerializedType);
				}
				finally
				{
					if (flag)
					{
						reader.ExitNode();
					}
				}
			}
		}
		switch (entryType2)
		{
		case EntryType.Null:
			reader.ReadNull();
			return null;
		case EntryType.ExternalReferenceByIndex:
		{
			reader.ReadExternalReference(out int index);
			object externalObject2 = context.GetExternalObject(index);
			if (externalObject2 != null && !SerializedType.IsAssignableFrom(externalObject2.GetType()))
			{
				context.Config.DebugContext.LogWarning("Can't cast external reference type " + externalObject2.GetType().GetNiceFullName() + " into expected type " + SerializedType.GetNiceFullName() + ". Value lost for node '" + name2 + "'.");
				return null;
			}
			return externalObject2;
		}
		case EntryType.ExternalReferenceByGuid:
		{
			reader.ReadExternalReference(out Guid guid);
			object externalObject = context.GetExternalObject(guid);
			if (externalObject != null && !SerializedType.IsAssignableFrom(externalObject.GetType()))
			{
				context.Config.DebugContext.LogWarning("Can't cast external reference type " + externalObject.GetType().GetNiceFullName() + " into expected type " + SerializedType.GetNiceFullName() + ". Value lost for node '" + name2 + "'.");
				return null;
			}
			return externalObject;
		}
		case EntryType.ExternalReferenceByString:
		{
			reader.ReadExternalReference(out string id2);
			object externalObject3 = context.GetExternalObject(id2);
			if (externalObject3 != null && !SerializedType.IsAssignableFrom(externalObject3.GetType()))
			{
				context.Config.DebugContext.LogWarning("Can't cast external reference type " + externalObject3.GetType().GetNiceFullName() + " into expected type " + SerializedType.GetNiceFullName() + ". Value lost for node '" + name2 + "'.");
				return null;
			}
			return externalObject3;
		}
		case EntryType.InternalReference:
		{
			reader.ReadInternalReference(out var id);
			object internalReference = context.GetInternalReference(id);
			if (internalReference != null && !SerializedType.IsAssignableFrom(internalReference.GetType()))
			{
				context.Config.DebugContext.LogWarning("Can't cast internal reference type " + internalReference.GetType().GetNiceFullName() + " into expected type " + SerializedType.GetNiceFullName() + ". Value lost for node '" + name2 + "'.");
				return null;
			}
			return internalReference;
		}
		case EntryType.StartOfNode:
			try
			{
				Type serializedType2 = SerializedType;
				if (reader.EnterNode(out var type2))
				{
					int currentNodeId = reader.CurrentNodeId;
					object obj2;
					if (!(type2 != null) || !(serializedType2 != type2))
					{
						obj2 = ((!IsAbstract) ? GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader) : null);
					}
					else
					{
						bool flag3 = false;
						bool flag4 = FormatterUtilities.IsPrimitiveType(type2);
						bool flag5;
						if (MayBeBoxedValueType & flag4)
						{
							Serializer serializer = Serializer.Get(type2);
							obj2 = serializer.ReadValueWeak(reader);
							flag3 = true;
						}
						else if ((flag5 = serializedType2.IsAssignableFrom(type2)) || type2.HasCastDefined(serializedType2, requireImplicitCast: false))
						{
							try
							{
								object obj3;
								if (flag4)
								{
									Serializer serializer2 = Serializer.Get(type2);
									obj3 = serializer2.ReadValueWeak(reader);
								}
								else
								{
									IFormatter formatter = FormatterLocator.GetFormatter(type2, context.Config.SerializationPolicy);
									obj3 = formatter.Deserialize(reader);
								}
								if (flag5)
								{
									obj2 = obj3;
								}
								else
								{
									Func<object, object> castMethodDelegate = type2.GetCastMethodDelegate(serializedType2);
									obj2 = ((castMethodDelegate == null) ? obj3 : castMethodDelegate(obj3));
								}
								flag3 = true;
							}
							catch (SerializationAbortException ex2)
							{
								flag = false;
								throw ex2;
							}
							catch (InvalidCastException)
							{
								flag3 = false;
								obj2 = null;
							}
						}
						else if (!IsAbstract && (AllowDeserializeInvalidData || reader.Context.Config.AllowDeserializeInvalidData))
						{
							context.Config.DebugContext.LogWarning("Can't cast serialized type " + type2.GetNiceFullName() + " into expected type " + serializedType2.GetNiceFullName() + ". Attempting to deserialize with invalid data. Value may be lost or corrupted for node '" + name2 + "'.");
							obj2 = GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
							flag3 = true;
						}
						else
						{
							IFormatter formatter2 = FormatterLocator.GetFormatter(type2, context.Config.SerializationPolicy);
							object reference = formatter2.Deserialize(reader);
							if (currentNodeId >= 0)
							{
								context.RegisterInternalReference(currentNodeId, reference);
							}
							obj2 = null;
						}
						if (!flag3)
						{
							context.Config.DebugContext.LogWarning("Can't cast serialized type " + type2.GetNiceFullName() + " into expected type " + serializedType2.GetNiceFullName() + ". Value lost for node '" + name2 + "'.");
							obj2 = null;
						}
					}
					if (currentNodeId >= 0)
					{
						context.RegisterInternalReference(currentNodeId, obj2);
					}
					return obj2;
				}
				context.Config.DebugContext.LogError("Failed to enter node '" + name2 + "'.");
				return null;
			}
			catch (SerializationAbortException ex4)
			{
				flag = false;
				throw ex4;
			}
			catch (Exception exception2)
			{
				context.Config.DebugContext.LogException(exception2);
				return null;
			}
			finally
			{
				if (flag)
				{
					reader.ExitNode();
				}
			}
		case EntryType.Boolean:
			if (MayBeBoxedValueType)
			{
				reader.ReadBoolean(out var value6);
				return value6;
			}
			break;
		case EntryType.FloatingPoint:
			if (MayBeBoxedValueType)
			{
				reader.ReadDouble(out var value5);
				return value5;
			}
			break;
		case EntryType.Integer:
			if (MayBeBoxedValueType)
			{
				reader.ReadInt64(out var value4);
				return value4;
			}
			break;
		case EntryType.String:
			if (MayBeBoxedValueType)
			{
				reader.ReadString(out var value3);
				return value3;
			}
			break;
		case EntryType.Guid:
			if (MayBeBoxedValueType)
			{
				reader.ReadGuid(out var value2);
				return value2;
			}
			break;
		}
		context.Config.DebugContext.LogWarning("Unexpected entry of type " + entryType2.ToString() + ", when a reference or node start was expected. A value has been lost.");
		reader.SkipEntry();
		return null;
	}

	public override void WriteValueWeak(string name, object value, IDataWriter writer)
	{
		if (IsEnum)
		{
			ulong value2;
			try
			{
				value2 = Convert.ToUInt64(value as Enum);
			}
			catch (OverflowException)
			{
				value2 = (ulong)Convert.ToInt64(value as Enum);
			}
			writer.WriteUInt64(name, value2);
			return;
		}
		SerializationContext context = writer.Context;
		ISerializationPolicy serializationPolicy = context.Config.SerializationPolicy;
		if (!serializationPolicy.AllowNonSerializableTypes && !SerializedType.IsSerializable)
		{
			context.Config.DebugContext.LogError("The type " + SerializedType.Name + " is not marked as serializable.");
			return;
		}
		if (IsValueType)
		{
			bool flag = true;
			try
			{
				writer.BeginStructNode(name, SerializedType);
				GetBaseFormatter(serializationPolicy).Serialize(value, writer);
				return;
			}
			catch (SerializationAbortException ex2)
			{
				flag = false;
				throw ex2;
			}
			finally
			{
				if (flag)
				{
					writer.EndNode(name);
				}
			}
		}
		bool flag2 = true;
		if (value == null)
		{
			writer.WriteNull(name);
			return;
		}
		if (context.TryRegisterExternalReference(value, out int index))
		{
			writer.WriteExternalReference(name, index);
			return;
		}
		if (context.TryRegisterExternalReference(value, out Guid guid))
		{
			writer.WriteExternalReference(name, guid);
			return;
		}
		if (context.TryRegisterExternalReference(value, out string id))
		{
			writer.WriteExternalReference(name, id);
			return;
		}
		if (context.TryRegisterInternalReference(value, out var id2))
		{
			Type type = value.GetType();
			if (MayBeBoxedValueType && FormatterUtilities.IsPrimitiveType(type))
			{
				try
				{
					writer.BeginReferenceNode(name, type, id2);
					Serializer serializer = Serializer.Get(type);
					serializer.WriteValueWeak(value, writer);
					return;
				}
				catch (SerializationAbortException ex3)
				{
					flag2 = false;
					throw ex3;
				}
				finally
				{
					if (flag2)
					{
						writer.EndNode(name);
					}
				}
			}
			IFormatter formatter = (((object)type != SerializedType) ? FormatterLocator.GetFormatter(type, serializationPolicy) : GetBaseFormatter(serializationPolicy));
			try
			{
				writer.BeginReferenceNode(name, type, id2);
				formatter.Serialize(value, writer);
				return;
			}
			catch (SerializationAbortException ex4)
			{
				flag2 = false;
				throw ex4;
			}
			finally
			{
				if (flag2)
				{
					writer.EndNode(name);
				}
			}
		}
		writer.WriteInternalReference(name, id2);
	}

	private IFormatter GetBaseFormatter(ISerializationPolicy serializationPolicy)
	{
		if (serializationPolicy == UnityPolicy)
		{
			if (UnityPolicyFormatter == null)
			{
				UnityPolicyFormatter = FormatterLocator.GetFormatter(SerializedType, UnityPolicy);
			}
			return UnityPolicyFormatter;
		}
		if (serializationPolicy == EverythingPolicy)
		{
			if (EverythingPolicyFormatter == null)
			{
				EverythingPolicyFormatter = FormatterLocator.GetFormatter(SerializedType, EverythingPolicy);
			}
			return EverythingPolicyFormatter;
		}
		if (serializationPolicy == StrictPolicy)
		{
			if (StrictPolicyFormatter == null)
			{
				StrictPolicyFormatter = FormatterLocator.GetFormatter(SerializedType, StrictPolicy);
			}
			return StrictPolicyFormatter;
		}
		IFormatter value;
		lock (FormattersByPolicy_LOCK)
		{
			if (!FormattersByPolicy.TryGetValue(serializationPolicy, out value))
			{
				value = FormatterLocator.GetFormatter(SerializedType, serializationPolicy);
				FormattersByPolicy.Add(serializationPolicy, value);
			}
		}
		return value;
	}
}
