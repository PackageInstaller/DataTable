using GameFramework.Runtime;

namespace Ase;

public class TaskRewardsReceiveMessager : MessageBase
{
	public PbDropThing Rewards;

	public TaskRewardsReceiveMessager(object sender, PbDropThing rewards)
		: base(sender)
	{
		Rewards = rewards;
	}
}
