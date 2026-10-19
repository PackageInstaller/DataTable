using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class DropitemReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static DropitemReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg5kcm9waXRlbS5wcm90bxICcGIaDGNvbW1vbi5wcm90byIkChZEcm9wSXRl" + "bVBpY2tQYWNrYWdlUmVxEgoKAmlkGAEgASgNInMKFkRyb3BJdGVtUGlja1Bh" + "Y2thZ2VBY2sSJQoHZHJvcFJlcxgBIAMoCzIULnBiLkRyb3BJdGVtUGlja0lu" + "Zm8SCwoDd2lkGAIgASgFEiUKCmdvdFJld2FyZHMYAyADKAsyES5wYi5Vbml2" + "ZXJzYWxJdGVtIiMKE0Ryb3BJdGVtUGlja0l0ZW1SZXESDAoEdWlkcxgBIAMo" + "BSI5ChBEcm9wSXRlbVBpY2tJbmZvEgsKA3VpZBgBIAEoBRIYCgNlcnIYAiAB" + "KA4yCy5wYi5QaWNrRXJyIkkKE0Ryb3BJdGVtUGlja0l0ZW1BY2sSJQoHZHJv" + "cFJlcxgBIAMoCzIULnBiLkRyb3BJdGVtUGlja0luZm8SCwoDd2lkGAIgASgF" + "ImQKDkRyb3BJdGVtQWRkTnRmEgsKA3dpZBgBIAEoBRIUCgxkcm9wU291cmVV" + "aWQYAiABKAUSHAoGZGl0ZW1zGAMgAygLMgwucGIuRHJvcEl0ZW0SEQoJcGFj" + "a2FnZUlkGAQgASgNKkcKB1BpY2tFcnISDwoLUElDS19OT19FUlIQABIUChBQ" + "SUNLX1VOS05PV05fRVJSEAESFQoRUElDS19CQUdfRlVMTF9FUlIQAmIGcHJv" + "dG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(new Type[1] { typeof(PickErr) }, null, new GeneratedClrTypeInfo[6]
		{
			new GeneratedClrTypeInfo(typeof(DropItemPickPackageReq), DropItemPickPackageReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DropItemPickPackageAck), DropItemPickPackageAck.Parser, new string[3] { "DropRes", "Wid", "GotRewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DropItemPickItemReq), DropItemPickItemReq.Parser, new string[1] { "Uids" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DropItemPickInfo), DropItemPickInfo.Parser, new string[2] { "Uid", "Err" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DropItemPickItemAck), DropItemPickItemAck.Parser, new string[2] { "DropRes", "Wid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DropItemAddNtf), DropItemAddNtf.Parser, new string[4] { "Wid", "DropSoureUid", "Ditems", "PackageId" }, null, null, null, null)
		}));
	}
}
