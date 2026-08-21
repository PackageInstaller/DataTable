using System;
using System.Collections.Concurrent;
using System.Runtime.CompilerServices;
using System.Threading;
using Cysharp.Threading.Tasks;

namespace Ase;

public class ObjectPool : Singleton<ObjectPool>, ISingletonAwake
{
	private class Pool
	{
		private readonly Type ObjectType;

		private readonly int MaxCapacity;

		private int NumItems;

		private readonly ConcurrentQueue<object> _items = new ConcurrentQueue<object>();

		private object FastItem;

		public Pool(Type objectType, int maxCapacity)
		{
			ObjectType = objectType;
			MaxCapacity = maxCapacity;
		}

		public object Get()
		{
			object result = FastItem;
			if (result == null || Interlocked.CompareExchange(ref FastItem, null, result) != result)
			{
				if (_items.TryDequeue(out result))
				{
					Interlocked.Decrement(ref NumItems);
					return result;
				}
				return Activator.CreateInstance(ObjectType);
			}
			return result;
		}

		public void Return(object obj)
		{
			if (FastItem != null || Interlocked.CompareExchange(ref FastItem, obj, null) != null)
			{
				if (Interlocked.Increment(ref NumItems) <= MaxCapacity)
				{
					_items.Enqueue(obj);
				}
				else
				{
					Interlocked.Decrement(ref NumItems);
				}
			}
		}
	}

	private ConcurrentDictionary<Type, Pool> objPool;

	private readonly Func<Type, Pool> AddPoolFunc = (Type type) => new Pool(type, 1000);

	public void Awake()
	{
		lock (this)
		{
			objPool = new ConcurrentDictionary<Type, Pool>();
		}
	}

	public T Fetch<T>() where T : class
	{
		return Fetch(typeof(T)) as T;
	}

	public object Fetch(Type type)
	{
		return GetPool(type).Get();
	}

	public void Recycle(object obj)
	{
		Type type = obj.GetType();
		GetPool(type).Return(obj);
	}

	[MethodImpl((MethodImplOptions)256)]
	private Pool GetPool(Type type)
	{
		return objPool.GetOrAdd(type, AddPoolFunc);
	}
}
public class ObjectPool<T> : IObjectPool<T>, IObjectPool, IDisposable where T : class
{
	private struct Entry
	{
		public T value;
	}

	private readonly Entry[] entries;

	private int maxSize;

	private int initialSize;

	protected readonly IObjectFactory<T> factory;

	private bool disposed;

	public int MaxSize => maxSize;

	public int InitialSize => initialSize;

	public ObjectPool(IObjectFactory<T> factory)
		: this(factory, 0, Environment.ProcessorCount * 2)
	{
	}

	public ObjectPool(IObjectFactory<T> factory, int maxSize)
		: this(factory, 0, maxSize)
	{
	}

	public ObjectPool(IObjectFactory<T> factory, int initialSize, int maxSize)
	{
		this.factory = factory;
		this.initialSize = initialSize;
		this.maxSize = maxSize;
		entries = new Entry[maxSize];
		if (maxSize < initialSize)
		{
			throw new ArgumentException("the maxSize must be greater than or equal to the initialSize");
		}
		for (int i = 0; i < initialSize; i++)
		{
			entries[i].value = factory.Create(this);
		}
	}

	public virtual T Allocate()
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().Name);
		}
		T val = null;
		for (int i = 0; i < entries.Length; i++)
		{
			val = entries[i].value;
			if (val != null && Interlocked.CompareExchange(ref entries[i].value, null, val) == val)
			{
				return val;
			}
		}
		return factory.Create(this);
	}

	public virtual async UniTask<bool> PreLoadData()
	{
		if (disposed)
		{
			throw new ObjectDisposedException(GetType().Name);
		}
		for (int i = 0; i < entries.Length; i++)
		{
			if (entries[i].value != null)
			{
				return true;
			}
		}
		return await factory.PreLoadData();
	}

	public virtual void Free(T obj)
	{
		if (obj == null)
		{
			return;
		}
		if (disposed || !factory.Validate(obj))
		{
			factory.Destroy(obj);
			return;
		}
		factory.Reset(obj);
		for (int i = 0; i < entries.Length; i++)
		{
			if (Interlocked.CompareExchange(ref entries[i].value, obj, null) == null)
			{
				return;
			}
		}
		factory.Destroy(obj);
	}

	object IObjectPool.Allocate()
	{
		return Allocate();
	}

	void IObjectPool.Free(object obj)
	{
		Free((T)obj);
	}

	public void Release(T obj)
	{
		factory.Destroy(obj);
	}

	protected virtual void Clear()
	{
		for (int i = 0; i < entries.Length; i++)
		{
			T val = Interlocked.Exchange(ref entries[i].value, null);
			if (val != null)
			{
				factory.Destroy(val);
			}
		}
		factory.Dispose();
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposed)
		{
			Clear();
			disposed = true;
		}
	}

	~ObjectPool()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
