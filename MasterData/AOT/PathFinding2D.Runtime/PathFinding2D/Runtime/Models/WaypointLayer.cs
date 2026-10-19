using System;
using System.ComponentModel;

namespace PathFinding2D.Runtime.Models;

[Flags]
[DefaultValue(1)]
public enum WaypointLayer
{
	Layer0 = 1,
	Layer1 = 2,
	Layer2 = 4,
	Layer3 = 8,
	Layer4 = 0x10,
	Layer5 = 0x20,
	Layer6 = 0x40,
	Layer7 = 0x80,
	Layer8 = 0x100,
	Layer9 = 0x200,
	Layer10 = 0x400,
	Layer11 = 0x800,
	Layer12 = 0x1000,
	Layer13 = 0x2000,
	Layer14 = 0x4000,
	Layer15 = 0x8000,
	Layer16 = 0x10000,
	Layer17 = 0x20000,
	Layer18 = 0x40000,
	Layer19 = 0x80000,
	Layer20 = 0x100000,
	Layer21 = 0x200000,
	Layer22 = 0x400000,
	Layer23 = 0x800000,
	Layer24 = 0x1000000,
	Layer25 = 0x2000000,
	Layer26 = 0x4000000,
	Layer27 = 0x8000000,
	Layer28 = 0x10000000,
	Layer29 = 0x20000000,
	Layer30 = 0x40000000,
	Layer31 = ~(Layer0 | Layer1 | Layer2 | Layer3 | Layer4 | Layer5 | Layer6 | Layer7 | Layer8 | Layer9 | Layer10 | Layer11 | Layer12 | Layer13 | Layer14 | Layer15 | Layer16 | Layer17 | Layer18 | Layer19 | Layer20 | Layer21 | Layer22 | Layer23 | Layer24 | Layer25 | Layer26 | Layer27 | Layer28 | Layer29 | Layer30)
}
