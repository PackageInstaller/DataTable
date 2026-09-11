namespace System.Reflection;

[Flags]
public enum CallingConventions
{
	Standard = 1,
	VarArgs = 2,
	Any = Standard | VarArgs,
	HasThis = 0x20,
	ExplicitThis = 0x40
}
