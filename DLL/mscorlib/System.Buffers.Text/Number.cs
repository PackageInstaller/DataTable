using System.Runtime.CompilerServices;

namespace System.Buffers.Text;

internal static class Number
{
	private static readonly ulong[] s_rgval64Power10 = new ulong[30]
	{
		11529215046068469760uL, 14411518807585587200uL, 18014398509481984000uL, 11258999068426240000uL, 14073748835532800000uL, 17592186044416000000uL, 10995116277760000000uL, 13743895347200000000uL, 17179869184000000000uL, 10737418240000000000uL,
		13421772800000000000uL, 16777216000000000000uL, 10485760000000000000uL, 13107200000000000000uL, 16384000000000000000uL, 14757395258967641293uL, 11805916207174113035uL, 9444732965739290428uL, 15111572745182864686uL, 12089258196146291749uL,
		9671406556917033399uL, 15474250491067253438uL, 12379400392853802751uL, 9903520314283042201uL, 15845632502852867522uL, 12676506002282294018uL, 10141204801825835215uL, 16225927682921336344uL, 12980742146337069075uL, 10384593717069655260uL
	};

	private static readonly sbyte[] s_rgexp64Power10 = new sbyte[15]
	{
		4, 7, 10, 14, 17, 20, 24, 27, 30, 34,
		37, 40, 44, 47, 50
	};

	private static readonly ulong[] s_rgval64Power10By16 = new ulong[42]
	{
		10240000000000000000uL, 11368683772161602974uL, 12621774483536188886uL, 14012984643248170708uL, 15557538194652854266uL, 17272337110188889248uL, 9588073174409622172uL, 10644899600020376798uL, 11818212630765741798uL, 13120851772591970216uL,
		14567071740625403792uL, 16172698447808779622uL, 17955302187076837696uL, 9967194951097567532uL, 11065809325636130658uL, 12285516299433008778uL, 13639663065038175358uL, 15143067982934716296uL, 16812182738118149112uL, 9332636185032188787uL,
		10361307573072618722uL, 16615349947311448416uL, 14965776766268445891uL, 13479973333575319909uL, 12141680576410806707uL, 10936253623915059637uL, 9850501549098619819uL, 17745086042373215136uL, 15983352577617880260uL, 14396524142538228461uL,
		12967236152753103031uL, 11679847981112819795uL, 10520271803096747049uL, 9475818434452569218uL, 17070116948172427008uL, 15375394465392026135uL, 13848924157002783096uL, 12474001934591998882uL, 11235582092889474480uL, 10120112665365530972uL,
		18230774251475056952uL, 16420821625123739930uL
	};

	private static readonly short[] s_rgexp64Power10By16 = new short[21]
	{
		54, 107, 160, 213, 266, 319, 373, 426, 479, 532,
		585, 638, 691, 745, 798, 851, 904, 957, 1010, 1064,
		1117
	};

	public static void DecimalToNumber(decimal value, ref NumberBuffer number)
	{
		ref MutableDecimal reference = ref Unsafe.As<decimal, MutableDecimal>(ref value);
		Span<byte> digits = number.Digits;
		number.IsNegative = reference.IsNegative;
		int num = 29;
		while ((reference.Mid != 0) | (reference.High != 0))
		{
			uint num2 = DecimalDecCalc.DecDivMod1E9(ref reference);
			for (int i = 0; i < 9; i++)
			{
				digits[--num] = (byte)(num2 % 10 + 48);
				num2 /= 10;
			}
		}
		for (uint num3 = reference.Low; num3 != 0; num3 /= 10)
		{
			digits[--num] = (byte)(num3 % 10 + 48);
		}
		int num4 = 29 - num;
		number.Scale = num4 - reference.Scale;
		Span<byte> digits2 = number.Digits;
		int index = 0;
		while (--num4 >= 0)
		{
			digits2[index++] = digits[num++];
		}
		digits2[index] = 0;
	}

	public static void RoundNumber(ref NumberBuffer number, int pos)
	{
		Span<byte> digits = number.Digits;
		int i;
		for (i = 0; i < pos && digits[i] != 0; i++)
		{
		}
		if (i == pos && digits[i] >= 53)
		{
			while (i > 0 && digits[i - 1] == 57)
			{
				i--;
			}
			if (i > 0)
			{
				digits[i - 1]++;
			}
			else
			{
				number.Scale++;
				digits[0] = 49;
				i = 1;
			}
		}
		else
		{
			while (i > 0 && digits[i - 1] == 48)
			{
				i--;
			}
		}
		if (i == 0)
		{
			number.Scale = 0;
			number.IsNegative = false;
		}
		digits[i] = 0;
	}
}
