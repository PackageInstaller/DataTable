using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace Ase.Paradox;

[Name("修改列表", 0)]
[Description("对列表进行添加、删除、获取等操作")]
[Category("✫ DragonLost/Operation")]
[Preserve]
public class OperationList<T> : ActionTaskBase
{
	[Name("值", 0)]
	[Description("要添加或设置的元素值")]
	public BBParameter<T> element;

	[Name("索引", 0)]
	[Description("要操作的元素索引")]
	public BBParameter<int> index;

	[Name("具体操作", 0)]
	[Description("要执行的列表操作类型")]
	public ListOperationType OperationType;

	[Name("操作对象", 0)]
	[Description("要进行操作的列表")]
	public BBParameter<List<T>> targetList;

	protected override string info => GetNodeInfo();

	protected override void OnExecute()
	{
		base.OnExecute();
		if (targetList == null || targetList.value == null)
		{
			EndAction();
			return;
		}
		if (OperationType != ListOperationType.ADD && OperationType != ListOperationType.CLEAR && OperationType != ListOperationType.DISRUPTED && OperationType != ListOperationType.GET && (index.value < 0 || index.value >= targetList.value.Count))
		{
			EndAction();
			return;
		}
		switch (OperationType)
		{
		case ListOperationType.ADD:
			if (!targetList.value.Contains(element.value))
			{
				if (index.value < 0 || index.value >= targetList.value.Count)
				{
					targetList.value.Add(element.value);
				}
				else
				{
					targetList.value.Insert(index.value, element.value);
				}
			}
			OnActionFinish();
			break;
		case ListOperationType.SUB:
			targetList.value.RemoveAt(index.value);
			OnActionFinish();
			break;
		case ListOperationType.SUB_VALUE:
			targetList.value.Remove(element.value);
			OnActionFinish();
			break;
		case ListOperationType.GET:
			if (index.value >= 0 && index.value < targetList.value.Count)
			{
				element.value = targetList.value[index.value];
			}
			OnActionFinish();
			break;
		case ListOperationType.SET:
			if (index.value >= 0 && index.value < targetList.value.Count)
			{
				targetList.value[index.value] = element.value;
			}
			OnActionFinish();
			break;
		case ListOperationType.CLEAR:
			targetList.value.Clear();
			OnActionFinish();
			break;
		case ListOperationType.DISRUPTED:
			Shuffle(targetList.value);
			OnActionFinish();
			break;
		}
	}

	private void Shuffle(List<T> list)
	{
		int num = list.Count;
		while (num > 1)
		{
			num--;
			int num2 = ownerEntity.RandomInt(0, num + 1);
			T value = list[num2];
			list[num2] = list[num];
			list[num] = value;
		}
	}

	private string GetNodeInfo()
	{
		string text = "修改列表" + typeof(T).Name;
		if (targetList == null)
		{
			return text;
		}
		string text2 = targetList.name;
		string text3 = "";
		ListOperationType operationType = OperationType;
		if (operationType == ListOperationType.ADD || operationType == ListOperationType.SUB || operationType == ListOperationType.GET || operationType == ListOperationType.SET)
		{
			text3 = $"({index.value})";
		}
		string text4 = "";
		operationType = OperationType;
		if (operationType == ListOperationType.ADD || operationType == ListOperationType.SET || operationType == ListOperationType.SUB_VALUE)
		{
			text4 = $"[{element.value}]";
		}
		return text + " " + text2 + " " + text3 + " " + OperationType.ToString() + " " + text4;
	}
}
