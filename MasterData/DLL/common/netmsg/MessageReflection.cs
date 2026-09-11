using System;
using Google.Protobuf.Reflection;

namespace netmsg;

public static class MessageReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static MessageReflection()
	{
		byte[] descriptorData = Convert.FromBase64String("Cg1tZXNzYWdlLnByb3RvIsABCgRkYXRhGqcBCgxVc2VyUHJvZmlsZXISCgoC" + "aWQYASABKAUSMwoJYWxsX3JvbGVzGAIgAygLMiAuZGF0YS5Vc2VyUHJvZmls" + "ZXIuQWxsUm9sZXNFbnRyeRIRCgljdXJyX2NhbXAYAyABKAUaQwoNQWxsUm9s" + "ZXNFbnRyeRILCgNrZXkYASABKAUSIQoFdmFsdWUYAiABKAsyEi5kYXRhLlJv" + "bGVQcm9maWxlcjoCOAEaDgoMUm9sZVByb2ZpbGVyIrQDCgNtc2caIAoKU2tp" + "bGxJbnB1dBISCgpzbG90X2luZGV4GAEgASgNGl4KCVVzZXJJbnB1dBILCgN1" + "aWQYASABKAUSHgoKaW5wdXRfdHlwZRgCIAEoDjIKLklucHV0VHlwZRIkCgtz" + "a2lsbF9pbnB1dBgDIAEoCzIPLm1zZy5Ta2lsbElucHV0Gg4KDEJhdHRsZUVu" + "ZE1zZxpKCg9CYXR0bGVVcGRhdGVNc2cSEwoLZnJhbWVfY291bnQYASABKAUS" + "IgoKYWxsX2lucHV0cxgCIAMoCzIOLm1zZy5Vc2VySW5wdXQaYQoOQmF0dGxl" + "U3RhcnRNc2cSEQoJYmF0dGxlX2lkGAEgASgFEhIKCnN0YXJ0X3RpbWUYAiAB" + "KAMSKAoMYmF0dGxlX3JvbGVzGAMgAygLMhIuZGF0YS5Sb2xlUHJvZmlsZXIa" + "LQoITG9naW5Nc2cSDwoHYWNjb3VudBgBIAEoCRIQCghwYXNzd29yZBgCIAEo" + "CRo9Cg1Tb2NrZXRDb21tYW5kEhwKBm1zZ190cBgBIAEoDjIMLk1lc3NhZ2VU" + "eXBlEg4KBnBhcmFtcxgCIAEoDCpmCgtNZXNzYWdlVHlwZRILCgdNVF9OT05F" + "EAASDAoITVRfTE9HSU4QARITCg9NVF9CQVRUTEVfU1RBUlQQAhIUChBNVF9C" + "QVRUTEVfVVBEQVRFEAMSEQoNTVRfQkFUVExFX0VORBAEKikKCUlucHV0VHlw" + "ZRILCgdJVF9OT05FEAASDwoLSVRfRE9fU0tJTEwQAUIJqgIGbmV0bXNnYgZw" + "cm90bzM=");
		descriptor = FileDescriptor.FromGeneratedCode(descriptorData, new FileDescriptor[0], new GeneratedClrTypeInfo(new Type[2]
		{
			typeof(MessageType),
			typeof(InputType)
		}, new GeneratedClrTypeInfo[2]
		{
			new GeneratedClrTypeInfo(typeof(data), data.Parser, null, null, null, new GeneratedClrTypeInfo[2]
			{
				new GeneratedClrTypeInfo(typeof(data.Types.UserProfiler), data.Types.UserProfiler.Parser, new string[3] { "Id", "AllRoles", "CurrCamp" }, null, null, new GeneratedClrTypeInfo[1]),
				new GeneratedClrTypeInfo(typeof(data.Types.RoleProfiler), data.Types.RoleProfiler.Parser, null, null, null, null)
			}),
			new GeneratedClrTypeInfo(typeof(msg), msg.Parser, null, null, null, new GeneratedClrTypeInfo[7]
			{
				new GeneratedClrTypeInfo(typeof(msg.Types.SkillInput), msg.Types.SkillInput.Parser, new string[1] { "SlotIndex" }, null, null, null),
				new GeneratedClrTypeInfo(typeof(msg.Types.UserInput), msg.Types.UserInput.Parser, new string[3] { "Uid", "InputType", "SkillInput" }, null, null, null),
				new GeneratedClrTypeInfo(typeof(msg.Types.BattleEndMsg), msg.Types.BattleEndMsg.Parser, null, null, null, null),
				new GeneratedClrTypeInfo(typeof(msg.Types.BattleUpdateMsg), msg.Types.BattleUpdateMsg.Parser, new string[2] { "FrameCount", "AllInputs" }, null, null, null),
				new GeneratedClrTypeInfo(typeof(msg.Types.BattleStartMsg), msg.Types.BattleStartMsg.Parser, new string[3] { "BattleId", "StartTime", "BattleRoles" }, null, null, null),
				new GeneratedClrTypeInfo(typeof(msg.Types.LoginMsg), msg.Types.LoginMsg.Parser, new string[2] { "Account", "Password" }, null, null, null),
				new GeneratedClrTypeInfo(typeof(msg.Types.SocketCommand), msg.Types.SocketCommand.Parser, new string[2] { "MsgTp", "Params" }, null, null, null)
			})
		}));
	}
}
