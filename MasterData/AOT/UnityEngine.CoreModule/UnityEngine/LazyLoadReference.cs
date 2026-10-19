using System;

namespace UnityEngine;

[Serializable]
public struct LazyLoadReference<T> where T : Object
{
	[SerializeField]
	private int m_InstanceID;

	public T asset
	{
		get
		{
			if (m_InstanceID == 0)
			{
				return null;
			}
			return (T)Object.ForceLoadFromInstanceID(m_InstanceID);
		}
		set
		{
			if (value == null)
			{
				m_InstanceID = 0;
				return;
			}
			if (!Object.IsPersistent(value))
			{
				throw new ArgumentException("Object that does not belong to a persisted asset cannot be set as the target of a LazyLoadReference.");
			}
			m_InstanceID = value.GetInstanceID();
		}
	}
}
