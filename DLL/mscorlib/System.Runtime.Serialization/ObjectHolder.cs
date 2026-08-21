using System.Reflection;

namespace System.Runtime.Serialization;

internal sealed class ObjectHolder
{
	private object m_object;

	internal long m_id;

	private int m_missingElementsRemaining;

	private int m_missingDecendents;

	internal SerializationInfo m_serInfo;

	internal ISerializationSurrogate m_surrogate;

	internal FixupHolderList m_missingElements;

	internal LongList m_dependentObjects;

	internal ObjectHolder m_next;

	internal int m_flags;

	private bool m_markForFixupWhenAvailable;

	private ValueTypeFixupInfo m_valueFixup;

	private TypeLoadExceptionHolder m_typeLoad;

	private bool m_reachable;

	internal bool IsIncompleteObjectReference
	{
		get
		{
			return (m_flags & 1) != 0;
		}
		set
		{
			if (value)
			{
				m_flags |= 1;
			}
			else
			{
				m_flags &= -2;
			}
		}
	}

	internal bool RequiresDelayedFixup => (m_flags & 7) != 0;

	internal bool RequiresValueTypeFixup => (m_flags & 8) != 0;

	internal bool ValueTypeFixupPerformed
	{
		get
		{
			if ((m_flags & 0x8000) == 0)
			{
				if (m_object != null)
				{
					if (m_dependentObjects != null)
					{
						return m_dependentObjects.Count == 0;
					}
					return true;
				}
				return false;
			}
			return true;
		}
		set
		{
			if (value)
			{
				m_flags |= 32768;
			}
		}
	}

	internal bool HasISerializable => (m_flags & 2) != 0;

	internal bool HasSurrogate => (m_flags & 4) != 0;

	internal bool CanSurrogatedObjectValueChange
	{
		get
		{
			if (m_surrogate != null)
			{
				return m_surrogate.GetType() != typeof(SurrogateForCyclicalReference);
			}
			return true;
		}
	}

	internal bool CanObjectValueChange
	{
		get
		{
			if (IsIncompleteObjectReference)
			{
				return true;
			}
			if (HasSurrogate)
			{
				return CanSurrogatedObjectValueChange;
			}
			return false;
		}
	}

	internal int DirectlyDependentObjects => m_missingElementsRemaining;

	internal int TotalDependentObjects => m_missingElementsRemaining + m_missingDecendents;

	internal bool Reachable
	{
		get
		{
			return m_reachable;
		}
		set
		{
			m_reachable = value;
		}
	}

	internal bool TypeLoadExceptionReachable => m_typeLoad != null;

	internal TypeLoadExceptionHolder TypeLoadException
	{
		get
		{
			return m_typeLoad;
		}
		set
		{
			m_typeLoad = value;
		}
	}

	internal object ObjectValue => m_object;

	internal SerializationInfo SerializationInfo
	{
		get
		{
			return m_serInfo;
		}
		set
		{
			m_serInfo = value;
		}
	}

	internal ISerializationSurrogate Surrogate => m_surrogate;

	internal LongList DependentObjects
	{
		get
		{
			return m_dependentObjects;
		}
		set
		{
			m_dependentObjects = value;
		}
	}

	internal bool RequiresSerInfoFixup
	{
		get
		{
			if ((m_flags & 4) == 0 && (m_flags & 2) == 0)
			{
				return false;
			}
			return (m_flags & 0x4000) == 0;
		}
		set
		{
			if (!value)
			{
				m_flags |= 16384;
			}
			else
			{
				m_flags &= -16385;
			}
		}
	}

	internal ValueTypeFixupInfo ValueFixup => m_valueFixup;

	internal bool CompletelyFixed
	{
		get
		{
			if (!RequiresSerInfoFixup)
			{
				return !IsIncompleteObjectReference;
			}
			return false;
		}
	}

	internal long ContainerID
	{
		get
		{
			if (m_valueFixup != null)
			{
				return m_valueFixup.ContainerID;
			}
			return 0L;
		}
	}

	internal ObjectHolder(long objID)
		: this(null, objID, null, null, 0L, null, null)
	{
	}

	internal ObjectHolder(object obj, long objID, SerializationInfo info, ISerializationSurrogate surrogate, long idOfContainingObj, FieldInfo field, int[] arrayIndex)
	{
		m_object = obj;
		m_id = objID;
		m_flags = 0;
		m_missingElementsRemaining = 0;
		m_missingDecendents = 0;
		m_dependentObjects = null;
		m_next = null;
		m_serInfo = info;
		m_surrogate = surrogate;
		m_markForFixupWhenAvailable = false;
		if (obj is TypeLoadExceptionHolder)
		{
			m_typeLoad = (TypeLoadExceptionHolder)obj;
		}
		if (idOfContainingObj != 0L && ((field != null && field.FieldType.IsValueType) || arrayIndex != null))
		{
			if (idOfContainingObj == objID)
			{
				throw new SerializationException(Environment.GetResourceString("The ID of the containing object cannot be the same as the object ID."));
			}
			m_valueFixup = new ValueTypeFixupInfo(idOfContainingObj, field, arrayIndex);
		}
		SetFlags();
	}

	internal ObjectHolder(string obj, long objID, SerializationInfo info, ISerializationSurrogate surrogate, long idOfContainingObj, FieldInfo field, int[] arrayIndex)
	{
		m_object = obj;
		m_id = objID;
		m_flags = 0;
		m_missingElementsRemaining = 0;
		m_missingDecendents = 0;
		m_dependentObjects = null;
		m_next = null;
		m_serInfo = info;
		m_surrogate = surrogate;
		m_markForFixupWhenAvailable = false;
		if (idOfContainingObj != 0L && arrayIndex != null)
		{
			m_valueFixup = new ValueTypeFixupInfo(idOfContainingObj, field, arrayIndex);
		}
		if (m_valueFixup != null)
		{
			m_flags |= 8;
		}
	}

	private void IncrementDescendentFixups(int amount)
	{
		m_missingDecendents += amount;
	}

	internal void DecrementFixupsRemaining(ObjectManager manager)
	{
		m_missingElementsRemaining--;
		if (RequiresValueTypeFixup)
		{
			UpdateDescendentDependencyChain(-1, manager);
		}
	}

	internal void RemoveDependency(long id)
	{
		m_dependentObjects.RemoveElement(id);
	}

	internal void AddFixup(FixupHolder fixup, ObjectManager manager)
	{
		if (m_missingElements == null)
		{
			m_missingElements = new FixupHolderList();
		}
		m_missingElements.Add(fixup);
		m_missingElementsRemaining++;
		if (RequiresValueTypeFixup)
		{
			UpdateDescendentDependencyChain(1, manager);
		}
	}

	private void UpdateDescendentDependencyChain(int amount, ObjectManager manager)
	{
		ObjectHolder objectHolder = this;
		do
		{
			objectHolder = manager.FindOrCreateObjectHolder(objectHolder.ContainerID);
			objectHolder.IncrementDescendentFixups(amount);
		}
		while (objectHolder.RequiresValueTypeFixup);
	}

	internal void AddDependency(long dependentObject)
	{
		if (m_dependentObjects == null)
		{
			m_dependentObjects = new LongList();
		}
		m_dependentObjects.Add(dependentObject);
	}

	internal void UpdateData(object obj, SerializationInfo info, ISerializationSurrogate surrogate, long idOfContainer, FieldInfo field, int[] arrayIndex, ObjectManager manager)
	{
		SetObjectValue(obj, manager);
		m_serInfo = info;
		m_surrogate = surrogate;
		if (idOfContainer != 0L && ((field != null && field.FieldType.IsValueType) || arrayIndex != null))
		{
			if (idOfContainer == m_id)
			{
				throw new SerializationException(Environment.GetResourceString("The ID of the containing object cannot be the same as the object ID."));
			}
			m_valueFixup = new ValueTypeFixupInfo(idOfContainer, field, arrayIndex);
		}
		SetFlags();
		if (RequiresValueTypeFixup)
		{
			UpdateDescendentDependencyChain(m_missingElementsRemaining, manager);
		}
	}

	internal void MarkForCompletionWhenAvailable()
	{
		m_markForFixupWhenAvailable = true;
	}

	internal void SetFlags()
	{
		if (m_object is IObjectReference)
		{
			m_flags |= 1;
		}
		m_flags &= -7;
		if (m_surrogate != null)
		{
			m_flags |= 4;
		}
		else if (m_object is ISerializable)
		{
			m_flags |= 2;
		}
		if (m_valueFixup != null)
		{
			m_flags |= 8;
		}
	}

	internal void SetObjectValue(object obj, ObjectManager manager)
	{
		m_object = obj;
		if (obj == manager.TopObject)
		{
			m_reachable = true;
		}
		if (obj is TypeLoadExceptionHolder)
		{
			m_typeLoad = (TypeLoadExceptionHolder)obj;
		}
		if (m_markForFixupWhenAvailable)
		{
			manager.CompleteObject(this, bObjectFullyComplete: true);
		}
	}
}
