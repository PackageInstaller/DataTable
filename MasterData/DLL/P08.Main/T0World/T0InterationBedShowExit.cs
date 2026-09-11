using System;

namespace T0World;

[Serializable]
public class T0InterationBedShowExit : T0InterationBedSelectBase
{
	public override T0BedClickType GetSelectType()
	{
		return T0BedClickType.EXIT_HANDLE;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		base.StartEvent(behaviour);
		T0BedGame.bedGame.ShowExitBtn(isShow: true);
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
		T0BedGame.bedGame.ShowExitBtn(isShow: false);
	}

	public override void DisposeEvent()
	{
		T0BedGame.bedGame.ShowExitBtn(isShow: false);
	}
}
