using System.Collections.Generic;

namespace Ase;

[Trigger("检查任务道具区域触发器")]
public class CheckTaskPropTrigger : BaseTrigger
{
	public MapItemNode targetMapItem;

	public bool anyMode = true;

	public List<int> TaskPropIdList;

	public override string TriggerName => "检查任务道具区域触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		KnapsackViewModel knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		bool value = !anyMode;
		foreach (int taskPropId in TaskPropIdList)
		{
			bool flag = knapsackViewModel.GetProp(taskPropId) != null;
			if (anyMode & flag)
			{
				value = true;
				break;
			}
			if (!anyMode && !flag)
			{
				value = false;
				break;
			}
		}
		targetMapItem.SendParadoxMessage("TaskCheck", MapDataNodeParadoxParameter.CreateBoolParameter(value));
	}
}
