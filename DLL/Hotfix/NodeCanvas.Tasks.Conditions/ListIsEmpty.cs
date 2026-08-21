#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard/Lists")]
public class ListIsEmpty : ConditionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<IList> targetList;

	protected override string info => $"{targetList} Is Empty";

	protected override bool OnCheck()
	{
		Log.Error("ListIsEmpty 弃用 => 改为 TListIsEmpty具体类型  所在行为树 => $" + base.agent?.name + "  正在操作的变量名字 ： " + targetList?.name + " ");
		BBParameter<IList> bBParameter = targetList;
		if (bBParameter == null)
		{
			return false;
		}
		return bBParameter.value.Count == 0;
	}
}
