using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class ShopReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static ShopReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgpzaG9wLnByb3RvEgJwYhoMY29tbW9uLnByb3RvImgKB1Nob3BOdGYSJQoF" + "c2hvcHMYASADKAsyFi5wYi5TaG9wTnRmLlNob3BzRW50cnkaNgoKU2hvcHNF" + "bnRyeRILCgNrZXkYASABKAUSFwoFdmFsdWUYAiABKAsyCC5wYi5TaG9wOgI4" + "ASJfChNTaG9wQnV5Q29tbW9kaXR5UmVxEg4KBnNob3BJZBgBIAEoBRISCgpz" + "dWJTaG9wSWR4GAIgASgFEhQKDGNvbW1vZGl0eUlkeBgDIAEoBRIOCgZidXlO" + "dW0YBCABKAUiOgoTU2hvcEJ1eUNvbW1vZGl0eUFjaxIjCghnb3RJdGVtcxgB" + "IAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0iNgoORGlhbW9uZERhdGFOdGYSJAoL" + "ZGlhbW9uZERhdGEYASABKAsyDy5wYi5EaWFtb25kRGF0YSIzCg1CdW5kbGVE" + "YXRhTnRmEiIKCmJ1bmRsZURhdGEYASABKAsyDi5wYi5CdW5kbGVEYXRhIiUK" + "FkV4Y2hhbmdlRnJlZURpYW1vbmRSZXESCwoDbnVtGAEgASgFIhgKFkV4Y2hh" + "bmdlRnJlZURpYW1vbmRBY2siTgoURXhjaGFuZ2VDb21tb2RpdHlSZXESEwoL" + "Y29tbW9kaXR5SWQYASABKAUSDgoGaW5kZXhzGAIgAygFEhEKCXN1YlNob3BJ" + "ZBgDIAEoBSI7ChRFeGNoYW5nZUNvbW1vZGl0eUFjaxIjCghnb3RJdGVtcxgB" + "IAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW1iBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[9]
		{
			new GeneratedClrTypeInfo(typeof(ShopNtf), ShopNtf.Parser, new string[1] { "Shops" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(ShopBuyCommodityReq), ShopBuyCommodityReq.Parser, new string[4] { "ShopId", "SubShopIdx", "CommodityIdx", "BuyNum" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ShopBuyCommodityAck), ShopBuyCommodityAck.Parser, new string[1] { "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DiamondDataNtf), DiamondDataNtf.Parser, new string[1] { "DiamondData" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BundleDataNtf), BundleDataNtf.Parser, new string[1] { "BundleData" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ExchangeFreeDiamondReq), ExchangeFreeDiamondReq.Parser, new string[1] { "Num" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ExchangeFreeDiamondAck), ExchangeFreeDiamondAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ExchangeCommodityReq), ExchangeCommodityReq.Parser, new string[3] { "CommodityId", "Indexs", "SubShopId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ExchangeCommodityAck), ExchangeCommodityAck.Parser, new string[1] { "GotItems" }, null, null, null, null)
		}));
	}
}
