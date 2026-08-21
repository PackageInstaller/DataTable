using System;
using P08Main.Loading;

namespace T0World;

[Serializable]
public class T0InterationAddBalckShow : T0InterationFunctionDataBase
{
	public bool isShow = true;

	private const string Lua_ShowBlackFunc = "T0AddBlackShow";

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		BaseT0Gameloading loadingInst = T0WorldCreator.GetLoadingInst();
		if (loadingInst == null)
		{
			base.IsFinish = true;
			return;
		}
		if (isShow)
		{
			if (!loadingInst.hasLoading)
			{
				loadingInst.ShowLoadUI();
			}
		}
		else if (loadingInst.hasLoading)
		{
			loadingInst.CloseLoadUI();
		}
		base.IsFinish = true;
	}
}
