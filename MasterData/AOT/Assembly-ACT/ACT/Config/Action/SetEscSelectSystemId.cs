using ACT.Model;

namespace ACT.Config.Action;

public class SetEscSelectSystemId : GuideStepAction
{
	public int EscSelectSystemId;

	public override void Execute(GuideStepData data)
	{
		Model<EscModel>.Interface.SetEscSelectSystemId(EscSelectSystemId);
	}
}
