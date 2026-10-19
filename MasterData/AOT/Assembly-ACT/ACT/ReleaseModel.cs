using ACT.Game;
using ACT.UI;
using Fundamental;

namespace ACT;

internal class ReleaseModel : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		G.service?.SetNetState(IGameService.NetState.Disconnect);
		ContextManager.ResetAll(ContextType.GAME);
		ContextManager.ResetAll(ContextType.NET);
		Singleton<NewUIManager>.instance.UidTxt.gameObject.SetActive(value: false);
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
