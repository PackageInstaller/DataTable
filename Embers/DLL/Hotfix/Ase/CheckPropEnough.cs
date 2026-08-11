using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("检查背包中道具数量是否足够", 0)]
[Category("✫ DragonLost/Interactive")]
[Description("检查背包中道具数量是否足够，足够返回true")]
public class CheckPropEnough : ConditionTaskBase
{
	[Name("道具ID", 0)]
	[Description("道具ID。")]
	public BBParameter<int> PropId;

	[Name("道具数量", 0)]
	[Description("道具数量。")]
	public BBParameter<int> PropCount;

	protected override bool OnCheck()
	{
		base.OnCheck();
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(PropId.value);
		if (dataRow == null)
		{
			return false;
		}
		return Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().CheckEnough(new PropData(dataRow, PropCount.value));
	}
}
