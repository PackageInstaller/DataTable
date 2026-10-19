using System;

namespace ACT.Battle;

[Flags]
public enum GameInputState
{
	None = 0,
	Battle = 1,
	Guide = 2,
	Loading = 4,
	Login = 8,
	Pay = 0x10
}
