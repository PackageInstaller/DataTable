using UnityEngine;

[AddComponentMenu("触发器结果/AI与技能/执行或关闭AI", 0)]
public class Task_OperateAI : TaskCellBase
{
	public enum OperateAIType
	{
		[InspectorName("执行")]
		START,
		[InspectorName("关闭")]
		DISABLE
	}

	public OperateAIType operateType;

	public string aiTypeString;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(aiTypeString))
		{
			EndAction(success: false);
			return;
		}
		switch (operateType)
		{
		case OperateAIType.START:
			Singleton<TriggerManager>.Instance?.StartTriggerAI(aiTypeString);
			break;
		case OperateAIType.DISABLE:
			Singleton<TriggerManager>.Instance?.DisableTriggerAI(aiTypeString);
			break;
		}
		EndAction();
	}
}
