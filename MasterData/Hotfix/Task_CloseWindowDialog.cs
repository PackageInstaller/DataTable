using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/关闭UI提示", 10)]
public class Task_CloseWindowDialog : TaskCellBase
{
	protected override void OnExecute()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("BattlePopupTips", 0, 0, a3: false);
		EndAction();
	}
}
