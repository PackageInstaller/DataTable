using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("更新任务存档状态", 0)]
[Category("✫ DragonLost/Task")]
[Description("用于更新指定任务的存档状态。")]
public class UpdateTaskStateAction : ActionTaskBase
{
	[RequiredField]
	[Name("任务Id", 0)]
	[Description("要更新状态的任务的唯一标识符。")]
	public BBParameter<int> taskId;

	[RequiredField]
	[Name("状态索引", 0)]
	[Description("要更新的状态的索引。")]
	public BBParameter<int> stateIndex;

	[RequiredField]
	[Name("状态", 0)]
	[Description("要更新的状态的值。")]
	public BBParameter<string> stateValue;

	[Name("保存存档", 0)]
	[Description("是否要保存存档")]
	public bool IsSaveData = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetSystem<TaskSystem>().UpdateTaskState(taskId.value, stateIndex.value, stateValue.value);
		if (IsSaveData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(GetOwnerEntity().GetSystem<SceneSystem>().GetLevelId());
		}
		OnActionFinish();
	}
}
