using System;
using Google.Protobuf.Reflection;

namespace Pb;

public static class RoomReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static RoomReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgpyb29tLnByb3RvEgJwYiJHCgRSb29tEgoKAmlkGAEgASgEEhAKCG93bmVy" + "UElEGAIgASgDEgwKBHBpZHMYAyADKAMSEwoLY3JlYXRlU3RhbXAYBCABKAMi" + "DQoLUm9vbUluZm9SZXEiJQoLUm9vbUluZm9BY2sSFgoEcm9vbRgBIAEoCzII" + "LnBiLlJvb20iDwoNUm9vbUNyZWF0ZVJlcSIfCg1Sb29tQ3JlYXRlQWNrEg4K" + "BnJvb21JZBgBIAEoBCIdCgtSb29tSm9pblJlcRIOCgZyb29tSWQYASABKAQi" + "HQoLUm9vbUpvaW5BY2sSDgoGcm9vbUlkGAEgASgEIh4KDFJvb21MZWF2ZVJl" + "cRIOCgZyb29tSWQYASABKAQiDgoMUm9vbUxlYXZlQWNrIh0KC1Jvb21Kb2lu" + "TnRmEg4KBnJvb21JZBgBIAEoBCIzChJSb29tSm9pbkNvbmZpcm1SZXESEQoJ" + "am9pbmVyUElEGAEgASgDEgoKAm9rGAIgASgIIhQKElJvb21Kb2luQ29uZmly" + "bUFjayIgChJSb29tSm9pbkNvbmZpcm1OdGYSCgoCb2sYASABKAgiHQoOUm9v" + "bUtpY2tvdXRSZXESCwoDcGlkGAEgASgDIhAKDlJvb21LaWNrb3V0QWNrIioK" + "FFJvb21TZXRQZXJtaXNzaW9uUmVxEhIKCnBlcm1pc3Npb24YASABKAUiFgoU" + "Um9vbVNldFBlcm1pc3Npb25BY2siIQoHUm9vbU50ZhIWCgRyb29tGAEgASgL" + "MggucGIuUm9vbSIcCgtSb29tU3luY1JlcRINCgVieXRlcxgBIAEoDCINCgtS" + "b29tU3luY0FjayI1ChhSb29tRm9yd2FyZGluZ01lc3NhZ2VOdGYSCwoDcGlk" + "GAEgASgDEgwKBGRhdGEYAiABKAxiBnByb3RvMw=="), new FileDescriptor[0], new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[21]
		{
			new GeneratedClrTypeInfo(typeof(Room), Room.Parser, new string[4] { "Id", "OwnerPID", "Pids", "CreateStamp" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomInfoReq), RoomInfoReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomInfoAck), RoomInfoAck.Parser, new string[1] { "Room" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomCreateReq), RoomCreateReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomCreateAck), RoomCreateAck.Parser, new string[1] { "RoomId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomJoinReq), RoomJoinReq.Parser, new string[1] { "RoomId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomJoinAck), RoomJoinAck.Parser, new string[1] { "RoomId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomLeaveReq), RoomLeaveReq.Parser, new string[1] { "RoomId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomLeaveAck), RoomLeaveAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomJoinNtf), RoomJoinNtf.Parser, new string[1] { "RoomId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomJoinConfirmReq), RoomJoinConfirmReq.Parser, new string[2] { "JoinerPID", "Ok" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomJoinConfirmAck), RoomJoinConfirmAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomJoinConfirmNtf), RoomJoinConfirmNtf.Parser, new string[1] { "Ok" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomKickoutReq), RoomKickoutReq.Parser, new string[1] { "Pid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomKickoutAck), RoomKickoutAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomSetPermissionReq), RoomSetPermissionReq.Parser, new string[1] { "Permission" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomSetPermissionAck), RoomSetPermissionAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomNtf), RoomNtf.Parser, new string[1] { "Room" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomSyncReq), RoomSyncReq.Parser, new string[1] { "Bytes" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomSyncAck), RoomSyncAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoomForwardingMessageNtf), RoomForwardingMessageNtf.Parser, new string[2] { "Pid", "Data" }, null, null, null, null)
		}));
	}
}
