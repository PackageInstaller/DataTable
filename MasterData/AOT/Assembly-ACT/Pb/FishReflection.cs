using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class FishReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static FishReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgpmaXNoLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIiAKDEZpc2hTZXR1cFJl" + "cRIQCghmaXNoQmFpdBgBIAEoBSIOCgxGaXNoU2V0dXBBY2siDgoMRmlzaFN0" + "YXJ0UmVxIjEKDEZpc2hTdGFydEFjaxIPCgdzdGFydFRzGAEgASgDEhAKCGZp" + "bmlzaFRzGAIgASgDIhUKB0Zpc2hSZXESCgoCdHMYASABKAMiQAoHRmlzaEFj" + "axIMCgRmaXNoGAEgASgFEgwKBHNpemUYAiABKAISGQoHY2hhbmdlcxgDIAMo" + "CzIILnBiLkl0ZW1iBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[6]
		{
			new GeneratedClrTypeInfo(typeof(FishSetupReq), FishSetupReq.Parser, new string[1] { "FishBait" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(FishSetupAck), FishSetupAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(FishStartReq), FishStartReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(FishStartAck), FishStartAck.Parser, new string[2] { "StartTs", "FinishTs" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(FishReq), FishReq.Parser, new string[1] { "Ts" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(FishAck), FishAck.Parser, new string[3] { "Fish", "Size", "Changes" }, null, null, null, null)
		}));
	}
}
