using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class InteracteventReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static InteracteventReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("ChNpbnRlcmFjdGV2ZW50LnByb3RvEgJwYhoMY29tbW9uLnByb3RvIqQCChdU" + "cmlnZ2VySW50ZXJhY3RFdmVudFJlcRILCgN3aWQYASABKAUSIwoGc3RhdGVz" + "GAIgAygLMhMucGIuU3RhdGVDaGFuZ2VJbmZvEhcKBWl0ZW1zGAMgAygLMggu" + "cGIuSXRlbRIfCghwb3NpdGlvbhgEIAEoCzINLnBiLlBCVmVjdG9yMxIsCg1j" + "aGFyYWN0ZXJJbmZvGAUgASgLMhUucGIuQ2hhcmFjdGVyU3luY0luZm8SKgoO" + "bWFwVmlld0xvZ0luZm8YBiADKAsyEi5wYi5NYXBWaWV3TG9nSW5mbxIyChJt" + "YXBWaWV3UmVjb3JkUGFyYW0YByABKAsyFi5wYi5NYXBWaWV3UmVjb3JkUGFy" + "YW0SDwoHY2h1bmtJRBgIIAEoBSJCCg9TdGF0ZUNoYW5nZUluZm8SCwoDdWlk" + "GAEgASgFEg8KB3N0YXRlSWQYAiABKAUSEQoJZXZlbnROYW1lGAMgASgJIjsK" + "F1RyaWdnZXJJbnRlcmFjdEV2ZW50QWNrEiAKBWl0ZW1zGAEgAygLMhEucGIu" + "VW5pdmVyc2FsSXRlbSJJChNTZXJ2aWNlU2F2ZVN0YXRlTnRmEgsKA3dpZBgB" + "IAEoBRIlCgdjaGFuZ2VzGAIgAygLMhQucGIuU2VydmljZVNhdmVTdGF0ZSJD" + "ChBTZXJ2aWNlQmVoYXZlTnRmEgsKA3dpZBgBIAEoBRIiCgdjaGFuZ2VzGAIg" + "AygLMhEucGIuU2VydmljZUJlaGF2ZSJIChVTY2VuZUNoYWxsZW5nZUJvc3NS" + "ZXESFwoPZGlmZmljdWx0eUxldmVsGAEgASgFEhYKDmludGVyYWN0aW9uVWlk" + "GAIgASgFIhcKFVNjZW5lQ2hhbGxlbmdlQm9zc0FjayI5Ch9TY2VuZVRha2VD" + "aGFsbGVuZ2VCb3NzUmV3YXJkUmVxEhYKDmludGVyYWN0aW9uVWlkGAEgASgF" + "IjwKH1NjZW5lVGFrZUNoYWxsZW5nZUJvc3NSZXdhcmRBY2sSGQoHcmV3YXJk" + "cxgBIAMoCzIILnBiLkl0ZW0iHAoaU2NlbmVSZXNldENoYWxsZW5nZUJvc3NS" + "ZXEiHAoaU2NlbmVSZXNldENoYWxsZW5nZUJvc3NBY2siGQoXVHJpZ2dlclRl" + "bGVwb3J0UG9pbnRSZXEiGQoXVHJpZ2dlclRlbGVwb3J0UG9pbnRBY2tiBnBy" + "b3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[13]
		{
			new GeneratedClrTypeInfo(typeof(TriggerInteractEventReq), TriggerInteractEventReq.Parser, new string[8] { "Wid", "States", "Items", "Position", "CharacterInfo", "MapViewLogInfo", "MapViewRecordParam", "ChunkID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(StateChangeInfo), StateChangeInfo.Parser, new string[3] { "Uid", "StateId", "EventName" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TriggerInteractEventAck), TriggerInteractEventAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ServiceSaveStateNtf), ServiceSaveStateNtf.Parser, new string[2] { "Wid", "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ServiceBehaveNtf), ServiceBehaveNtf.Parser, new string[2] { "Wid", "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneChallengeBossReq), SceneChallengeBossReq.Parser, new string[2] { "DifficultyLevel", "InteractionUid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneChallengeBossAck), SceneChallengeBossAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneTakeChallengeBossRewardReq), SceneTakeChallengeBossRewardReq.Parser, new string[1] { "InteractionUid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneTakeChallengeBossRewardAck), SceneTakeChallengeBossRewardAck.Parser, new string[1] { "Rewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneResetChallengeBossReq), SceneResetChallengeBossReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneResetChallengeBossAck), SceneResetChallengeBossAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TriggerTeleportPointReq), TriggerTeleportPointReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TriggerTeleportPointAck), TriggerTeleportPointAck.Parser, null, null, null, null, null)
		}));
	}
}
