using System.Globalization;

namespace System;

internal struct ParsingInfo
{
	internal Calendar calendar;

	internal int dayOfWeek;

	internal DateTimeParse.TM timeMark;

	internal bool fUseHour12;

	internal bool fUseTwoDigitYear;

	internal bool fAllowInnerWhite;

	internal bool fAllowTrailingWhite;

	internal bool fCustomNumberParser;

	internal DateTimeParse.MatchNumberDelegate parseNumberDelegate;

	internal void Init()
	{
		dayOfWeek = -1;
		timeMark = DateTimeParse.TM.NotSet;
	}
}
