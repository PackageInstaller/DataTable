using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class BillReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static BillReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgpiaWxsLnByb3RvEgJwYhoMY29tbW9uLnByb3RvImUKDUNyZWF0T3JkZXJS" + "ZXESDwoHZ29vZHNJZBgBIAEoBRIQCghjdXJyZW5jeRgCIAEoCRIOCgZpbmRl" + "eHMYAyADKAUSDgoGaXRlbUlkGAQgASgFEhEKCXN1YlNob3BJZBgFIAEoBSJh" + "Cg1DcmVhdE9yZGVyQWNrEg8KB29yZGVySWQYASABKAkSDQoFbW9uZXkYAiAB" + "KAUSEwoLY2FsbGJhY2tVcmwYAyABKAkSDQoFZXh0cmEYBCABKAkSDAoEc2ln" + "bhgFIAEoCSIVChNQYXlBY3Rpb25Qcm9jZXNzUmVxIhUKE1BheUFjdGlvblBy" + "b2Nlc3NBY2siRAoMT3JkZXJTaGlwTnRmEg8KB29yZGVySWQYASABKAkSIwoI" + "Z290SXRlbXMYAiADKAsyES5wYi5Vbml2ZXJzYWxJdGVtIigKFU9yZGVyU2hp" + "cERpc3BsYXllZFJlcRIPCgdvcmRlcklkGAEgASgJIhcKFU9yZGVyU2hpcERp" + "c3BsYXllZEFja2IGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[7]
		{
			new GeneratedClrTypeInfo(typeof(CreatOrderReq), CreatOrderReq.Parser, new string[5] { "GoodsId", "Currency", "Indexs", "ItemId", "SubShopId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(CreatOrderAck), CreatOrderAck.Parser, new string[5] { "OrderId", "Money", "CallbackUrl", "Extra", "Sign" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PayActionProcessReq), PayActionProcessReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(PayActionProcessAck), PayActionProcessAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(OrderShipNtf), OrderShipNtf.Parser, new string[2] { "OrderId", "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(OrderShipDisplayedReq), OrderShipDisplayedReq.Parser, new string[1] { "OrderId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(OrderShipDisplayedAck), OrderShipDisplayedAck.Parser, null, null, null, null, null)
		}));
	}
}
