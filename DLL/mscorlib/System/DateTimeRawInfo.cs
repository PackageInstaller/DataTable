namespace System;

internal struct DateTimeRawInfo
{
	private unsafe int* num;

	internal int numCount;

	internal int month;

	internal int year;

	internal int dayOfWeek;

	internal int era;

	internal DateTimeParse.TM timeMark;

	internal double fraction;

	internal bool hasSameDateAndTimeSeparators;

	internal unsafe void Init(int* numberBuffer)
	{
		month = -1;
		year = -1;
		dayOfWeek = -1;
		era = -1;
		timeMark = DateTimeParse.TM.NotSet;
		fraction = -1.0;
		num = numberBuffer;
	}

	internal unsafe void AddNumber(int value)
	{
		num[numCount++] = value;
	}

	internal unsafe int GetNumber(int index)
	{
		return num[index];
	}
}
