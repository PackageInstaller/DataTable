namespace System.Reflection;

[Flags]
public enum MethodAttributes
{
	MemberAccessMask = 7,
	PrivateScope = 0,
	Private = 1,
	FamANDAssem = 2,
	Assembly = 3,
	Family = 4,
	FamORAssem = 5,
	Public = 6,
	Static = 0x10,
	Final = 0x20,
	Virtual = 0x40,
	HideBySig = 0x80,
	CheckAccessOnOverride = 0x200,
	VtableLayoutMask = 0x100,
	ReuseSlot = 0,
	NewSlot = VtableLayoutMask,
	Abstract = 0x400,
	SpecialName = 0x800,
	PinvokeImpl = 0x2000,
	UnmanagedExport = 8,
	RTSpecialName = 0x1000,
	HasSecurity = 0x4000,
	RequireSecObject = 0x8000,
	ReservedMask = RTSpecialName | HasSecurity | RequireSecObject
}
