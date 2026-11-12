using System.Collections.Generic;
using System.Text;
using UnityEngine;

[AddComponentMenu("触发器结果/序章关卡与引导/按键解锁与关闭", 2)]
public class Task_EnableActionButton : TaskCellBase
{
	public List<string> names = new List<string>();

	public bool enable;

	public bool playHintEffect;

	protected override void OnExecute()
	{
		if (names == null || names.Count == 0)
		{
			LogWarning("未配置");
			EndAction(success: false);
			return;
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (string name in names)
		{
			stringBuilder.Append("+");
			stringBuilder.Append(name);
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("EnableBtnControl", stringBuilder.ToString(), enable, playHintEffect);
		EndAction();
	}
}
