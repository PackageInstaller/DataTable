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
			-996976700, -1487539545, 2130477694, 1031423805, 1690872932, 1572530013, 422718233, 1944491379, 1623236704, -2129028991,
			1335808335
		};
		int[] ends = new int[11]
		{
			13697105, 786629, 30081036, 30146574, 5308497, 5308877, 5308497, 4981198, 4980812, 4980812,
			4980812
		};
		int[] starts2 = new int[9] { 5308869, 29753425, 29818961, 5308497, 29950408, 4980812, 786444, 917962, 5308430 };
		int[] ends2 = new int[9] { 1610612736, 1358954496, 2130706432, -1459617792, 419430400, -1258291200, 1241513984, 218103808, 754974720 };
		int[] starts3 = new int[30]
		{
			30474291, 30539827, 30605363, 4981204, 4980812, 30736435, 30801971, 30867507, 4980812, 4980812,
			3342387, 30933043, 31064537, 30999001, 31195611, 31260723, 31392222, 31457331, 31522867, 4980812,
			3342818, 31719907, 3342387, 31785011, 31850547, 31916083, 31981619, 4981225, 4980812, 4980812
		};
		int[] ends3 = new int[30]
		{
			5881, 5897, 5903, 5923, 5927, 5939, 5953, 5981, 5987, 0,
			20, 25, 20, 25, 20, 20, 20, 20, 20, 20,
			20, 9, 31, 20, 31, 20, 9, 20, 6, 1
		};
		int[] starts4 = new int[3] { 13824, 16128, 63232 };
		int[] ends4 = new int[3] { 1054715397, -431143235, 1418835341 };
		int[] starts5 = new int[9] { 7143424, 9109504, 13697024, 2424832, 7471104, 16252928, 16121856, 6553600, 8781824 };
		int[] ends5 = new int[9] { 12779520, 5111808, 524288, 3014656, 10551296, 6684672, 2621440, 14221312, 2359296 };
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
