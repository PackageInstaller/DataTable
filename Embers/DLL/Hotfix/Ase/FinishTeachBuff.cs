namespace Ase;

public class FinishTeachBuff : BuffOperationBase<BuffDataFinishTeach>
{
	protected override void OnExecute()
	{
		int teachGuideId = dataBase.teachGuideId;
		base.buffOwner.GetSystem<TeachGuideSystem>()?.ForceFinshTaskGroup(teachGuideId);
	}
}
