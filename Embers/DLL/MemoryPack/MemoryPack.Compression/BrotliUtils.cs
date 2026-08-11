using System;
using System.IO.Compression;

namespace MemoryPack.Compression;

internal static class BrotliUtils
{
	public const int WindowBits_Min = 10;

	public const int WindowBits_Default = 22;

	public const int WindowBits_Max = 24;

	public const int Quality_Min = 0;

	public const int Quality_Default = 4;

	public const int Quality_Max = 11;

	public const int MaxInputSize = 2147483132;

	internal static int GetQualityFromCompressionLevel(CompressionLevel compressionLevel)
	{
		return compressionLevel switch
		{
			CompressionLevel.NoCompression => 0, 
			CompressionLevel.Fastest => 1, 
			CompressionLevel.Optimal => 4, 
			_ => throw new ArgumentException(), 
		};
	}

	internal static int BrotliEncoderMaxCompressedSize(int input_size)
	{
		int num = input_size >> 14;
		int num2 = 2 + 4 * num + 3 + 1;
		int num3 = input_size + num2;
		if (input_size == 0)
		{
			return 2;
		}
		if (num3 >= input_size)
		{
			return num3;
		}
		return 0;
	}
}
