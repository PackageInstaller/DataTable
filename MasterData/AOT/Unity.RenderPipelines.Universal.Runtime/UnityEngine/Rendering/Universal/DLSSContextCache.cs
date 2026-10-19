using System;

namespace UnityEngine.Rendering.Universal;

public static class DLSSContextCache
{
	public struct CacheKey : IEquatable<CacheKey>
	{
		public int cameraInstanceID;

		public int inputWidth;

		public int inputHeight;

		public int outputWidth;

		public int outputHeight;

		public int quality;

		public uint flags;

		public bool Equals(CacheKey other)
		{
			if (cameraInstanceID == other.cameraInstanceID && inputWidth == other.inputWidth && inputHeight == other.inputHeight && outputWidth == other.outputWidth && outputHeight == other.outputHeight && quality == other.quality)
			{
				return flags == other.flags;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return (((((cameraInstanceID * 31 + inputWidth) * 31 + inputHeight) * 31 + outputWidth) * 31 + outputHeight) * 31 + quality) * 31 + (int)flags;
		}
	}
}
