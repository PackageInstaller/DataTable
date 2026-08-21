namespace Ase;

public class CloseTeachTaskBuff : BuffOperationBase<BuffDataCloseTeachTask>
{
	protected override void OnExecute()
	{
		base.buffOwner.GetSystem<TeachGuideSystem>()?.CloseTeachTask(dataBase.teachTaskId);
	}
}
