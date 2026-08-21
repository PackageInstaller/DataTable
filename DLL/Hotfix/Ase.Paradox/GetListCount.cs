using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取列表长度", 0)]
[Category("✫ Blackboard/Lists")]
public class GetListCount<T> : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	[BlackboardOnly]
	public BBParameter<int> saveAs;

	protected override string info => $"{saveAs} = {targetList}.Count  类型 ： {typeof(T).Name}";

	protected override void OnExecute()
	{
		if (targetList?.value == null)
		{
			EndAction(success: true);
			return;
		}
		saveAs.value = targetList.value.Count;
		EndAction(success: true);
	}
}
