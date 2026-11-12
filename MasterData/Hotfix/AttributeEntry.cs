using System;
using Nova.Client;
using TrueSync;

public struct AttributeEntry
{
	private FDP origin;

	private FDP baseAmend;

	private FDP percentAmend;

	private FDP absAmend;

	public readonly FDP Origin => origin;

	public readonly FDP BaseValue => origin + baseAmend;

	public readonly FDP AmendValue => (origin + baseAmend) * (FDP.One + percentAmend) + absAmend;

	public void Clear()
	{
		origin = FDP.Zero;
		baseAmend = FDP.Zero;
		percentAmend = FDP.Zero;
		absAmend = FDP.Zero;
	}

	public void SetOrigin(FDP o)
	{
		origin = o;
	}

	public void ChangeValue(HotfixEnum.parameterType subType, FDP val)
	{
		switch (subType)
		{
		case HotfixEnum.parameterType.BASE_VALUE:
			baseAmend += val;
			break;
		case HotfixEnum.parameterType.PERCENTAGE:
			percentAmend += val;
			break;
		case HotfixEnum.parameterType.ABSOLUTE_VALUE:
			absAmend += val;
			break;
		}
	}

	public readonly FDP GetAmendValue(HotfixEnum.parameterType subType)
	{
		return subType switch
		{
			HotfixEnum.parameterType.BASE_VALUE => baseAmend, 
			HotfixEnum.parameterType.PERCENTAGE => percentAmend, 
			HotfixEnum.parameterType.ABSOLUTE_VALUE => absAmend, 
			_ => throw new NotImplementedException(), 
		};
	}

	public void CopyValueFrom(AttributeEntry from)
	{
		origin = from.origin;
		baseAmend = from.baseAmend;
		percentAmend = from.percentAmend;
		absAmend = from.absAmend;
	}

	public void AddValueFrom(AttributeEntry from)
	{
		origin += from.origin;
		baseAmend += from.baseAmend;
		percentAmend += from.percentAmend;
		absAmend += from.absAmend;
	}

	public Recorder.Types.Attribute ToMessage()
	{
		return new Recorder.Types.Attribute
		{
			Origin = origin.AsDouble(),
			BaseAmend = baseAmend.AsDouble(),
			PercentAmend = percentAmend.AsDouble(),
			AbsAmend = absAmend.AsDouble()
		};
	}
}
