using System;

namespace T0World;

[Serializable]
public class T0InterationTalkSetSubtitleMode : T0InterationFunctionDataBase
{
	public enum Mode
	{
		SingleSubtitle,
		MultipleSubtitle
	}

	public Mode mode;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		LuaHelper.CallFunction("T0WorldSetSubtitleDisplayMultiple", mode == Mode.MultipleSubtitle);
		base.IsFinish = true;
	}
}
