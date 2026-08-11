using System;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using System.Runtime.InteropServices;

namespace Mono.Globalization.Unicode;

internal class MSCompatUnicodeTable
{
	public static int MaxExpansionLength;

	private unsafe static readonly byte* ignorableFlags;

	private unsafe static readonly byte* categories;

	private unsafe static readonly byte* level1;

	private unsafe static readonly byte* level2;

	private unsafe static readonly byte* level3;

	private unsafe static byte* cjkCHScategory;

	private unsafe static byte* cjkCHTcategory;

	private unsafe static byte* cjkJAcategory;

	private unsafe static byte* cjkKOcategory;

	private unsafe static byte* cjkCHSlv1;

	private unsafe static byte* cjkCHTlv1;

	private unsafe static byte* cjkJAlv1;

	private unsafe static byte* cjkKOlv1;

	private unsafe static byte* cjkKOlv2;

	private static readonly char[] tailoringArr;

	private static readonly TailoringInfo[] tailoringInfos;

	private static object forLock;

	public static readonly bool isReady;

	public static bool IsReady => isReady;

	public static TailoringInfo GetTailoringInfo(int lcid)
	{
		for (int i = 0; i < tailoringInfos.Length; i++)
		{
			if (tailoringInfos[i].LCID == lcid)
			{
				return tailoringInfos[i];
			}
		}
		return null;
	}

	public unsafe static void BuildTailoringTables(CultureInfo culture, TailoringInfo t, ref Contraction[] contractions, ref Level2Map[] diacriticals)
	{
		List<Contraction> list = new List<Contraction>();
		List<Level2Map> list2 = new List<Level2Map>();
		int num = 0;
		fixed (char* ptr = tailoringArr)
		{
			int num2 = t.TailoringIndex;
			int num3 = num2 + t.TailoringCount;
			while (num2 < num3)
			{
				int i = num2 + 1;
				char[] array = null;
				switch (ptr[num2])
				{
				case '\u0001':
				{
					num2++;
					for (; ptr[i] != 0; i++)
					{
					}
					array = new char[i - num2];
					Marshal.Copy((IntPtr)(ptr + num2), array, 0, i - num2);
					byte[] array2 = new byte[4];
					for (int k = 0; k < 4; k++)
					{
						array2[k] = (byte)ptr[i + 1 + k];
					}
					list.Add(new Contraction(num, array, null, array2));
					num2 = i + 6;
					num++;
					break;
				}
				case '\u0002':
					list2.Add(new Level2Map((byte)ptr[num2 + 1], (byte)ptr[num2 + 2]));
					num2 += 3;
					break;
				case '\u0003':
				{
					num2++;
					for (; ptr[i] != 0; i++)
					{
					}
					array = new char[i - num2];
					Marshal.Copy((IntPtr)(ptr + num2), array, 0, i - num2);
					i++;
					int j;
					for (j = i; ptr[j] != 0; j++)
					{
					}
					string replacement = new string(ptr, i, j - i);
					list.Add(new Contraction(num, array, replacement, null));
					num2 = j + 1;
					num++;
					break;
				}
				default:
					throw new NotImplementedException($"Mono INTERNAL ERROR (Should not happen): Collation tailoring table is broken for culture {culture.LCID} ({culture.Name}) at 0x{num2:X}");
				}
			}
		}
		list.Sort(ContractionComparer.Instance);
		list2.Sort((Level2Map a, Level2Map b) => a.Source - b.Source);
		contractions = list.ToArray();
		diacriticals = list2.ToArray();
	}

	private unsafe static void SetCJKReferences(string name, ref CodePointIndexer cjkIndexer, ref byte* catTable, ref byte* lv1Table, ref CodePointIndexer lv2Indexer, ref byte* lv2Table)
	{
		switch (name)
		{
		case "zh-CHS":
			catTable = cjkCHScategory;
			lv1Table = cjkCHSlv1;
			cjkIndexer = MSCompatUnicodeTableUtil.CjkCHS;
			break;
		case "zh-CHT":
			catTable = cjkCHTcategory;
			lv1Table = cjkCHTlv1;
			cjkIndexer = MSCompatUnicodeTableUtil.Cjk;
			break;
		case "ja":
			catTable = cjkJAcategory;
			lv1Table = cjkJAlv1;
			cjkIndexer = MSCompatUnicodeTableUtil.Cjk;
			break;
		case "ko":
			catTable = cjkKOcategory;
			lv1Table = cjkKOlv1;
			lv2Table = cjkKOlv2;
			cjkIndexer = MSCompatUnicodeTableUtil.Cjk;
			lv2Indexer = MSCompatUnicodeTableUtil.Cjk;
			break;
		}
	}

	public unsafe static byte Category(int cp)
	{
		return categories[MSCompatUnicodeTableUtil.Category.ToIndex(cp)];
	}

	public unsafe static byte Level1(int cp)
	{
		return level1[MSCompatUnicodeTableUtil.Level1.ToIndex(cp)];
	}

	public unsafe static byte Level2(int cp)
	{
		return level2[MSCompatUnicodeTableUtil.Level2.ToIndex(cp)];
	}

	public unsafe static byte Level3(int cp)
	{
		return level3[MSCompatUnicodeTableUtil.Level3.ToIndex(cp)];
	}

	public unsafe static bool IsIgnorable(int cp, byte flag)
	{
		if (cp == 0)
		{
			return true;
		}
		if ((flag & 1) != 0)
		{
			if (char.GetUnicodeCategory((char)cp) == UnicodeCategory.OtherNotAssigned)
			{
				return true;
			}
			if (55424 <= cp && cp < 56192)
			{
				return true;
			}
		}
		int num = MSCompatUnicodeTableUtil.Ignorable.ToIndex(cp);
		if (num >= 0)
		{
			return (ignorableFlags[num] & flag) != 0;
		}
		return false;
	}

	public static bool IsIgnorableNonSpacing(int cp)
	{
		return IsIgnorable(cp, 4);
	}

	public static int ToKanaTypeInsensitive(int i)
	{
		if (12353 > i || i > 12436)
		{
			return i;
		}
		return i + 96;
	}

	public static int ToWidthCompat(int i)
	{
		if (i < 8592)
		{
			return i;
		}
		switch (i)
		{
		case 65281:
		case 65282:
		case 65283:
		case 65284:
		case 65285:
		case 65286:
		case 65287:
		case 65288:
		case 65289:
		case 65290:
		case 65291:
		case 65292:
		case 65293:
		case 65294:
		case 65295:
		case 65296:
		case 65297:
		case 65298:
		case 65299:
		case 65300:
		case 65301:
		case 65302:
		case 65303:
		case 65304:
		case 65305:
		case 65306:
		case 65307:
		case 65308:
		case 65309:
		case 65310:
		case 65311:
		case 65312:
		case 65313:
		case 65314:
		case 65315:
		case 65316:
		case 65317:
		case 65318:
		case 65319:
		case 65320:
		case 65321:
		case 65322:
		case 65323:
		case 65324:
		case 65325:
		case 65326:
		case 65327:
		case 65328:
		case 65329:
		case 65330:
		case 65331:
		case 65332:
		case 65333:
		case 65334:
		case 65335:
		case 65336:
		case 65337:
		case 65338:
		case 65339:
		case 65340:
		case 65341:
		case 65342:
		case 65343:
		case 65344:
		case 65345:
		case 65346:
		case 65347:
		case 65348:
		case 65349:
		case 65350:
		case 65351:
		case 65352:
		case 65353:
		case 65354:
		case 65355:
		case 65356:
		case 65357:
		case 65358:
		case 65359:
		case 65360:
		case 65361:
		case 65362:
		case 65363:
		case 65364:
		case 65365:
		case 65366:
		case 65367:
		case 65368:
		case 65369:
		case 65370:
		case 65371:
		case 65372:
		case 65373:
		case 65374:
			return i - 65280 + 32;
		case 65504:
			return 162;
		case 65505:
			return 163;
		case 65506:
			return 172;
		case 65507:
			return 175;
		case 65508:
			return 166;
		case 65509:
			return 165;
		case 65510:
			return 8361;
		default:
			if (i > 13054)
			{
				return i;
			}
			if (i <= 8595)
			{
				return 56921 + i;
			}
			if (i < 9474)
			{
				return i;
			}
			if (i <= 9675)
			{
				return i switch
				{
					9474 => 65512, 
					9632 => 65517, 
					9675 => 65518, 
					_ => i, 
				};
			}
			if (i < 12288)
			{
				return i;
			}
			if (i < 12593)
			{
				return i switch
				{
					12288 => 32, 
					12289 => 65380, 
					12290 => 65377, 
					12300 => 65378, 
					12301 => 65379, 
					12539 => 65381, 
					_ => i, 
				};
			}
			if (i < 12644)
			{
				return i - 12592 + 65440;
			}
			if (i == 12644)
			{
				return 65440;
			}
			return i;
		}
	}

	public static bool HasSpecialWeight(char c)
	{
		if (c < 'ぁ')
		{
			return false;
		}
		if ('ｦ' <= c && c < 'ﾞ')
		{
			return true;
		}
		if ('㌀' <= c)
		{
			return false;
		}
		if (c < 'ゝ')
		{
			return c < '\u3099';
		}
		if (c < '\u3100')
		{
			return c != '・';
		}
		if (c < '㋐')
		{
			return false;
		}
		if (c < '㋿')
		{
			return true;
		}
		return false;
	}

	public static bool IsHalfWidthKana(char c)
	{
		if ('ｦ' <= c)
		{
			return c <= 'ﾝ';
		}
		return false;
	}

	public static bool IsHiragana(char c)
	{
		if ('ぁ' <= c)
		{
			return c <= 'ゔ';
		}
		return false;
	}

	public static bool IsJapaneseSmallLetter(char c)
	{
		if ('ｧ' <= c && c <= 'ｯ')
		{
			return true;
		}
		if ('\u3040' < c)
		{
			switch (c)
			{
			case 'ぁ':
			case 'ぃ':
			case 'ぅ':
			case 'ぇ':
			case 'ぉ':
			case 'っ':
			case 'ゃ':
			case 'ゅ':
			case 'ょ':
			case 'ゎ':
			case 'ァ':
			case 'ィ':
			case 'ゥ':
			case 'ェ':
			case 'ォ':
			case 'ッ':
			case 'ャ':
			case 'ュ':
			case 'ョ':
			case 'ヮ':
			case 'ヵ':
			case 'ヶ':
				return true;
			}
		}
		return false;
	}

	private static IntPtr GetResource(string name)
	{
		int size;
		Module module;
		return ((RuntimeAssembly)Assembly.GetExecutingAssembly()).GetManifestResourceInternal(name, out size, out module);
	}

	private unsafe static uint UInt32FromBytePtr(byte* raw, uint idx)
	{
		return (uint)(raw[idx] + (raw[idx + 1] << 8) + (raw[idx + 2] << 16) + (raw[idx + 3] << 24));
	}

	unsafe static MSCompatUnicodeTable()
	{
		MaxExpansionLength = 3;
		forLock = new object();
		uint num = 0u;
		IntPtr resource = GetResource("collation.core.bin");
		if (resource == IntPtr.Zero)
		{
			return;
		}
		byte* ptr = (byte*)(void*)resource;
		resource = GetResource("collation.tailoring.bin");
		if (resource == IntPtr.Zero)
		{
			return;
		}
		byte* ptr2 = (byte*)(void*)resource;
		if (ptr != null && ptr2 != null && *ptr == 3 && *ptr2 == 3)
		{
			num = 1u;
			uint num2 = UInt32FromBytePtr(ptr, num);
			num += 4;
			ignorableFlags = ptr + num;
			num += num2;
			num2 = UInt32FromBytePtr(ptr, num);
			num += 4;
			categories = ptr + num;
			num += num2;
			num2 = UInt32FromBytePtr(ptr, num);
			num += 4;
			level1 = ptr + num;
			num += num2;
			num2 = UInt32FromBytePtr(ptr, num);
			num += 4;
			level2 = ptr + num;
			num += num2;
			num2 = UInt32FromBytePtr(ptr, num);
			num += 4;
			level3 = ptr + num;
			num += num2;
			num = 1u;
			uint num3 = UInt32FromBytePtr(ptr2, num);
			num += 4;
			tailoringInfos = new TailoringInfo[num3];
			for (int i = 0; i < num3; i++)
			{
				uint lcid = UInt32FromBytePtr(ptr2, num);
				num += 4;
				int tailoringIndex = (int)UInt32FromBytePtr(ptr2, num);
				num += 4;
				int tailoringCount = (int)UInt32FromBytePtr(ptr2, num);
				num += 4;
				TailoringInfo tailoringInfo = new TailoringInfo((int)lcid, tailoringIndex, tailoringCount, ptr2[num++] != 0);
				tailoringInfos[i] = tailoringInfo;
			}
			num += 2;
			num3 = UInt32FromBytePtr(ptr2, num);
			num += 4;
			tailoringArr = new char[num3];
			int num4 = 0;
			while (num4 < num3)
			{
				tailoringArr[num4] = (char)(ptr2[num] + (ptr2[num + 1] << 8));
				num4++;
				num += 2;
			}
			isReady = true;
		}
	}

	public unsafe static void FillCJK(string culture, ref CodePointIndexer cjkIndexer, ref byte* catTable, ref byte* lv1Table, ref CodePointIndexer lv2Indexer, ref byte* lv2Table)
	{
		lock (forLock)
		{
			FillCJKCore(culture, ref cjkIndexer, ref catTable, ref lv1Table, ref lv2Indexer, ref lv2Table);
			SetCJKReferences(culture, ref cjkIndexer, ref catTable, ref lv1Table, ref lv2Indexer, ref lv2Table);
		}
	}

	private unsafe static void FillCJKCore(string culture, ref CodePointIndexer cjkIndexer, ref byte* catTable, ref byte* lv1Table, ref CodePointIndexer cjkLv2Indexer, ref byte* lv2Table)
	{
		if (!IsReady)
		{
			return;
		}
		string text = null;
		switch (culture)
		{
		case "zh-CHS":
			text = "cjkCHS";
			catTable = cjkCHScategory;
			lv1Table = cjkCHSlv1;
			break;
		case "zh-CHT":
			text = "cjkCHT";
			catTable = cjkCHTcategory;
			lv1Table = cjkCHTlv1;
			break;
		case "ja":
			text = "cjkJA";
			catTable = cjkJAcategory;
			lv1Table = cjkJAlv1;
			break;
		case "ko":
			text = "cjkKO";
			catTable = cjkKOcategory;
			lv1Table = cjkKOlv1;
			break;
		}
		if (text == null || lv1Table != null)
		{
			return;
		}
		uint num = 0u;
		IntPtr resource = GetResource($"collation.{text}.bin");
		if (resource == IntPtr.Zero)
		{
			return;
		}
		byte* ptr = (byte*)(void*)resource;
		num++;
		uint num2 = UInt32FromBytePtr(ptr, num);
		num += 4;
		catTable = ptr + num;
		lv1Table = ptr + num + num2;
		switch (culture)
		{
		case "zh-CHS":
			cjkCHScategory = catTable;
			cjkCHSlv1 = lv1Table;
			break;
		case "zh-CHT":
			cjkCHTcategory = catTable;
			cjkCHTlv1 = lv1Table;
			break;
		case "ja":
			cjkJAcategory = catTable;
			cjkJAlv1 = lv1Table;
			break;
		case "ko":
			cjkKOcategory = catTable;
			cjkKOlv1 = lv1Table;
			break;
		}
		if (!(text != "cjkKO"))
		{
			resource = GetResource("collation.cjkKOlv2.bin");
			if (!(resource == IntPtr.Zero))
			{
				ptr = (byte*)(void*)resource;
				num = 5u;
				cjkKOlv2 = ptr + num;
				lv2Table = cjkKOlv2;
			}
		}
	}
}
