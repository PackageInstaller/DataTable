public static class FrameObjectPool<T> where T : class, IFramePooledObject, new()
{
	public static T Claim()
	{
		return FrameObjectPoolSimple<T>.Claim();
	}

	public static void Release(T obj)
	{
		T val = obj;
		FrameObjectPoolSimple<T>.Release(ref obj);
		val.OnEnterPool();
	}
}
