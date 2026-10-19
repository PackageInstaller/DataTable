using ACT.Model;

namespace ACT.Config.Action;

public class SetSelectPoolId : GuideStepAction
{
	public int PoolId;

	public override void Execute(GuideStepData data)
	{
		Model<CardDrawModel>.Interface.SetNextSelectPoolId(PoolId);
	}
}
