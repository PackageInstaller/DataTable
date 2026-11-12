using UnityEngine;

[AddComponentMenu("触发器结果/玩家事件/大招满能量高亮", 3)]
public class Task_HintUltraButton : TaskCellBase
{
	public string buttonName;

	protected override void OnExecute()
	{
		if (string.IsNullOrEmpty(buttonName))
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("HintUltraButton", buttonName);
			EndAction();
		}
	}
}
