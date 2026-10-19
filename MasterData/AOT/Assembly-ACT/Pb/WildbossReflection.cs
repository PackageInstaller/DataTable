using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class WildbossReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static WildbossReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg53aWxkYm9zcy5wcm90bxICcGIaDGNvbW1vbi5wcm90byIyChVXaWxkQm9z" + "c1Rha2VSZXdhcmRSZXESGQoRaW50ZXJhY3Rpb25PYmpVSUQYASABKAUiPgoV" + "V2lsZEJvc3NUYWtlUmV3YXJkQWNrEiUKCmdvdFJld2FyZHMYAyADKAsyES5w" + "Yi5Vbml2ZXJzYWxJdGVtIigKF1dpbGRCb3NzUmV3YXJkQm91Z2h0UmVxEg0K" + "BWNvdW50GAEgASgFIhkKF1dpbGRCb3NzUmV3YXJkQm91Z2h0QWNrYgZwcm90" + "bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[4]
		{
			new GeneratedClrTypeInfo(typeof(WildBossTakeRewardReq), WildBossTakeRewardReq.Parser, new string[1] { "InteractionObjUID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WildBossTakeRewardAck), WildBossTakeRewardAck.Parser, new string[1] { "GotRewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WildBossRewardBoughtReq), WildBossRewardBoughtReq.Parser, new string[1] { "Count" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WildBossRewardBoughtAck), WildBossRewardBoughtAck.Parser, null, null, null, null, null)
		}));
	}
}
