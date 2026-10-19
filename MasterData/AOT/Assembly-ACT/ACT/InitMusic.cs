using ACT.Event;
using ACT.Game;
using ACT.Net;
using Fundamental;

namespace ACT;

internal class InitMusic : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		SexChange evt = Singleton<EventManager>.instance.GetEvt<SexChange>();
		evt.Sex = (Sex)G.detailUserInfo.Brief.Gender;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnSexChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
