namespace Ase;

public enum WorldUpdateType : byte
{
	Local = 1,
	Authority,
	RollBack,
	All
}
