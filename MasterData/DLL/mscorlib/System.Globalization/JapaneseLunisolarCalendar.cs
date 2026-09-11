namespace System.Globalization;

[Serializable]
public class JapaneseLunisolarCalendar : EastAsianLunisolarCalendar
{
	internal GregorianCalendarHelper helper;

	internal static DateTime minDate = new DateTime(1960, 1, 28);

	internal static DateTime maxDate = new DateTime(new DateTime(2050, 1, 22, 23, 59, 59, 999).Ticks + 9999);

	private static readonly int[,] yinfo = new int[90, 4]
	{
		{ 1680159088, 672858221, 689635394, 706412610 },
		{ 723189826, 1528496194, 7156017, 808540955 },
		{ 109, 0, 738274304, 738405378 },
		{ 738536452, 738667526, 738798600, 738929674 },
		{ 739060748, 739191822, 739322896, 739453970 },
		{ 739585044, 739716118, 739847192, 739978266 },
		{ 740109340, 740240414, 740371488, 740502562 },
		{ 740633636, 740764710, 740895784, 741026858 },
		{ 741157932, 744434734, 744500320, 744696930 },
		{ 37366884, 744948286, 745090151, 745221225 },
		{ 745352299, 745483374, 745614448, 745679986 },
		{ 745876596, 746007669, 746138744, 746269818 },
		{ 746400892, 746531966, 746597504, 746728578 },
		{ 746859652, 746990726, 747121800, 747252874 },
		{ 747383948, 747515022, 747646096, 747777170 },
		{ 747908244, 748039318, 748170392, 748301466 },
		{ 748432540, 748563614, 748694688, 748825762 },
		{ 748956836, 749087910, 749218984, 749350058 },
		{ 749481132, 749612206, 749743280, 749874354 },
		{ 750005428, 750136502, 750267576, 750398650 },
		{ 750529724, 750660798, 750791872, 750922946 },
		{ 751054020, 751185094, 751316168, 751447242 },
		{ 751578316, 751709390, 751840464, 751971538 },
		{ 752102612, 752233686, 752364760, 752495834 },
		{ 752626908, 752757982, 752889056, 753020130 },
		{ -1548937006, 1080595114, -1202590843, -1072675554 },
		{ -688789059, 1066824020, 560013664, 560144738 },
		{ 560275812, 560406886, 560537960, 560669034 },
		{ 560800108, 560931182, 562110848, 562241922 },
		{ 8579, 0, 7238995, 7237453 },
		{ 6649172, 6579543, 7694420, 6910534 },
		{ 7627091, 0, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, 50462976, 117835012 },
		{ -63224, -1, 202050303, -15790579 },
		{ -1, -1, -1, -1 },
		{ -1, -1, 202050303, -15790579 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, -1, -1 },
		{ -1, -1, 4063292, 2555938 },
		{ 38, 0, 12544, 19968 },
		{ 63744, 0, 100925953, 235670024 },
		{ 353571087, 471537943, 0, 0 },
		{ 0, 8, 32528, 27296 },
		{ 32720, 27264, 32512, 27136 },
		{ 31744, 26624, 28672, 24576 },
		{ 16384, 32768, 65536, 0 },
		{ 262144, 0, 2, 3 },
		{ 5, 7, 11, 13 },
		{ 17, 19, 23, 29 },
		{ 31, 37, 41, 43 },
		{ 47, 53, 59, 61 },
		{ 67, 71, 73, 79 },
		{ 83, 89, 97, 101 },
		{ 103, 107, 109, 113 },
		{ 127, 131, 137, 139 },
		{ 149, 151, 157, 163 },
		{ 167, 173, 179, 181 },
		{ 191, 193, 197, 199 },
		{ 211, 223, 227, 229 },
		{ 233, 239, 241, 251 },
		{ 257, 263, 269, 271 },
		{ 277, 281, 283, 293 },
		{ 307, 311, 313, 317 },
		{ 331, 337, 347, 349 },
		{ 353, 359, 367, 373 },
		{ 379, 383, 389, 397 },
		{ 401, 409, 419, 421 },
		{ 431, 433, 439, 443 },
		{ 449, 457, 461, 463 },
		{ 467, 479, 487, 491 },
		{ 499, 503, 509, 521 },
		{ 523, 541, 547, 557 },
		{ 563, 569, 571, 577 },
		{ 587, 593, 599, 601 },
		{ 607, 613, 617, 619 },
		{ 631, 641, 643, 647 },
		{ 653, 659, 661, 673 },
		{ 677, 683, 691, 701 },
		{ 709, 719, 727, 733 },
		{ 739, 743, 751, 757 },
		{ 761, 769, 773, 787 }
	};

	public override DateTime MinSupportedDateTime => minDate;

	public override DateTime MaxSupportedDateTime => maxDate;

	internal override int MinCalendarYear => 1960;

	internal override int MaxCalendarYear => 2049;

	internal override DateTime MinDate => minDate;

	internal override DateTime MaxDate => maxDate;

	internal override EraInfo[] CalEraInfo => JapaneseCalendar.GetEraInfo();

	internal override int BaseCalendarID => 3;

	internal override int ID => 14;

	public override int[] Eras => helper.Eras;

	internal override int GetYearInfo(int LunarYear, int Index)
	{
		if (LunarYear < 1960 || LunarYear > 2049)
		{
			throw new ArgumentOutOfRangeException("year", string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Valid values are between {0} and {1}, inclusive."), 1960, 2049));
		}
		return yinfo[LunarYear - 1960, Index];
	}

	internal override int GetYear(int year, DateTime time)
	{
		return helper.GetYear(year, time);
	}

	internal override int GetGregorianYear(int year, int era)
	{
		return helper.GetGregorianYear(year, era);
	}

	private static EraInfo[] TrimEras(EraInfo[] baseEras)
	{
		EraInfo[] array = new EraInfo[baseEras.Length];
		int num = 0;
		for (int i = 0; i < baseEras.Length; i++)
		{
			if (baseEras[i].yearOffset + baseEras[i].minEraYear < 2049)
			{
				if (baseEras[i].yearOffset + baseEras[i].maxEraYear < 1960)
				{
					break;
				}
				array[num] = baseEras[i];
				num++;
			}
		}
		if (num == 0)
		{
			return baseEras;
		}
		Array.Resize(ref array, num);
		return array;
	}

	public JapaneseLunisolarCalendar()
	{
		helper = new GregorianCalendarHelper(this, TrimEras(JapaneseCalendar.GetEraInfo()));
	}

	public override int GetEra(DateTime time)
	{
		return helper.GetEra(time);
	}
}
