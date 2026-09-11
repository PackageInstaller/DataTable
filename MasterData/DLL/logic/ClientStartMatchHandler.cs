using System.Collections.Generic;
using Config;
using NetProcol;
using UnityEngine;

[MessageHandler(~AppType.Client, 125)]
public class ClientStartMatchHandler : AMClientHandler<Op_B2C_start_match>
{
	protected override void Run(Op_B2C_start_match message)
	{
		Debug.Log((object)"=============比赛开始=============");
		if (message.RoomKey != 0L)
		{
			Dictionary<MemberPosition, RemoteMember> mRoomMembers = base.mCallback.mSimContext.sEntityWorldState.status.mRoomMembers;
			Dictionary<MemberPosition, RemoteMember>.Enumerator enumerator = mRoomMembers.GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.Value.mNetID = -1L;
			}
			IEnumerator<KeyValuePair<ulong, MatchMember>> enumerator2 = message.PlayerNetId.GetEnumerator();
			while (enumerator2.MoveNext())
			{
				KeyValuePair<ulong, MatchMember> current = enumerator2.Current;
				MemberPosition pos = (MemberPosition)current.Value.Pos;
				if (mRoomMembers.TryGetValue(pos, out var value))
				{
					value.mNetID = current.Value.NetID;
				}
			}
		}
		ClientSimulator.Instance.mSimContext.PostEvent(EntityTriggerEvent.Claim(TriggerEventType.MapInit));
		ClientSimulator.Instance.StartSim();
	}
}
