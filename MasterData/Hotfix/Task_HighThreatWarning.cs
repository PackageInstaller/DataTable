using UnityEngine;

[AddComponentMenu("触发器结果/关卡事件/高威胁怪出现预警", 0)]
public class Task_HighThreatWarning : TaskCellBase
{
	protected override void OnExecute()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("Show_HighThreat_Warning");
		EndAction();
	}
}
