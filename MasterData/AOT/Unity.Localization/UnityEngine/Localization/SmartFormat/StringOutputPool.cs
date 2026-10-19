using UnityEngine.Localization.SmartFormat.Core.Output;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat;

internal static class StringOutputPool
{
	internal static readonly ObjectPool<StringOutput> s_Pool = new ObjectPool<StringOutput>(() => new StringOutput(), null, (StringOutput so) =>
	{
		so.Clear();
	});

	public static StringOutput Get(int capacity)
	{
		StringOutput stringOutput = s_Pool.Get();
		stringOutput.SetCapacity(capacity);
		return stringOutput;
	}

	public static PooledObject<StringOutput> Get(int capacity, out StringOutput value)
	{
		PooledObject<StringOutput> result = s_Pool.Get(out value);
		value.SetCapacity(capacity);
		return result;
	}

	public static void Release(StringOutput toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
