using Unity.Burst.LowLevel;
using UnityEngine;
using UnityEngine.Bindings;

namespace Unity.Collections.LowLevel.Unsafe;

[NativeHeader("Runtime/Export/BurstLike/BurstLike.bindings.h")]
[StaticAccessor("BurstLike", StaticAccessorType.DoubleColon)]
internal static class BurstLike
{
	internal readonly struct SharedStatic<T> where T : unmanaged
	{
		private unsafe readonly void* _buffer;

		public unsafe ref T Data => ref UnsafeUtility.AsRef<T>(_buffer);

		private unsafe SharedStatic(void* buffer)
		{
			_buffer = buffer;
		}

		public unsafe static SharedStatic<T> GetOrCreate<TContext>(uint alignment = 0u)
		{
			return new SharedStatic<T>(SharedStatic.GetOrCreateSharedStaticInternal(BurstRuntime.GetHashCode64<TContext>(), 0L, (uint)UnsafeUtility.SizeOf<T>(), alignment));
		}
	}

	internal static class SharedStatic
	{
		public unsafe static void* GetOrCreateSharedStaticInternal(long getHashCode64, long getSubHashCode64, uint sizeOf, uint alignment)
		{
			Hash128 key = new Hash128((ulong)getHashCode64, (ulong)getSubHashCode64);
			return BurstCompilerService.GetOrCreateSharedMemory(ref key, sizeOf, (alignment == 0) ? 4u : alignment);
		}
	}
}
