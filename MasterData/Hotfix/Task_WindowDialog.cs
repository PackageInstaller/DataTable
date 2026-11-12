using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/调用指定UI提示", 9)]
public class Task_WindowDialog : TaskCellBase
{
	public string dialogID;

	public float time = 0.5f;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(dialogID))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("BattlePopupTips", dialogID, time, a3: true);
			EndAction();
		}
	}
}
