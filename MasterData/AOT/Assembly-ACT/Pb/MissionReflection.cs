using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class MissionReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static MissionReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg1taXNzaW9uLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIjoKFU1pc3Npb25V" + "cGRhdGVTdGF0ZVJlcRIhCgdtaXNzaW9uGAEgASgLMhAucGIuTWlzc2lvblN0" + "YXRlIjIKFU1pc3Npb25VcGRhdGVTdGF0ZUFjaxIZCgdyZXdhcmRzGAEgAygL" + "MggucGIuSXRlbSIeChBBY2NlcHRNaXNzaW9uUmVxEgoKAmlkGAEgASgFIjQK" + "EEFjY2VwdE1pc3Npb25BY2sSCgoCb2sYASABKAgSFAoMZXJyb3JNZXNzYWdl" + "GAIgASgJIi8KCk1pc3Npb25OdGYSIQoHbWlzc2lvbhgBIAMoCzIQLnBiLk1p" + "c3Npb25TdGF0ZSIiChRNaXNzaW9uTW9uc3RlckRpZVJlcRIKCgJpZBgBIAEo" + "BSIWChRNaXNzaW9uTW9uc3RlckRpZUFjayI+ChlNaXNzaW9uVXBkYXRlQmx1" + "ZVByaW50UmVxEiEKB21pc3Npb24YASABKAsyEC5wYi5NaXNzaW9uU3RhdGUi" + "GwoZTWlzc2lvblVwZGF0ZUJsdWVQcmludEFjayI+ChNNaXNzaW9uQXBwbHlJ" + "dGVtUmVxEhEKCW1pc3Npb25JZBgBIAEoBRIUCgxjb2xsZWN0aW9uSWQYAiAB" + "KAUiLgoTTWlzc2lvbkFwcGx5SXRlbUFjaxIXCgVpdGVtcxgBIAMoCzIILnBi" + "Lkl0ZW0ifQoLTWlzc2lvblJOdGYSLwoIbWlzc2lvbnMYASADKAsyHS5wYi5N" + "aXNzaW9uUk50Zi5NaXNzaW9uc0VudHJ5Gj0KDU1pc3Npb25zRW50cnkSCwoD" + "a2V5GAEgASgDEhsKBXZhbHVlGAIgASgLMgwucGIuTWlzc2lvblI6AjgBIoMB" + "Cg5OZXdNaXNzaW9uUk50ZhIyCghtaXNzaW9ucxgBIAMoCzIgLnBiLk5ld01p" + "c3Npb25STnRmLk1pc3Npb25zRW50cnkaPQoNTWlzc2lvbnNFbnRyeRILCgNr" + "ZXkYASABKAMSGwoFdmFsdWUYAiABKAsyDC5wYi5NaXNzaW9uUjoCOAEicwoV" + "TWlzc2lvblN0YXRlVXBkYXRlTnRmEhEKCW1pc3Npb25JRBgBIAEoAxIjCgVz" + "dGF0ZRgCIAEoDjIULnBiLk1pc3Npb25TdGF0ZUVudW0SIgoHcmV3YXJkcxgD" + "IAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0iTwoVTWlzc2lvblN0YXRlVXBkYXRl" + "UmVxEhEKCW1pc3Npb25JRBgBIAEoAxIjCgVzdGF0ZRgCIAEoDjIULnBiLk1p" + "c3Npb25TdGF0ZUVudW0iFwoVTWlzc2lvblN0YXRlVXBkYXRlQWNrImUKGE1p" + "c3Npb25Db25kaXRpb25TdGF0ZU50ZhIRCgltaXNzaW9uSUQYASABKAMSEwoL" + "Y29uZGl0aW9uSUQYAiABKAUSEAoIcHJvZ3Jlc3MYAyABKAUSDwoHc3VjY2Vz" + "cxgEIAEoCCJwCiVNaXNzaW9uQ29uZGl0aW9uQWN0aW9uUGFpckNvbXBsZXRl" + "TnRmEhEKCW1pc3Npb25JRBgBIAEoAxIPCgdwYWlySWR4GAIgASgFEiMKBXN0" + "YXRlGAMgASgOMhQucGIuTWlzc2lvblN0YXRlRW51bSJUChlNaXNzaW9uQ29u" + "ZGl0aW9uVXBkYXRlUmVxEhEKCW1pc3Npb25JRBgBIAEoAxITCgtjb25kaXRp" + "b25JRBgCIAEoBRIPCgdzdWNjZXNzGAMgASgIIhsKGU1pc3Npb25Db25kaXRp" + "b25VcGRhdGVBY2siSgoWTWlzc2lvbkZsb3dDb21wbGV0ZU50ZhIRCgltaXNz" + "aW9uSUQYASABKAMSHQoEZmxvdxgCIAEoCzIPLnBiLk1pc3Npb25GbG93IkgK" + "FE1pc3Npb25GbG93VXBkYXRlTnRmEhEKCW1pc3Npb25JRBgBIAEoAxIdCgRm" + "bG93GAIgASgLMg8ucGIuTWlzc2lvbkZsb3ciJQoQTWlzc2lvbkFjY2VwdFJl" + "cRIRCgltaXNzaW9uSUQYASABKAMiEgoQTWlzc2lvbkFjY2VwdEFjayIpChBN" + "aXNzaW9uRXhwaXJlTnRmEhUKDW1pc3Npb25JRExpc3QYASADKAMiLQoYUmVw" + "bGFjTWlzc2lvblRyYWNraW5nUmVxEhEKCW1pc3Npb25JRBgBIAEoAyIaChhS" + "ZXBsYWNNaXNzaW9uVHJhY2tpbmdBY2siJwoSTWlzc2lvblRyYWNraW5nTnRm" + "EhEKCW1pc3Npb25JRBgBIAEoAyImChFNaXNzaW9uUkFjY2VwdFJlcRIRCglt" + "aXNzaW9uSUQYASABKAMiEwoRTWlzc2lvblJBY2NlcHRBY2sicAoVTWlzc2lv" + "blJVcGRhdGVGbG93UmVxEhEKCW1pc3Npb25JRBgBIAEoAxIdCgRmbG93GAIg" + "ASgLMg8ucGIuTWlzc2lvbkZsb3cSJQoIZmxvd1R5cGUYAyABKA4yEy5wYi5N" + "aXNzaW9uRmxvd1R5cGUiNgoVTWlzc2lvblJVcGRhdGVGbG93QWNrEh0KBGZs" + "b3cYASABKAsyDy5wYi5NaXNzaW9uRmxvdyKSAQoaTWlzc2lvblJDb25kaXRp" + "b25VcGRhdGVSZXESEQoJbWlzc2lvbklEGAEgASgDEhEKCWZsb3dJbmRleBgC" + "IAEoBRInCgljb25kaXRpb24YAyABKAsyFC5wYi5UcmlnZ2VyQ29uZGl0aW9u" + "EiUKCGZsb3dUeXBlGAQgASgOMhMucGIuTWlzc2lvbkZsb3dUeXBlIhwKGk1p" + "c3Npb25SQ29uZGl0aW9uVXBkYXRlQWNrIpoBChdNaXNzaW9uUkFjdGlvblVw" + "ZGF0ZVJlcRIRCgltaXNzaW9uSUQYASABKAMSEQoJZmxvd0luZGV4GAIgASgF" + "Eg8KB3BhaXJJZHgYAyABKAUSIQoGYWN0aW9uGAQgASgLMhEucGIuVHJpZ2dl" + "ckFjdGlvbhIlCghmbG93VHlwZRgFIAEoDjITLnBiLk1pc3Npb25GbG93VHlw" + "ZSIZChdNaXNzaW9uUkFjdGlvblVwZGF0ZUFjayJQChZNaXNzaW9uUlVwZGF0" + "ZVN0YXRlUmVxEhEKCW1pc3Npb25JRBgBIAEoAxIjCgVzdGF0ZRgCIAEoDjIU" + "LnBiLk1pc3Npb25TdGF0ZUVudW0iPAoWTWlzc2lvblJVcGRhdGVTdGF0ZUFj" + "axIiCgdyZXdhcmRzGAEgAygLMhEucGIuVW5pdmVyc2FsSXRlbWIGcHJvdG8z"), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[38]
		{
			new GeneratedClrTypeInfo(typeof(MissionUpdateStateReq), MissionUpdateStateReq.Parser, new string[1] { "Mission" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionUpdateStateAck), MissionUpdateStateAck.Parser, new string[1] { "Rewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AcceptMissionReq), AcceptMissionReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(AcceptMissionAck), AcceptMissionAck.Parser, new string[2] { "Ok", "ErrorMessage" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionNtf), MissionNtf.Parser, new string[1] { "Mission" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionMonsterDieReq), MissionMonsterDieReq.Parser, new string[1] { "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionMonsterDieAck), MissionMonsterDieAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionUpdateBluePrintReq), MissionUpdateBluePrintReq.Parser, new string[1] { "Mission" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionUpdateBluePrintAck), MissionUpdateBluePrintAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionApplyItemReq), MissionApplyItemReq.Parser, new string[2] { "MissionId", "CollectionId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionApplyItemAck), MissionApplyItemAck.Parser, new string[1] { "Items" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRNtf), MissionRNtf.Parser, new string[1] { "Missions" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(NewMissionRNtf), NewMissionRNtf.Parser, new string[1] { "Missions" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(MissionStateUpdateNtf), MissionStateUpdateNtf.Parser, new string[3] { "MissionID", "State", "Rewards" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionStateUpdateReq), MissionStateUpdateReq.Parser, new string[2] { "MissionID", "State" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionStateUpdateAck), MissionStateUpdateAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionConditionStateNtf), MissionConditionStateNtf.Parser, new string[4] { "MissionID", "ConditionID", "Progress", "Success" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionConditionActionPairCompleteNtf), MissionConditionActionPairCompleteNtf.Parser, new string[3] { "MissionID", "PairIdx", "State" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionConditionUpdateReq), MissionConditionUpdateReq.Parser, new string[3] { "MissionID", "ConditionID", "Success" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionConditionUpdateAck), MissionConditionUpdateAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionFlowCompleteNtf), MissionFlowCompleteNtf.Parser, new string[2] { "MissionID", "Flow" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionFlowUpdateNtf), MissionFlowUpdateNtf.Parser, new string[2] { "MissionID", "Flow" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionAcceptReq), MissionAcceptReq.Parser, new string[1] { "MissionID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionAcceptAck), MissionAcceptAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionExpireNtf), MissionExpireNtf.Parser, new string[1] { "MissionIDList" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ReplacMissionTrackingReq), ReplacMissionTrackingReq.Parser, new string[1] { "MissionID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ReplacMissionTrackingAck), ReplacMissionTrackingAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionTrackingNtf), MissionTrackingNtf.Parser, new string[1] { "MissionID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRAcceptReq), MissionRAcceptReq.Parser, new string[1] { "MissionID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRAcceptAck), MissionRAcceptAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRUpdateFlowReq), MissionRUpdateFlowReq.Parser, new string[3] { "MissionID", "Flow", "FlowType" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRUpdateFlowAck), MissionRUpdateFlowAck.Parser, new string[1] { "Flow" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRConditionUpdateReq), MissionRConditionUpdateReq.Parser, new string[4] { "MissionID", "FlowIndex", "Condition", "FlowType" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRConditionUpdateAck), MissionRConditionUpdateAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRActionUpdateReq), MissionRActionUpdateReq.Parser, new string[5] { "MissionID", "FlowIndex", "PairIdx", "Action", "FlowType" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRActionUpdateAck), MissionRActionUpdateAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRUpdateStateReq), MissionRUpdateStateReq.Parser, new string[2] { "MissionID", "State" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MissionRUpdateStateAck), MissionRUpdateStateAck.Parser, new string[1] { "Rewards" }, null, null, null, null)
		}));
	}
}
