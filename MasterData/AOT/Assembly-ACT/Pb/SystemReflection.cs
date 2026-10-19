using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class SystemReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static SystemReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgxzeXN0ZW0ucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iGwoNU3lzdGVtT3Bl" + "blJlcRIKCgJpZBgBIAEoBSIbCg1TeXN0ZW1PcGVuQWNrEgoKAmlkGAEgASgF" + "IjkKDVN5c3RlbU9wZW5OdGYSEwoLb3BlblN5c3RlbXMYASADKAUSEwoLcmVh" + "ZFN5c3RlbXMYAiADKAUiHwoRU3lzdGVtUmVhZERvbmVSZXESCgoCaWQYASAB" + "KAUiHwoRU3lzdGVtUmVhZERvbmVBY2sSCgoCaWQYASABKAUiNgoYU3lzdGVt" + "VGFrZUxldmVsUmV3YXJkUmVxEg0KBWxldmVsGAEgASgFEgsKA2FsbBgCIAEo" + "CCIzChhTeXN0ZW1UYWtlTGV2ZWxSZXdhcmRBY2sSFwoFaXRlbXMYASADKAsy" + "CC5wYi5JdGVtIjQKH1N5c3RlbUd1aWRlVGFrZUNoYXB0ZXJSZXdhcmRSZXES" + "EQoJY2hhcHRlcklkGAEgASgFIkYKH1N5c3RlbUd1aWRlVGFrZUNoYXB0ZXJS" + "ZXdhcmRBY2sSIwoIZ290SXRlbXMYASADKAsyES5wYi5Vbml2ZXJzYWxJdGVt" + "IrcBChhTeXN0ZW1UYWtlTGV2ZWxSZXdhcmROdGYSDgoGbGV2ZWxzGAEgAygF" + "ElAKEnN5c3RlbUd1aWRlQ2hhcHRlchgCIAMoCzI0LnBiLlN5c3RlbVRha2VM" + "ZXZlbFJld2FyZE50Zi5TeXN0ZW1HdWlkZUNoYXB0ZXJFbnRyeRo5ChdTeXN0" + "ZW1HdWlkZUNoYXB0ZXJFbnRyeRILCgNrZXkYASABKAUSDQoFdmFsdWUYAiAB" + "KAg6AjgBIjQKD1N5c3RlbVN0YXR1c050ZhIhCgdzeXN0ZW1zGAEgAygLMhAu" + "cGIuU3lzdGVtU3RhdHVzIjkKFVN5c3RlbVN0YXR1c0NoYW5nZU50ZhIgCgZz" + "eXN0ZW0YASABKAsyEC5wYi5TeXN0ZW1TdGF0dXNiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[12]
		{
			new GeneratedClrTypeInfo(typeof(SystemOpenReq), SystemOpenReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemOpenAck), SystemOpenAck.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemOpenNtf), SystemOpenNtf.Parser, new string[2] { "OpenSystems", "ReadSystems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemReadDoneReq), SystemReadDoneReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemReadDoneAck), SystemReadDoneAck.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemTakeLevelRewardReq), SystemTakeLevelRewardReq.Parser, new string[2] { "Level", "All" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemTakeLevelRewardAck), SystemTakeLevelRewardAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemGuideTakeChapterRewardReq), SystemGuideTakeChapterRewardReq.Parser, new string[1] { "ChapterId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemGuideTakeChapterRewardAck), SystemGuideTakeChapterRewardAck.Parser, new string[1] { "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemTakeLevelRewardNtf), SystemTakeLevelRewardNtf.Parser, new string[2] { "Levels", "SystemGuideChapter" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(SystemStatusNtf), SystemStatusNtf.Parser, new string[1] { "Systems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SystemStatusChangeNtf), SystemStatusChangeNtf.Parser, new string[1] { "System" }, null, null, null, null)
		}));
	}
}
