using System.Collections.Generic;

public class GuildActivitySPNodeDataList
{
	public GuildActivitySPSelfData selfData;

	public List<GuildActivitySPNodeData> dataList;

	public GuildActivitySPNodeDataList()
	{
		selfData = new GuildActivitySPSelfData();
		dataList = new List<GuildActivitySPNodeData>();
	}
}
