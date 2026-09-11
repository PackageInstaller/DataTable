using System.Collections.Generic;

public class GuildActivityNodeDataList
{
	public GuildActivitySelfData selfData;

	public List<GuildActivityNodeData> dataList;

	public GuildActivityNodeDataList()
	{
		selfData = new GuildActivitySelfData();
		dataList = new List<GuildActivityNodeData>();
	}
}
