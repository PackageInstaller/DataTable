namespace Mono.Globalization.Unicode;

internal class MSCompatUnicodeTableUtil
{
	public static readonly CodePointIndexer Ignorable;

	public static readonly CodePointIndexer Category;

	public static readonly CodePointIndexer Level1;

	public static readonly CodePointIndexer Level2;

	public static readonly CodePointIndexer Level3;

	public static readonly CodePointIndexer CjkCHS;

	public static readonly CodePointIndexer Cjk;

	static MSCompatUnicodeTableUtil()
	{
		int[] starts = new int[3] { 0, 40960, 63744 };
		int[] ends = new int[3] { 13312, 42240, 65536 };
		int[] starts2 = new int[6] { 0, 7680, 12288, 19968, 44032, 63744 };
		int[] ends2 = new int[6] { 4608, 10240, 13312, 40960, 55216, 65536 };
		int[] starts3 = new int[6] { 0, 7680, 12288, 19968, 44032, 63744 };
		int[] ends3 = new int[6] { 4608, 10240, 13312, 40960, 55216, 65536 };
		int[] starts4 = new int[4] { 0, 7680, 12288, 64256 };
		int[] ends4 = new int[4] { 3840, 10240, 13312, 65536 };
		int[] starts5 = new int[4] { 0, 7680, 12288, 64256 };
		int[] ends5 = new int[4] { 4608, 10240, 13312, 65536 };
		int[] starts6 = new int[3] { 12544, 19968, 59392 };
		int[] ends6 = new int[3] { 13312, 40960, 65536 };
		int[] starts7 = new int[3] { 12544, 19968, 63744 };
		int[] ends7 = new int[3] { 13312, 40960, 64256 };
		Ignorable = new CodePointIndexer(starts, ends, -1, -1);
		Category = new CodePointIndexer(starts2, ends2, 0, 0);
		Level1 = new CodePointIndexer(starts3, ends3, 0, 0);
		Level2 = new CodePointIndexer(starts4, ends4, 0, 0);
		Level3 = new CodePointIndexer(starts5, ends5, 0, 0);
		CjkCHS = new CodePointIndexer(starts6, ends6, -1, -1);
		Cjk = new CodePointIndexer(starts7, ends7, -1, -1);
	}
}
