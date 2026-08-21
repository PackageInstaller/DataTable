namespace Ase;

public class SetTimeTaskBuff : BuffOperationBase<BuffDataSetTimeTask>
{
	protected override void OnExecute()
	{
		base.buffOwner.GetSystem<TeachGuideSystem>()?.SetTimeTaskFinish(dataBase.isSuccess);
	}
}
