using System;

namespace Ase;

public interface IBoardPartContextSource
{
	string PartId { get; }

	event Action<BoardPartClickContext> OnPartClick;

	event Action<BoardPartDragContext> OnPartDrag;
}
