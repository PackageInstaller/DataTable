namespace System.Reflection;

[Serializable]
[Flags]
internal enum PInvokeAttributes
{
	NoMangle = 1,
	CharSetMask = 6,
	CharSetNotSpec = 0,
	CharSetAnsi = 2,
	CharSetUnicode = 4,
	CharSetAuto = CharSetMask,
	BestFitUseAssem = 0,
	BestFitEnabled = 0x10,
	BestFitDisabled = 0x20,
	BestFitMask = BestFitEnabled | BestFitDisabled,
	ThrowOnUnmappableCharUseAssem = 0,
	ThrowOnUnmappableCharEnabled = 0x1000,
	ThrowOnUnmappableCharDisabled = 0x2000,
	ThrowOnUnmappableCharMask = ThrowOnUnmappableCharEnabled | ThrowOnUnmappableCharDisabled,
	SupportsLastError = 0x40,
	CallConvMask = 0x700,
	CallConvWinapi = 0x100,
	CallConvCdecl = 0x200,
	CallConvStdcall = 0x300,
	CallConvThiscall = 0x400,
	CallConvFastcall = 0x500,
	MaxValue = 0xFFFF
}
