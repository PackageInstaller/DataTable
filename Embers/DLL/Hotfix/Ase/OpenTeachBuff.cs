namespace Ase;

public class OpenTeachBuff : BuffOperationBase<BuffDataOpenTeach>
{
	protected override void OnExecute()
	{
		int teachGuideId = dataBase.teachGuideId;
		base.buffOwner.GetSystem<TeachGuideSystem>()?.StartNewTeach(teachGuideId, dataBase.coverCureentTeach == 1);
	}
}
