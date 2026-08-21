using GameFramework.Runtime;

namespace Ase;

public class WorldPauseMessenger : MessageBase
{
	private uint worldId;

	private bool pause;

	private bool transition;

	private bool allPause;

	public uint WorldId => worldId;

	public bool Pause => pause;

	public bool Transition => transition;

	public bool AllPause => allPause;

	public WorldPauseMessenger(object sender, uint worldId, bool pause, bool transition = false)
		: base(sender)
	{
		this.worldId = worldId;
		this.pause = pause;
		this.transition = transition;
	}

	public WorldPauseMessenger(object sender, bool pause, bool allPause, bool transition = false)
		: base(sender)
	{
		this.pause = pause;
		this.allPause = allPause;
		this.transition = transition;
	}
}
