using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class WeaponReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static WeaponReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgx3ZWFwb24ucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iXgoJV2VhcG9uTnRm" + "EhsKB2NoYW5nZXMYASADKAsyCi5wYi5XZWFwb24SEgoKcmVtb3ZlVWlkcxgC" + "IAMoBRIgCgljaGFuZ2VXYXkYAyABKA4yDS5wYi5JdGVtc1dheXMiMQoNV2Vh" + "cG9uV2VhclJlcRILCgN1aWQYASABKAUSEwoLY2hhcmFjdGVySWQYAiABKAUi" + "DwoNV2VhcG9uV2VhckFjayIqCg1XZWFwb25Mb2NrUmVxEgsKA3VpZBgBIAEo" + "BRIMCgRsb2NrGAIgASgIIg8KDVdlYXBvbkxvY2tBY2siVgoQV2VhcG9uTGV2" + "ZWxVcFJlcRILCgN1aWQYASABKAUSFwoPc3BlbmRXZWFwb25VaWRzGAIgAygF" + "EhwKCnNwZW5kSXRlbXMYAyADKAsyCC5wYi5JdGVtIi0KEFdlYXBvbkxldmVs" + "VXBBY2sSGQoHY2hhbmdlcxgBIAMoCzIILnBiLkl0ZW0iHQoOV2VhcG9uU3Rh" + "Z2VSZXESCwoDdWlkGAEgASgFIisKDldlYXBvblN0YWdlQWNrEhkKB2NoYW5n" + "ZXMYASADKAsyCC5wYi5JdGVtIjAKD1dlYXBvblJlZmluZVJlcRILCgN1aWQY" + "ASABKAUSEAoIc3BlbmRVaWQYAiABKAUiLAoPV2VhcG9uUmVmaW5lQWNrEhkK" + "B2NoYW5nZXMYASADKAsyCC5wYi5JdGVtYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[11]
		{
			new GeneratedClrTypeInfo(typeof(WeaponNtf), WeaponNtf.Parser, new string[3] { "Changes", "RemoveUids", "ChangeWay" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponWearReq), WeaponWearReq.Parser, new string[2] { "Uid", "CharacterId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponWearAck), WeaponWearAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponLockReq), WeaponLockReq.Parser, new string[2] { "Uid", "Lock" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponLockAck), WeaponLockAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponLevelUpReq), WeaponLevelUpReq.Parser, new string[3] { "Uid", "SpendWeaponUids", "SpendItems" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponLevelUpAck), WeaponLevelUpAck.Parser, new string[1] { "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponStageReq), WeaponStageReq.Parser, new string[1] { "Uid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponStageAck), WeaponStageAck.Parser, new string[1] { "Changes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponRefineReq), WeaponRefineReq.Parser, new string[2] { "Uid", "SpendUid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(WeaponRefineAck), WeaponRefineAck.Parser, new string[1] { "Changes" }, null, null, null, null)
		}));
	}
}
