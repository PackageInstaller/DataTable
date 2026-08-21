using UnityEngine;

namespace Ase;

[Trigger("更新任务ui标点")]
public class ChangeTaskUIPositionTrigger : BaseTrigger
{
	public int TaskId;

	public int Index;

	public Vector3 ChangePos;

	public override string TriggerName => "更新任务ui标点触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().ChangeTaskUIPosition(TaskId, Index, ChangePos);
	}
}
