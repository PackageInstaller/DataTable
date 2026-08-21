using System;
using Pathfinding.Util;

namespace Pathfinding;

public class NavmeshTile : INavmeshHolder, INavmesh
{
	public int[] tris;

	public Int3[] verts;

	public Int3[] vertsInGraphSpace;

	public int x;

	public int z;

	public int w;

	public int d;

	public TriangleMeshNode[] nodes;

	public BBTree bbTree;

	public bool flag;

	public void GetTileCoordinates(int tileIndex, out int x, out int z)
	{
		x = this.x;
		z = this.z;
	}

	public int GetVertexArrayIndex(int index)
	{
		return index & 0xFFF;
	}

	public Int3 GetVertex(int index)
	{
		int num = index & 0xFFF;
		return verts[num];
	}

	public Int3 GetVertexInGraphSpace(int index)
	{
		return vertsInGraphSpace[index & 0xFFF];
	}

	public void GetNodes(Action<GraphNode> action)
	{
		if (nodes != null)
		{
			for (int i = 0; i < nodes.Length; i++)
			{
				action(nodes[i]);
			}
		}
	}

	internal void Destroy()
	{
		if (nodes.Length != 0)
		{
			int tileIndex = NavmeshBase.GetTileIndex(nodes[0].GetVertexIndex(0));
			uint graphIndex = nodes[0].GraphIndex;
			for (int i = 0; i < nodes.Length; i++)
			{
				TriangleMeshNode triangleMeshNode = nodes[i];
				if (triangleMeshNode.connections == null)
				{
					continue;
				}
				for (int j = 0; j < triangleMeshNode.connections.Length; j++)
				{
					if (triangleMeshNode.connections[j].node is TriangleMeshNode triangleMeshNode2 && triangleMeshNode2.GraphIndex == graphIndex && NavmeshBase.GetTileIndex(triangleMeshNode2.GetVertexIndex(0)) == tileIndex)
					{
						triangleMeshNode.connections[j].node = null;
					}
				}
			}
			for (int k = 0; k < nodes.Length; k++)
			{
				nodes[k].Destroy();
			}
		}
		nodes = null;
		ObjectPool<BBTree>.Release(ref bbTree);
	}
}
