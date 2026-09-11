using System;

namespace T0World;

[Serializable]
public class T0InterationExitHalfLock : T0InterationFunctionDataBase
{
	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0WorldScene.Scene.player.ExitHalfLockMode();
		base.IsFinish = true;
	}
}
