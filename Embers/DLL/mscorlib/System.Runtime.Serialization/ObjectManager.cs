using System.Globalization;
using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Runtime.Serialization;

[ComVisible(true)]
public class ObjectManager
{
	private DeserializationEventHandler m_onDeserializationHandler;

	private SerializationEventHandler m_onDeserializedHandler;

	internal ObjectHolder[] m_objects;

	internal object m_topObject;

	internal ObjectHolderList m_specialFixupObjects;

	internal long m_fixupCount;

	internal ISurrogateSelector m_selector;

	internal StreamingContext m_context;

	internal object TopObject
	{
		get
		{
			return m_topObject;
		}
		set
		{
			m_topObject = value;
		}
	}

	internal ObjectHolderList SpecialFixupObjects
	{
		get
		{
			if (m_specialFixupObjects == null)
			{
				m_specialFixupObjects = new ObjectHolderList();
			}
			return m_specialFixupObjects;
		}
	}

	internal ObjectManager(ISurrogateSelector selector, StreamingContext context, bool checkSecurity, bool isCrossAppDomain)
	{
		m_objects = new ObjectHolder[16];
		m_selector = selector;
		m_context = context;
	}

	private bool CanCallGetType(object obj)
	{
		return true;
	}

	internal ObjectHolder FindObjectHolder(long objectID)
	{
		int num = (int)(objectID & 0xFFF);
		if (num >= m_objects.Length)
		{
			return null;
		}
		ObjectHolder objectHolder;
		for (objectHolder = m_objects[num]; objectHolder != null; objectHolder = objectHolder.m_next)
		{
			if (objectHolder.m_id == objectID)
			{
				return objectHolder;
			}
		}
		return objectHolder;
	}

	internal ObjectHolder FindOrCreateObjectHolder(long objectID)
	{
		ObjectHolder objectHolder = FindObjectHolder(objectID);
		if (objectHolder == null)
		{
			objectHolder = new ObjectHolder(objectID);
			AddObjectHolder(objectHolder);
		}
		return objectHolder;
	}

	private void AddObjectHolder(ObjectHolder holder)
	{
		if (holder.m_id >= m_objects.Length && m_objects.Length != 4096)
		{
			int num = 4096;
			if (holder.m_id < 2048)
			{
				num = m_objects.Length * 2;
				while (num <= holder.m_id && num < 4096)
				{
					num *= 2;
				}
				if (num > 4096)
				{
					num = 4096;
				}
			}
			ObjectHolder[] array = new ObjectHolder[num];
			Array.Copy(m_objects, array, m_objects.Length);
			m_objects = array;
		}
		int num2 = (int)(holder.m_id & 0xFFF);
		ObjectHolder next = m_objects[num2];
		holder.m_next = next;
		m_objects[num2] = holder;
	}

	private bool GetCompletionInfo(FixupHolder fixup, out ObjectHolder holder, out object member, bool bThrowIfMissing)
	{
		member = fixup.m_fixupInfo;
		holder = FindObjectHolder(fixup.m_id);
		if (!holder.CompletelyFixed && holder.ObjectValue != null && holder.ObjectValue is ValueType)
		{
			SpecialFixupObjects.Add(holder);
			return false;
		}
		if (holder == null || holder.CanObjectValueChange || holder.ObjectValue == null)
		{
			if (bThrowIfMissing)
			{
				if (holder == null)
				{
					throw new SerializationException(Environment.GetResourceString("A fixup is registered to the object with ID {0}, but the object does not appear in the graph.", fixup.m_id));
				}
				if (holder.IsIncompleteObjectReference)
				{
					throw new SerializationException(Environment.GetResourceString("The object with ID {0} implements the IObjectReference interface for which all dependencies cannot be resolved. The likely cause is two instances of IObjectReference that have a mutual dependency on each other.", fixup.m_id));
				}
				throw new SerializationException(Environment.GetResourceString("The object with ID {0} was referenced in a fixup but does not exist.", fixup.m_id));
			}
			return false;
		}
		return true;
	}

	private void FixupSpecialObject(ObjectHolder holder)
	{
		ISurrogateSelector selector = null;
		if (holder.HasSurrogate)
		{
			ISerializationSurrogate surrogate = holder.Surrogate;
			object obj = surrogate.SetObjectData(holder.ObjectValue, holder.SerializationInfo, m_context, selector);
			if (obj != null)
			{
				if (!holder.CanSurrogatedObjectValueChange && obj != holder.ObjectValue)
				{
					throw new SerializationException(string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("{0}.SetObjectData returns a value that is neither null nor equal to the first parameter. Such Surrogates cannot be part of cyclical reference."), surrogate.GetType().FullName));
				}
				holder.SetObjectValue(obj, this);
			}
			holder.m_surrogate = null;
			holder.SetFlags();
		}
		else
		{
			CompleteISerializableObject(holder.ObjectValue, holder.SerializationInfo, m_context);
		}
		holder.SerializationInfo = null;
		holder.RequiresSerInfoFixup = false;
		if (holder.RequiresValueTypeFixup && holder.ValueTypeFixupPerformed)
		{
			DoValueTypeFixup(null, holder, holder.ObjectValue);
		}
		DoNewlyRegisteredObjectFixups(holder);
	}

	private bool ResolveObjectReference(ObjectHolder holder)
	{
		int num = 0;
		try
		{
			object objectValue;
			do
			{
				objectValue = holder.ObjectValue;
				holder.SetObjectValue(((IObjectReference)holder.ObjectValue).GetRealObject(m_context), this);
				if (holder.ObjectValue == null)
				{
					holder.SetObjectValue(objectValue, this);
					return false;
				}
				if (num++ == 100)
				{
					throw new SerializationException(Environment.GetResourceString("The implementation of the IObjectReference interface returns too many nested references to other objects that implement IObjectReference."));
				}
			}
			while (holder.ObjectValue is IObjectReference && objectValue != holder.ObjectValue);
		}
		catch (NullReferenceException)
		{
			return false;
		}
		holder.IsIncompleteObjectReference = false;
		DoNewlyRegisteredObjectFixups(holder);
		return true;
	}

	private bool DoValueTypeFixup(FieldInfo memberToFix, ObjectHolder holder, object value)
	{
		FieldInfo[] array = new FieldInfo[4];
		FieldInfo[] array2 = null;
		int num = 0;
		int[] array3 = null;
		ValueTypeFixupInfo valueTypeFixupInfo = null;
		object objectValue = holder.ObjectValue;
		while (holder.RequiresValueTypeFixup)
		{
			if (num + 1 >= array.Length)
			{
				FieldInfo[] array4 = new FieldInfo[array.Length * 2];
				Array.Copy(array, array4, array.Length);
				array = array4;
			}
			valueTypeFixupInfo = holder.ValueFixup;
			objectValue = holder.ObjectValue;
			if (valueTypeFixupInfo.ParentField != null)
			{
				FieldInfo parentField = valueTypeFixupInfo.ParentField;
				ObjectHolder objectHolder = FindObjectHolder(valueTypeFixupInfo.ContainerID);
				if (objectHolder.ObjectValue == null)
				{
					break;
				}
				if (Nullable.GetUnderlyingType(parentField.FieldType) != null)
				{
					array[num] = parentField.FieldType.GetField("value", BindingFlags.Instance | BindingFlags.NonPublic);
					num++;
				}
				array[num] = parentField;
				holder = objectHolder;
				num++;
				continue;
			}
			holder = FindObjectHolder(valueTypeFixupInfo.ContainerID);
			array3 = valueTypeFixupInfo.ParentIndex;
			if (holder.ObjectValue != null)
			{
			}
			break;
		}
		if (!(holder.ObjectValue is Array) && holder.ObjectValue != null)
		{
			objectValue = holder.ObjectValue;
		}
		if (num != 0)
		{
			array2 = new FieldInfo[num];
			for (int i = 0; i < num; i++)
			{
				FieldInfo fieldInfo = array[num - 1 - i];
				SerializationFieldInfo serializationFieldInfo = fieldInfo as SerializationFieldInfo;
				array2[i] = ((serializationFieldInfo == null) ? fieldInfo : serializationFieldInfo.FieldInfo);
			}
			TypedReference typedReference = TypedReference.MakeTypedReference(objectValue, array2);
			if (memberToFix != null)
			{
				((RuntimeFieldInfo)memberToFix).SetValueDirect(typedReference, value);
			}
			else
			{
				TypedReference.SetTypedReference(typedReference, value);
			}
		}
		else if (memberToFix != null)
		{
			FormatterServices.SerializationSetValue(memberToFix, objectValue, value);
		}
		if (array3 != null && holder.ObjectValue != null)
		{
			((Array)holder.ObjectValue).SetValue(objectValue, array3);
		}
		return true;
	}

	internal void CompleteObject(ObjectHolder holder, bool bObjectFullyComplete)
	{
		FixupHolderList missingElements = holder.m_missingElements;
		object member = null;
		ObjectHolder holder2 = null;
		int num = 0;
		if (holder.ObjectValue == null)
		{
			throw new SerializationException(Environment.GetResourceString("The object with ID {0} was referenced in a fixup but has not been registered.", holder.m_id));
		}
		if (missingElements == null)
		{
			return;
		}
		if (holder.HasSurrogate || holder.HasISerializable)
		{
			SerializationInfo serInfo = holder.m_serInfo;
			if (serInfo == null)
			{
				throw new SerializationException(Environment.GetResourceString("A fixup on an object implementing ISerializable or having a surrogate was discovered for an object which does not have a SerializationInfo available."));
			}
			if (missingElements != null)
			{
				for (int i = 0; i < missingElements.m_count; i++)
				{
					if (missingElements.m_values[i] != null && GetCompletionInfo(missingElements.m_values[i], out holder2, out member, bObjectFullyComplete))
					{
						object objectValue = holder2.ObjectValue;
						if (CanCallGetType(objectValue))
						{
							serInfo.UpdateValue((string)member, objectValue, objectValue.GetType());
						}
						else
						{
							serInfo.UpdateValue((string)member, objectValue, typeof(MarshalByRefObject));
						}
						num++;
						missingElements.m_values[i] = null;
						if (!bObjectFullyComplete)
						{
							holder.DecrementFixupsRemaining(this);
							holder2.RemoveDependency(holder.m_id);
						}
					}
				}
			}
		}
		else
		{
			for (int j = 0; j < missingElements.m_count; j++)
			{
				FixupHolder fixupHolder = missingElements.m_values[j];
				if (fixupHolder == null || !GetCompletionInfo(fixupHolder, out holder2, out member, bObjectFullyComplete))
				{
					continue;
				}
				if (holder2.TypeLoadExceptionReachable)
				{
					holder.TypeLoadException = holder2.TypeLoadException;
					if (holder.Reachable)
					{
						throw new SerializationException(Environment.GetResourceString("Unable to load type {0} required for deserialization.", holder.TypeLoadException.TypeName));
					}
				}
				if (holder.Reachable)
				{
					holder2.Reachable = true;
				}
				switch (fixupHolder.m_fixupType)
				{
				case 1:
					if (holder.RequiresValueTypeFixup)
					{
						throw new SerializationException(Environment.GetResourceString("ValueType fixup on Arrays is not implemented."));
					}
					((Array)holder.ObjectValue).SetValue(holder2.ObjectValue, (int[])member);
					break;
				case 2:
				{
					MemberInfo memberInfo = (MemberInfo)member;
					if (memberInfo.MemberType == MemberTypes.Field)
					{
						if (holder.RequiresValueTypeFixup && holder.ValueTypeFixupPerformed)
						{
							if (!DoValueTypeFixup((FieldInfo)memberInfo, holder, holder2.ObjectValue))
							{
								throw new SerializationException(Environment.GetResourceString("Fixing up a partially available ValueType chain is not implemented."));
							}
						}
						else
						{
							FormatterServices.SerializationSetValue(memberInfo, holder.ObjectValue, holder2.ObjectValue);
						}
						if (holder2.RequiresValueTypeFixup)
						{
							holder2.ValueTypeFixupPerformed = true;
						}
						break;
					}
					throw new SerializationException(Environment.GetResourceString("Cannot perform fixup."));
				}
				default:
					throw new SerializationException(Environment.GetResourceString("Cannot perform fixup."));
				}
				num++;
				missingElements.m_values[j] = null;
				if (!bObjectFullyComplete)
				{
					holder.DecrementFixupsRemaining(this);
					holder2.RemoveDependency(holder.m_id);
				}
			}
		}
		m_fixupCount -= num;
		if (missingElements.m_count == num)
		{
			holder.m_missingElements = null;
		}
	}

	private void DoNewlyRegisteredObjectFixups(ObjectHolder holder)
	{
		if (holder.CanObjectValueChange)
		{
			return;
		}
		LongList dependentObjects = holder.DependentObjects;
		if (dependentObjects == null)
		{
			return;
		}
		dependentObjects.StartEnumeration();
		while (dependentObjects.MoveNext())
		{
			ObjectHolder objectHolder = FindObjectHolder(dependentObjects.Current);
			objectHolder.DecrementFixupsRemaining(this);
			if (objectHolder.DirectlyDependentObjects == 0)
			{
				if (objectHolder.ObjectValue != null)
				{
					CompleteObject(objectHolder, bObjectFullyComplete: true);
				}
				else
				{
					objectHolder.MarkForCompletionWhenAvailable();
				}
			}
		}
	}

	public virtual object GetObject(long objectID)
	{
		if (objectID <= 0)
		{
			throw new ArgumentOutOfRangeException("objectID", Environment.GetResourceString("objectID cannot be less than or equal to zero."));
		}
		ObjectHolder objectHolder = FindObjectHolder(objectID);
		if (objectHolder == null || objectHolder.CanObjectValueChange)
		{
			return null;
		}
		return objectHolder.ObjectValue;
	}

	internal void RegisterString(string obj, long objectID, SerializationInfo info, long idOfContainingObj, MemberInfo member)
	{
		ObjectHolder holder = new ObjectHolder(obj, objectID, info, null, idOfContainingObj, (FieldInfo)member, null);
		AddObjectHolder(holder);
	}

	public void RegisterObject(object obj, long objectID, SerializationInfo info, long idOfContainingObj, MemberInfo member, int[] arrayIndex)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (objectID <= 0)
		{
			throw new ArgumentOutOfRangeException("objectID", Environment.GetResourceString("objectID cannot be less than or equal to zero."));
		}
		if (member != null && !(member is RuntimeFieldInfo) && !(member is SerializationFieldInfo))
		{
			throw new SerializationException(Environment.GetResourceString("Only FieldInfo, PropertyInfo, and SerializationMemberInfo are recognized."));
		}
		ISerializationSurrogate surrogate = null;
		if (m_selector != null)
		{
			Type type = null;
			type = ((!CanCallGetType(obj)) ? typeof(MarshalByRefObject) : obj.GetType());
			surrogate = m_selector.GetSurrogate(type, m_context, out var _);
		}
		if (obj is IDeserializationCallback)
		{
			DeserializationEventHandler handler = ((IDeserializationCallback)obj).OnDeserialization;
			AddOnDeserialization(handler);
		}
		if (arrayIndex != null)
		{
			arrayIndex = (int[])arrayIndex.Clone();
		}
		ObjectHolder objectHolder = FindObjectHolder(objectID);
		if (objectHolder == null)
		{
			objectHolder = new ObjectHolder(obj, objectID, info, surrogate, idOfContainingObj, (FieldInfo)member, arrayIndex);
			AddObjectHolder(objectHolder);
			if (objectHolder.RequiresDelayedFixup)
			{
				SpecialFixupObjects.Add(objectHolder);
			}
			AddOnDeserialized(obj);
			return;
		}
		if (objectHolder.ObjectValue != null)
		{
			throw new SerializationException(Environment.GetResourceString("An object cannot be registered twice."));
		}
		objectHolder.UpdateData(obj, info, surrogate, idOfContainingObj, (FieldInfo)member, arrayIndex, this);
		if (objectHolder.DirectlyDependentObjects > 0)
		{
			CompleteObject(objectHolder, bObjectFullyComplete: false);
		}
		if (objectHolder.RequiresDelayedFixup)
		{
			SpecialFixupObjects.Add(objectHolder);
		}
		if (objectHolder.CompletelyFixed)
		{
			DoNewlyRegisteredObjectFixups(objectHolder);
			objectHolder.DependentObjects = null;
		}
		if (objectHolder.TotalDependentObjects > 0)
		{
			AddOnDeserialized(obj);
		}
		else
		{
			RaiseOnDeserializedEvent(obj);
		}
	}

	internal void CompleteISerializableObject(object obj, SerializationInfo info, StreamingContext context)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (!(obj is ISerializable))
		{
			throw new ArgumentException(Environment.GetResourceString("The given object does not implement the ISerializable interface."));
		}
		RuntimeConstructorInfo runtimeConstructorInfo = null;
		RuntimeType runtimeType = (RuntimeType)obj.GetType();
		try
		{
			runtimeConstructorInfo = GetConstructor(runtimeType);
		}
		catch (Exception innerException)
		{
			throw new SerializationException(Environment.GetResourceString("The constructor to deserialize an object of type '{0}' was not found.", runtimeType), innerException);
		}
		runtimeConstructorInfo.SerializationInvoke(obj, info, context);
	}

	internal static RuntimeConstructorInfo GetConstructor(RuntimeType t)
	{
		RuntimeConstructorInfo serializationCtor = t.GetSerializationCtor();
		if (serializationCtor == null)
		{
			throw new SerializationException(Environment.GetResourceString("The constructor to deserialize an object of type '{0}' was not found.", t.FullName));
		}
		return serializationCtor;
	}

	public virtual void DoFixups()
	{
		int num = -1;
		while (num != 0)
		{
			num = 0;
			ObjectHolderListEnumerator fixupEnumerator = SpecialFixupObjects.GetFixupEnumerator();
			while (fixupEnumerator.MoveNext())
			{
				ObjectHolder current = fixupEnumerator.Current;
				if (current.ObjectValue == null)
				{
					throw new SerializationException(Environment.GetResourceString("The object with ID {0} was referenced in a fixup but does not exist.", current.m_id));
				}
				if (current.TotalDependentObjects == 0)
				{
					if (current.RequiresSerInfoFixup)
					{
						FixupSpecialObject(current);
						num++;
					}
					else if (!current.IsIncompleteObjectReference)
					{
						CompleteObject(current, bObjectFullyComplete: true);
					}
					if (current.IsIncompleteObjectReference && ResolveObjectReference(current))
					{
						num++;
					}
				}
			}
		}
		if (m_fixupCount == 0L)
		{
			if (TopObject is TypeLoadExceptionHolder)
			{
				throw new SerializationException(Environment.GetResourceString("Unable to load type {0} required for deserialization.", ((TypeLoadExceptionHolder)TopObject).TypeName));
			}
			return;
		}
		for (int i = 0; i < m_objects.Length; i++)
		{
			for (ObjectHolder current = m_objects[i]; current != null; current = current.m_next)
			{
				if (current.TotalDependentObjects > 0)
				{
					CompleteObject(current, bObjectFullyComplete: true);
				}
			}
			if (m_fixupCount == 0L)
			{
				return;
			}
		}
		throw new SerializationException(Environment.GetResourceString("The ObjectManager found an invalid number of fixups. This usually indicates a problem in the Formatter."));
	}

	private void RegisterFixup(FixupHolder fixup, long objectToBeFixed, long objectRequired)
	{
		ObjectHolder objectHolder = FindOrCreateObjectHolder(objectToBeFixed);
		if (objectHolder.RequiresSerInfoFixup && fixup.m_fixupType == 2)
		{
			throw new SerializationException(Environment.GetResourceString("A member fixup was registered for an object which implements ISerializable or has a surrogate. In this situation, a delayed fixup must be used."));
		}
		objectHolder.AddFixup(fixup, this);
		FindOrCreateObjectHolder(objectRequired).AddDependency(objectToBeFixed);
		m_fixupCount++;
	}

	public virtual void RecordFixup(long objectToBeFixed, MemberInfo member, long objectRequired)
	{
		if (objectToBeFixed <= 0 || objectRequired <= 0)
		{
			throw new ArgumentOutOfRangeException((objectToBeFixed <= 0) ? "objectToBeFixed" : "objectRequired", Environment.GetResourceString("Object IDs must be greater than zero."));
		}
		if (member == null)
		{
			throw new ArgumentNullException("member");
		}
		if (!(member is RuntimeFieldInfo) && !(member is SerializationFieldInfo))
		{
			throw new SerializationException(Environment.GetResourceString("Only system-provided types can be passed to the GetUninitializedObject method. '{0}' is not a valid instance of a type.", member.GetType().ToString()));
		}
		FixupHolder fixup = new FixupHolder(objectRequired, member, 2);
		RegisterFixup(fixup, objectToBeFixed, objectRequired);
	}

	public virtual void RecordDelayedFixup(long objectToBeFixed, string memberName, long objectRequired)
	{
		if (objectToBeFixed <= 0 || objectRequired <= 0)
		{
			throw new ArgumentOutOfRangeException((objectToBeFixed <= 0) ? "objectToBeFixed" : "objectRequired", Environment.GetResourceString("Object IDs must be greater than zero."));
		}
		if (memberName == null)
		{
			throw new ArgumentNullException("memberName");
		}
		FixupHolder fixup = new FixupHolder(objectRequired, memberName, 4);
		RegisterFixup(fixup, objectToBeFixed, objectRequired);
	}

	public virtual void RecordArrayElementFixup(long arrayToBeFixed, int[] indices, long objectRequired)
	{
		if (arrayToBeFixed <= 0 || objectRequired <= 0)
		{
			throw new ArgumentOutOfRangeException((arrayToBeFixed <= 0) ? "objectToBeFixed" : "objectRequired", Environment.GetResourceString("Object IDs must be greater than zero."));
		}
		if (indices == null)
		{
			throw new ArgumentNullException("indices");
		}
		FixupHolder fixup = new FixupHolder(objectRequired, indices, 1);
		RegisterFixup(fixup, arrayToBeFixed, objectRequired);
	}

	public virtual void RaiseDeserializationEvent()
	{
		if (m_onDeserializedHandler != null)
		{
			m_onDeserializedHandler(m_context);
		}
		if (m_onDeserializationHandler != null)
		{
			m_onDeserializationHandler(null);
		}
	}

	internal virtual void AddOnDeserialization(DeserializationEventHandler handler)
	{
		m_onDeserializationHandler = (DeserializationEventHandler)Delegate.Combine(m_onDeserializationHandler, handler);
	}

	internal virtual void AddOnDeserialized(object obj)
	{
		SerializationEvents serializationEventsForType = SerializationEventsCache.GetSerializationEventsForType(obj.GetType());
		m_onDeserializedHandler = serializationEventsForType.AddOnDeserialized(obj, m_onDeserializedHandler);
	}

	internal virtual void RaiseOnDeserializedEvent(object obj)
	{
		SerializationEventsCache.GetSerializationEventsForType(obj.GetType()).InvokeOnDeserialized(obj, m_context);
	}

	public void RaiseOnDeserializingEvent(object obj)
	{
		SerializationEventsCache.GetSerializationEventsForType(obj.GetType()).InvokeOnDeserializing(obj, m_context);
	}
}
