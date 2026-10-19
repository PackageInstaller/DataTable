using System;
using System.Collections.Generic;
using Sirenix.Serialization.Utilities;

namespace Sirenix.Serialization;

public class ComplexTypeSerializer<T> : Serializer<T>
{
	private static readonly bool ComplexTypeMayBeBoxedValueType = typeof(T).IsInterface || typeof(T) == typeof(object) || typeof(T) == typeof(ValueType) || typeof(T) == typeof(Enum);

	private static readonly bool ComplexTypeIsAbstract = typeof(T).IsAbstract || typeof(T).IsInterface;

	private static readonly bool ComplexTypeIsNullable = typeof(T).IsGenericType && typeof(T).GetGenericTypeDefinition() == typeof(Nullable<>);

	private static readonly bool ComplexTypeIsValueType = typeof(T).IsValueType;

	private static readonly Type TypeOf_T = typeof(T);

	private static readonly bool AllowDeserializeInvalidDataForT = typeof(T).IsDefined(typeof(AllowDeserializeInvalidDataAttribute), inherit: true);

	private static readonly Dictionary<ISerializationPolicy, IFormatter<T>> FormattersByPolicy = new Dictionary<ISerializationPolicy, IFormatter<T>>(ReferenceEqualityComparer<ISerializationPolicy>.Default);

	private static readonly object FormattersByPolicy_LOCK = new object();

	private static readonly ISerializationPolicy UnityPolicy = SerializationPolicies.Unity;

	private static readonly ISerializationPolicy StrictPolicy = SerializationPolicies.Strict;

	private static readonly ISerializationPolicy EverythingPolicy = SerializationPolicies.Everything;

	private static IFormatter<T> UnityPolicyFormatter;

	private static IFormatter<T> StrictPolicyFormatter;

	private static IFormatter<T> EverythingPolicyFormatter;

	public override T ReadValue(IDataReader reader)
	{
		DeserializationContext context = reader.Context;
		if (!context.Config.SerializationPolicy.AllowNonSerializableTypes && !TypeOf_T.IsSerializable)
		{
			context.Config.DebugContext.LogError("The type " + TypeOf_T.GetNiceFullName() + " is not marked as serializable.");
			return default;
		}
		bool flag = true;
		EntryType entryType = reader.PeekEntry(out var name);
		if (ComplexTypeIsValueType)
		{
			switch (entryType)
			{
			case EntryType.Null:
				context.Config.DebugContext.LogWarning("Expecting complex struct of type " + TypeOf_T.GetNiceFullName() + " but got null value.");
				reader.ReadNull();
				return default;
			default:
				context.Config.DebugContext.LogWarning("Unexpected entry '" + name + "' of type " + entryType.ToString() + ", when " + EntryType.StartOfNode.ToString() + " was expected. A value has likely been lost.");
				reader.SkipEntry();
				return default;
			case EntryType.StartOfNode:
				try
				{
					Type typeOf_T = TypeOf_T;
					if (reader.EnterNode(out var type))
					{
						if (type != typeOf_T)
						{
							if (type != null)
							{
								context.Config.DebugContext.LogWarning("Expected complex struct value " + typeOf_T.GetNiceFullName() + " but the serialized value is of type " + type.GetNiceFullName() + ".");
								if (type.IsCastableTo(typeOf_T))
								{
									object obj = FormatterLocator.GetFormatter(type, context.Config.SerializationPolicy).Deserialize(reader);
									bool flag2 = type.IsGenericType && type.GetGenericTypeDefinition() == typeof(Nullable<>);
									Func<object, object> func = ((!ComplexTypeIsNullable && !flag2) ? type.GetCastMethodDelegate(typeOf_T) : null);
									if (func != null)
									{
										return (T)func(obj);
									}
									return (T)obj;
								}
								if (AllowDeserializeInvalidDataForT || reader.Context.Config.AllowDeserializeInvalidData)
								{
									context.Config.DebugContext.LogWarning("Can't cast serialized type " + type.GetNiceFullName() + " into expected type " + typeOf_T.GetNiceFullName() + ". Attempting to deserialize with possibly invalid data. Value may be lost or corrupted for node '" + name + "'.");
									return GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
								}
								context.Config.DebugContext.LogWarning("Can't cast serialized type " + type.GetNiceFullName() + " into expected type " + typeOf_T.GetNiceFullName() + ". Value lost for node '" + name + "'.");
								return default;
							}
							if (AllowDeserializeInvalidDataForT || reader.Context.Config.AllowDeserializeInvalidData)
							{
								context.Config.DebugContext.LogWarning("Expected complex struct value " + typeOf_T.GetNiceFullName() + " but the serialized type could not be resolved. Attempting to deserialize with possibly invalid data. Value may be lost or corrupted for node '" + name + "'.");
								return GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
							}
							context.Config.DebugContext.LogWarning("Expected complex struct value " + typeOf_T.GetNiceFullName() + " but the serialized type could not be resolved. Value lost for node '" + name + "'.");
							return default;
						}
						return GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
					}
					context.Config.DebugContext.LogError("Failed to enter node '" + name + "'.");
					return default;
				}
				catch (SerializationAbortException ex)
				{
					flag = false;
					throw ex;
				}
				catch (Exception exception)
				{
					context.Config.DebugContext.LogException(exception);
					return default;
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
		switch (entryType)
		{
		case EntryType.Null:
			reader.ReadNull();
			return default;
		case EntryType.ExternalReferenceByIndex:
		{
			reader.ReadExternalReference(out int index);
			object externalObject3 = context.GetExternalObject(index);
			try
			{
				return (T)externalObject3;
			}
			catch (InvalidCastException)
			{
				context.Config.DebugContext.LogWarning("Can't cast external reference type " + externalObject3.GetType().GetNiceFullName() + " into expected type " + TypeOf_T.GetNiceFullName() + ". Value lost for node '" + name + "'.");
				return default;
			}
		}
		case EntryType.ExternalReferenceByGuid:
		{
			reader.ReadExternalReference(out Guid guid);
			object externalObject2 = context.GetExternalObject(guid);
			try
			{
				return (T)externalObject2;
			}
			catch (InvalidCastException)
			{
				context.Config.DebugContext.LogWarning("Can't cast external reference type " + externalObject2.GetType().GetNiceFullName() + " into expected type " + TypeOf_T.GetNiceFullName() + ". Value lost for node '" + name + "'.");
				return default;
			}
		}
		case EntryType.ExternalReferenceByString:
		{
			reader.ReadExternalReference(out string id2);
			object externalObject = context.GetExternalObject(id2);
			try
			{
				return (T)externalObject;
			}
			catch (InvalidCastException)
			{
				context.Config.DebugContext.LogWarning("Can't cast external reference type " + externalObject.GetType().GetNiceFullName() + " into expected type " + TypeOf_T.GetNiceFullName() + ". Value lost for node '" + name + "'.");
				return default;
			}
		}
		case EntryType.InternalReference:
		{
			reader.ReadInternalReference(out var id);
			object internalReference = context.GetInternalReference(id);
			try
			{
				return (T)internalReference;
			}
			catch (InvalidCastException)
			{
				context.Config.DebugContext.LogWarning("Can't cast internal reference type " + internalReference.GetType().GetNiceFullName() + " into expected type " + TypeOf_T.GetNiceFullName() + ". Value lost for node '" + name + "'.");
				return default;
			}
		}
		case EntryType.StartOfNode:
			try
			{
				Type typeOf_T2 = TypeOf_T;
				if (reader.EnterNode(out var type2))
				{
					int currentNodeId = reader.CurrentNodeId;
					T val;
					if (!(type2 != null) || !(typeOf_T2 != type2))
					{
						val = ((!ComplexTypeIsAbstract) ? GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader) : default(T));
					}
					else
					{
						bool flag3 = false;
						bool flag4 = FormatterUtilities.IsPrimitiveType(type2);
						bool flag5;
						if (ComplexTypeMayBeBoxedValueType & flag4)
						{
							Serializer serializer = Serializer.Get(type2);
							val = (T)serializer.ReadValueWeak(reader);
							flag3 = true;
						}
						else if ((flag5 = typeOf_T2.IsAssignableFrom(type2)) || type2.HasCastDefined(typeOf_T2, requireImplicitCast: false))
						{
							try
							{
								object obj2;
								if (flag4)
								{
									Serializer serializer2 = Serializer.Get(type2);
									obj2 = serializer2.ReadValueWeak(reader);
								}
								else
								{
									IFormatter formatter = FormatterLocator.GetFormatter(type2, context.Config.SerializationPolicy);
									obj2 = formatter.Deserialize(reader);
								}
								if (flag5)
								{
									val = (T)obj2;
								}
								else
								{
									Func<object, object> castMethodDelegate = type2.GetCastMethodDelegate(typeOf_T2);
									val = ((castMethodDelegate == null) ? ((T)obj2) : ((T)castMethodDelegate(obj2)));
								}
								flag3 = true;
							}
							catch (SerializationAbortException ex6)
							{
								flag = false;
								throw ex6;
							}
							catch (InvalidCastException)
							{
								flag3 = false;
								val = default;
							}
						}
						else if (!ComplexTypeIsAbstract && (AllowDeserializeInvalidDataForT || reader.Context.Config.AllowDeserializeInvalidData))
						{
							context.Config.DebugContext.LogWarning("Can't cast serialized type " + type2.GetNiceFullName() + " into expected type " + typeOf_T2.GetNiceFullName() + ". Attempting to deserialize with invalid data. Value may be lost or corrupted for node '" + name + "'.");
							val = GetBaseFormatter(context.Config.SerializationPolicy).Deserialize(reader);
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
							val = default;
						}
						if (!flag3)
						{
							context.Config.DebugContext.LogWarning("Can't cast serialized type " + type2.GetNiceFullName() + " into expected type " + typeOf_T2.GetNiceFullName() + ". Value lost for node '" + name + "'.");
							val = default;
						}
					}
					if (currentNodeId >= 0)
					{
						context.RegisterInternalReference(currentNodeId, val);
					}
					return val;
				}
				context.Config.DebugContext.LogError("Failed to enter node '" + name + "'.");
				return default;
			}
			catch (SerializationAbortException ex8)
			{
				flag = false;
				throw ex8;
			}
			catch (Exception exception2)
			{
				context.Config.DebugContext.LogException(exception2);
				return default;
			}
			finally
			{
				if (flag)
				{
					reader.ExitNode();
				}
			}
		case EntryType.Boolean:
			if (ComplexTypeMayBeBoxedValueType)
			{
				reader.ReadBoolean(out var value5);
				return (T)(object)value5;
			}
			break;
		case EntryType.FloatingPoint:
			if (ComplexTypeMayBeBoxedValueType)
			{
				reader.ReadDouble(out var value4);
				return (T)(object)value4;
			}
			break;
		case EntryType.Integer:
			if (ComplexTypeMayBeBoxedValueType)
			{
				reader.ReadInt64(out var value3);
				return (T)(object)value3;
			}
			break;
		case EntryType.String:
			if (ComplexTypeMayBeBoxedValueType)
			{
				reader.ReadString(out var value2);
				return (T)(object)value2;
			}
			break;
		case EntryType.Guid:
			if (ComplexTypeMayBeBoxedValueType)
			{
				reader.ReadGuid(out var value);
				return (T)(object)value;
			}
			break;
		}
		context.Config.DebugContext.LogWarning("Unexpected entry of type " + entryType.ToString() + ", when a reference or node start was expected. A value has been lost.");
		reader.SkipEntry();
		return default;
	}

	private static IFormatter<T> GetBaseFormatter(ISerializationPolicy serializationPolicy)
	{
		if (serializationPolicy == UnityPolicy)
		{
			if (UnityPolicyFormatter == null)
			{
				UnityPolicyFormatter = FormatterLocator.GetFormatter<T>(UnityPolicy);
			}
			return UnityPolicyFormatter;
		}
		if (serializationPolicy == EverythingPolicy)
		{
			if (EverythingPolicyFormatter == null)
			{
				EverythingPolicyFormatter = FormatterLocator.GetFormatter<T>(EverythingPolicy);
			}
			return EverythingPolicyFormatter;
		}
		if (serializationPolicy == StrictPolicy)
		{
			if (StrictPolicyFormatter == null)
			{
				StrictPolicyFormatter = FormatterLocator.GetFormatter<T>(StrictPolicy);
			}
			return StrictPolicyFormatter;
		}
		IFormatter<T> value;
		lock (FormattersByPolicy_LOCK)
		{
			if (!FormattersByPolicy.TryGetValue(serializationPolicy, out value))
			{
				value = FormatterLocator.GetFormatter<T>(serializationPolicy);
				FormattersByPolicy.Add(serializationPolicy, value);
			}
		}
		return value;
	}

	public override void WriteValue(string name, T value, IDataWriter writer)
	{
		SerializationContext context = writer.Context;
		ISerializationPolicy serializationPolicy = context.Config.SerializationPolicy;
		if (!serializationPolicy.AllowNonSerializableTypes && !TypeOf_T.IsSerializable)
		{
			context.Config.DebugContext.LogError("The type " + TypeOf_T.GetNiceFullName() + " is not marked as serializable.");
			return;
		}
		if (ComplexTypeIsValueType)
		{
			bool flag = true;
			try
			{
				writer.BeginStructNode(name, TypeOf_T);
				GetBaseFormatter(serializationPolicy).Serialize(value, writer);
				return;
			}
			catch (SerializationAbortException ex)
			{
				flag = false;
				throw ex;
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
		if (context.TryRegisterExternalReference((object)value, out int index))
		{
			writer.WriteExternalReference(name, index);
			return;
		}
		if (context.TryRegisterExternalReference((object)value, out Guid guid))
		{
			writer.WriteExternalReference(name, guid);
			return;
		}
		if (context.TryRegisterExternalReference((object)value, out string id))
		{
			writer.WriteExternalReference(name, id);
			return;
		}
		if (context.TryRegisterInternalReference(value, out var id2))
		{
			Type type = value.GetType();
			if (ComplexTypeMayBeBoxedValueType && FormatterUtilities.IsPrimitiveType(type))
			{
				try
				{
					writer.BeginReferenceNode(name, type, id2);
					Serializer serializer = Serializer.Get(type);
					serializer.WriteValueWeak(value, writer);
					return;
				}
				catch (SerializationAbortException ex2)
				{
					flag2 = false;
					throw ex2;
				}
				finally
				{
					if (flag2)
					{
						writer.EndNode(name);
					}
				}
			}
			IFormatter formatter = (((object)type != TypeOf_T) ? FormatterLocator.GetFormatter(type, serializationPolicy) : GetBaseFormatter(serializationPolicy));
			try
			{
				writer.BeginReferenceNode(name, type, id2);
				formatter.Serialize(value, writer);
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
		writer.WriteInternalReference(name, id2);
	}
}
