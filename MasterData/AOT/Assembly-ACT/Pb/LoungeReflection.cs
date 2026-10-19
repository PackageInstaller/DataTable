using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class LoungeReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static LoungeReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgxsb3VuZ2UucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iEAoOTG91bmdlRW50" + "ZXJSZXEiMAoOTG91bmdlRW50ZXJBY2sSHgoKbG91bmdlSW5mbxgBIAEoCzIK" + "LnBiLkxvdW5nZSIQCg5Mb3VuZ2VMZWF2ZVJlcSIQCg5Mb3VuZ2VMZWF2ZUFj" + "ayJCChJHaWZ0VG9DaGFyYWN0ZXJSZXESFwoFZ2lmdHMYASADKAsyCC5wYi5J" + "dGVtEhMKC2NoYXJhY3RlcklEGAIgASgFIr0BChJHaWZ0VG9DaGFyYWN0ZXJB" + "Y2sSEwoLY2hhcmFjdGVySUQYASABKAUSFgoOZ290TGlrZWFiaWxpdHkYAiAB" + "KAUSGAoQY3VyTGlrZWFiaWxpdHlMdhgDIAEoBRIZChFjdXJMaWtlYWJpbGl0" + "eUV4cBgEIAEoBRItChJsaWtlYWJpbGl0eVJld2FyZHMYBSADKAsyES5wYi5V" + "bml2ZXJzYWxJdGVtEhYKDnRvZGF5R2lmdENvdW50GAYgASgFIm4KFUxvdW5n" + "ZVRyaWdnZXJQb2ludFJlcRIPCgdwb2ludElEGAEgASgFEi8KC3RyaWdnZXJU" + "eXBlGAIgASgOMhoucGIuTG91bmdlVHJpZ2dlclBvaW50VHlwZRITCgtjaGFy" + "YWN0ZXJJRBgDIAEoBSLEAQoVTG91bmdlVHJpZ2dlclBvaW50QWNrEh4KCmxv" + "dW5nZUluZm8YASABKAsyCi5wYi5Mb3VuZ2USDwoHcG9pbnRJRBgCIAEoBRIW" + "Cg5nb3RMaWtlYWJpbGl0eRgDIAEoBRIYChBjdXJMaWtlYWJpbGl0eUx2GAQg" + "ASgFEhkKEWN1ckxpa2VhYmlsaXR5RXhwGAUgASgFEi0KEmxpa2VhYmlsaXR5" + "UmV3YXJkcxgGIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0qnwEKFkxvdW5nZVRy" + "aWdnZXJQb2ludFR5cGUSLgoqTE9VTkdFX1RSSUdHRVJfUE9JTlRfVFlQRV9J" + "TlZJVEVfQ0hBUkFDVEVSEAASMAosTE9VTkdFX1RSSUdHRVJfUE9JTlRfVFlQ" + "RV9JTlRFUkFDVF9DSEFSQUNURVIQARIjCh9MT1VOR0VfVFJJR0dFUl9QT0lO" + "VF9UWVBFX1NUT1JZEAJiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(new Type[1] { typeof(LoungeTriggerPointType) }, null, new GeneratedClrTypeInfo[8]
		{
			new GeneratedClrTypeInfo(typeof(LoungeEnterReq), LoungeEnterReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LoungeEnterAck), LoungeEnterAck.Parser, new string[1] { "LoungeInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LoungeLeaveReq), LoungeLeaveReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LoungeLeaveAck), LoungeLeaveAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GiftToCharacterReq), GiftToCharacterReq.Parser, new string[2] { "Gifts", "CharacterID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GiftToCharacterAck), GiftToCharacterAck.Parser, new string[6] { "CharacterID", "GotLikeability", "CurLikeabilityLv", "CurLikeabilityExp", "LikeabilityRewards", "TodayGiftCount" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LoungeTriggerPointReq), LoungeTriggerPointReq.Parser, new string[3] { "PointID", "TriggerType", "CharacterID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LoungeTriggerPointAck), LoungeTriggerPointAck.Parser, new string[6] { "LoungeInfo", "PointID", "GotLikeability", "CurLikeabilityLv", "CurLikeabilityExp", "LikeabilityRewards" }, null, null, null, null)
		}));
	}
}
