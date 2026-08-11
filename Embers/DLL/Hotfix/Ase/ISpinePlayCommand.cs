using System;

namespace Ase;

public interface ISpinePlayCommand
{
	bool OnExecute(ISpineAnimationPlayer player, string aniName, Action onActionFinish = null);

	bool HasAction(ISpineAnimationPlayer player, string aniName);
}
