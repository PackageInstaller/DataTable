using Cysharp.Threading.Tasks;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("完成任务", 0)]
[Category("✫ DragonLost/Task")]
[Description("用于标记指定任务为已完成。")]
public class UpdateTaskAction : ActionTaskBase
{
	[RequiredField]
	[Name("任务Id", 0)]
	[Description("要完成的任务的唯一标识符。")]
	public BBParameter<int> taskId;

	[Name("是否完成任务", 0)]
	[Description("回到回复是否完成任务。0代表没有收到回复不做任何处理 -1代表没有完成 1代表完成了")]
	public BBParameter<int> FinishTask = 0;

	private long requestTime;

	protected override async void OnExecute()
	{
		base.OnExecute();
		FinishTask.value = 0;
		if (taskId != null && taskId.value > 0)
		{
			if (!(await GetOwnerEntity().GetSystem<TaskSystem>().FinishTask(taskId.value)))
			{
				requestTime = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetRequestDataTime();
				TaskDataViewModel taskDataViewModel = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskId.value);
				if (taskDataViewModel == null)
				{
					return;
				}
				while (!taskDataViewModel.Finish)
				{
					await UniTask.WaitForSeconds(1);
					if (this == null)
					{
						return;
					}
					if (Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetRequestDataTime() != requestTime)
					{
						taskDataViewModel = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetTask(taskId.value);
						if (!taskDataViewModel.Finish)
						{
							FinishTask.value = -1;
							OnActionFinish();
							return;
						}
					}
				}
				FinishTask.value = 1;
				OnActionFinish();
			}
			else
			{
				FinishTask.value = 1;
				OnActionFinish();
			}
		}
		else
		{
			FinishTask.value = -1;
			OnActionFinish();
		}
	}
}
