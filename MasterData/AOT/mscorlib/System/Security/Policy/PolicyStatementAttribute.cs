namespace System.Security.Policy;

[Flags]
public enum PolicyStatementAttribute
{
	All = 3,
	Exclusive = 1,
	LevelFinal = 2,
	Nothing = 0
}
