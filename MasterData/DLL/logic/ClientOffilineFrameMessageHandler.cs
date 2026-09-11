using NetProcol;

[MessageHandler(~AppType.Client, 145)]
public class ClientOffilineFrameMessageHandler : AMClientHandler<Op_B2C_Player_Offline>
{
	protected override void Run(Op_B2C_Player_Offline message)
	{
		if (base.mCallback.mSimContext.sEntityWorldState != null)
		{
			base.mCallback.mSimContext.sEntityWorldState.status.m_offlineMember = message.OfflineMember;
			base.mCallback.mSimContext.sEntityWorldState.status.m_hasOffline = true;
		}
	}
}
