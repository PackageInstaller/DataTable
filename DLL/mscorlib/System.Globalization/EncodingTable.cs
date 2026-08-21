using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace System.Globalization;

internal static class EncodingTable
{
	internal static InternalEncodingDataItem[] encodingDataPtr;

	internal static InternalCodePageDataItem[] codePageDataPtr;

	private static int lastEncodingItem;

	private static volatile int lastCodePageItem;

	private static Dictionary<string, int> hashByName;

	private static Dictionary<int, CodePageDataItem> hashByCodePage;

	private static int GetNumEncodingItems()
	{
		return encodingDataPtr.Length;
	}

	private static InternalEncodingDataItem ENC(string name, ushort cp)
	{
		return new InternalEncodingDataItem
		{
			webName = name,
			codePage = cp
		};
	}

	private static InternalCodePageDataItem MapCodePageDataItem(ushort cp, ushort fcp, string names, uint flags)
	{
		return new InternalCodePageDataItem
		{
			codePage = cp,
			uiFamilyCodePage = fcp,
			flags = flags,
			Names = names
		};
	}

	static EncodingTable()
	{
		encodingDataPtr = new InternalEncodingDataItem[405]
		{
			ENC("437", 437),
			ENC("ANSI_X3.4-1968", 20127),
			ENC("ANSI_X3.4-1986", 20127),
			ENC("arabic", 28596),
			ENC("ascii", 20127),
			ENC("ASMO-708", 708),
			ENC("Big5", 950),
			ENC("Big5-HKSCS", 950),
			ENC("CCSID00858", 858),
			ENC("CCSID00924", 20924),
			ENC("CCSID01140", 1140),
			ENC("CCSID01141", 1141),
			ENC("CCSID01142", 1142),
			ENC("CCSID01143", 1143),
			ENC("CCSID01144", 1144),
			ENC("CCSID01145", 1145),
			ENC("CCSID01146", 1146),
			ENC("CCSID01147", 1147),
			ENC("CCSID01148", 1148),
			ENC("CCSID01149", 1149),
			ENC("chinese", 936),
			ENC("cn-big5", 950),
			ENC("CN-GB", 936),
			ENC("CP00858", 858),
			ENC("CP00924", 20924),
			ENC("CP01140", 1140),
			ENC("CP01141", 1141),
			ENC("CP01142", 1142),
			ENC("CP01143", 1143),
			ENC("CP01144", 1144),
			ENC("CP01145", 1145),
			ENC("CP01146", 1146),
			ENC("CP01147", 1147),
			ENC("CP01148", 1148),
			ENC("CP01149", 1149),
			ENC("cp037", 37),
			ENC("cp1025", 21025),
			ENC("CP1026", 1026),
			ENC("cp1256", 1256),
			ENC("CP273", 20273),
			ENC("CP278", 20278),
			ENC("CP280", 20280),
			ENC("CP284", 20284),
			ENC("CP285", 20285),
			ENC("cp290", 20290),
			ENC("cp297", 20297),
			ENC("cp367", 20127),
			ENC("cp420", 20420),
			ENC("cp423", 20423),
			ENC("cp424", 20424),
			ENC("cp437", 437),
			ENC("CP500", 500),
			ENC("cp50227", 50227),
			ENC("cp819", 28591),
			ENC("cp850", 850),
			ENC("cp852", 852),
			ENC("cp855", 855),
			ENC("cp857", 857),
			ENC("cp858", 858),
			ENC("cp860", 860),
			ENC("cp861", 861),
			ENC("cp862", 862),
			ENC("cp863", 863),
			ENC("cp864", 864),
			ENC("cp865", 865),
			ENC("cp866", 866),
			ENC("cp869", 869),
			ENC("CP870", 870),
			ENC("CP871", 20871),
			ENC("cp875", 875),
			ENC("cp880", 20880),
			ENC("CP905", 20905),
			ENC("csASCII", 20127),
			ENC("csbig5", 950),
			ENC("csEUCKR", 51949),
			ENC("csEUCPkdFmtJapanese", 51932),
			ENC("csGB2312", 936),
			ENC("csGB231280", 936),
			ENC("csIBM037", 37),
			ENC("csIBM1026", 1026),
			ENC("csIBM273", 20273),
			ENC("csIBM277", 20277),
			ENC("csIBM278", 20278),
			ENC("csIBM280", 20280),
			ENC("csIBM284", 20284),
			ENC("csIBM285", 20285),
			ENC("csIBM290", 20290),
			ENC("csIBM297", 20297),
			ENC("csIBM420", 20420),
			ENC("csIBM423", 20423),
			ENC("csIBM424", 20424),
			ENC("csIBM500", 500),
			ENC("csIBM870", 870),
			ENC("csIBM871", 20871),
			ENC("csIBM880", 20880),
			ENC("csIBM905", 20905),
			ENC("csIBMThai", 20838),
			ENC("csISO2022JP", 50221),
			ENC("csISO2022KR", 50225),
			ENC("csISO58GB231280", 936),
			ENC("csISOLatin1", 28591),
			ENC("csISOLatin2", 28592),
			ENC("csISOLatin3", 28593),
			ENC("csISOLatin4", 28594),
			ENC("csISOLatin5", 28599),
			ENC("csISOLatin9", 28605),
			ENC("csISOLatinArabic", 28596),
			ENC("csISOLatinCyrillic", 28595),
			ENC("csISOLatinGreek", 28597),
			ENC("csISOLatinHebrew", 28598),
			ENC("csKOI8R", 20866),
			ENC("csKSC56011987", 949),
			ENC("csPC8CodePage437", 437),
			ENC("csShiftJIS", 932),
			ENC("csUnicode11UTF7", 65000),
			ENC("csWindows31J", 932),
			ENC("cyrillic", 28595),
			ENC("DIN_66003", 20106),
			ENC("DOS-720", 720),
			ENC("DOS-862", 862),
			ENC("DOS-874", 874),
			ENC("ebcdic-cp-ar1", 20420),
			ENC("ebcdic-cp-be", 500),
			ENC("ebcdic-cp-ca", 37),
			ENC("ebcdic-cp-ch", 500),
			ENC("EBCDIC-CP-DK", 20277),
			ENC("ebcdic-cp-es", 20284),
			ENC("ebcdic-cp-fi", 20278),
			ENC("ebcdic-cp-fr", 20297),
			ENC("ebcdic-cp-gb", 20285),
			ENC("ebcdic-cp-gr", 20423),
			ENC("ebcdic-cp-he", 20424),
			ENC("ebcdic-cp-is", 20871),
			ENC("ebcdic-cp-it", 20280),
			ENC("ebcdic-cp-nl", 37),
			ENC("EBCDIC-CP-NO", 20277),
			ENC("ebcdic-cp-roece", 870),
			ENC("ebcdic-cp-se", 20278),
			ENC("ebcdic-cp-tr", 20905),
			ENC("ebcdic-cp-us", 37),
			ENC("ebcdic-cp-wt", 37),
			ENC("ebcdic-cp-yu", 870),
			ENC("EBCDIC-Cyrillic", 20880),
			ENC("ebcdic-de-273+euro", 1141),
			ENC("ebcdic-dk-277+euro", 1142),
			ENC("ebcdic-es-284+euro", 1145),
			ENC("ebcdic-fi-278+euro", 1143),
			ENC("ebcdic-fr-297+euro", 1147),
			ENC("ebcdic-gb-285+euro", 1146),
			ENC("ebcdic-international-500+euro", 1148),
			ENC("ebcdic-is-871+euro", 1149),
			ENC("ebcdic-it-280+euro", 1144),
			ENC("EBCDIC-JP-kana", 20290),
			ENC("ebcdic-Latin9--euro", 20924),
			ENC("ebcdic-no-277+euro", 1142),
			ENC("ebcdic-se-278+euro", 1143),
			ENC("ebcdic-us-37+euro", 1140),
			ENC("ECMA-114", 28596),
			ENC("ECMA-118", 28597),
			ENC("ELOT_928", 28597),
			ENC("euc-cn", 51936),
			ENC("euc-jp", 51932),
			ENC("euc-kr", 51949),
			ENC("Extended_UNIX_Code_Packed_Format_for_Japanese", 51932),
			ENC("GB18030", 54936),
			ENC("GB2312", 936),
			ENC("GB2312-80", 936),
			ENC("GB231280", 936),
			ENC("GBK", 936),
			ENC("GB_2312-80", 936),
			ENC("German", 20106),
			ENC("greek", 28597),
			ENC("greek8", 28597),
			ENC("hebrew", 28598),
			ENC("hz-gb-2312", 52936),
			ENC("IBM-Thai", 20838),
			ENC("IBM00858", 858),
			ENC("IBM00924", 20924),
			ENC("IBM01047", 1047),
			ENC("IBM01140", 1140),
			ENC("IBM01141", 1141),
			ENC("IBM01142", 1142),
			ENC("IBM01143", 1143),
			ENC("IBM01144", 1144),
			ENC("IBM01145", 1145),
			ENC("IBM01146", 1146),
			ENC("IBM01147", 1147),
			ENC("IBM01148", 1148),
			ENC("IBM01149", 1149),
			ENC("IBM037", 37),
			ENC("IBM1026", 1026),
			ENC("IBM273", 20273),
			ENC("IBM277", 20277),
			ENC("IBM278", 20278),
			ENC("IBM280", 20280),
			ENC("IBM284", 20284),
			ENC("IBM285", 20285),
			ENC("IBM290", 20290),
			ENC("IBM297", 20297),
			ENC("IBM367", 20127),
			ENC("IBM420", 20420),
			ENC("IBM423", 20423),
			ENC("IBM424", 20424),
			ENC("IBM437", 437),
			ENC("IBM500", 500),
			ENC("ibm737", 737),
			ENC("ibm775", 775),
			ENC("ibm819", 28591),
			ENC("IBM850", 850),
			ENC("IBM852", 852),
			ENC("IBM855", 855),
			ENC("IBM857", 857),
			ENC("IBM860", 860),
			ENC("IBM861", 861),
			ENC("IBM862", 862),
			ENC("IBM863", 863),
			ENC("IBM864", 864),
			ENC("IBM865", 865),
			ENC("IBM866", 866),
			ENC("IBM869", 869),
			ENC("IBM870", 870),
			ENC("IBM871", 20871),
			ENC("IBM880", 20880),
			ENC("IBM905", 20905),
			ENC("irv", 20105),
			ENC("ISO-10646-UCS-2", 1200),
			ENC("iso-2022-jp", 50220),
			ENC("iso-2022-jpeuc", 51932),
			ENC("iso-2022-kr", 50225),
			ENC("iso-2022-kr-7", 50225),
			ENC("iso-2022-kr-7bit", 50225),
			ENC("iso-2022-kr-8", 51949),
			ENC("iso-2022-kr-8bit", 51949),
			ENC("iso-8859-1", 28591),
			ENC("iso-8859-11", 874),
			ENC("iso-8859-13", 28603),
			ENC("iso-8859-15", 28605),
			ENC("iso-8859-2", 28592),
			ENC("iso-8859-3", 28593),
			ENC("iso-8859-4", 28594),
			ENC("iso-8859-5", 28595),
			ENC("iso-8859-6", 28596),
			ENC("iso-8859-7", 28597),
			ENC("iso-8859-8", 28598),
			ENC("ISO-8859-8 Visual", 28598),
			ENC("iso-8859-8-i", 38598),
			ENC("iso-8859-9", 28599),
			ENC("iso-ir-100", 28591),
			ENC("iso-ir-101", 28592),
			ENC("iso-ir-109", 28593),
			ENC("iso-ir-110", 28594),
			ENC("iso-ir-126", 28597),
			ENC("iso-ir-127", 28596),
			ENC("iso-ir-138", 28598),
			ENC("iso-ir-144", 28595),
			ENC("iso-ir-148", 28599),
			ENC("iso-ir-149", 949),
			ENC("iso-ir-58", 936),
			ENC("iso-ir-6", 20127),
			ENC("ISO646-US", 20127),
			ENC("iso8859-1", 28591),
			ENC("iso8859-2", 28592),
			ENC("ISO_646.irv:1991", 20127),
			ENC("iso_8859-1", 28591),
			ENC("ISO_8859-15", 28605),
			ENC("iso_8859-1:1987", 28591),
			ENC("iso_8859-2", 28592),
			ENC("iso_8859-2:1987", 28592),
			ENC("ISO_8859-3", 28593),
			ENC("ISO_8859-3:1988", 28593),
			ENC("ISO_8859-4", 28594),
			ENC("ISO_8859-4:1988", 28594),
			ENC("ISO_8859-5", 28595),
			ENC("ISO_8859-5:1988", 28595),
			ENC("ISO_8859-6", 28596),
			ENC("ISO_8859-6:1987", 28596),
			ENC("ISO_8859-7", 28597),
			ENC("ISO_8859-7:1987", 28597),
			ENC("ISO_8859-8", 28598),
			ENC("ISO_8859-8:1988", 28598),
			ENC("ISO_8859-9", 28599),
			ENC("ISO_8859-9:1989", 28599),
			ENC("Johab", 1361),
			ENC("koi", 20866),
			ENC("koi8", 20866),
			ENC("koi8-r", 20866),
			ENC("koi8-ru", 21866),
			ENC("koi8-u", 21866),
			ENC("koi8r", 20866),
			ENC("korean", 949),
			ENC("ks-c-5601", 949),
			ENC("ks-c5601", 949),
			ENC("KSC5601", 949),
			ENC("KSC_5601", 949),
			ENC("ks_c_5601", 949),
			ENC("ks_c_5601-1987", 949),
			ENC("ks_c_5601-1989", 949),
			ENC("ks_c_5601_1987", 949),
			ENC("l1", 28591),
			ENC("l2", 28592),
			ENC("l3", 28593),
			ENC("l4", 28594),
			ENC("l5", 28599),
			ENC("l9", 28605),
			ENC("latin1", 28591),
			ENC("latin2", 28592),
			ENC("latin3", 28593),
			ENC("latin4", 28594),
			ENC("latin5", 28599),
			ENC("latin9", 28605),
			ENC("logical", 28598),
			ENC("macintosh", 10000),
			ENC("ms_Kanji", 932),
			ENC("Norwegian", 20108),
			ENC("NS_4551-1", 20108),
			ENC("PC-Multilingual-850+euro", 858),
			ENC("SEN_850200_B", 20107),
			ENC("shift-jis", 932),
			ENC("shift_jis", 932),
			ENC("sjis", 932),
			ENC("Swedish", 20107),
			ENC("TIS-620", 874),
			ENC("ucs-2", 1200),
			ENC("unicode", 1200),
			ENC("unicode-1-1-utf-7", 65000),
			ENC("unicode-1-1-utf-8", 65001),
			ENC("unicode-2-0-utf-7", 65000),
			ENC("unicode-2-0-utf-8", 65001),
			ENC("unicodeFFFE", 1201),
			ENC("us", 20127),
			ENC("us-ascii", 20127),
			ENC("utf-16", 1200),
			ENC("UTF-16BE", 1201),
			ENC("UTF-16LE", 1200),
			ENC("utf-32", 12000),
			ENC("UTF-32BE", 12001),
			ENC("UTF-32LE", 12000),
			ENC("utf-7", 65000),
			ENC("utf-8", 65001),
			ENC("visual", 28598),
			ENC("windows-1250", 1250),
			ENC("windows-1251", 1251),
			ENC("windows-1252", 1252),
			ENC("windows-1253", 1253),
			ENC("Windows-1254", 1254),
			ENC("windows-1255", 1255),
			ENC("windows-1256", 1256),
			ENC("windows-1257", 1257),
			ENC("windows-1258", 1258),
			ENC("windows-874", 874),
			ENC("x-ansi", 1252),
			ENC("x-Chinese-CNS", 20000),
			ENC("x-Chinese-Eten", 20002),
			ENC("x-cp1250", 1250),
			ENC("x-cp1251", 1251),
			ENC("x-cp20001", 20001),
			ENC("x-cp20003", 20003),
			ENC("x-cp20004", 20004),
			ENC("x-cp20005", 20005),
			ENC("x-cp20261", 20261),
			ENC("x-cp20269", 20269),
			ENC("x-cp20936", 20936),
			ENC("x-cp20949", 20949),
			ENC("x-cp50227", 50227),
			ENC("X-EBCDIC-KoreanExtended", 20833),
			ENC("x-euc", 51932),
			ENC("x-euc-cn", 51936),
			ENC("x-euc-jp", 51932),
			ENC("x-Europa", 29001),
			ENC("x-IA5", 20105),
			ENC("x-IA5-German", 20106),
			ENC("x-IA5-Norwegian", 20108),
			ENC("x-IA5-Swedish", 20107),
			ENC("x-iscii-as", 57006),
			ENC("x-iscii-be", 57003),
			ENC("x-iscii-de", 57002),
			ENC("x-iscii-gu", 57010),
			ENC("x-iscii-ka", 57008),
			ENC("x-iscii-ma", 57009),
			ENC("x-iscii-or", 57007),
			ENC("x-iscii-pa", 57011),
			ENC("x-iscii-ta", 57004),
			ENC("x-iscii-te", 57005),
			ENC("x-mac-arabic", 10004),
			ENC("x-mac-ce", 10029),
			ENC("x-mac-chinesesimp", 10008),
			ENC("x-mac-chinesetrad", 10002),
			ENC("x-mac-croatian", 10082),
			ENC("x-mac-cyrillic", 10007),
			ENC("x-mac-greek", 10006),
			ENC("x-mac-hebrew", 10005),
			ENC("x-mac-icelandic", 10079),
			ENC("x-mac-japanese", 10001),
			ENC("x-mac-korean", 10003),
			ENC("x-mac-romanian", 10010),
			ENC("x-mac-thai", 10021),
			ENC("x-mac-turkish", 10081),
			ENC("x-mac-ukrainian", 10017),
			ENC("x-ms-cp932", 932),
			ENC("x-sjis", 932),
			ENC("x-unicode-1-1-utf-7", 65000),
			ENC("x-unicode-1-1-utf-8", 65001),
			ENC("x-unicode-2-0-utf-7", 65000),
			ENC("x-unicode-2-0-utf-8", 65001),
			ENC("x-x-big5", 950)
		};
		codePageDataPtr = new InternalCodePageDataItem[98]
		{
			MapCodePageDataItem(37, 1252, "IBM037", 0u),
			MapCodePageDataItem(437, 1252, "IBM437", 0u),
			MapCodePageDataItem(500, 1252, "IBM500", 0u),
			MapCodePageDataItem(708, 1256, "ASMO-708", 514u),
			MapCodePageDataItem(737, 1253, "ibm737", 0u),
			MapCodePageDataItem(775, 1257, "ibm775", 0u),
			MapCodePageDataItem(850, 1252, "ibm850", 0u),
			MapCodePageDataItem(852, 1250, "ibm852", 514u),
			MapCodePageDataItem(855, 1252, "IBM855", 0u),
			MapCodePageDataItem(857, 1254, "ibm857", 0u),
			MapCodePageDataItem(858, 1252, "IBM00858", 0u),
			MapCodePageDataItem(860, 1252, "IBM860", 0u),
			MapCodePageDataItem(861, 1252, "ibm861", 0u),
			MapCodePageDataItem(862, 1255, "DOS-862", 514u),
			MapCodePageDataItem(863, 1252, "IBM863", 0u),
			MapCodePageDataItem(864, 1256, "IBM864", 0u),
			MapCodePageDataItem(865, 1252, "IBM865", 0u),
			MapCodePageDataItem(866, 1251, "cp866", 514u),
			MapCodePageDataItem(869, 1253, "ibm869", 0u),
			MapCodePageDataItem(870, 1250, "IBM870", 0u),
			MapCodePageDataItem(874, 874, "windows-874", 771u),
			MapCodePageDataItem(875, 1253, "cp875", 0u),
			MapCodePageDataItem(932, 932, "|shift_jis|iso-2022-jp|iso-2022-jp", 771u),
			MapCodePageDataItem(936, 936, "gb2312", 771u),
			MapCodePageDataItem(949, 949, "ks_c_5601-1987", 771u),
			MapCodePageDataItem(950, 950, "big5", 771u),
			MapCodePageDataItem(1026, 1254, "IBM1026", 0u),
			MapCodePageDataItem(1047, 1252, "IBM01047", 0u),
			MapCodePageDataItem(1140, 1252, "IBM01140", 0u),
			MapCodePageDataItem(1141, 1252, "IBM01141", 0u),
			MapCodePageDataItem(1142, 1252, "IBM01142", 0u),
			MapCodePageDataItem(1143, 1252, "IBM01143", 0u),
			MapCodePageDataItem(1144, 1252, "IBM01144", 0u),
			MapCodePageDataItem(1145, 1252, "IBM01145", 0u),
			MapCodePageDataItem(1146, 1252, "IBM01146", 0u),
			MapCodePageDataItem(1147, 1252, "IBM01147", 0u),
			MapCodePageDataItem(1148, 1252, "IBM01148", 0u),
			MapCodePageDataItem(1149, 1252, "IBM01149", 0u),
			MapCodePageDataItem(1200, 1200, "utf-16", 512u),
			MapCodePageDataItem(1201, 1200, "utf-16BE", 0u),
			MapCodePageDataItem(1250, 1250, "|windows-1250|windows-1250|iso-8859-2", 771u),
			MapCodePageDataItem(1251, 1251, "|windows-1251|windows-1251|koi8-r", 771u),
			MapCodePageDataItem(1252, 1252, "|Windows-1252|Windows-1252|iso-8859-1", 771u),
			MapCodePageDataItem(1253, 1253, "|windows-1253|windows-1253|iso-8859-7", 771u),
			MapCodePageDataItem(1254, 1254, "|windows-1254|windows-1254|iso-8859-9", 771u),
			MapCodePageDataItem(1255, 1255, "windows-1255", 771u),
			MapCodePageDataItem(1256, 1256, "windows-1256", 771u),
			MapCodePageDataItem(1257, 1257, "windows-1257", 771u),
			MapCodePageDataItem(1258, 1258, "windows-1258", 771u),
			MapCodePageDataItem(10000, 1252, "macintosh", 0u),
			MapCodePageDataItem(10079, 1252, "x-mac-icelandic", 0u),
			MapCodePageDataItem(12000, 1200, "utf-32", 0u),
			MapCodePageDataItem(12001, 1200, "utf-32BE", 0u),
			MapCodePageDataItem(20127, 1252, "us-ascii", 257u),
			MapCodePageDataItem(20273, 1252, "IBM273", 0u),
			MapCodePageDataItem(20277, 1252, "IBM277", 0u),
			MapCodePageDataItem(20278, 1252, "IBM278", 0u),
			MapCodePageDataItem(20280, 1252, "IBM280", 0u),
			MapCodePageDataItem(20284, 1252, "IBM284", 0u),
			MapCodePageDataItem(20285, 1252, "IBM285", 0u),
			MapCodePageDataItem(20290, 932, "IBM290", 0u),
			MapCodePageDataItem(20297, 1252, "IBM297", 0u),
			MapCodePageDataItem(20420, 1256, "IBM420", 0u),
			MapCodePageDataItem(20424, 1255, "IBM424", 0u),
			MapCodePageDataItem(20866, 1251, "koi8-r", 771u),
			MapCodePageDataItem(20871, 1252, "IBM871", 0u),
			MapCodePageDataItem(21025, 1251, "cp1025", 0u),
			MapCodePageDataItem(21866, 1251, "koi8-u", 771u),
			MapCodePageDataItem(28591, 1252, "iso-8859-1", 771u),
			MapCodePageDataItem(28592, 1250, "iso-8859-2", 771u),
			MapCodePageDataItem(28593, 1254, "iso-8859-3", 257u),
			MapCodePageDataItem(28594, 1257, "iso-8859-4", 771u),
			MapCodePageDataItem(28595, 1251, "iso-8859-5", 771u),
			MapCodePageDataItem(28596, 1256, "iso-8859-6", 771u),
			MapCodePageDataItem(28597, 1253, "iso-8859-7", 771u),
			MapCodePageDataItem(28598, 1255, "iso-8859-8", 514u),
			MapCodePageDataItem(28599, 1254, "iso-8859-9", 771u),
			MapCodePageDataItem(28605, 1252, "iso-8859-15", 769u),
			MapCodePageDataItem(38598, 1255, "iso-8859-8-i", 771u),
			MapCodePageDataItem(50220, 932, "iso-2022-jp", 257u),
			MapCodePageDataItem(50221, 932, "|csISO2022JP|iso-2022-jp|iso-2022-jp", 769u),
			MapCodePageDataItem(50222, 932, "iso-2022-jp", 0u),
			MapCodePageDataItem(51932, 932, "euc-jp", 771u),
			MapCodePageDataItem(51949, 949, "euc-kr", 257u),
			MapCodePageDataItem(54936, 936, "GB18030", 771u),
			MapCodePageDataItem(57002, 57002, "x-iscii-de", 0u),
			MapCodePageDataItem(57003, 57003, "x-iscii-be", 0u),
			MapCodePageDataItem(57004, 57004, "x-iscii-ta", 0u),
			MapCodePageDataItem(57005, 57005, "x-iscii-te", 0u),
			MapCodePageDataItem(57006, 57006, "x-iscii-as", 0u),
			MapCodePageDataItem(57007, 57007, "x-iscii-or", 0u),
			MapCodePageDataItem(57008, 57008, "x-iscii-ka", 0u),
			MapCodePageDataItem(57009, 57009, "x-iscii-ma", 0u),
			MapCodePageDataItem(57010, 57010, "x-iscii-gu", 0u),
			MapCodePageDataItem(57011, 57011, "x-iscii-pa", 0u),
			MapCodePageDataItem(65000, 1200, "utf-7", 257u),
			MapCodePageDataItem(65001, 1200, "utf-8", 771u),
			MapCodePageDataItem(0, 0, null, 0u)
		};
		lastEncodingItem = GetNumEncodingItems() - 1;
		hashByName = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);
		hashByCodePage = new Dictionary<int, CodePageDataItem>();
	}

	private static int internalGetCodePageFromName(string name)
	{
		int i = 0;
		int num = lastEncodingItem;
		while (num - i > 3)
		{
			int num2 = (num - i) / 2 + i;
			int num3 = string.Compare(name, encodingDataPtr[num2].webName, StringComparison.OrdinalIgnoreCase);
			if (num3 == 0)
			{
				return encodingDataPtr[num2].codePage;
			}
			if (num3 < 0)
			{
				num = num2;
			}
			else
			{
				i = num2;
			}
		}
		for (; i <= num; i++)
		{
			if (string.Compare(name, encodingDataPtr[i].webName, StringComparison.OrdinalIgnoreCase) == 0)
			{
				return encodingDataPtr[i].codePage;
			}
		}
		throw new ArgumentException(string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("'{0}' is not a supported encoding name. For information on defining a custom encoding, see the documentation for the Encoding.RegisterProvider method."), name), "name");
	}

	internal static EncodingInfo[] GetEncodings()
	{
		if (lastCodePageItem == 0)
		{
			int i;
			for (i = 0; codePageDataPtr[i].codePage != 0; i++)
			{
			}
			lastCodePageItem = i;
		}
		EncodingInfo[] array = new EncodingInfo[lastCodePageItem];
		for (int j = 0; j < lastCodePageItem; j++)
		{
			array[j] = new EncodingInfo(codePageDataPtr[j].codePage, CodePageDataItem.CreateString(codePageDataPtr[j].Names, 0u), Environment.GetResourceString("Globalization.cp_" + codePageDataPtr[j].codePage));
		}
		return array;
	}

	internal static int GetCodePageFromName(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		lock (((ICollection)hashByName).SyncRoot)
		{
			if (hashByName.TryGetValue(name, out var value))
			{
				return value;
			}
			value = internalGetCodePageFromName(name);
			hashByName[name] = value;
			return value;
		}
	}

	internal static CodePageDataItem GetCodePageDataItem(int codepage)
	{
		lock (((ICollection)hashByCodePage).SyncRoot)
		{
			if (hashByCodePage.TryGetValue(codepage, out var value))
			{
				return value;
			}
			int num = 0;
			int codePage;
			while ((codePage = codePageDataPtr[num].codePage) != 0)
			{
				if (codePage == codepage)
				{
					value = new CodePageDataItem(num);
					hashByCodePage[codepage] = value;
					return value;
				}
				num++;
			}
		}
		return null;
	}
}
