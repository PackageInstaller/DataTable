using System.Collections.Generic;
using System.Globalization;

namespace System.Text.RegularExpressions;

internal sealed class RegexCharClass
{
	private readonly struct LowerCaseMapping
	{
		public readonly char ChMin;

		public readonly char ChMax;

		public readonly int LcOp;

		public readonly int Data;

		internal LowerCaseMapping(char chMin, char chMax, int lcOp, int data)
		{
			ChMin = chMin;
			ChMax = chMax;
			LcOp = lcOp;
			Data = data;
		}
	}

	private sealed class SingleRangeComparer : IComparer<SingleRange>
	{
		public static readonly SingleRangeComparer Instance = new SingleRangeComparer();

		private SingleRangeComparer()
		{
		}

		public int Compare(SingleRange x, SingleRange y)
		{
			return x.First.CompareTo(y.First);
		}
	}

	private readonly struct SingleRange
	{
		public readonly char First;

		public readonly char Last;

		internal SingleRange(char first, char last)
		{
			First = first;
			Last = last;
		}
	}

	private static readonly string s_internalRegexIgnoreCase = "__InternalRegexIgnoreCase__";

	private static readonly string s_space = "d";

	private static readonly string s_notSpace = "ﾜ";

	private static readonly string s_word = "\0\u0002\u0004\u0005\u0003\u0001\u0006\t\u0013\0";

	private static readonly string s_notWord = "\0\ufffe￼\ufffb\ufffd\uffff\ufffa\ufff7￭\0";

	public static readonly string SpaceClass = "\0\0\u0001d";

	public static readonly string NotSpaceClass = "\u0001\0\u0001d";

	public static readonly string WordClass = "\0\0\n\0\u0002\u0004\u0005\u0003\u0001\u0006\t\u0013\0";

	public static readonly string NotWordClass = "\u0001\0\n\0\u0002\u0004\u0005\u0003\u0001\u0006\t\u0013\0";

	public static readonly string DigitClass = "\0\0\u0001\t";

	public static readonly string NotDigitClass = "\0\0\u0001\ufff7";

	private static readonly Dictionary<string, string> s_definedCategories = new Dictionary<string, string>(38)
	{
		{ "Cc", "\u000f" },
		{ "Cf", "\u0010" },
		{ "Cn", "\u001e" },
		{ "Co", "\u0012" },
		{ "Cs", "\u0011" },
		{ "C", "\0\u000f\u0010\u001e\u0012\u0011\0" },
		{ "Ll", "\u0002" },
		{ "Lm", "\u0004" },
		{ "Lo", "\u0005" },
		{ "Lt", "\u0003" },
		{ "Lu", "\u0001" },
		{ "L", "\0\u0002\u0004\u0005\u0003\u0001\0" },
		{ "__InternalRegexIgnoreCase__", "\0\u0002\u0003\u0001\0" },
		{ "Mc", "\a" },
		{ "Me", "\b" },
		{ "Mn", "\u0006" },
		{ "M", "\0\a\b\u0006\0" },
		{ "Nd", "\t" },
		{ "Nl", "\n" },
		{ "No", "\v" },
		{ "N", "\0\t\n\v\0" },
		{ "Pc", "\u0013" },
		{ "Pd", "\u0014" },
		{ "Pe", "\u0016" },
		{ "Po", "\u0019" },
		{ "Ps", "\u0015" },
		{ "Pf", "\u0018" },
		{ "Pi", "\u0017" },
		{ "P", "\0\u0013\u0014\u0016\u0019\u0015\u0018\u0017\0" },
		{ "Sc", "\u001b" },
		{ "Sk", "\u001c" },
		{ "Sm", "\u001a" },
		{ "So", "\u001d" },
		{ "S", "\0\u001b\u001c\u001a\u001d\0" },
		{ "Zl", "\r" },
		{ "Zp", "\u000e" },
		{ "Zs", "\f" },
		{ "Z", "\0\r\u000e\f\0" }
	};

	private static readonly string[][] s_propTable = new string[112][]
	{
		new string[2] { "IsAlphabeticPresentationForms", "ﬀﭐ" },
		new string[2] { "IsArabic", "\u0600܀" },
		new string[2] { "IsArabicPresentationForms-A", "ﭐ\ufe00" },
		new string[2] { "IsArabicPresentationForms-B", "ﹰ\uff00" },
		new string[2] { "IsArmenian", "\u0530\u0590" },
		new string[2] { "IsArrows", "←∀" },
		new string[2] { "IsBasicLatin", "\0\u0080" },
		new string[2] { "IsBengali", "ঀ\u0a00" },
		new string[2] { "IsBlockElements", "▀■" },
		new string[2] { "IsBopomofo", "\u3100\u3130" },
		new string[2] { "IsBopomofoExtended", "ㆠ㇀" },
		new string[2] { "IsBoxDrawing", "─▀" },
		new string[2] { "IsBraillePatterns", "⠀⤀" },
		new string[2] { "IsBuhid", "ᝀᝠ" },
		new string[2] { "IsCJKCompatibility", "㌀㐀" },
		new string[2] { "IsCJKCompatibilityForms", "︰﹐" },
		new string[2] { "IsCJKCompatibilityIdeographs", "豈ﬀ" },
		new string[2] { "IsCJKRadicalsSupplement", "⺀⼀" },
		new string[2] { "IsCJKSymbolsandPunctuation", "\u3000\u3040" },
		new string[2] { "IsCJKUnifiedIdeographs", "一ꀀ" },
		new string[2] { "IsCJKUnifiedIdeographsExtensionA", "㐀䷀" },
		new string[2] { "IsCherokee", "Ꭰ᐀" },
		new string[2] { "IsCombiningDiacriticalMarks", "\u0300Ͱ" },
		new string[2] { "IsCombiningDiacriticalMarksforSymbols", "\u20d0℀" },
		new string[2] { "IsCombiningHalfMarks", "\ufe20︰" },
		new string[2] { "IsCombiningMarksforSymbols", "\u20d0℀" },
		new string[2] { "IsControlPictures", "␀⑀" },
		new string[2] { "IsCurrencySymbols", "₠\u20d0" },
		new string[2] { "IsCyrillic", "ЀԀ" },
		new string[2] { "IsCyrillicSupplement", "Ԁ\u0530" },
		new string[2] { "IsDevanagari", "\u0900ঀ" },
		new string[2] { "IsDingbats", "✀⟀" },
		new string[2] { "IsEnclosedAlphanumerics", "①─" },
		new string[2] { "IsEnclosedCJKLettersandMonths", "㈀㌀" },
		new string[2] { "IsEthiopic", "ሀᎀ" },
		new string[2] { "IsGeneralPunctuation", "\u2000⁰" },
		new string[2] { "IsGeometricShapes", "■☀" },
		new string[2] { "IsGeorgian", "Ⴀᄀ" },
		new string[2] { "IsGreek", "ͰЀ" },
		new string[2] { "IsGreekExtended", "ἀ\u2000" },
		new string[2] { "IsGreekandCoptic", "ͰЀ" },
		new string[2] { "IsGujarati", "\u0a80\u0b00" },
		new string[2] { "IsGurmukhi", "\u0a00\u0a80" },
		new string[2] { "IsHalfwidthandFullwidthForms", "\uff00\ufff0" },
		new string[2] { "IsHangulCompatibilityJamo", "\u3130㆐" },
		new string[2] { "IsHangulJamo", "ᄀሀ" },
		new string[2] { "IsHangulSyllables", "가ힰ" },
		new string[2] { "IsHanunoo", "ᜠᝀ" },
		new string[2] { "IsHebrew", "\u0590\u0600" },
		new string[2] { "IsHighPrivateUseSurrogates", "\udb80\udc00" },
		new string[2] { "IsHighSurrogates", "\ud800\udb80" },
		new string[2] { "IsHiragana", "\u3040゠" },
		new string[2] { "IsIPAExtensions", "ɐʰ" },
		new string[2] { "IsIdeographicDescriptionCharacters", "⿰\u3000" },
		new string[2] { "IsKanbun", "㆐ㆠ" },
		new string[2] { "IsKangxiRadicals", "⼀\u2fe0" },
		new string[2] { "IsKannada", "ಀ\u0d00" },
		new string[2] { "IsKatakana", "゠\u3100" },
		new string[2] { "IsKatakanaPhoneticExtensions", "ㇰ㈀" },
		new string[2] { "IsKhmer", "ក᠀" },
		new string[2] { "IsKhmerSymbols", "᧠ᨀ" },
		new string[2] { "IsLao", "\u0e80ༀ" },
		new string[2] { "IsLatin-1Supplement", "\u0080Ā" },
		new string[2] { "IsLatinExtended-A", "Āƀ" },
		new string[2] { "IsLatinExtended-B", "ƀɐ" },
		new string[2] { "IsLatinExtendedAdditional", "Ḁἀ" },
		new string[2] { "IsLetterlikeSymbols", "℀⅐" },
		new string[2] { "IsLimbu", "ᤀᥐ" },
		new string[2] { "IsLowSurrogates", "\udc00\ue000" },
		new string[2] { "IsMalayalam", "\u0d00\u0d80" },
		new string[2] { "IsMathematicalOperators", "∀⌀" },
		new string[2] { "IsMiscellaneousMathematicalSymbols-A", "⟀⟰" },
		new string[2] { "IsMiscellaneousMathematicalSymbols-B", "⦀⨀" },
		new string[2] { "IsMiscellaneousSymbols", "☀✀" },
		new string[2] { "IsMiscellaneousSymbolsandArrows", "⬀Ⰰ" },
		new string[2] { "IsMiscellaneousTechnical", "⌀␀" },
		new string[2] { "IsMongolian", "᠀ᢰ" },
		new string[2] { "IsMyanmar", "ကႠ" },
		new string[2] { "IsNumberForms", "⅐←" },
		new string[2] { "IsOgham", "\u1680ᚠ" },
		new string[2] { "IsOpticalCharacterRecognition", "⑀①" },
		new string[2] { "IsOriya", "\u0b00\u0b80" },
		new string[2] { "IsPhoneticExtensions", "ᴀᶀ" },
		new string[2] { "IsPrivateUse", "\ue000豈" },
		new string[2] { "IsPrivateUseArea", "\ue000豈" },
		new string[2] { "IsRunic", "ᚠᜀ" },
		new string[2] { "IsSinhala", "\u0d80\u0e00" },
		new string[2] { "IsSmallFormVariants", "﹐ﹰ" },
		new string[2] { "IsSpacingModifierLetters", "ʰ\u0300" },
		new string[2] { "IsSpecials", "\ufff0" },
		new string[2] { "IsSuperscriptsandSubscripts", "⁰₠" },
		new string[2] { "IsSupplementalArrows-A", "⟰⠀" },
		new string[2] { "IsSupplementalArrows-B", "⤀⦀" },
		new string[2] { "IsSupplementalMathematicalOperators", "⨀⬀" },
		new string[2] { "IsSyriac", "܀ݐ" },
		new string[2] { "IsTagalog", "ᜀᜠ" },
		new string[2] { "IsTagbanwa", "ᝠក" },
		new string[2] { "IsTaiLe", "ᥐᦀ" },
		new string[2] { "IsTamil", "\u0b80\u0c00" },
		new string[2] { "IsTelugu", "\u0c00ಀ" },
		new string[2] { "IsThaana", "ހ߀" },
		new string[2] { "IsThai", "\u0e00\u0e80" },
		new string[2] { "IsTibetan", "ༀက" },
		new string[2] { "IsUnifiedCanadianAboriginalSyllabics", "᐀\u1680" },
		new string[2] { "IsVariationSelectors", "\ufe00︐" },
		new string[2] { "IsYiRadicals", "꒐ꓐ" },
		new string[2] { "IsYiSyllables", "ꀀ꒐" },
		new string[2] { "IsYijingHexagramSymbols", "䷀一" },
		new string[2] { "_xmlC", "-/0;A[_`a{·\u00b8À×Ø÷øĲĴĿŁŉŊſƀǄǍǱǴǶǺȘɐʩʻ\u02c2ː\u02d2\u0300\u0346\u0360\u0362Ά\u038bΌ\u038dΎ\u03a2ΣϏϐϗϚϛϜϝϞϟϠϡϢϴЁЍЎѐёѝў҂\u0483\u0487ҐӅӇӉӋӍӐӬӮӶӸӺԱ\u0557ՙ՚աև\u0591\u05a2\u05a3\u05ba\u05bb־\u05bf׀\u05c1׃\u05c4\u05c5א\u05ebװ׳ءػـ\u0653٠٪\u0670ڸںڿۀۏې۔ە۩\u06eaۮ۰ۺ\u0901ऄअ\u093a\u093c\u094e\u0951\u0955क़।०॰\u0981\u0984অ\u098dএ\u0991ও\u09a9প\u09b1ল\u09b3শ\u09ba\u09bcঽ\u09be\u09c5\u09c7\u09c9\u09cbৎ\u09d7\u09d8ড়\u09deয়\u09e4০৲\u0a02\u0a03ਅ\u0a0bਏ\u0a11ਓ\u0a29ਪ\u0a31ਲ\u0a34ਵ\u0a37ਸ\u0a3a\u0a3c\u0a3d\u0a3e\u0a43\u0a47\u0a49\u0a4b\u0a4eਖ਼\u0a5dਫ਼\u0a5f੦\u0a75\u0a81\u0a84અઌઍ\u0a8eએ\u0a92ઓ\u0aa9પ\u0ab1લ\u0ab4વ\u0aba\u0abc\u0ac6\u0ac7\u0aca\u0acb\u0aceૠૡ૦૰\u0b01\u0b04ଅ\u0b0dଏ\u0b11ଓ\u0b29ପ\u0b31ଲ\u0b34ଶ\u0b3a\u0b3c\u0b44\u0b47\u0b49\u0b4b\u0b4e\u0b56\u0b58ଡ଼\u0b5eୟ\u0b62୦୰\u0b82\u0b84அ\u0b8bஎ\u0b91ஒ\u0b96ங\u0b9bஜ\u0b9dஞ\u0ba0ண\u0ba5ந\u0babமஶஷ\u0bba\u0bbe\u0bc3\u0bc6\u0bc9\u0bca\u0bce\u0bd7\u0bd8௧௰\u0c01\u0c04అ\u0c0dఎ\u0c11ఒ\u0c29పఴవ\u0c3a\u0c3e\u0c45\u0c46\u0c49\u0c4a\u0c4e\u0c55\u0c57ౠ\u0c62౦\u0c70\u0c82಄ಅ\u0c8dಎ\u0c91ಒ\u0ca9ಪ\u0cb4ವ\u0cba\u0cbe\u0cc5\u0cc6\u0cc9\u0cca\u0cce\u0cd5\u0cd7ೞ\u0cdfೠ\u0ce2೦\u0cf0\u0d02ഄഅ\u0d0dഎ\u0d11ഒഩപഺ\u0d3e\u0d44\u0d46\u0d49\u0d4aൎ\u0d57൘ൠ\u0d62൦൰กฯะ\u0e3bเ๏๐๚ກ\u0e83ຄ\u0e85ງຉຊ\u0e8bຍຎດຘນຠມ\u0ea4ລ\u0ea6ວຨສຬອຯະ\u0eba\u0ebb\u0ebeເ\u0ec5ໆ\u0ec7\u0ec8\u0ece໐\u0eda\u0f18༚༠༪\u0f35༶\u0f37༸\u0f39༺\u0f3e\u0f48ཉཪ\u0f71྅\u0f86ྌ\u0f90\u0f96\u0f97\u0f98\u0f99\u0fae\u0fb1\u0fb8\u0fb9\u0fbaႠ\u10c6აჷᄀᄁᄂᄄᄅᄈᄉᄊᄋᄍᄎᄓᄼᄽᄾᄿᅀᅁᅌᅍᅎᅏᅐᅑᅔᅖᅙᅚᅟᅢᅣᅤᅥᅦᅧᅨᅩᅪᅭᅯᅲᅴᅵᅶᆞᆟᆨᆩᆫᆬᆮᆰᆷᆹᆺᆻᆼᇃᇫᇬᇰᇱᇹᇺḀẜẠỺἀ\u1f16Ἐ\u1f1eἠ\u1f46Ὀ\u1f4eὐ\u1f58Ὑ\u1f5aὛ\u1f5cὝ\u1f5eὟ\u1f7eᾀ\u1fb5ᾶ\u1fbdι\u1fbfῂ\u1fc5ῆ\u1fcdῐ\u1fd4ῖ\u1fdcῠ\u1fedῲ\u1ff5ῶ\u1ffd\u20d0\u20dd\u20e1\u20e2Ω℧Kℬ℮ℯↀↃ々〆〇〈〡〰〱〶ぁゕ\u3099\u309bゝゟァ・ーヿㄅㄭ一龦가\ud7a4" },
		new string[2] { "_xmlD", "0:٠٪۰ۺ०॰০ৰ੦\u0a70૦૰୦୰௧௰౦\u0c70೦\u0cf0൦൰๐๚໐\u0eda༠༪၀၊፩፲០\u17ea᠐\u181a０：" },
		new string[2] { "_xmlI", ":;A[_`a{À×Ø÷øĲĴĿŁŉŊſƀǄǍǱǴǶǺȘɐʩʻ\u02c2Ά·Έ\u038bΌ\u038dΎ\u03a2ΣϏϐϗϚϛϜϝϞϟϠϡϢϴЁЍЎѐёѝў҂ҐӅӇӉӋӍӐӬӮӶӸӺԱ\u0557ՙ՚աևא\u05ebװ׳ءػف\u064bٱڸںڿۀۏې۔ە\u06d6ۥ\u06e7अ\u093aऽ\u093eक़\u0962অ\u098dএ\u0991ও\u09a9প\u09b1ল\u09b3শ\u09baড়\u09deয়\u09e2ৰ৲ਅ\u0a0bਏ\u0a11ਓ\u0a29ਪ\u0a31ਲ\u0a34ਵ\u0a37ਸ\u0a3aਖ਼\u0a5dਫ਼\u0a5fੲ\u0a75અઌઍ\u0a8eએ\u0a92ઓ\u0aa9પ\u0ab1લ\u0ab4વ\u0abaઽ\u0abeૠૡଅ\u0b0dଏ\u0b11ଓ\u0b29ପ\u0b31ଲ\u0b34ଶ\u0b3aଽ\u0b3eଡ଼\u0b5eୟ\u0b62அ\u0b8bஎ\u0b91ஒ\u0b96ங\u0b9bஜ\u0b9dஞ\u0ba0ண\u0ba5ந\u0babமஶஷ\u0bbaఅ\u0c0dఎ\u0c11ఒ\u0c29పఴవ\u0c3aౠ\u0c62ಅ\u0c8dಎ\u0c91ಒ\u0ca9ಪ\u0cb4ವ\u0cbaೞ\u0cdfೠ\u0ce2അ\u0d0dഎ\u0d11ഒഩപഺൠ\u0d62กฯะ\u0e31า\u0e34เๆກ\u0e83ຄ\u0e85ງຉຊ\u0e8bຍຎດຘນຠມ\u0ea4ລ\u0ea6ວຨສຬອຯະ\u0eb1າ\u0eb4ຽ\u0ebeເ\u0ec5ཀ\u0f48ཉཪႠ\u10c6აჷᄀᄁᄂᄄᄅᄈᄉᄊᄋᄍᄎᄓᄼᄽᄾᄿᅀᅁᅌᅍᅎᅏᅐᅑᅔᅖᅙᅚᅟᅢᅣᅤᅥᅦᅧᅨᅩᅪᅭᅯᅲᅴᅵᅶᆞᆟᆨᆩᆫᆬᆮᆰᆷᆹᆺᆻᆼᇃᇫᇬᇰᇱᇹᇺḀẜẠỺἀ\u1f16Ἐ\u1f1eἠ\u1f46Ὀ\u1f4eὐ\u1f58Ὑ\u1f5aὛ\u1f5cὝ\u1f5eὟ\u1f7eᾀ\u1fb5ᾶ\u1fbdι\u1fbfῂ\u1fc5ῆ\u1fcdῐ\u1fd4ῖ\u1fdcῠ\u1fedῲ\u1ff5ῶ\u1ffdΩ℧Kℬ℮ℯↀↃ〇〈〡\u302aぁゕァ・ㄅㄭ一龦가\ud7a4" },
		new string[2] { "_xmlW", "$%+,0:<?A[^_`{|}~\u007f¢«¬\u00ad®·\u00b8»¼¿ÀȡȢȴɐʮʰ\u02ef\u0300\u0350\u0360ͰʹͶͺͻ\u0384·Έ\u038bΌ\u038dΎ\u03a2ΣϏϐϷЀ\u0487\u0488ӏӐӶӸӺԀԐԱ\u0557ՙ՚աֈ\u0591\u05a2\u05a3\u05ba\u05bb־\u05bf׀\u05c1׃\u05c4\u05c5א\u05ebװ׳ءػـ\u0656٠٪ٮ۔ە\u06dd۞ۮ۰ۿܐܭ\u0730\u074bހ\u07b2\u0901ऄअ\u093a\u093c\u094eॐ\u0955क़।०॰\u0981\u0984অ\u098dএ\u0991ও\u09a9প\u09b1ল\u09b3শ\u09ba\u09bcঽ\u09be\u09c5\u09c7\u09c9\u09cbৎ\u09d7\u09d8ড়\u09deয়\u09e4০৻\u0a02\u0a03ਅ\u0a0bਏ\u0a11ਓ\u0a29ਪ\u0a31ਲ\u0a34ਵ\u0a37ਸ\u0a3a\u0a3c\u0a3d\u0a3e\u0a43\u0a47\u0a49\u0a4b\u0a4eਖ਼\u0a5dਫ਼\u0a5f੦\u0a75\u0a81\u0a84અઌઍ\u0a8eએ\u0a92ઓ\u0aa9પ\u0ab1લ\u0ab4વ\u0aba\u0abc\u0ac6\u0ac7\u0aca\u0acb\u0aceૐ\u0ad1ૠૡ૦૰\u0b01\u0b04ଅ\u0b0dଏ\u0b11ଓ\u0b29ପ\u0b31ଲ\u0b34ଶ\u0b3a\u0b3c\u0b44\u0b47\u0b49\u0b4b\u0b4e\u0b56\u0b58ଡ଼\u0b5eୟ\u0b62୦ୱ\u0b82\u0b84அ\u0b8bஎ\u0b91ஒ\u0b96ங\u0b9bஜ\u0b9dஞ\u0ba0ண\u0ba5ந\u0babமஶஷ\u0bba\u0bbe\u0bc3\u0bc6\u0bc9\u0bca\u0bce\u0bd7\u0bd8௧௳\u0c01\u0c04అ\u0c0dఎ\u0c11ఒ\u0c29పఴవ\u0c3a\u0c3e\u0c45\u0c46\u0c49\u0c4a\u0c4e\u0c55\u0c57ౠ\u0c62౦\u0c70\u0c82಄ಅ\u0c8dಎ\u0c91ಒ\u0ca9ಪ\u0cb4ವ\u0cba\u0cbe\u0cc5\u0cc6\u0cc9\u0cca\u0cce\u0cd5\u0cd7ೞ\u0cdfೠ\u0ce2೦\u0cf0\u0d02ഄഅ\u0d0dഎ\u0d11ഒഩപഺ\u0d3e\u0d44\u0d46\u0d49\u0d4aൎ\u0d57൘ൠ\u0d62൦൰\u0d82\u0d84අ\u0d97ක\u0db2ඳ\u0dbcල\u0dbeව\u0dc7\u0dca\u0dcb\u0dcf\u0dd5\u0dd6\u0dd7\u0dd8\u0de0\u0df2෴ก\u0e3b฿๏๐๚ກ\u0e83ຄ\u0e85ງຉຊ\u0e8bຍຎດຘນຠມ\u0ea4ລ\u0ea6ວຨສຬອ\u0eba\u0ebb\u0ebeເ\u0ec5ໆ\u0ec7\u0ec8\u0ece໐\u0edaໜໞༀ༄༓༺\u0f3e\u0f48ཉཫ\u0f71྅\u0f86ྌ\u0f90\u0f98\u0f99\u0fbd྾\u0fcd࿏࿐ကဢဣဨဩ\u102b\u102c\u1033\u1036\u103a၀၊ၐၚႠ\u10c6აჹᄀᅚᅟᆣᆨᇺሀሇለቇቈ\u1249ቊ\u124eቐ\u1257ቘ\u1259ቚ\u125eበኇኈ\u1289ኊ\u128eነኯኰ\u12b1ኲ\u12b6ኸ\u12bfዀ\u12c1ዂ\u12c6ወዏዐ\u12d7ዘዯደጏጐ\u1311ጒ\u1316ጘጟጠፇፈ\u135b፩\u137dᎠᏵᐁ᙭ᙯᙷᚁ᚛ᚠ᛫ᛮᛱᜀᜍᜎ\u1715ᜠ᜵ᝀ\u1754ᝠ\u176dᝮ\u1771\u1772\u1774ក។ៗ៘៛\u17dd០\u17ea\u180b\u180e᠐\u181aᠠᡸᢀᢪḀẜẠỺἀ\u1f16Ἐ\u1f1eἠ\u1f46Ὀ\u1f4eὐ\u1f58Ὑ\u1f5aὛ\u1f5cὝ\u1f5eὟ\u1f7eᾀ\u1fb5ᾶ\u1fc5ῆ\u1fd4ῖ\u1fdc\u1fdd\u1ff0ῲ\u1ff5ῶ\u1fff⁄⁅⁒⁓⁰\u2072⁴⁽ⁿ₍₠₲\u20d0\u20eb℀℻ℽ⅌⅓ↄ←〈⌫⎴⎷⏏␀␧⑀\u244b①⓿─☔☖☘☙♾⚀⚊✁✅✆✊✌✨✩❌❍❎❏❓❖❗❘❟❡❨❶➕➘➰➱➿⟐⟦⟰⦃⦙⧘⧜⧼⧾⬀⺀\u2e9a⺛\u2ef4⼀\u2fd6⿰⿼〄〈〒〔〠〰〱〽〾\u3040ぁ\u3097\u3099゠ァ・ー\u3100ㄅㄭㄱ\u318f㆐ㆸㇰ㈝㈠㉄㉑㉼㉿㋌㋐㋿㌀㍷㍻㏞㏠㏿㐀䶶一龦ꀀ\ua48d꒐\ua4c7가\ud7a4豈郞侮恵ﬀ\ufb07ﬓ\ufb18יִ\ufb37טּ\ufb3dמּ\ufb3fנּ\ufb42ףּ\ufb45צּ\ufbb2ﯓ﴾ﵐ\ufd90ﶒ\ufdc8ﷰ﷽\ufe00︐\ufe20\ufe24﹢﹣﹤\ufe67﹩﹪ﹰ\ufe75ﹶ\ufefd＄％＋，０：＜？Ａ［\uff3e\uff3f\uff40｛｜｝～｟ｦ\uffbfￂ\uffc8ￊ\uffd0ￒ\uffd8ￚ\uffdd￠\uffe7￨\uffef￼\ufffe" }
	};

	private static readonly LowerCaseMapping[] s_lcTable = new LowerCaseMapping[94]
	{
		new LowerCaseMapping('A', 'Z', 1, 32),
		new LowerCaseMapping('À', 'Þ', 1, 32),
		new LowerCaseMapping('Ā', 'Į', 2, 0),
		new LowerCaseMapping('İ', 'İ', 0, 105),
		new LowerCaseMapping('Ĳ', 'Ķ', 2, 0),
		new LowerCaseMapping('Ĺ', 'Ň', 3, 0),
		new LowerCaseMapping('Ŋ', 'Ŷ', 2, 0),
		new LowerCaseMapping('Ÿ', 'Ÿ', 0, 255),
		new LowerCaseMapping('Ź', 'Ž', 3, 0),
		new LowerCaseMapping('Ɓ', 'Ɓ', 0, 595),
		new LowerCaseMapping('Ƃ', 'Ƅ', 2, 0),
		new LowerCaseMapping('Ɔ', 'Ɔ', 0, 596),
		new LowerCaseMapping('Ƈ', 'Ƈ', 0, 392),
		new LowerCaseMapping('Ɖ', 'Ɗ', 1, 205),
		new LowerCaseMapping('Ƌ', 'Ƌ', 0, 396),
		new LowerCaseMapping('Ǝ', 'Ǝ', 0, 477),
		new LowerCaseMapping('Ə', 'Ə', 0, 601),
		new LowerCaseMapping('Ɛ', 'Ɛ', 0, 603),
		new LowerCaseMapping('Ƒ', 'Ƒ', 0, 402),
		new LowerCaseMapping('Ɠ', 'Ɠ', 0, 608),
		new LowerCaseMapping('Ɣ', 'Ɣ', 0, 611),
		new LowerCaseMapping('Ɩ', 'Ɩ', 0, 617),
		new LowerCaseMapping('Ɨ', 'Ɨ', 0, 616),
		new LowerCaseMapping('Ƙ', 'Ƙ', 0, 409),
		new LowerCaseMapping('Ɯ', 'Ɯ', 0, 623),
		new LowerCaseMapping('Ɲ', 'Ɲ', 0, 626),
		new LowerCaseMapping('Ɵ', 'Ɵ', 0, 629),
		new LowerCaseMapping('Ơ', 'Ƥ', 2, 0),
		new LowerCaseMapping('Ƨ', 'Ƨ', 0, 424),
		new LowerCaseMapping('Ʃ', 'Ʃ', 0, 643),
		new LowerCaseMapping('Ƭ', 'Ƭ', 0, 429),
		new LowerCaseMapping('Ʈ', 'Ʈ', 0, 648),
		new LowerCaseMapping('Ư', 'Ư', 0, 432),
		new LowerCaseMapping('Ʊ', 'Ʋ', 1, 217),
		new LowerCaseMapping('Ƴ', 'Ƶ', 3, 0),
		new LowerCaseMapping('Ʒ', 'Ʒ', 0, 658),
		new LowerCaseMapping('Ƹ', 'Ƹ', 0, 441),
		new LowerCaseMapping('Ƽ', 'Ƽ', 0, 445),
		new LowerCaseMapping('Ǆ', 'ǅ', 0, 454),
		new LowerCaseMapping('Ǉ', 'ǈ', 0, 457),
		new LowerCaseMapping('Ǌ', 'ǋ', 0, 460),
		new LowerCaseMapping('Ǎ', 'Ǜ', 3, 0),
		new LowerCaseMapping('Ǟ', 'Ǯ', 2, 0),
		new LowerCaseMapping('Ǳ', 'ǲ', 0, 499),
		new LowerCaseMapping('Ǵ', 'Ǵ', 0, 501),
		new LowerCaseMapping('Ǻ', 'Ȗ', 2, 0),
		new LowerCaseMapping('Ά', 'Ά', 0, 940),
		new LowerCaseMapping('Έ', 'Ί', 1, 37),
		new LowerCaseMapping('Ό', 'Ό', 0, 972),
		new LowerCaseMapping('Ύ', 'Ώ', 1, 63),
		new LowerCaseMapping('Α', 'Ϋ', 1, 32),
		new LowerCaseMapping('Ϣ', 'Ϯ', 2, 0),
		new LowerCaseMapping('Ё', 'Џ', 1, 80),
		new LowerCaseMapping('А', 'Я', 1, 32),
		new LowerCaseMapping('Ѡ', 'Ҁ', 2, 0),
		new LowerCaseMapping('Ґ', 'Ҿ', 2, 0),
		new LowerCaseMapping('Ӂ', 'Ӄ', 3, 0),
		new LowerCaseMapping('Ӈ', 'Ӈ', 0, 1224),
		new LowerCaseMapping('Ӌ', 'Ӌ', 0, 1228),
		new LowerCaseMapping('Ӑ', 'Ӫ', 2, 0),
		new LowerCaseMapping('Ӯ', 'Ӵ', 2, 0),
		new LowerCaseMapping('Ӹ', 'Ӹ', 0, 1273),
		new LowerCaseMapping('Ա', 'Ֆ', 1, 48),
		new LowerCaseMapping('Ⴀ', 'Ⴥ', 1, 48),
		new LowerCaseMapping('Ḁ', 'Ỹ', 2, 0),
		new LowerCaseMapping('Ἀ', 'Ἇ', 1, -8),
		new LowerCaseMapping('Ἐ', '\u1f1f', 1, -8),
		new LowerCaseMapping('Ἠ', 'Ἧ', 1, -8),
		new LowerCaseMapping('Ἰ', 'Ἷ', 1, -8),
		new LowerCaseMapping('Ὀ', 'Ὅ', 1, -8),
		new LowerCaseMapping('Ὑ', 'Ὑ', 0, 8017),
		new LowerCaseMapping('Ὓ', 'Ὓ', 0, 8019),
		new LowerCaseMapping('Ὕ', 'Ὕ', 0, 8021),
		new LowerCaseMapping('Ὗ', 'Ὗ', 0, 8023),
		new LowerCaseMapping('Ὠ', 'Ὧ', 1, -8),
		new LowerCaseMapping('ᾈ', 'ᾏ', 1, -8),
		new LowerCaseMapping('ᾘ', 'ᾟ', 1, -8),
		new LowerCaseMapping('ᾨ', 'ᾯ', 1, -8),
		new LowerCaseMapping('Ᾰ', 'Ᾱ', 1, -8),
		new LowerCaseMapping('Ὰ', 'Ά', 1, -74),
		new LowerCaseMapping('ᾼ', 'ᾼ', 0, 8115),
		new LowerCaseMapping('Ὲ', 'Ή', 1, -86),
		new LowerCaseMapping('ῌ', 'ῌ', 0, 8131),
		new LowerCaseMapping('Ῐ', 'Ῑ', 1, -8),
		new LowerCaseMapping('Ὶ', 'Ί', 1, -100),
		new LowerCaseMapping('Ῠ', 'Ῡ', 1, -8),
		new LowerCaseMapping('Ὺ', 'Ύ', 1, -112),
		new LowerCaseMapping('Ῥ', 'Ῥ', 0, 8165),
		new LowerCaseMapping('Ὸ', 'Ό', 1, -128),
		new LowerCaseMapping('Ὼ', 'Ώ', 1, -126),
		new LowerCaseMapping('ῼ', 'ῼ', 0, 8179),
		new LowerCaseMapping('Ⅰ', 'Ⅿ', 1, 16),
		new LowerCaseMapping('Ⓐ', 'ⓐ', 1, 26),
		new LowerCaseMapping('Ａ', 'Ｚ', 1, 32)
	};

	private List<SingleRange> _rangelist;

	private StringBuilder _categories;

	private bool _canonical;

	private bool _negate;

	private RegexCharClass _subtractor;

	public bool CanMerge
	{
		get
		{
			if (!_negate)
			{
				return _subtractor == null;
			}
			return false;
		}
	}

	public bool Negate
	{
		set
		{
			_negate = value;
		}
	}

	public RegexCharClass()
	{
		_rangelist = new List<SingleRange>(6);
		_canonical = true;
		_categories = new StringBuilder();
	}

	private RegexCharClass(bool negate, List<SingleRange> ranges, StringBuilder categories, RegexCharClass subtraction)
	{
		_rangelist = ranges;
		_categories = categories;
		_canonical = true;
		_negate = negate;
		_subtractor = subtraction;
	}

	public void AddChar(char c)
	{
		AddRange(c, c);
	}

	public void AddCharClass(RegexCharClass cc)
	{
		if (!cc._canonical)
		{
			_canonical = false;
		}
		else if (_canonical && RangeCount() > 0 && cc.RangeCount() > 0 && cc.GetRangeAt(0).First <= GetRangeAt(RangeCount() - 1).Last)
		{
			_canonical = false;
		}
		for (int i = 0; i < cc.RangeCount(); i++)
		{
			_rangelist.Add(cc.GetRangeAt(i));
		}
		_categories.Append(cc._categories.ToString());
	}

	private void AddSet(string set)
	{
		if (_canonical && RangeCount() > 0 && set.Length > 0 && set[0] <= GetRangeAt(RangeCount() - 1).Last)
		{
			_canonical = false;
		}
		int i;
		for (i = 0; i < set.Length - 1; i += 2)
		{
			_rangelist.Add(new SingleRange(set[i], (char)(set[i + 1] - 1)));
		}
		if (i < set.Length)
		{
			_rangelist.Add(new SingleRange(set[i], '\uffff'));
		}
	}

	public void AddSubtraction(RegexCharClass sub)
	{
		_subtractor = sub;
	}

	public void AddRange(char first, char last)
	{
		_rangelist.Add(new SingleRange(first, last));
		if (_canonical && _rangelist.Count > 0 && first <= _rangelist[_rangelist.Count - 1].Last)
		{
			_canonical = false;
		}
	}

	public void AddCategoryFromName(string categoryName, bool invert, bool caseInsensitive, string pattern)
	{
		if (s_definedCategories.TryGetValue(categoryName, out var value) && !categoryName.Equals(s_internalRegexIgnoreCase))
		{
			if (caseInsensitive && (categoryName.Equals("Ll") || categoryName.Equals("Lu") || categoryName.Equals("Lt")))
			{
				value = s_definedCategories[s_internalRegexIgnoreCase];
			}
			if (invert)
			{
				value = NegateCategory(value);
			}
			_categories.Append(value);
		}
		else
		{
			AddSet(SetFromProperty(categoryName, invert, pattern));
		}
	}

	private void AddCategory(string category)
	{
		_categories.Append(category);
	}

	public void AddLowercase(CultureInfo culture)
	{
		_canonical = false;
		int count = _rangelist.Count;
		for (int i = 0; i < count; i++)
		{
			SingleRange singleRange = _rangelist[i];
			if (singleRange.First == singleRange.Last)
			{
				char c = culture.TextInfo.ToLower(singleRange.First);
				_rangelist[i] = new SingleRange(c, c);
			}
			else
			{
				AddLowercaseRange(singleRange.First, singleRange.Last, culture);
			}
		}
	}

	private void AddLowercaseRange(char chMin, char chMax, CultureInfo culture)
	{
		int i = 0;
		int num = s_lcTable.Length;
		while (i < num)
		{
			int num2 = (i + num) / 2;
			if (s_lcTable[num2].ChMax < chMin)
			{
				i = num2 + 1;
			}
			else
			{
				num = num2;
			}
		}
		if (i >= s_lcTable.Length)
		{
			return;
		}
		for (; i < s_lcTable.Length; i++)
		{
			LowerCaseMapping lowerCaseMapping2;
			LowerCaseMapping lowerCaseMapping = (lowerCaseMapping2 = s_lcTable[i]);
			if (lowerCaseMapping.ChMin <= chMax)
			{
				char c;
				if ((c = lowerCaseMapping2.ChMin) < chMin)
				{
					c = chMin;
				}
				char c2;
				if ((c2 = lowerCaseMapping2.ChMax) > chMax)
				{
					c2 = chMax;
				}
				switch (lowerCaseMapping2.LcOp)
				{
				case 0:
					c = (char)lowerCaseMapping2.Data;
					c2 = (char)lowerCaseMapping2.Data;
					break;
				case 1:
					c = (char)(c + (ushort)lowerCaseMapping2.Data);
					c2 = (char)(c2 + (ushort)lowerCaseMapping2.Data);
					break;
				case 2:
					c = (char)(c | 1);
					c2 = (char)(c2 | 1);
					break;
				case 3:
					c = (char)(c + (ushort)(c & 1));
					c2 = (char)(c2 + (ushort)(c2 & 1));
					break;
				}
				if (c < chMin || c2 > chMax)
				{
					AddRange(c, c2);
				}
				continue;
			}
			break;
		}
	}

	public void AddWord(bool ecma, bool negate)
	{
		if (negate)
		{
			if (ecma)
			{
				AddSet("\00:A[_`a{İı");
			}
			else
			{
				AddCategory(s_notWord);
			}
		}
		else if (ecma)
		{
			AddSet("0:A[_`a{İı");
		}
		else
		{
			AddCategory(s_word);
		}
	}

	public void AddSpace(bool ecma, bool negate)
	{
		if (negate)
		{
			if (ecma)
			{
				AddSet("\0\t\u000e !");
			}
			else
			{
				AddCategory(s_notSpace);
			}
		}
		else if (ecma)
		{
			AddSet("\t\u000e !");
		}
		else
		{
			AddCategory(s_space);
		}
	}

	public void AddDigit(bool ecma, bool negate, string pattern)
	{
		if (ecma)
		{
			if (negate)
			{
				AddSet("\00:");
			}
			else
			{
				AddSet("0:");
			}
		}
		else
		{
			AddCategoryFromName("Nd", negate, caseInsensitive: false, pattern);
		}
	}

	public static char SingletonChar(string set)
	{
		return set[3];
	}

	public static bool IsMergeable(string charClass)
	{
		if (!IsNegated(charClass))
		{
			return !IsSubtraction(charClass);
		}
		return false;
	}

	public static bool IsEmpty(string charClass)
	{
		if (charClass[2] == '\0' && charClass[0] == '\0' && charClass[1] == '\0')
		{
			return !IsSubtraction(charClass);
		}
		return false;
	}

	public static bool IsSingleton(string set)
	{
		if (set[0] == '\0' && set[2] == '\0' && set[1] == '\u0002' && !IsSubtraction(set) && (set[3] == '\uffff' || set[3] + 1 == set[4]))
		{
			return true;
		}
		return false;
	}

	public static bool IsSingletonInverse(string set)
	{
		if (set[0] == '\u0001' && set[2] == '\0' && set[1] == '\u0002' && !IsSubtraction(set) && (set[3] == '\uffff' || set[3] + 1 == set[4]))
		{
			return true;
		}
		return false;
	}

	private static bool IsSubtraction(string charClass)
	{
		return charClass.Length > 3 + charClass[1] + charClass[2];
	}

	private static bool IsNegated(string set)
	{
		if (set != null)
		{
			return set[0] == '\u0001';
		}
		return false;
	}

	public static bool IsECMAWordChar(char ch)
	{
		return CharInClass(ch, "\0\n\00:A[_`a{İı");
	}

	public static bool IsWordChar(char ch)
	{
		if (!CharInClass(ch, WordClass) && ch != '\u200d')
		{
			return ch == '\u200c';
		}
		return true;
	}

	public static bool CharInClass(char ch, string set)
	{
		return CharInClassRecursive(ch, set, 0);
	}

	private static bool CharInClassRecursive(char ch, string set, int start)
	{
		int num = set[start + 1];
		int num2 = set[start + 2];
		int num3 = start + 3 + num + num2;
		bool flag = false;
		if (set.Length > num3)
		{
			flag = CharInClassRecursive(ch, set, num3);
		}
		bool flag2 = CharInClassInternal(ch, set, start, num, num2);
		if (set[start] == '\u0001')
		{
			flag2 = !flag2;
		}
		if (flag2)
		{
			return !flag;
		}
		return false;
	}

	private static bool CharInClassInternal(char ch, string set, int start, int mySetLength, int myCategoryLength)
	{
		int num = start + 3;
		int num2 = num + mySetLength;
		while (num != num2)
		{
			int num3 = (num + num2) / 2;
			if (ch < set[num3])
			{
				num2 = num3;
			}
			else
			{
				num = num3 + 1;
			}
		}
		if ((num & 1) == (start & 1))
		{
			return true;
		}
		if (myCategoryLength == 0)
		{
			return false;
		}
		return CharInCategory(ch, set, start, mySetLength, myCategoryLength);
	}

	private static bool CharInCategory(char ch, string set, int start, int mySetLength, int myCategoryLength)
	{
		UnicodeCategory unicodeCategory = CharUnicodeInfo.GetUnicodeCategory(ch);
		int i = start + 3 + mySetLength;
		int num = i + myCategoryLength;
		while (i < num)
		{
			int num2 = (short)set[i];
			if (num2 == 0)
			{
				if (CharInCategoryGroup(ch, unicodeCategory, set, ref i))
				{
					return true;
				}
			}
			else if (num2 > 0)
			{
				if (num2 == 100)
				{
					if (char.IsWhiteSpace(ch))
					{
						return true;
					}
					i++;
					continue;
				}
				num2--;
				if (unicodeCategory == (UnicodeCategory)num2)
				{
					return true;
				}
			}
			else
			{
				if (num2 == -100)
				{
					if (!char.IsWhiteSpace(ch))
					{
						return true;
					}
					i++;
					continue;
				}
				num2 = -1 - num2;
				if (unicodeCategory != (UnicodeCategory)num2)
				{
					return true;
				}
			}
			i++;
		}
		return false;
	}

	private static bool CharInCategoryGroup(char ch, UnicodeCategory chcategory, string category, ref int i)
	{
		i++;
		int num = (short)category[i];
		if (num > 0)
		{
			bool flag = false;
			while (num != 0)
			{
				if (!flag)
				{
					num--;
					if (chcategory == (UnicodeCategory)num)
					{
						flag = true;
					}
				}
				i++;
				num = (short)category[i];
			}
			return flag;
		}
		bool flag2 = true;
		while (num != 0)
		{
			if (flag2)
			{
				num = -1 - num;
				if (chcategory == (UnicodeCategory)num)
				{
					flag2 = false;
				}
			}
			i++;
			num = (short)category[i];
		}
		return flag2;
	}

	private static string NegateCategory(string category)
	{
		if (category == null)
		{
			return null;
		}
		StringBuilder stringBuilder = System.Text.StringBuilderCache.Acquire(category.Length);
		for (int i = 0; i < category.Length; i++)
		{
			short num = (short)category[i];
			stringBuilder.Append((char)(-num));
		}
		return System.Text.StringBuilderCache.GetStringAndRelease(stringBuilder);
	}

	public static RegexCharClass Parse(string charClass)
	{
		return ParseRecursive(charClass, 0);
	}

	private static RegexCharClass ParseRecursive(string charClass, int start)
	{
		int num = charClass[start + 1];
		int num2 = charClass[start + 2];
		int num3 = start + 3 + num + num2;
		List<SingleRange> list = new List<SingleRange>(num);
		int num4 = start + 3;
		int num5 = num4 + num;
		while (num4 < num5)
		{
			char first = charClass[num4];
			num4++;
			char last = ((num4 >= num5) ? '\uffff' : ((char)(charClass[num4] - 1)));
			num4++;
			list.Add(new SingleRange(first, last));
		}
		RegexCharClass subtraction = null;
		if (charClass.Length > num3)
		{
			subtraction = ParseRecursive(charClass, num3);
		}
		return new RegexCharClass(charClass[start] == '\u0001', list, new StringBuilder(charClass.Substring(num5, num2)), subtraction);
	}

	private int RangeCount()
	{
		return _rangelist.Count;
	}

	public string ToStringClass()
	{
		if (!_canonical)
		{
			Canonicalize();
		}
		int num = _rangelist.Count * 2;
		StringBuilder stringBuilder = System.Text.StringBuilderCache.Acquire(num + _categories.Length + 3);
		int num2 = (_negate ? 1 : 0);
		stringBuilder.Append((char)num2);
		stringBuilder.Append((char)num);
		stringBuilder.Append((char)_categories.Length);
		for (int i = 0; i < _rangelist.Count; i++)
		{
			SingleRange singleRange = _rangelist[i];
			stringBuilder.Append(singleRange.First);
			if (singleRange.Last != '\uffff')
			{
				stringBuilder.Append((char)(singleRange.Last + 1));
			}
		}
		stringBuilder[1] = (char)(stringBuilder.Length - 3);
		stringBuilder.Append(_categories);
		if (_subtractor != null)
		{
			stringBuilder.Append(_subtractor.ToStringClass());
		}
		return System.Text.StringBuilderCache.GetStringAndRelease(stringBuilder);
	}

	private SingleRange GetRangeAt(int i)
	{
		return _rangelist[i];
	}

	private void Canonicalize()
	{
		_canonical = true;
		_rangelist.Sort(SingleRangeComparer.Instance);
		if (_rangelist.Count <= 1)
		{
			return;
		}
		bool flag = false;
		int num = 1;
		int num2 = 0;
		while (true)
		{
			char last = _rangelist[num2].Last;
			while (true)
			{
				if (num == _rangelist.Count || last == '\uffff')
				{
					flag = true;
					break;
				}
				SingleRange singleRange2;
				SingleRange singleRange = (singleRange2 = _rangelist[num]);
				if (singleRange.First > last + 1)
				{
					break;
				}
				if (last < singleRange2.Last)
				{
					last = singleRange2.Last;
				}
				num++;
			}
			_rangelist[num2] = new SingleRange(_rangelist[num2].First, last);
			num2++;
			if (flag)
			{
				break;
			}
			if (num2 < num)
			{
				_rangelist[num2] = _rangelist[num];
			}
			num++;
		}
		_rangelist.RemoveRange(num2, _rangelist.Count - num2);
	}

	private static string SetFromProperty(string capname, bool invert, string pattern)
	{
		int num = 0;
		int num2 = s_propTable.Length;
		while (num != num2)
		{
			int num3 = (num + num2) / 2;
			int num4 = string.Compare(capname, s_propTable[num3][0], StringComparison.Ordinal);
			if (num4 < 0)
			{
				num2 = num3;
				continue;
			}
			if (num4 > 0)
			{
				num = num3 + 1;
				continue;
			}
			string text = s_propTable[num3][1];
			if (invert)
			{
				if (text[0] == '\0')
				{
					return text.Substring(1);
				}
				return "\0" + text;
			}
			return text;
		}
		throw new ArgumentException(global::SR.Format("parsing \"{0}\" - {1}", pattern, global::SR.Format("Unknown property '{0}'.", capname)));
	}
}
