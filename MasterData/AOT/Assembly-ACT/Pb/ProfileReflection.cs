using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class ProfileReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static ProfileReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg1wcm9maWxlLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIjMKEFJlY29yZExh" + "c3RQb3NSZXESHwoIcG9zaXRpb24YASABKAsyDS5wYi5QQlZlY3RvcjMiEgoQ" + "UmVjb3JkTGFzdFBvc0FjayI1ChFSZWNvcmRTcGF3blBvc1JlcRIgCgRpbmZv" + "GAEgASgLMhIucGIuU2NlbmVTcGF3bkluZm8iEwoRUmVjb3JkU3Bhd25Qb3NB" + "Y2siQAoWUmVjb3JkVG1wQXJjaGl2ZVBvc1JlcRImCgRpbmZvGAEgASgLMhgu" + "cGIuU2NlbmVUZW1wQXJjaGl2ZUluZm8iGAoWUmVjb3JkVG1wQXJjaGl2ZVBv" + "c0FjayIgChFSZWNvcmRDaGVja1Bvc1JlcRILCgN1aWQYASABKAUiEwoRUmVj" + "b3JkQ2hlY2tQb3NBY2siKAoURXNjTW9kaWZ5Tmlja25hbWVSZXESEAoIbmlj" + "a25hbWUYASABKAkiFgoURXNjTW9kaWZ5Tmlja25hbWVBY2siKgoVRXNjTW9k" + "aWZ5U2lnbmF0dXJlUmVxEhEKCXNpZ25hdHVyZRgBIAEoCSIXChVFc2NNb2Rp" + "ZnlTaWduYXR1cmVBY2siJgoSRXNjTW9kaWZ5QXZhdGFyUmVxEhAKCGF2YXRh" + "cklkGAEgASgFIhQKEkVzY01vZGlmeUF2YXRhckFjayIkCgxFc2NBdmF0YXJO" + "dGYSFAoMZ2V0QXZhdGFySWRzGAEgAygFIjAKF0VzY01vZGlmeUF2YXRhckZy" + "YW1lUmVxEhUKDWF2YXRhckZyYW1lSWQYASABKAUiGQoXRXNjTW9kaWZ5QXZh" + "dGFyRnJhbWVBY2siLgoRRXNjQXZhdGFyRnJhbWVOdGYSGQoRZ2V0QXZhdGFy" + "RnJhbWVJZHMYASADKAUiJAoRRXNjTW9kaWZ5VGl0bGVSZXESDwoHdGl0bGVJ" + "ZBgBIAEoBSITChFFc2NNb2RpZnlUaXRsZUFjayIiCgtFc2NUaXRsZU50ZhIT" + "CgtnZXRUaXRsZUlkcxgBIAMoBSI1ChlFc2NNb2RpZnlTaG93Q2hhcmFjdGVy" + "UmVxEhgKEHNob3dDaGFyYWN0ZXJJZHMYASADKAUiGwoZRXNjTW9kaWZ5U2hv" + "d0NoYXJhY3RlckFjayIkChNTYXZlUGxheWluZ011c2ljUmVxEg0KBW11c2lj" + "GAEgASgFIhUKE1NhdmVQbGF5aW5nTXVzaWNBY2siIwoTUXVlcnlVc2VyUHJv" + "ZmlsZVJlcRIMCgR1aWRzGAEgAygDIj4KE1F1ZXJ5VXNlclByb2ZpbGVBY2sS" + "JwoIcHJvZmlsZXMYASADKAsyFS5wYi5Ob3JtYWxVc2VyUHJvZmlsZSIhCg9D" + "aGFuZ2VHZW5kZXJSZXESDgoGZ2VuZGVyGAEgASgFIqEBCg9DaGFuZ2VHZW5k" + "ZXJBY2sSEwoLY3VyQXZhdGFySWQYASABKAUSNQoJYXZhdGFySWRzGAIgAygL" + "MiIucGIuQ2hhbmdlR2VuZGVyQWNrLkF2YXRhcklkc0VudHJ5EhAKCGNoYW5n" + "ZVRTGAMgASgFGjAKDkF2YXRhcklkc0VudHJ5EgsKA2tleRgBIAEoBRINCgV2" + "YWx1ZRgCIAEoCDoCOAFiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[29]
		{
			new GeneratedClrTypeInfo(typeof(RecordLastPosReq), RecordLastPosReq.Parser, new string[1] { "Position" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordLastPosAck), RecordLastPosAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordSpawnPosReq), RecordSpawnPosReq.Parser, new string[1] { "Info" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordSpawnPosAck), RecordSpawnPosAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordTmpArchivePosReq), RecordTmpArchivePosReq.Parser, new string[1] { "Info" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordTmpArchivePosAck), RecordTmpArchivePosAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordCheckPosReq), RecordCheckPosReq.Parser, new string[1] { "Uid" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecordCheckPosAck), RecordCheckPosAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyNicknameReq), EscModifyNicknameReq.Parser, new string[1] { "Nickname" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyNicknameAck), EscModifyNicknameAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifySignatureReq), EscModifySignatureReq.Parser, new string[1] { "Signature" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifySignatureAck), EscModifySignatureAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyAvatarReq), EscModifyAvatarReq.Parser, new string[1] { "AvatarId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyAvatarAck), EscModifyAvatarAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscAvatarNtf), EscAvatarNtf.Parser, new string[1] { "GetAvatarIds" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyAvatarFrameReq), EscModifyAvatarFrameReq.Parser, new string[1] { "AvatarFrameId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyAvatarFrameAck), EscModifyAvatarFrameAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscAvatarFrameNtf), EscAvatarFrameNtf.Parser, new string[1] { "GetAvatarFrameIds" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyTitleReq), EscModifyTitleReq.Parser, new string[1] { "TitleId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyTitleAck), EscModifyTitleAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscTitleNtf), EscTitleNtf.Parser, new string[1] { "GetTitleIds" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyShowCharacterReq), EscModifyShowCharacterReq.Parser, new string[1] { "ShowCharacterIds" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EscModifyShowCharacterAck), EscModifyShowCharacterAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SavePlayingMusicReq), SavePlayingMusicReq.Parser, new string[1] { "Music" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(SavePlayingMusicAck), SavePlayingMusicAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(QueryUserProfileReq), QueryUserProfileReq.Parser, new string[1] { "Uids" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(QueryUserProfileAck), QueryUserProfileAck.Parser, new string[1] { "Profiles" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChangeGenderReq), ChangeGenderReq.Parser, new string[1] { "Gender" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ChangeGenderAck), ChangeGenderAck.Parser, new string[3] { "CurAvatarId", "AvatarIds", "ChangeTS" }, null, null, null, new GeneratedClrTypeInfo[1])
		}));
	}
}
