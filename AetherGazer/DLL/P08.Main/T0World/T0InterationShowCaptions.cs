using System;

namespace T0World;

[Serializable]
public class T0InterationShowCaptions : T0InterationFunctionDataBase
{
	public string tipsKey = string.Empty;

	public bool isShow = true;

	public bool isLinkMainLine;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		LuaHelper.CallFunction("T0WorldShowCaptions", isShow, tipsKey);
		if (isLinkMainLine)
		{
			if (!isShow)
			{
				AudioManager.Instance.Stop("voice");
			}
			base.IsFinish = true;
		}
	}

	public override void DisposeEvent()
	{
	}
}
