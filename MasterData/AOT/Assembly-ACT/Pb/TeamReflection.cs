using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class TeamReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static TeamReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cgp0ZWFtLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIi0KC1RlYW1JbmZvTnRm" + "Eh4KCHRlYW1JbmZvGAEgASgLMgwucGIuVGVhbUluZm8iZAoUUmVwbGFjZVBy" + "ZXNldFRlYW1SZXESCwoDaWR4GAEgASgFEhsKBHRlYW0YAiABKAsyDS5wYi5U" + "ZWFtVXNhZ2USIgoKcHJlc2V0VGVhbRgDIAEoCzIOLnBiLlByZXNldFRlYW0i" + "FgoUUmVwbGFjZVByZXNldFRlYW1BY2siSAoSU2F2ZVByZXNldFRlYW1zUmVx" + "Eh0KBXRlYW1zGAEgAygLMg4ucGIuUHJlc2V0VGVhbRITCgttYWluVGVhbUlk" + "eBgCIAEoBSIUChJTYXZlUHJlc2V0VGVhbXNBY2siNAoXTW9kaWZ5UHJlc2V0" + "VGVhbU5hbWVSZXESCwoDaWR4GAEgASgFEgwKBG5hbWUYAiABKAkiGQoXTW9k" + "aWZ5UHJlc2V0VGVhbU5hbWVBY2siHwoQRGVsUHJlc2V0VGVhbVJlcRILCgNp" + "ZHgYASABKAUiEgoQRGVsUHJlc2V0VGVhbUFjayIiChNSZWNvcmRCYXR0bGVU" + "ZWFtUmVxEgsKA2lkeBgBIAEoBSIVChNSZWNvcmRCYXR0bGVUZWFtQWNrIkgK" + "ElVwZGF0ZVVzYWdlVGVhbVJlcRIRCglzY2VuZUVudW0YASABKAUSHwoIbmV3" + "VXNhZ2UYAiABKAsyDS5wYi5UZWFtVXNhZ2UiegoSVXBkYXRlVXNhZ2VUZWFt" + "QWNrEhEKCXNjZW5lRW51bRgBIAEoBRIbCgV0ZWFtcxgCIAEoCzIMLnBiLlRl" + "YW1MaXN0EjQKE2NoYXJhY3RlclJlcG9zaXRvcnkYAyABKAsyFy5wYi5DaGFy" + "YWN0ZXJSZXBvc2l0b3J5YgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[13]
		{
			new GeneratedClrTypeInfo(typeof(TeamInfoNtf), TeamInfoNtf.Parser, new string[1] { "TeamInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ReplacePresetTeamReq), ReplacePresetTeamReq.Parser, new string[3] { "Idx", "Team", "PresetTeam" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ReplacePresetTeamAck), ReplacePresetTeamAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SavePresetTeamsReq), SavePresetTeamsReq.Parser, new string[2] { "Teams", "MainTeamIdx" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SavePresetTeamsAck), SavePresetTeamsAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ModifyPresetTeamNameReq), ModifyPresetTeamNameReq.Parser, new string[2] { "Idx", "Name" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ModifyPresetTeamNameAck), ModifyPresetTeamNameAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DelPresetTeamReq), DelPresetTeamReq.Parser, new string[1] { "Idx" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(DelPresetTeamAck), DelPresetTeamAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordBattleTeamReq), RecordBattleTeamReq.Parser, new string[1] { "Idx" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordBattleTeamAck), RecordBattleTeamAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UpdateUsageTeamReq), UpdateUsageTeamReq.Parser, new string[2] { "SceneEnum", "NewUsage" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UpdateUsageTeamAck), UpdateUsageTeamAck.Parser, new string[3] { "SceneEnum", "Teams", "CharacterRepository" }, null, null, null, null)
		}));
	}
}
