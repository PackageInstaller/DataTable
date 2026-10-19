using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class TraininggroundReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static TraininggroundReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("ChR0cmFpbmluZ2dyb3VuZC5wcm90bxICcGIaDGNvbW1vbi5wcm90byI/ChZU" + "cmFpbmluZ0dyb3VuZEVudGVyUmVxEiUKCnNjZW5lUGFyYW0YASABKAsyES5w" + "Yi5TY2VuZVBvc1BhcmFtIk4KFlRyYWluaW5nR3JvdW5kRW50ZXJBY2sSNAoT" + "Y2hhcmFjdGVyUmVwb3NpdG9yeRgBIAEoCzIXLnBiLkNoYXJhY3RlclJlcG9z" + "aXRvcnkiGAoWVHJhaW5pbmdHcm91bmRMZWF2ZVJlcSIYChZUcmFpbmluZ0dy" + "b3VuZExlYXZlQWNrYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[4]
		{
			new GeneratedClrTypeInfo(typeof(TrainingGroundEnterReq), TrainingGroundEnterReq.Parser, new string[1] { "SceneParam" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TrainingGroundEnterAck), TrainingGroundEnterAck.Parser, new string[1] { "CharacterRepository" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TrainingGroundLeaveReq), TrainingGroundLeaveReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(TrainingGroundLeaveAck), TrainingGroundLeaveAck.Parser, null, null, null, null, null)
		}));
	}
}
