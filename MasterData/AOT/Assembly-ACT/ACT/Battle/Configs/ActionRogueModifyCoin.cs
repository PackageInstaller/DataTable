using System;
using ACT.Net;
using Fundamental;
using Google.Protobuf;
using Pb;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Rogue金币", "Action", new string[] { "rogue", "modify", "coin" })]
public class ActionRogueModifyCoin : ConfigAction
{
	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		float num = value.Return(memory);
		RogueModifyCoinReq rogueModifyCoinReq = new RogueModifyCoinReq();
		rogueModifyCoinReq.IsAdd = num > 0f;
		rogueModifyCoinReq.CoinNum = (int)Math.Abs(num);
		Singleton<NetManager>.instance.Request(rogueModifyCoinReq, async (IMessage msg) =>
		{
			if (msg is RogueModifyCoinAck && LuminApplication.LogEnabled)
			{
				Debug.LogError("RogueModifyCoinAck");
			}
		});
	}
}
