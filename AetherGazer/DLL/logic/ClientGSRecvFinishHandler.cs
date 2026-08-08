using NetProcol;
using UnityEngine;

[MessageHandler(~AppType.Client, 135)]
public class ClientGSRecvFinishHandler : AMClientHandler<Op_B2C_Ack_BattleGSResult>
{
	protected override void Run(Op_B2C_Ack_BattleGSResult message)
	{
		Debug.Log((object)("============ClientGSRecvFinishHandler==============" + base.mCallback.mSimContext.GetSimInterface().mGSRecvBattleResultFinishEvent));
		if (base.mCallback.mSimContext.GetSimInterface().mGSRecvBattleResultFinishEvent != null)
		{
			base.mCallback.mSimContext.GetSimInterface().mGSRecvBattleResultFinishEvent(message.Code);
		}
	}
}
