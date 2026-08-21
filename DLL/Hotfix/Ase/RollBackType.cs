using System;

namespace Ase;

[Flags]
public enum RollBackType : byte
{
	Ignore = 0,
	SoftRollBack = 1,
	HardRollBack = 2
}
