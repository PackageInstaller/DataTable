using System;

namespace UnityEngine;

public enum TouchScreenKeyboardType
{
	Default,
	ASCIICapable,
	NumbersAndPunctuation,
	URL,
	NumberPad,
	PhonePad,
	NamePhonePad,
	EmailAddress,
	[Obsolete("Wii U is no longer supported as of Unity 2018.1.")]
	NintendoNetworkAccount,
	Social,
	Search,
	DecimalPad,
	OneTimeCode
}
