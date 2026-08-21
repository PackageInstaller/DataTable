using System;

namespace Ase;

public class SpinePlayCommand : ISpinePlayCommand
{
	public bool HasAction(ISpineAnimationPlayer player, string aniName)
	{
		return player.HasAction(aniName);
	}

	public bool OnExecute(ISpineAnimationPlayer player, string aniName, Action onActionFinish = null)
	{
		return player.PlayAction(aniName, onActionFinish);
	}
}
