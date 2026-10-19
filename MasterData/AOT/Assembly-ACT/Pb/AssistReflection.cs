using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class AssistReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static AssistReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgxhc3Npc3QucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iKAoJQXNzaXN0TnRm" + "EhsKB2NoYW5nZXMYASADKAsyCi5wYi5Bc3Npc3QiPQoNQXNzaXN0U2tpbk50" + "ZhIOCgZhc3Npc3QYASABKAUSHAoEc2tpbhgCIAEoCzIOLnBiLkFzc2lzdFNr" + "aW4iPgoPQXNzaXN0RHllaW5nUmVxEg4KBmFzc2lzdBgBIAEoBRIMCgRza2lu" + "GAIgASgFEg0KBWNvbG9yGAMgASgFIiwKD0Fzc2lzdER5ZWluZ0FjaxIZCgdj" + "aGFuZ2VzGAEgAygLMggucGIuSXRlbSI9Cg5Bc3Npc3RTZXR1cFJlcRIOCgZh" + "c3Npc3QYASABKAUSDAoEc2tpbhgCIAEoBRINCgVjb2xvchgDIAEoBSIQCg5B" + "c3Npc3RTZXR1cEFjayIgCg5Bc3Npc3RFcXVpcFJlcRIOCgZhc3Npc3QYASAB" + "KAUiEAoOQXNzaXN0RXF1aXBBY2tiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[8]
		{
			new GeneratedClrTypeInfo(typeof(AssistNtf), AssistNtf.Parser, new string[1] { "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AssistSkinNtf), AssistSkinNtf.Parser, new string[2] { "Assist", "Skin" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AssistDyeingReq), AssistDyeingReq.Parser, new string[3] { "Assist", "Skin", "Color" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AssistDyeingAck), AssistDyeingAck.Parser, new string[1] { "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AssistSetupReq), AssistSetupReq.Parser, new string[3] { "Assist", "Skin", "Color" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AssistSetupAck), AssistSetupAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AssistEquipReq), AssistEquipReq.Parser, new string[1] { "Assist" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AssistEquipAck), AssistEquipAck.Parser, null, null, null, null, null)
		}));
	}
}
