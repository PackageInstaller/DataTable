using System;

namespace Unity.VisualScripting.Dependencies.NCalc;

[Flags]
public enum EvaluateOptions
{
	None = 1,
	IgnoreCase = 2,
	NoCache = 4,
	IterateParameters = 8,
	RoundAwayFromZero = 0x10
}
