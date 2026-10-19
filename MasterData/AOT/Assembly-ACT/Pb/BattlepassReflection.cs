using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class BattlepassReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static BattlepassReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("ChBiYXR0bGVwYXNzLnByb3RvEgJwYhoMY29tbW9uLnByb3RvInYKDUJhdHRs" + "ZVBhc3NOdGYSLQoOYmF0dGxlUGFzc0luZm8YASABKAsyFS5wYi5CYXR0bGVQ" + "YXNzRGJNb2RlbBIbChNiYXR0bGVQYXNzQmVnaW5UaW1lGAIgASgDEhkKEWJh" + "dHRsZVBhc3NFbmRUaW1lGAMgASgDIikKFUJhdHRsZVBhc3NCdXlMZXZlbFJl" + "cRIQCghidXlDb3VudBgBIAEoBSIXChVCYXR0bGVQYXNzQnV5TGV2ZWxBY2si" + "OwoWQmF0dGxlUGFzc0NsYWltVGFza1JlcRIOCgZ0YXNrSWQYASABKAUSEQoJ" + "c3ViVGFza0lkGAIgASgFIhgKFkJhdHRsZVBhc3NDbGFpbVRhc2tBY2siOgoY" + "QmF0dGxlUGFzc0NsYWltUmV3YXJkUmVxEg0KBWxldmVsGAEgASgFEg8KB3By" + "ZW1pdW0YAiABKAgiPAoYQmF0dGxlUGFzc0NsYWltUmV3YXJkQWNrEiAKBWl0" + "ZW1zGAEgAygLMhEucGIuVW5pdmVyc2FsSXRlbWIGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[7]
		{
			new GeneratedClrTypeInfo(typeof(BattlePassNtf), BattlePassNtf.Parser, new string[3] { "BattlePassInfo", "BattlePassBeginTime", "BattlePassEndTime" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BattlePassBuyLevelReq), BattlePassBuyLevelReq.Parser, new string[1] { "BuyCount" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BattlePassBuyLevelAck), BattlePassBuyLevelAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BattlePassClaimTaskReq), BattlePassClaimTaskReq.Parser, new string[2] { "TaskId", "SubTaskId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BattlePassClaimTaskAck), BattlePassClaimTaskAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BattlePassClaimRewardReq), BattlePassClaimRewardReq.Parser, new string[2] { "Level", "Premium" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BattlePassClaimRewardAck), BattlePassClaimRewardAck.Parser, new string[1] { "Items" }, null, null, null, null)
		}));
	}
}
