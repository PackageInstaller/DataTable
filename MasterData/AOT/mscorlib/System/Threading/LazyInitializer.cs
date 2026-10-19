namespace System.Threading;

public static class LazyInitializer
{
	public static T EnsureInitialized<T>(ref T target) where T : class
	{
		return Volatile.Read(ref target) ?? EnsureInitializedCore(ref target);
	}

	private static T EnsureInitializedCore<T>(ref T target) where T : class
	{
		try
		{
			Interlocked.CompareExchange(ref target, Activator.CreateInstance<T>(), null);
		}
		catch (MissingMethodException)
		{
			throw new MissingMemberException("The lazily-initialized type does not have a public, parameterless constructor.");
		}
		return target;
	}

	public static T EnsureInitialized<T>(ref T target, Func<T> valueFactory) where T : class
	{
		return Volatile.Read(ref target) ?? EnsureInitializedCore(ref target, valueFactory);
	}

	private static T EnsureInitializedCore<T>(ref T target, Func<T> valueFactory) where T : class
	{
		T val = valueFactory();
		if (val == null)
		{
			throw new InvalidOperationException("ValueFactory returned null.");
		}
		Interlocked.CompareExchange(ref target, val, null);
		return target;
	}

	public static T EnsureInitialized<T>(ref T target, ref bool initialized, ref object syncLock, Func<T> valueFactory)
	{
		if (Volatile.Read(ref initialized))
		{
			return target;
		}
		return EnsureInitializedCore(ref target, ref initialized, ref syncLock, valueFactory);
	}

	private static T EnsureInitializedCore<T>(ref T target, ref bool initialized, ref object syncLock, Func<T> valueFactory)
	{
		lock (EnsureLockInitialized(ref syncLock))
		{
			if (!Volatile.Read(ref initialized))
			{
				target = valueFactory();
				Volatile.Write(ref initialized, value: true);
			}
		}
		return target;
	}

	public static T EnsureInitialized<T>(ref T target, ref object syncLock, Func<T> valueFactory) where T : class
	{
		return Volatile.Read(ref target) ?? EnsureInitializedCore(ref target, ref syncLock, valueFactory);
	}

	private static T EnsureInitializedCore<T>(ref T target, ref object syncLock, Func<T> valueFactory) where T : class
	{
		lock (EnsureLockInitialized(ref syncLock))
		{
			if (Volatile.Read(ref target) == null)
			{
				Volatile.Write(ref target, valueFactory());
				if (target == null)
				{
					throw new InvalidOperationException("ValueFactory returned null.");
				}
			}
		}
		return target;
	}

	private static object EnsureLockInitialized(ref object syncLock)
	{
		return syncLock ?? Interlocked.CompareExchange(ref syncLock, new object(), null) ?? syncLock;
	}
}
