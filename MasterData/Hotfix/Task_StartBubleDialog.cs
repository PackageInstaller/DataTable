using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/开始冒泡对话", 1)]
public class Task_StartBubleDialog : TaskCellBase
{
	private const string AvgBubbleStart = "AvgBubbleStart";

	public string dialogID;

	public int groupID;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(dialogID))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("AvgBubbleStart", dialogID, groupID);
			EndAction();
		}
	}
}
