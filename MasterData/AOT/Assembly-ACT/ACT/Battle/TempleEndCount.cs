using ACT.Model;

namespace ACT.Battle;

public class TempleEndCount : PreconditionInfo
{
	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}

	public override int GetCompleteCount(int[] param)
	{
		if (!Model<TempleModel>.HasInstance())
		{
			Model<TempleModel>.CreateModel();
		}
		return Model<TempleModel>.Interface.AllCompletedCount();
	}

	public override bool IsComplete(int[] param)
	{
		if (!Model<TempleModel>.HasInstance())
		{
			Model<TempleModel>.CreateModel();
		}
		return Model<TempleModel>.Interface.AllCompletedCount() >= param[0];
	}
}
