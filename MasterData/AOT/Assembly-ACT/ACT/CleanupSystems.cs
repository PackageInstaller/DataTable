using ACT.Battle;

namespace ACT;

internal class CleanupSystems : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		MonoECS.instance.CleanupOnDestroy();
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
