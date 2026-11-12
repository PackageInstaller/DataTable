using System;

[Flags]
public enum LostControlType : uint
{
	None = 0u,
	Stiff = 1u,
	KnockBack = 2u,
	AirBorne = 4u
}
