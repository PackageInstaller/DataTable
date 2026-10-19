using ACT.Net;
using Fundamental;

namespace ACT;

internal class DisconnectNetwork : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		if (Singleton<NetManager>.HasInstance())
		{
			Singleton<NetManager>.instance.Disconnect(NetDisconnectReason.WorldDestroyed);
			ContextManager.DestroyContext(Singleton<NetManager>.instance);
		}
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
