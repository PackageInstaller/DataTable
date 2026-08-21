using System.Runtime.Serialization;

namespace System.Globalization;

[Serializable]
internal class EraInfo
{
	internal int era;

	internal long ticks;

	internal int yearOffset;

	internal int minEraYear;

	internal int maxEraYear;

	[OptionalField(VersionAdded = 4)]
	internal string eraName;

	[OptionalField(VersionAdded = 4)]
	internal string abbrevEraName;

	[OptionalField(VersionAdded = 4)]
	internal string englishEraName;

	internal EraInfo(int era, int startYear, int startMonth, int startDay, int yearOffset, int minEraYear, int maxEraYear)
	{
		this.era = era;
		this.yearOffset = yearOffset;
		this.minEraYear = minEraYear;
		this.maxEraYear = maxEraYear;
		ticks = new DateTime(startYear, startMonth, startDay).Ticks;
	}

	internal EraInfo(int era, int startYear, int startMonth, int startDay, int yearOffset, int minEraYear, int maxEraYear, string eraName, string abbrevEraName, string englishEraName)
	{
		this.era = era;
		this.yearOffset = yearOffset;
		this.minEraYear = minEraYear;
		this.maxEraYear = maxEraYear;
		ticks = new DateTime(startYear, startMonth, startDay).Ticks;
		this.eraName = eraName;
		this.abbrevEraName = abbrevEraName;
		this.englishEraName = englishEraName;
	}
}
