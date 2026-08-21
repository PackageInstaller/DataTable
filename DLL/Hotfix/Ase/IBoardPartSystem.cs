namespace Ase;

public interface IBoardPartSystem
{
	BoardPartState HandlePartClick(BoardPartClickContext ctx);

	void HandlePartDrag(BoardPartDragContext ctx);
}
