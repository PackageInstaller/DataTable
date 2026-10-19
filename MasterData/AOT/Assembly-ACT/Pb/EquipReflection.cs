using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class EquipReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static EquipReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgtlcXVpcC5wcm90bxICcGIaDGNvbW1vbi5wcm90byJgCgxFcXVpcEluZm9O" + "dGYSGgoHY2hhbmdlcxgBIAMoCzIJLnBiLkVxdWlwEhIKCnJlbW92ZVVpZHMY" + "AiADKAUSIAoJY2hhbmdlV2F5GAMgASgOMg0ucGIuSXRlbXNXYXlzIlwKCkdl" + "bUluZm9OdGYSGAoHY2hhbmdlcxgBIAMoCzIHLnBiLkdlbRISCgpyZW1vdmVV" + "aWRzGAIgAygFEiAKCWNoYW5nZVdheRgDIAEoDjINLnBiLkl0ZW1zV2F5cyIc" + "Cg5FcXVpcENyZWF0ZVJlcRIKCgJpZBgBIAEoBSI1Cg5FcXVpcENyZWF0ZUFj" + "axIjCghnb3RJdGVtcxgBIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0iLQoPRXF1" + "aXBFbmhhbmNlUmVxEgsKA3VpZBgBIAEoBRINCgVsZXZlbBgCIAEoBSIRCg9F" + "cXVpcEVuaGFuY2VBY2siIQoRRXF1aXBEaXNtYW50bGVSZXESDAoEdWlkcxgB" + "IAMoBSIsChFFcXVpcERpc21hbnRsZUFjaxIXCgVpdGVtcxgBIAMoCzIILnBi" + "Lkl0ZW0iMAoMRXF1aXBXZWFyUmVxEgsKA3VpZBgBIAEoBRITCgtjaGFyYWN0" + "ZXJJZBgCIAEoBSIOCgxFcXVpcFdlYXJBY2siWgoSRXF1aXBHZW1PcGVyYXRl" + "UmVxEhAKCGVxdWlwVWlkGAEgASgFEhEKCWdlbVNsb3RJZBgCIAEoBRIPCgdv" + "cGVyYXRlGAMgASgIEg4KBmdlbVVpZBgEIAEoBSIuChJFcXVpcEdlbU9wZXJh" + "dGVBY2sSGAoFZXF1aXAYASABKAsyCS5wYi5FcXVpcCIrCgxFcXVpcExvY2tS" + "ZXESCwoDdWlkGAEgASgFEg4KBmlzTG9jaxgCIAEoCCIOCgxFcXVpcExvY2tB" + "Y2siHAoMR2VtRnVzaW9uUmVxEgwKBHVpZHMYASADKAUiMwoMR2VtRnVzaW9u" + "QWNrEiMKCGdvdEl0ZW1zGAEgAygLMhEucGIuVW5pdmVyc2FsSXRlbSIpCgpH" + "ZW1Mb2NrUmVxEgsKA3VpZBgBIAEoBRIOCgZpc0xvY2sYAiABKAgiDAoKR2Vt" + "TG9ja0Fja2IGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[18]
		{
			new GeneratedClrTypeInfo(typeof(EquipInfoNtf), EquipInfoNtf.Parser, new string[3] { "Changes", "RemoveUids", "ChangeWay" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GemInfoNtf), GemInfoNtf.Parser, new string[3] { "Changes", "RemoveUids", "ChangeWay" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipCreateReq), EquipCreateReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipCreateAck), EquipCreateAck.Parser, new string[1] { "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipEnhanceReq), EquipEnhanceReq.Parser, new string[2] { "Uid", "Level" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipEnhanceAck), EquipEnhanceAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipDismantleReq), EquipDismantleReq.Parser, new string[1] { "Uids" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipDismantleAck), EquipDismantleAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipWearReq), EquipWearReq.Parser, new string[2] { "Uid", "CharacterId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipWearAck), EquipWearAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipGemOperateReq), EquipGemOperateReq.Parser, new string[4] { "EquipUid", "GemSlotId", "Operate", "GemUid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipGemOperateAck), EquipGemOperateAck.Parser, new string[1] { "Equip" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipLockReq), EquipLockReq.Parser, new string[2] { "Uid", "IsLock" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EquipLockAck), EquipLockAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GemFusionReq), GemFusionReq.Parser, new string[1] { "Uids" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GemFusionAck), GemFusionAck.Parser, new string[1] { "GotItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GemLockReq), GemLockReq.Parser, new string[2] { "Uid", "IsLock" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(GemLockAck), GemLockAck.Parser, null, null, null, null, null)
		}));
	}
}
