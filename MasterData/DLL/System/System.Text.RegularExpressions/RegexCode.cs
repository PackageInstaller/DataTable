using System.Collections;
using System.Collections.Generic;

namespace System.Text.RegularExpressions;

internal sealed class RegexCode
{
	public const int Onerep = 0;

	public const int Notonerep = 1;

	public const int Setrep = 2;

	public const int Oneloop = 3;

	public const int Notoneloop = 4;

	public const int Setloop = 5;

	public const int Onelazy = 6;

	public const int Notonelazy = 7;

	public const int Setlazy = 8;

	public const int One = 9;

	public const int Notone = 10;

	public const int Set = 11;

	public const int Multi = 12;

	public const int Ref = 13;

	public const int Bol = 14;

	public const int Eol = 15;

	public const int Boundary = 16;

	public const int Nonboundary = 17;

	public const int Beginning = 18;

	public const int Start = 19;

	public const int EndZ = 20;

	public const int End = 21;

	public const int Nothing = 22;

	public const int Lazybranch = 23;

	public const int Branchmark = 24;

	public const int Lazybranchmark = 25;

	public const int Nullcount = 26;

	public const int Setcount = 27;

	public const int Branchcount = 28;

	public const int Lazybranchcount = 29;

	public const int Nullmark = 30;

	public const int Setmark = 31;

	public const int Capturemark = 32;

	public const int Getmark = 33;

	public const int Setjump = 34;

	public const int Backjump = 35;

	public const int Forejump = 36;

	public const int Testref = 37;

	public const int Goto = 38;

	public const int Prune = 39;

	public const int Stop = 40;

	public const int ECMABoundary = 41;

	public const int NonECMABoundary = 42;

	public const int Mask = 63;

	public const int Rtl = 64;

	public const int Back = 128;

	public const int Back2 = 256;

	public const int Ci = 512;

	public readonly int[] Codes;

	public readonly string[] Strings;

	public readonly int TrackCount;

	public readonly Hashtable Caps;

	public readonly int CapSize;

	public readonly RegexPrefix? FCPrefix;

	public readonly RegexBoyerMoore BMPrefix;

	public readonly int Anchors;

	public readonly bool RightToLeft;

	public RegexCode(int[] codes, List<string> stringlist, int trackcount, Hashtable caps, int capsize, RegexBoyerMoore bmPrefix, RegexPrefix? fcPrefix, int anchors, bool rightToLeft)
	{
		Codes = codes;
		Strings = stringlist.ToArray();
		TrackCount = trackcount;
		Caps = caps;
		CapSize = capsize;
		BMPrefix = bmPrefix;
		FCPrefix = fcPrefix;
		Anchors = anchors;
		RightToLeft = rightToLeft;
	}

	public static bool OpcodeBacktracks(int Op)
	{
		Op &= 0x3F;
		switch (Op)
		{
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 23:
		case 24:
		case 25:
		case 26:
		case 27:
		case 28:
		case 29:
		case 31:
		case 32:
		case 33:
		case 34:
		case 35:
		case 36:
		case 38:
			return true;
		default:
			return false;
		}
	}
}
