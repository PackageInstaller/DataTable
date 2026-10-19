using ACT.Event;
using ACT.UI;
using Fundamental;

namespace ACT;

internal class DestroyUIAndManagers : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		Singleton<NewUIManager>.instance.Reset();
		Singleton<NewUIManager>.instance.UidTxt.gameObject.SetActive(value: false);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Game_Over, null);
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
