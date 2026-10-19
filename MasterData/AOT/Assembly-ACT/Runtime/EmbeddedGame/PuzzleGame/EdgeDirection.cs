using System;

namespace Runtime.EmbeddedGame.PuzzleGame;

[Flags]
public enum EdgeDirection
{
	None = 0,
	Top = 1,
	Right = 2,
	Bottom = 4,
	Left = 8
}
