using System;

namespace Ase;

public class SpineDefaultTrackPlayCommand : ISpinePlayCommand
{
	public bool OnExecute(ISpineAnimationPlayer player, string aniName, Action onActionFinish = null)
	{
		return player.PlayLegacyAction(aniName, 0, onActionFinish);
	}

	public bool HasAction(ISpineAnimationPlayer player, string aniName)
	{
		return true;
	}
}
