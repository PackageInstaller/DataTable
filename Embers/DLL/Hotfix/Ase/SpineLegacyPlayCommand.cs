using System;

namespace Ase;

public class SpineLegacyPlayCommand : ISpinePlayCommand
{
	public bool OnExecute(ISpineAnimationPlayer player, string aniName, Action onActionFinish = null)
	{
		return player.PlayLegacyAction(aniName, onActionFinish);
	}

	public bool HasAction(ISpineAnimationPlayer player, string aniName)
	{
		return true;
	}
}
