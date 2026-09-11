using System.Globalization;

namespace System;

internal ref struct DateTimeResult
{
	internal int Year;

	internal int Month;

	internal int Day;

	internal int Hour;

	internal int Minute;

	internal int Second;

	internal double fraction;

	internal int era;

	internal ParseFlags flags;

	internal TimeSpan timeZoneOffset;

	internal Calendar calendar;

	internal DateTime parsedDate;

	internal ParseFailureKind failure;

	internal string failureMessageID;

	internal object failureMessageFormatArgument;

	internal string failureArgumentName;

	internal ReadOnlySpan<char> originalDateTimeString;

	internal ReadOnlySpan<char> failedFormatSpecifier;

	internal void Init(ReadOnlySpan<char> originalDateTimeString)
	{
		this.originalDateTimeString = originalDateTimeString;
		Year = -1;
		Month = -1;
		Day = -1;
		fraction = -1.0;
		era = -1;
	}

	internal void SetDate(int year, int month, int day)
	{
		Year = year;
		Month = month;
		Day = day;
	}

	internal void SetBadFormatSpecifierFailure()
	{
		SetBadFormatSpecifierFailure(ReadOnlySpan<char>.Empty);
	}

	internal void SetBadFormatSpecifierFailure(ReadOnlySpan<char> failedFormatSpecifier)
	{
		failure = ParseFailureKind.FormatWithFormatSpecifier;
		failureMessageID = "Format specifier was invalid.";
		this.failedFormatSpecifier = failedFormatSpecifier;
	}

	internal void SetBadDateTimeFailure()
	{
		failure = ParseFailureKind.FormatWithOriginalDateTime;
		failureMessageID = "String was not recognized as a valid DateTime.";
		failureMessageFormatArgument = null;
	}

	internal void SetFailure(ParseFailureKind failure, string failureMessageID)
	{
		this.failure = failure;
		this.failureMessageID = failureMessageID;
		failureMessageFormatArgument = null;
	}

	internal void SetFailure(ParseFailureKind failure, string failureMessageID, object failureMessageFormatArgument)
	{
		this.failure = failure;
		this.failureMessageID = failureMessageID;
		this.failureMessageFormatArgument = failureMessageFormatArgument;
	}

	internal void SetFailure(ParseFailureKind failure, string failureMessageID, object failureMessageFormatArgument, string failureArgumentName)
	{
		this.failure = failure;
		this.failureMessageID = failureMessageID;
		this.failureMessageFormatArgument = failureMessageFormatArgument;
		this.failureArgumentName = failureArgumentName;
	}
}
