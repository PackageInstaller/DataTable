using System.Collections.Generic;
using ACT.World;

namespace ACT.UI;

public interface IMapSelfNodeModel
{
	Dictionary<int, SelfNodeData> GetAllSelfNodes();

	List<SelfNodeData> GetSelfNodesByArea(MapArea area);

	SelfNodeData GetSelfNode(int id);

	bool AddSelfNode(SelfNodeData data);

	bool RemoveSelfNode(int id);

	int GetSelfNodeCount();

	int GetMaxSelfNodeCount();
}
