namespace Pathfinding;

public interface INavmeshHolder
{
	Int3 GetVertex(int i);

	Int3 GetVertexInGraphSpace(int i);

	int GetVertexArrayIndex(int index);

	void GetTileCoordinates(int tileIndex, out int x, out int z);
}
