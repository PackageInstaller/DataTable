namespace System.Buffers;

public abstract class ArrayPool<T>
{
	public static ArrayPool<T> Shared { get; } = new TlsOverPerCoreLockedStacksArrayPool<T>();

	public static ArrayPool<T> Create()
	{
		return new ConfigurableArrayPool<T>();
	}

	public static ArrayPool<T> Create(int maxArrayLength, int maxArraysPerBucket)
	{
		return new ConfigurableArrayPool<T>(maxArrayLength, maxArraysPerBucket);
	}

	public abstract T[] Rent(int minimumLength);

	public abstract void Return(T[] array, bool clearArray = false);
}
