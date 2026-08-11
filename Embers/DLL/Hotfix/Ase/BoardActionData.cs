using System.Collections.Generic;

namespace Ase;

public struct BoardActionData(DRBoardSpine drBoardSpine, ISpinePlayCommand playCommand)
{
	public List<int> BoardHeroId = drBoardSpine.BoardHeroId;

	public string ActionIndex = drBoardSpine.ActionIndex;

	public bool CanBreak = drBoardSpine.CanBreak;

	public ISpinePlayCommand PlayCommand = playCommand;
}
