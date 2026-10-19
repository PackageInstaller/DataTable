using System.Collections.Generic;

namespace ACT.UI;

public class MissionTipData : BaseTipData
{
	public string tableName = "Common";

	public int localizeId;

	public List<string> variableList;

	public float duration;
}
