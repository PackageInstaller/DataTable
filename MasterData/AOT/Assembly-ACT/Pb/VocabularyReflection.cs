using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class VocabularyReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static VocabularyReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("ChB2b2NhYnVsYXJ5LnByb3RvEgJwYhoMY29tbW9uLnByb3RvIu4CCg1Wb2Nh" + "YnVsYXJ5TnRmEjUKCkdyb3VwU3RhdGUYASADKAsyIS5wYi5Wb2NhYnVsYXJ5" + "TnRmLkdyb3VwU3RhdGVFbnRyeRI5CgxDb250ZW50U3RhdGUYAiADKAsyIy5w" + "Yi5Wb2NhYnVsYXJ5TnRmLkNvbnRlbnRTdGF0ZUVudHJ5EjcKC0NvbnRlbnRJ" + "bmZvGAMgAygLMiIucGIuVm9jYWJ1bGFyeU50Zi5Db250ZW50SW5mb0VudHJ5" + "GjEKD0dyb3VwU3RhdGVFbnRyeRILCgNrZXkYASABKAUSDQoFdmFsdWUYAiAB" + "KAg6AjgBGjMKEUNvbnRlbnRTdGF0ZUVudHJ5EgsKA2tleRgBIAEoBRINCgV2" + "YWx1ZRgCIAEoCDoCOAEaSgoQQ29udGVudEluZm9FbnRyeRILCgNrZXkYASAB" + "KAUSJQoFdmFsdWUYAiABKAsyFi5wYi5UZXh0TGlicmFyeUNvbnRlbnQ6AjgB" + "IiwKGlZvY2FidWxhcnlVbmxvY2tDb250ZW50UmVxEg4KBmlkTGlzdBgBIAMo" + "BSKiAwoaVm9jYWJ1bGFyeVVubG9ja0NvbnRlbnRBY2sSQgoKR3JvdXBTdGF0" + "ZRgBIAMoCzIuLnBiLlZvY2FidWxhcnlVbmxvY2tDb250ZW50QWNrLkdyb3Vw" + "U3RhdGVFbnRyeRJGCgxDb250ZW50U3RhdGUYAiADKAsyMC5wYi5Wb2NhYnVs" + "YXJ5VW5sb2NrQ29udGVudEFjay5Db250ZW50U3RhdGVFbnRyeRJECgtDb250" + "ZW50SW5mbxgDIAMoCzIvLnBiLlZvY2FidWxhcnlVbmxvY2tDb250ZW50QWNr" + "LkNvbnRlbnRJbmZvRW50cnkaMQoPR3JvdXBTdGF0ZUVudHJ5EgsKA2tleRgB" + "IAEoBRINCgV2YWx1ZRgCIAEoCDoCOAEaMwoRQ29udGVudFN0YXRlRW50cnkS" + "CwoDa2V5GAEgASgFEg0KBXZhbHVlGAIgASgIOgI4ARpKChBDb250ZW50SW5m" + "b0VudHJ5EgsKA2tleRgBIAEoBRIlCgV2YWx1ZRgCIAEoCzIWLnBiLlRleHRM" + "aWJyYXJ5Q29udGVudDoCOAEiKgoYVm9jYWJ1bGFyeVJlYWRDb250ZW50UmVx" + "Eg4KBmlkTGlzdBgBIAMoBSKlAgoYVm9jYWJ1bGFyeVJlYWRDb250ZW50QWNr" + "EkQKDENvbnRlbnRTdGF0ZRgBIAMoCzIuLnBiLlZvY2FidWxhcnlSZWFkQ29u" + "dGVudEFjay5Db250ZW50U3RhdGVFbnRyeRJCCgtDb250ZW50SW5mbxgCIAMo" + "CzItLnBiLlZvY2FidWxhcnlSZWFkQ29udGVudEFjay5Db250ZW50SW5mb0Vu" + "dHJ5GjMKEUNvbnRlbnRTdGF0ZUVudHJ5EgsKA2tleRgBIAEoBRINCgV2YWx1" + "ZRgCIAEoCDoCOAEaSgoQQ29udGVudEluZm9FbnRyeRILCgNrZXkYASABKAUS" + "JQoFdmFsdWUYAiABKAsyFi5wYi5UZXh0TGlicmFyeUNvbnRlbnQ6AjgBIp0B" + "Ch9Wb2NhYnVsYXJ5UmVtZW1iZXJHcm91cFN0YXRlUmVxEkcKCkdyb3VwU3Rh" + "dGUYASADKAsyMy5wYi5Wb2NhYnVsYXJ5UmVtZW1iZXJHcm91cFN0YXRlUmVx" + "Lkdyb3VwU3RhdGVFbnRyeRoxCg9Hcm91cFN0YXRlRW50cnkSCwoDa2V5GAEg" + "ASgFEg0KBXZhbHVlGAIgASgIOgI4ASIhCh9Wb2NhYnVsYXJ5UmVtZW1iZXJH" + "cm91cFN0YXRlQWNrYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[7]
		{
			new GeneratedClrTypeInfo(typeof(VocabularyNtf), VocabularyNtf.Parser, new string[3] { "GroupState", "ContentState", "ContentInfo" }, null, null, null, new GeneratedClrTypeInfo[3]),
			new GeneratedClrTypeInfo(typeof(VocabularyUnlockContentReq), VocabularyUnlockContentReq.Parser, new string[1] { "IdList" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(VocabularyUnlockContentAck), VocabularyUnlockContentAck.Parser, new string[3] { "GroupState", "ContentState", "ContentInfo" }, null, null, null, new GeneratedClrTypeInfo[3]),
			new GeneratedClrTypeInfo(typeof(VocabularyReadContentReq), VocabularyReadContentReq.Parser, new string[1] { "IdList" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(VocabularyReadContentAck), VocabularyReadContentAck.Parser, new string[2] { "ContentState", "ContentInfo" }, null, null, null, new GeneratedClrTypeInfo[2]),
			new GeneratedClrTypeInfo(typeof(VocabularyRememberGroupStateReq), VocabularyRememberGroupStateReq.Parser, new string[1] { "GroupState" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(VocabularyRememberGroupStateAck), VocabularyRememberGroupStateAck.Parser, null, null, null, null, null)
		}));
	}
}
