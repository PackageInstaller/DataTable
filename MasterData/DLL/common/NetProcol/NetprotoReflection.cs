using System;
using Google.Protobuf.Reflection;

namespace NetProcol;

public static class NetprotoReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static NetprotoReflection()
	{
		byte[] descriptorData = Convert.FromBase64String("ChhUZW1wUHJvdG8vbmV0cHJvdG8ucHJvdG8iHgoHT3BfcGluZxITCgtjbGll" + "bnRfdGltZRgBIAEoAyIzCgdPcF9wb25nEhMKC2NsaWVudF90aW1lGAEgASgD" + "EhMKC3NlcnZlcl90aW1lGAIgASgDIk4KFU9wX0IyR19Db25uZWN0UmVxdWVz" + "dBIMCgRQb3J0GAEgASgNEhEKCVRpbWVzdGFtcBgCIAEoDRIUCgxWZXJpZmlj" + "YXRpb24YAyABKAkiWgoWT3BfRzJCX0Nvbm5lY3RSZXNwb25zZRIRCglFcnJv" + "ckNvZGUYASABKA0SFgoOQmF0dGxlU2VydmVySWQYAiABKA0SFQoNSXNTZXJ2" + "aWNlT3BlbhgDIAEoCCIVChNPcF9HMkJfc3RhcnRfYmF0dGxlIhkKF09wX0Iy" + "R19hY2tfc3RhcnRfYmF0dGxlIm4KE09wX0IyR19CYXR0bGVSZXN1bHQSGAoQ" + "Z2FtZVNlcnZlclJvb21JRBgBIAEoBRIMCgR1dWlkGAIgASgFEg4KBnJlc3Vs" + "dBgDIAEoBRIfCgRpbmZvGAQgASgLMhEuQmF0dGxlUmVzdWx0SW5mbyIuChdP" + "cF9HMkJfQWNrX0JhdHRsZVJlc3VsdBITCgtyZXN1bHRfY29kZRgBIAEoBSIT" + "ChFPcF9HMkJfZW5kX2JhdHRsZSIgCg9PcF9DTURfbW92ZV9kaXISDQoFYW5n" + "bGUYASABKAUiFgoUT3BfQ01EX3N0b3BfbW92ZV9kaXIiKAoTT3BfQ01EX21l" + "bGVlX2F0dGFjaxIRCglhdHRhY2tfaWQYASABKAUiJwoST3BfQ01EX2NoYW5n" + "ZV9yb2xlEhEKCWNvbmZpZ19pZBgBIAEoBSISChBPcF9DTURfZ2FtZV9zdG9w" + "Ih0KG09wX0NNRF9tb2RpZnlfdHJpZ2dlcl9zdGF0ZSIhChFPcF9DTURfQUlf" + "Q29tbWFuZBIMCgR0eXBlGAEgASgFIqAFChlTY2VuZURhdGFGb3JFeGNlaGFu" + "Z2VJbmZvEhAKCG1TY2VuZUlEGAEgASgFEhoKEm1NaXNzaW9uQ2xlYXJUaW1l" + "cxgCIAEoBRIXCg90eXBlSURMaXN0QWZmaXgYAyADKAUSEQoJbGV2ZWxMaXN0" + "GAQgAygFEhIKCmVuZW15VHlwZXMYBSADKAUSLwoNcm9sZURhdGFJbkx1YRgG" + "IAMoCzIYLlJvbGVEYXRhRm9yRXhjaGFuZ2VJbmZvEhcKD2NoYWxsZW5nZUZh" + "Y3RvchgHIAEoBRIaChJhZGFwdGl2ZUVuZW15TGV2ZWwYCCABKAUSEgoKZGlm" + "ZmljdWx0eRgJIAEoBRIVCg1uZWVkUmVzdXJyZWN0GAogASgIEhIKCmNvaW5O" + "dW1iZXIYCyABKAMSEwoLY29pbkNvbnN1bWUYDCABKAMSHgoWY29vcGVyYXRl" + "VW5pcXVlU2tpbGxJRBgNIAEoBRIYChBhdHRyaWJ1dGVGYWN0b3JYGA4gASgF" + "EhgKEGF0dHJpYnV0ZUZhY3RvclkYDyABKAUSGAoQYXR0cmlidXRlRmFjdG9y" + "WhgQIAEoBRIbChNpbmRleE9mTWF4Q291bnRSYWNlGBEgASgFEhkKEW51bU9m" + "TWF4Q291bnRSYWNlGBIgASgFEhAKCGxlZnRUaW1lGBMgASgFEhUKDXRhcmdl" + "dEVuZW15SUQYFCABKAUSEwoLcmVzdXJyZWN0SFAYFSABKAUSIQoZY29vcGVy" + "YXRlVW5pcXVlU2tpbGxMZXZlbBgWIAEoBRISCgpWSExTa2lsbElEGBcgAygF" + "EhEKCVZITFJlc3VsdBgYIAEoBRItCgttYXN0ZXJTa2lsbBgZIAEoCzIYLlJv" + "bGVEYXRhRm9yRXhjaGFuZ2VJbmZvIrQCChdSb2xlRGF0YUZvckV4Y2hhbmdl" + "SW5mbxITCgtwbGF5ZXJMZXZlbBgBIAEoBRIKCgJJRBgCIAEoBRINCgVsZXZl" + "bBgDIAEoBRITCgthdHRyaWJ1dGVJRBgEIAMoBRIWCg5hdHRyaWJ1dGVWYWx1" + "ZRgFIAMoAxISCgpza2lsbExldmVsGAYgAygFEhEKCWFzdHJvbGFiZRgHIAMo" + "BRIRCgllcXVpcG1lbnQYCCADKAUSFgoOd2VhcG9uRWZmZWN0SUQYCSABKAUS" + "GQoRd2VhcG9uRWZmZWN0TGV2ZWwYCiABKAUSDgoGQUlDaGlwGAsgAygFEhYK" + "DmVxdWlwbWVudFNraWxsGAwgAygFEhgKEGVxdWlwbWVudFNraWxsTHYYDSAD" + "KAUSDQoFaXNWb3cYDiABKAginAMKEEJhdHRsZVJlc3VsdEluZm8SDgoGcmVz" + "dWx0GAEgASgIEhIKCmJhdHRsZVRpbWUYAiABKAUSFAoMdG90YWxEZWFkTnVt" + "GAMgASgFEhYKDnRvdGFsSGl0dGVkTnVtGAQgASgFEhIKCmluanVyZWROdW0Y" + "BSABKAMSEwoLZmFsbERvd25OdW0YBiABKAUSEwoLa25vY2tvdXROdW0YByAB" + "KAUSEAoIcXRlQ291bnQYCCABKAUSFgoOcmVzdXJyZWN0VGltZXMYCSABKAUS" + "IgoJY2hhcnNJbmZvGAogAygLMg8uQ2hhclJlc3VsdEluZm8SFAoMZW5lbXlE" + "ZWFkTnVtGAsgASgFEg4KBml0ZW1JRBgMIAMoBRISCgppdGVtTnVtYmVyGA0g" + "AygFEhQKDHJlY29yZERhdGFJRBgOIAMoBRIYChByZWNvcmREYXRhTnVtYmVy" + "GA8gAygFEhIKCkZyYW1lQ291bnQYECABKA0SEwoLYWNoaWV2ZW1lbnQYESAD" + "KAUSFwoPY2hvb3NlZEVmZmVjdElEGBIgAygFIm4KDkNoYXJSZXN1bHRJbmZv" + "Eg4KBkhlcm9JRBgBIAEoBRIRCglDdXJyZW50SFAYAiABKAMSDQoFTWF4SFAY" + "AyABKAMSDgoGRGFtYWdlGAQgASgDEgwKBEh1cnQYBSABKAMSDAoEQ3VyZRgG" + "IAEoAyIYChZPcF9DTURfRW50ZXJTb3VyY2VDb2RlIigKF09wX0NNRF9BYmls" + "aXR5RGlyZWN0aW9uEg0KBWFuZ2xlGAEgASgDIkEKFE9wX0NNRF9DaG9vc2Vf" + "VGFyZ2V0EhQKDGxhc3RUYXJnZXRJRBgBIAEoBRITCgtjYW1lcmFBbmdsZRgC" + "IAEoBSKwAQoRT3BfQ01EX1Rocm93X0l0ZW0SEQoJcG9zaXRpb25YGAEgASgF" + "EhEKCXBvc2l0aW9uWRgCIAEoBRIRCglwb3NpdGlvbloYAyABKAUSEAoIZm9y" + "d2FyZFgYBCABKAUSEAoIZm9yd2FyZFoYBSABKAUSEgoKdGltZWxpbmVJRBgG" + "IAEoBRIRCgl1c2VDb21tb24YByABKAgSFwoPc3Bhd25UaW1lbGluZUlEGAgg" + "ASgFIj4KE09wX0NNRF9TdWJfSm95c3RpY2sSEwoLY29tbWFuZENvZGUYASAB" + "KAUSEgoKdGltZWxpbmVJRBgCIAEoBSIOCgxPcF9DTURfU3RvcnkiOgoQT3Bf" + "Q01EX1Jlc3VycmVjdBIWCg50YXJnZXRFbnRpdHlJRBgBIAEoBRIOCgZyZXN1" + "bHQYAiABKAgiUAoRT3BfQzJCX1VuaXRfRnJhbWUSDgoGVW5pdElkGAEgASgD" + "Eg4KBm9wY29kZRgCIAEoAxIMCgRpY21mGAMgASgDEg0KBWZyYW1lGAQgASgM" + "IkUKE09wX0IyQ19TZXJ2ZXJfRnJhbWUSGgoSc2VydmVyX2ZyYW1lX2NvdW50" + "GAEgASgDEhIKCmFsbF9pbnB1dHMYAiABKAwiKQoLTWF0Y2hNZW1iZXISDQoF" + "bmV0SUQYASABKAMSCwoDcG9zGAIgASgFIqUBChJPcF9CMkNfc3RhcnRfbWF0" + "Y2gSEAoIcm9vbV9rZXkYASABKAMSOwoNcGxheWVyX25ldF9pZBgCIAMoCzIk" + "Lk9wX0IyQ19zdGFydF9tYXRjaC5QbGF5ZXJOZXRJZEVudHJ5GkAKEFBsYXll" + "ck5ldElkRW50cnkSCwoDa2V5GAEgASgEEhsKBXZhbHVlGAIgASgLMgwuTWF0" + "Y2hNZW1iZXI6AjgBIkcKEE9wX0MyQl9qb2luX3Jvb20SEQoJYmF0dGxlX2lk" + "GAEgASgDEg8KB2FjY291bnQYAiABKAkSDwoHcm9sZV9pZBgDIAEoBSJLChRP" + "cF9CMkNfYWNrX2pvaW5fcm9vbRIRCgliYXR0bGVfaWQYASABKAMSDwoHc2Vh" + "dF9pZBgCIAEoBRIPCgdyb2xlX2lkGAMgASgFIisKFk9wX0MyQl9mZXRjaF90" + "ZWFtX2luZm8SEQoJYmF0dGxlX2lkGAEgASgDIowBChpPcF9CMkNfYWNrX2Zl" + "dGNoX3RlYW1faW5mbxIzCgR0ZWFtGAEgAygLMiUuT3BfQjJDX2Fja19mZXRj" + "aF90ZWFtX2luZm8uVGVhbUVudHJ5GjkKCVRlYW1FbnRyeRILCgNrZXkYASAB" + "KAQSGwoFdmFsdWUYAiABKAsyDC5NYXRjaE1lbWJlcjoCOAEiigEKEk9wX0My" + "Ql9QbGF5ZXJSZWFkeRIMCgR1dWlkGAEgASgEEhAKCGJhdHRsZUlEGAIgASgD" + "EjkKFXNjZW5lRGF0YUZvckV4Y2VoYW5nZRgDIAEoCzIaLlNjZW5lRGF0YUZv" + "ckV4Y2VoYW5nZUluZm8SGQoRYmF0dGxlVmVyc2lvbkNvZGUYBCABKAUiKwoW" + "T3BfQjJDX2Fja19QbGF5ZXJSZWFkeRIRCglwbGF5ZXJfaWQYASABKAMiZgoT" + "T3BfQzJCX0JhdHRsZVJlc3VsdBIQCghiYXR0bGVJRBgBIAEoAxIMCgR1dWlk" + "GAIgASgEEg4KBnJlc3VsdBgDIAEoBRIfCgRpbmZvGAQgASgLMhEuQmF0dGxl" + "UmVzdWx0SW5mbyIgChBPcF9CMkNfRXJyb3JDb2RlEgwKBGNvZGUYASABKAUi" + "KQoXT3BfQjJDX0Fja19CYXR0bGVSZXN1bHQSDgoGcmVzdWx0GAEgASgFIikK" + "GU9wX0IyQ19BY2tfQmF0dGxlR1NSZXN1bHQSDAoEY29kZRgBIAEoBSIlChNP" + "cF9CMkNfQmF0dGxlRnJhbWVzEg4KBmZyYW1lcxgBIAEoDCJsChlPcF9DMkJf" + "QmF0dGxlUmVzdWx0T25saW5lEhAKCGJhdHRsZUlEGAEgASgDEgwKBHV1aWQY" + "AiABKAQSDgoGcmVzdWx0GAMgASgFEh8KBGluZm8YBCABKAsyES5CYXR0bGVS" + "ZXN1bHRJbmZvInQKGU9wX0IyR19CYXR0bGVSZXN1bHRPbmxpbmUSGAoQZ2Ft" + "ZVNlcnZlclJvb21JRBgBIAEoBRIMCgR1dWlkGAIgASgFEg4KBnJlc3VsdBgD" + "IAEoBRIfCgRpbmZvGAQgASgLMhEuQmF0dGxlUmVzdWx0SW5mbyITChFPcF9D" + "TURfRW5lbXlBbGVydCIbChlPcF9DTURfdHJpZ2dlcl9wYXJhbWV0ZXJzIkEK" + "Ek9wX0NNRF9tb3ZlX3RvX3BvcxINCgVwb3NfeBgBIAEoBRINCgVwb3NfeRgC" + "IAEoBRINCgVwb3NfehgDIAEoBSImChJPcF9DTURfQnV0dG9uU2hvb3QSEAoI" + "dGFyZ2V0SUQYASABKAUiLgoWT3BfQ01EX3NpZ25hbF9leGNoYW5nZRIUCgxz" + "aWduYWxfaW5kZXgYASABKAUiJQoST3BfQ01EX09ubGluZVJlYWR5Eg8KB2lz" + "UmVhZHkYASABKAgiLgoVT3BfQjJDX1BsYXllcl9PZmZsaW5lEhUKDW9mZmxp" + "bmVNZW1iZXIYASABKAUiLwoVT3BfQ01EX1BsYXllcl9PZmZsaW5lEhYKDm9m" + "ZmxpbmVfTWVtYmVyGAEgASgFIhwKCk9wX0NNRF9RVEUSDgoGc3RhdHVzGAEg" + "ASgFIi0KFE9wX0NNRF9Mb2NrTGlzdEVtZW55EhUKDWxvY2tfZW50aXR5SUQY" + "ASADKAUqewoLcm9vbV9zdGF0dXMSFAoQcm9vbV9zdGF0dXNfbm9uZRAAEhQK" + "EHJvb21fc3RhdHVzX2lkbGUQARIUChByb29tX3N0YXR1c19mdWxsEAISFQoR" + "cm9vbV9zdGF0dXNfcmVhZHkQAxITCg9yb29tX3N0YXR1c19ydW4QBCr0CAoV" + "TmV0cHJvdG9PcGVyYXRpb25Db2RlEggKBE5vbmUQABIICgRwaW5nEGQSCAoE" + "cG9uZxBlEhYKEkIyR19Db25uZWN0UmVxdWVzdBBmEhcKE0cyQl9Db25uZWN0" + "UmVzcG9uc2UQZxIUChBHMkJfc3RhcnRfYmF0dGxlEGgSGAoUQjJHX2Fja19z" + "dGFydF9iYXR0bGUQaRIUChBCMkdfQmF0dGxlUmVzdWx0EGoSGAoURzJCX0Fj" + "a19CYXR0bGVSZXN1bHQQaxISCg5HMkJfZW5kX2JhdHRsZRBsEhAKDENNRF9t" + "b3ZlX2RpchBtEhUKEUNNRF9zdG9wX21vdmVfZGlyEG4SFAoQQ01EX21lbGVl" + "X2F0dGFjaxBvEhMKD0NNRF9jaGFuZ2Vfcm9sZRBwEhEKDUNNRF9nYW1lX3N0" + "b3AQcRIcChhDTURfbW9kaWZ5X3RyaWdnZXJfc3RhdGUQchISCg5DTURfQUlf" + "Q29tbWFuZBBzEhcKE0NNRF9FbnRlclNvdXJjZUNvZGUQdBIYChRDTURfQWJp" + "bGl0eURpcmVjdGlvbhB1EhUKEUNNRF9DaG9vc2VfVGFyZ2V0EHYSEgoOQ01E" + "X1Rocm93X0l0ZW0QdxIUChBDTURfU3ViX0pveXN0aWNrEHgSDQoJQ01EX1N0" + "b3J5EHkSEQoNQ01EX1Jlc3VycmVjdBB6EhIKDkMyQl9Vbml0X0ZyYW1lEHsS" + "FAoQQjJDX1NlcnZlcl9GcmFtZRB8EhMKD0IyQ19zdGFydF9tYXRjaBB9EhEK" + "DUMyQl9qb2luX3Jvb20QfhIVChFCMkNfYWNrX2pvaW5fcm9vbRB/EhgKE0My" + "Ql9mZXRjaF90ZWFtX2luZm8QgAESHAoXQjJDX2Fja19mZXRjaF90ZWFtX2lu" + "Zm8QgQESFAoPQzJCX1BsYXllclJlYWR5EIIBEhgKE0IyQ19hY2tfUGxheWVy" + "UmVhZHkQgwESFQoQQzJCX0JhdHRsZVJlc3VsdBCEARISCg1CMkNfRXJyb3JD" + "b2RlEIUBEhkKFEIyQ19BY2tfQmF0dGxlUmVzdWx0EIYBEhsKFkIyQ19BY2tf" + "QmF0dGxlR1NSZXN1bHQQhwESFQoQQjJDX0JhdHRsZUZyYW1lcxCIARIbChZD" + "MkJfQmF0dGxlUmVzdWx0T25saW5lEIkBEhsKFkIyR19CYXR0bGVSZXN1bHRP" + "bmxpbmUQigESEwoOQ01EX0VuZW15QWxlcnQQiwESGwoWQ01EX3RyaWdnZXJf" + "cGFyYW1ldGVycxCMARIUCg9DTURfbW92ZV90b19wb3MQjQESFAoPQ01EX0J1" + "dHRvblNob290EI4BEhgKE0NNRF9zaWduYWxfZXhjaGFuZ2UQjwESFAoPQ01E" + "X09ubGluZVJlYWR5EJABEhcKEkIyQ19QbGF5ZXJfT2ZmbGluZRCRARIXChJD" + "TURfUGxheWVyX09mZmxpbmUQkgESDAoHQ01EX1FURRCTARIWChFDTURfTG9j" + "a0xpc3RFbWVueRCUAUIMqgIJTmV0UHJvY29sYgZwcm90bzM=");
		descriptor = FileDescriptor.FromGeneratedCode(descriptorData, new FileDescriptor[0], new GeneratedClrTypeInfo(new Type[2]
		{
			typeof(room_status),
			typeof(NetprotoOperationCode)
		}, new GeneratedClrTypeInfo[54]
		{
			new GeneratedClrTypeInfo(typeof(Op_ping), Op_ping.Parser, new string[1] { "ClientTime" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_pong), Op_pong.Parser, new string[2] { "ClientTime", "ServerTime" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2G_ConnectRequest), Op_B2G_ConnectRequest.Parser, new string[3] { "Port", "Timestamp", "Verification" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_G2B_ConnectResponse), Op_G2B_ConnectResponse.Parser, new string[3] { "ErrorCode", "BattleServerId", "IsServiceOpen" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_G2B_start_battle), Op_G2B_start_battle.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2G_ack_start_battle), Op_B2G_ack_start_battle.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2G_BattleResult), Op_B2G_BattleResult.Parser, new string[4] { "GameServerRoomID", "Uuid", "Result", "Info" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_G2B_Ack_BattleResult), Op_G2B_Ack_BattleResult.Parser, new string[1] { "ResultCode" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_G2B_end_battle), Op_G2B_end_battle.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_move_dir), Op_CMD_move_dir.Parser, new string[1] { "Angle" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_stop_move_dir), Op_CMD_stop_move_dir.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_melee_attack), Op_CMD_melee_attack.Parser, new string[1] { "AttackId" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_change_role), Op_CMD_change_role.Parser, new string[1] { "ConfigId" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_game_stop), Op_CMD_game_stop.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_modify_trigger_state), Op_CMD_modify_trigger_state.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_AI_Command), Op_CMD_AI_Command.Parser, new string[1] { "Type" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(SceneDataForExcehangeInfo), SceneDataForExcehangeInfo.Parser, new string[25]
			{
				"MSceneID", "MMissionClearTimes", "TypeIDListAffix", "LevelList", "EnemyTypes", "RoleDataInLua", "ChallengeFactor", "AdaptiveEnemyLevel", "Difficulty", "NeedResurrect",
				"CoinNumber", "CoinConsume", "CooperateUniqueSkillID", "AttributeFactorX", "AttributeFactorY", "AttributeFactorZ", "IndexOfMaxCountRace", "NumOfMaxCountRace", "LeftTime", "TargetEnemyID",
				"ResurrectHP", "CooperateUniqueSkillLevel", "VHLSkillID", "VHLResult", "MasterSkill"
			}, null, null, null),
			new GeneratedClrTypeInfo(typeof(RoleDataForExchangeInfo), RoleDataForExchangeInfo.Parser, new string[14]
			{
				"PlayerLevel", "ID", "Level", "AttributeID", "AttributeValue", "SkillLevel", "Astrolabe", "Equipment", "WeaponEffectID", "WeaponEffectLevel",
				"AIChip", "EquipmentSkill", "EquipmentSkillLv", "IsVow"
			}, null, null, null),
			new GeneratedClrTypeInfo(typeof(BattleResultInfo), BattleResultInfo.Parser, new string[18]
			{
				"Result", "BattleTime", "TotalDeadNum", "TotalHittedNum", "InjuredNum", "FallDownNum", "KnockoutNum", "QteCount", "ResurrectTimes", "CharsInfo",
				"EnemyDeadNum", "ItemID", "ItemNumber", "RecordDataID", "RecordDataNumber", "FrameCount", "Achievement", "ChoosedEffectID"
			}, null, null, null),
			new GeneratedClrTypeInfo(typeof(CharResultInfo), CharResultInfo.Parser, new string[6] { "HeroID", "CurrentHP", "MaxHP", "Damage", "Hurt", "Cure" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_EnterSourceCode), Op_CMD_EnterSourceCode.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_AbilityDirection), Op_CMD_AbilityDirection.Parser, new string[1] { "Angle" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_Choose_Target), Op_CMD_Choose_Target.Parser, new string[2] { "LastTargetID", "CameraAngle" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_Throw_Item), Op_CMD_Throw_Item.Parser, new string[8] { "PositionX", "PositionY", "PositionZ", "ForwardX", "ForwardZ", "TimelineID", "UseCommon", "SpawnTimelineID" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_Sub_Joystick), Op_CMD_Sub_Joystick.Parser, new string[2] { "CommandCode", "TimelineID" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_Story), Op_CMD_Story.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_Resurrect), Op_CMD_Resurrect.Parser, new string[2] { "TargetEntityID", "Result" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_C2B_Unit_Frame), Op_C2B_Unit_Frame.Parser, new string[4] { "UnitId", "Opcode", "Icmf", "Frame" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_Server_Frame), Op_B2C_Server_Frame.Parser, new string[2] { "ServerFrameCount", "AllInputs" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(MatchMember), MatchMember.Parser, new string[2] { "NetID", "Pos" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_start_match), Op_B2C_start_match.Parser, new string[2] { "RoomKey", "PlayerNetId" }, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(Op_C2B_join_room), Op_C2B_join_room.Parser, new string[3] { "BattleId", "Account", "RoleId" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_ack_join_room), Op_B2C_ack_join_room.Parser, new string[3] { "BattleId", "SeatId", "RoleId" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_C2B_fetch_team_info), Op_C2B_fetch_team_info.Parser, new string[1] { "BattleId" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_ack_fetch_team_info), Op_B2C_ack_fetch_team_info.Parser, new string[1] { "Team" }, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(Op_C2B_PlayerReady), Op_C2B_PlayerReady.Parser, new string[4] { "Uuid", "BattleID", "SceneDataForExcehange", "BattleVersionCode" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_ack_PlayerReady), Op_B2C_ack_PlayerReady.Parser, new string[1] { "PlayerId" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_C2B_BattleResult), Op_C2B_BattleResult.Parser, new string[4] { "BattleID", "Uuid", "Result", "Info" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_ErrorCode), Op_B2C_ErrorCode.Parser, new string[1] { "Code" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_Ack_BattleResult), Op_B2C_Ack_BattleResult.Parser, new string[1] { "Result" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_Ack_BattleGSResult), Op_B2C_Ack_BattleGSResult.Parser, new string[1] { "Code" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_BattleFrames), Op_B2C_BattleFrames.Parser, new string[1] { "Frames" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_C2B_BattleResultOnline), Op_C2B_BattleResultOnline.Parser, new string[4] { "BattleID", "Uuid", "Result", "Info" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2G_BattleResultOnline), Op_B2G_BattleResultOnline.Parser, new string[4] { "GameServerRoomID", "Uuid", "Result", "Info" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_EnemyAlert), Op_CMD_EnemyAlert.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_trigger_parameters), Op_CMD_trigger_parameters.Parser, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_move_to_pos), Op_CMD_move_to_pos.Parser, new string[3] { "PosX", "PosY", "PosZ" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_ButtonShoot), Op_CMD_ButtonShoot.Parser, new string[1] { "TargetID" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_signal_exchange), Op_CMD_signal_exchange.Parser, new string[1] { "SignalIndex" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_OnlineReady), Op_CMD_OnlineReady.Parser, new string[1] { "IsReady" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_B2C_Player_Offline), Op_B2C_Player_Offline.Parser, new string[1] { "OfflineMember" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_Player_Offline), Op_CMD_Player_Offline.Parser, new string[1] { "OfflineMember" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_QTE), Op_CMD_QTE.Parser, new string[1] { "Status" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(Op_CMD_LockListEmeny), Op_CMD_LockListEmeny.Parser, new string[1] { "LockEntityID" }, null, null, null)
		}));
	}
}
