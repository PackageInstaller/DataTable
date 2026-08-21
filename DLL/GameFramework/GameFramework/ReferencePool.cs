using System;
using System.Collections.Generic;

namespace GameFramework;

public static class ReferencePool
{
	private sealed class ReferenceCollection
	{
		private readonly Queue<IReference> m_References;

		private readonly Type m_ReferenceType;

		private int m_UsingReferenceCount;

		private int m_AcquireReferenceCount;

		private int m_ReleaseReferenceCount;

		private int m_AddReferenceCount;

		private int m_RemoveReferenceCount;

		public Type ReferenceType => m_ReferenceType;

		public int UnusedReferenceCount => m_References.Count;

		public int UsingReferenceCount => m_UsingReferenceCount;

		public int AcquireReferenceCount => m_AcquireReferenceCount;

		public int ReleaseReferenceCount => m_ReleaseReferenceCount;

		public int AddReferenceCount => m_AddReferenceCount;

		public int RemoveReferenceCount => m_RemoveReferenceCount;

		public ReferenceCollection(Type referenceType)
		{
			m_References = new Queue<IReference>();
			m_ReferenceType = referenceType;
			m_UsingReferenceCount = 0;
			m_AcquireReferenceCount = 0;
			m_ReleaseReferenceCount = 0;
			m_AddReferenceCount = 0;
			m_RemoveReferenceCount = 0;
		}

		public T Acquire<T>() where T : class, IReference, new()
		{
			if (typeof(T) != m_ReferenceType)
			{
				throw new GameFrameworkException("Type is invalid.");
			}
			m_UsingReferenceCount++;
			m_AcquireReferenceCount++;
			lock (m_References)
			{
				if (m_References.Count > 0)
				{
					return (T)m_References.Dequeue();
				}
			}
			m_AddReferenceCount++;
			return new T();
		}

		public IReference Acquire()
		{
			m_UsingReferenceCount++;
			m_AcquireReferenceCount++;
			lock (m_References)
			{
				if (m_References.Count > 0)
				{
					return m_References.Dequeue();
				}
			}
			m_AddReferenceCount++;
			return (IReference)Activator.CreateInstance(m_ReferenceType);
		}

		public void Release(IReference reference)
		{
			reference.Clear();
			lock (m_References)
			{
				if (m_EnableStrictCheck && m_References.Contains(reference))
				{
					throw new GameFrameworkException("The reference has been released.");
				}
				m_References.Enqueue(reference);
			}
			m_ReleaseReferenceCount++;
			m_UsingReferenceCount--;
		}

		public void Add<T>(int count) where T : class, IReference, new()
		{
			if (typeof(T) != m_ReferenceType)
			{
				throw new GameFrameworkException("Type is invalid.");
			}
			lock (m_References)
			{
				m_AddReferenceCount += count;
				while (count-- > 0)
				{
					m_References.Enqueue(new T());
				}
			}
		}

		public void Add(int count)
		{
			lock (m_References)
			{
				m_AddReferenceCount += count;
				while (count-- > 0)
				{
					m_References.Enqueue((IReference)Activator.CreateInstance(m_ReferenceType));
				}
			}
		}

		public void Remove(int count)
		{
			lock (m_References)
			{
				if (count > m_References.Count)
				{
					count = m_References.Count;
				}
				m_RemoveReferenceCount += count;
				while (count-- > 0)
				{
					m_References.Dequeue();
				}
			}
		}

		public void RemoveAll()
		{
			lock (m_References)
			{
				m_RemoveReferenceCount += m_References.Count;
				m_References.Clear();
			}
		}
	}

	private static readonly Dictionary<Type, ReferenceCollection> s_ReferenceCollections = new Dictionary<Type, ReferenceCollection>();

	private static bool m_EnableStrictCheck = false;

	public static bool EnableStrictCheck
	{
		get
		{
			return m_EnableStrictCheck;
		}
		set
		{
			m_EnableStrictCheck = value;
		}
	}

	public static int Count => s_ReferenceCollections.Count;

	public static ReferencePoolInfo[] GetAllReferencePoolInfos()
	{
		int num = 0;
		ReferencePoolInfo[] array = null;
		lock (s_ReferenceCollections)
		{
			array = new ReferencePoolInfo[s_ReferenceCollections.Count];
			foreach (KeyValuePair<Type, ReferenceCollection> s_ReferenceCollection in s_ReferenceCollections)
			{
				array[num++] = new ReferencePoolInfo(s_ReferenceCollection.Key, s_ReferenceCollection.Value.UnusedReferenceCount, s_ReferenceCollection.Value.UsingReferenceCount, s_ReferenceCollection.Value.AcquireReferenceCount, s_ReferenceCollection.Value.ReleaseReferenceCount, s_ReferenceCollection.Value.AddReferenceCount, s_ReferenceCollection.Value.RemoveReferenceCount);
			}
		}
		return array;
	}

	public static void ClearAll()
	{
		lock (s_ReferenceCollections)
		{
			foreach (KeyValuePair<Type, ReferenceCollection> s_ReferenceCollection in s_ReferenceCollections)
			{
				s_ReferenceCollection.Value.RemoveAll();
			}
			s_ReferenceCollections.Clear();
		}
	}

	public static T Acquire<T>() where T : class, IReference, new()
	{
		return GetReferenceCollection(typeof(T)).Acquire<T>();
	}

	public static IReference Acquire(Type referenceType)
	{
		InternalCheckReferenceType(referenceType);
		return GetReferenceCollection(referenceType).Acquire();
	}

	public static void Release(IReference reference)
	{
		if (reference == null)
		{
			throw new GameFrameworkException("Reference is invalid.");
		}
		Type type = reference.GetType();
		InternalCheckReferenceType(type);
		GetReferenceCollection(type).Release(reference);
	}

	public static void Add<T>(int count) where T : class, IReference, new()
	{
		GetReferenceCollection(typeof(T)).Add<T>(count);
	}

	public static void Add(Type referenceType, int count)
	{
		InternalCheckReferenceType(referenceType);
		GetReferenceCollection(referenceType).Add(count);
	}

	public static void Remove<T>(int count) where T : class, IReference
	{
		GetReferenceCollection(typeof(T)).Remove(count);
	}

	public static void Remove(Type referenceType, int count)
	{
		InternalCheckReferenceType(referenceType);
		GetReferenceCollection(referenceType).Remove(count);
	}

	public static void RemoveAll<T>() where T : class, IReference
	{
		GetReferenceCollection(typeof(T)).RemoveAll();
	}

	public static void RemoveAll(Type referenceType)
	{
		InternalCheckReferenceType(referenceType);
		GetReferenceCollection(referenceType).RemoveAll();
	}

	private static void InternalCheckReferenceType(Type referenceType)
	{
		if (m_EnableStrictCheck)
		{
			if (referenceType == null)
			{
				throw new GameFrameworkException("Reference type is invalid.");
			}
			if (!referenceType.IsClass || referenceType.IsAbstract)
			{
				throw new GameFrameworkException("Reference type is not a non-abstract class type.");
			}
			if (!typeof(IReference).IsAssignableFrom(referenceType))
			{
				throw new GameFrameworkException(Utility.Text.Format("Reference type '{0}' is invalid.", referenceType.FullName));
			}
		}
	}

	private static ReferenceCollection GetReferenceCollection(Type referenceType)
	{
		if (referenceType == null)
		{
			throw new GameFrameworkException("ReferenceType is invalid.");
		}
		ReferenceCollection value = null;
		lock (s_ReferenceCollections)
		{
			if (!s_ReferenceCollections.TryGetValue(referenceType, out value))
			{
				value = new ReferenceCollection(referenceType);
				s_ReferenceCollections.Add(referenceType, value);
			}
		}
		return value;
	}
}
