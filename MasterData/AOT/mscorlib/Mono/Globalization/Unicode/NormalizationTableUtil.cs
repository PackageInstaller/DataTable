namespace Mono.Globalization.Unicode;

internal class NormalizationTableUtil
{
	public static readonly CodePointIndexer Prop;

	public static readonly CodePointIndexer Map;

	public static readonly CodePointIndexer Combining;

	public static readonly CodePointIndexer Composite;

	public static readonly CodePointIndexer Helper;

	static NormalizationTableUtil()
	{
		int[] starts = new int[11]
		{
			0, 2320, 6912, 9312, 10624, 11376, 11616, 11920, 42864, 42992,
			63744
		};
		int[] ends = new int[11]
		{
			1760, 4608, 9008, 9728, 10976, 11392, 11632, 13312, 42880, 43008,
			65536
		};
		int[] starts2 = new int[9] { 144, 2336, 7456, 9312, 9376, 10752, 11616, 11920, 63744 };
		int[] ends2 = new int[9] { 1760, 4352, 9008, 9376, 9456, 10976, 11632, 13312, 65536 };
		int[] starts3 = new int[30]
		{
			752, 1152, 1424, 2352, 2480, 2608, 2736, 2864, 3008, 3136,
			3248, 3392, 3520, 3632, 3760, 3840, 4144, 4944, 5904, 6096,
			6304, 6448, 6672, 7616, 8400, 12320, 12432, 43008, 64272, 65056
		};
		int[] ends3 = new int[30]
		{
			864, 1168, 1872, 2400, 2512, 2640, 2768, 2896, 3024, 3168,
			3280, 3408, 3536, 3664, 3792, 4048, 4160, 4960, 5952, 6112,
			6320, 6464, 6688, 7632, 8432, 12336, 12448, 43024, 64288, 65072
		};
		int[] starts4 = new int[3] { 1152, 5136, 5744 };
		int[] ends4 = new int[3] { 4224, 5504, 8624 };
		int[] starts5 = new int[9] { 0, 2304, 7424, 9472, 12288, 15248, 16400, 19968, 64320 };
		int[] ends5 = new int[9] { 1792, 4608, 8960, 9728, 12640, 15264, 16432, 40960, 64336 };
		Prop = new CodePointIndexer(starts, ends, 0, 0);
		Map = new CodePointIndexer(starts2, ends2, 0, 0);
		Combining = new CodePointIndexer(starts3, ends3, 0, 0);
		Composite = new CodePointIndexer(starts4, ends4, 0, 0);
		Helper = new CodePointIndexer(starts5, ends5, 0, 0);
	}

	public static int PropIdx(int cp)
	{
		return Prop.ToIndex(cp);
	}

	public static int MapIdx(int cp)
	{
		return Map.ToIndex(cp);
	}
}
