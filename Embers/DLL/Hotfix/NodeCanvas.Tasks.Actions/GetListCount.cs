#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
public class GetListCount : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<IList> targetList;

	[BlackboardOnly]
	public BBParameter<int> saveAs;

	protected override string info => $"{saveAs} = {targetList}.Count";

	protected override void OnExecute()
	{
		if (targetList.value == null)
		{
			Log.Error("获取列表长度:节点报错");
			EndAction(success: true);
		}
		else
		{
			saveAs.value = targetList.value.Count;
			EndAction(success: true);
		}
	}
}
