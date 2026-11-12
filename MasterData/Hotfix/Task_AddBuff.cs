using UnityEngine;

[AddComponentMenu("触发器结果/AI与技能/添加Buff事件", 0)]
public class Task_AddBuff : TaskCellBase
{
	public int id;

	public int groupID;

	protected override void OnExecute()
	{
		if (id <= 0 && groupID <= 0)
		{
			LogWarning("未配置");
			EndAction(success: false);
		}
		else
		{
			Singleton<BuffManager>.Instance.AddBuffToTarget(id, groupID);
			EndAction();
		}
	}
}
