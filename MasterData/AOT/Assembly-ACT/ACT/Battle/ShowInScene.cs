using System.Linq;
using ACT.Core;
using Fundamental;

namespace ACT.Battle;

public class ShowInScene : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return !RuntimeConfigs.data.game.SmallItemShow.Contains(Singleton<GameManager>.instance.worldManager.ActiveWorldId);
	}

	public override int GetCompleteCount(int[] param)
	{
		return 0;
	}

	public override float GetCompletePercent(int[] param)
	{
		return 0f;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
