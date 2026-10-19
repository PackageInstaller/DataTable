using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class MapReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static MapReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgltYXAucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iNgoVTWFwU2V0dXBDdXN0" + "b21GbGFnUmVxEh0KAmNmGAEgASgLMhEucGIuTWFwQ3VzdG9tRmxhZyI2ChVN" + "YXBTZXR1cEN1c3RvbUZsYWdBY2sSHQoCY2YYASABKAsyES5wYi5NYXBDdXN0" + "b21GbGFnIkwKGk1hcE1vZGlmeUN1c3RvbUZsYWdUeXBlUmVxEg4KBmFyZWFJ" + "RBgBIAEoBRIOCgZmbGFnSUQYAiABKAUSDgoGbmV3VHlwGAMgASgFIkkKGk1h" + "cE1vZGlmeUN1c3RvbUZsYWdUeXBlQWNrEisKEGxhdGVzdEN1c3RvbUZsYWcY" + "ASABKAsyES5wYi5NYXBDdXN0b21GbGFnIjUKE01hcERlbEN1c3RvbUZsYWdS" + "ZXESDgoGYXJlYUlEGAEgASgFEg4KBmZsYWdJRBgCIAEoBSIVChNNYXBEZWxD" + "dXN0b21GbGFnQWNrIisKGU1hcEZldGNoQ3VzdG9tRmxhZ0luZm9SZXESDgoG" + "YXJlYUlEGAEgASgFIkIKGU1hcEZldGNoQ3VzdG9tRmxhZ0luZm9BY2sSJQoJ" + "YXJlYUZsYWdzGAEgASgLMhIucGIuTWFwQ3VzdG9tRmxhZ3MikAEKEE1hcEN1" + "c3RvbUZsYWdOdGYSNgoJYXJlYUZsYWdzGAEgAygLMiMucGIuTWFwQ3VzdG9t" + "RmxhZ050Zi5BcmVhRmxhZ3NFbnRyeRpECg5BcmVhRmxhZ3NFbnRyeRILCgNr" + "ZXkYASABKAUSIQoFdmFsdWUYAiABKAsyEi5wYi5NYXBDdXN0b21GbGFnczoC" + "OAEiSgoVTWFwU2V0dXBUcmFjZVBvaW50UmVxEiEKBXBvaW50GAEgASgLMhIu" + "cGIuTWFwVHJhbmNlUG9pbnQSDgoGY2FuY2VsGAIgASgIIhcKFU1hcFNldHVw" + "VHJhY2VQb2ludEFjayI2ChFNYXBUcmFuY2VQb2ludE50ZhIhCgVwb2ludBgB" + "IAEoCzISLnBiLk1hcFRyYW5jZVBvaW50IpABChZNYXBBcmVhRGl2aW5lUHVw" + "aWxzTnRmEjYKBnB1cGlscxgBIAMoCzImLnBiLk1hcEFyZWFEaXZpbmVQdXBp" + "bHNOdGYuUHVwaWxzRW50cnkaPgoLUHVwaWxzRW50cnkSCwoDa2V5GAEgASgF" + "Eh4KBXZhbHVlGAIgASgLMg8ucGIuRGl2aW5lUHVwaWw6AjgBIjgKF01hcFN1" + "Ym1pdERpdmluZVB1cGlsUmVxEg4KBmFyZWFJRBgBIAEoBRINCgVjb3VudBgC" + "IAEoBSJuChdNYXBTdWJtaXREaXZpbmVQdXBpbEFjaxIjCghnb3RJdGVtcxgB" + "IAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0SLgoVbGF0ZXN0RGl2aW5lUHVwaWxJ" + "bmZvGAIgASgLMg8ucGIuRGl2aW5lUHVwaWwiLgocTWFwQ2xhaW1EaXZpbmVQ" + "dXBpbFJld2FyZFJlcRIOCgZhcmVhSUQYASABKAUicwocTWFwQ2xhaW1EaXZp" + "bmVQdXBpbFJld2FyZEFjaxIjCghnb3RJdGVtcxgBIAMoCzIRLnBiLlVuaXZl" + "cnNhbEl0ZW0SLgoVbGF0ZXN0RGl2aW5lUHVwaWxJbmZvGAIgASgLMg8ucGIu" + "RGl2aW5lUHVwaWwilgEKEE1hcEFyZWFVbmxvY2tOdGYSOgoLYXJlYUV4cGxv" + "cmUYASADKAsyJS5wYi5NYXBBcmVhVW5sb2NrTnRmLkFyZWFFeHBsb3JlRW50" + "cnkaRgoQQXJlYUV4cGxvcmVFbnRyeRILCgNrZXkYASABKAUSIQoFdmFsdWUY" + "AiABKAsyEi5wYi5NYXBBcmVhRXhwbG9yZToCOAEiGAoWTWFwQXJlYUV4cGxv" + "cmVRdWVyeVJlcSKiAQoWTWFwQXJlYUV4cGxvcmVRdWVyeUFjaxJACgthcmVh" + "RXhwbG9yZRgBIAMoCzIrLnBiLk1hcEFyZWFFeHBsb3JlUXVlcnlBY2suQXJl" + "YUV4cGxvcmVFbnRyeRpGChBBcmVhRXhwbG9yZUVudHJ5EgsKA2tleRgBIAEo" + "BRIhCgV2YWx1ZRgCIAEoCzISLnBiLk1hcEFyZWFFeHBsb3JlOgI4ASI8ChhN" + "YXBFeHBsb3JlQ2xhaW1SZXdhcmRSZXESEAoIYXJlYVR5cGUYASABKAUSDgoG" + "YXJlYUlkGAIgASgFImgKGE1hcEV4cGxvcmVDbGFpbVJld2FyZEFjaxIjCghn" + "b3RJdGVtcxgBIAMoCzIRLnBiLlVuaXZlcnNhbEl0ZW0SJwoLYXJlYUV4cGxv" + "cmUYAiABKAsyEi5wYi5NYXBBcmVhRXhwbG9yZSIrChBMaWdodE1hcEJsb2Nr" + "UmVxEgsKA3dpZBgBIAEoBRIKCgJpZBgCIAEoBSISChBMaWdodE1hcEJsb2Nr" + "QWNrIi8KE0xpZ2h0ZWRNYXBCbG9ja3NOdGYSCwoDd2lkGAEgASgFEgsKA2lk" + "cxgCIAMoBSJCCg1NYXBWaWV3TG9nUmVxEg0KBWxheWVyGAEgASgJEiIKCHBv" + "c2l0aW9uGAIgASgLMhAucGIuUEJWZWN0b3IySW50Ig8KDU1hcFZpZXdMb2dB" + "Y2siSQoXTWFwVmlld0NvbXBsZXRlTGF5ZXJSZXESDQoFbGF5ZXIYASABKAkS" + "DgoGYXJlYUlEGAIgASgFEg8KB2NodW5rSUQYAyABKAUiGQoXTWFwVmlld0Nv" + "bXBsZXRlTGF5ZXJBY2siZQoKTWFwVmlld050ZhILCgN3aWQYASABKAUSIAoH" + "bWFwVmlldxgCIAEoCzIPLnBiLk1hcFZpZXdJbmZvEigKC21hcFZpZXdGdWxs" + "GAMgASgLMhMucGIuTWFwVmlld0Z1bGxJbmZvYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[30]
		{
			new GeneratedClrTypeInfo(typeof(MapSetupCustomFlagReq), MapSetupCustomFlagReq.Parser, new string[1] { "Cf" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapSetupCustomFlagAck), MapSetupCustomFlagAck.Parser, new string[1] { "Cf" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapModifyCustomFlagTypeReq), MapModifyCustomFlagTypeReq.Parser, new string[3] { "AreaID", "FlagID", "NewTyp" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapModifyCustomFlagTypeAck), MapModifyCustomFlagTypeAck.Parser, new string[1] { "LatestCustomFlag" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapDelCustomFlagReq), MapDelCustomFlagReq.Parser, new string[2] { "AreaID", "FlagID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapDelCustomFlagAck), MapDelCustomFlagAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapFetchCustomFlagInfoReq), MapFetchCustomFlagInfoReq.Parser, new string[1] { "AreaID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapFetchCustomFlagInfoAck), MapFetchCustomFlagInfoAck.Parser, new string[1] { "AreaFlags" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapCustomFlagNtf), MapCustomFlagNtf.Parser, new string[1] { "AreaFlags" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(MapSetupTracePointReq), MapSetupTracePointReq.Parser, new string[2] { "Point", "Cancel" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapSetupTracePointAck), MapSetupTracePointAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapTrancePointNtf), MapTrancePointNtf.Parser, new string[1] { "Point" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapAreaDivinePupilsNtf), MapAreaDivinePupilsNtf.Parser, new string[1] { "Pupils" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(MapSubmitDivinePupilReq), MapSubmitDivinePupilReq.Parser, new string[2] { "AreaID", "Count" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapSubmitDivinePupilAck), MapSubmitDivinePupilAck.Parser, new string[2] { "GotItems", "LatestDivinePupilInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapClaimDivinePupilRewardReq), MapClaimDivinePupilRewardReq.Parser, new string[1] { "AreaID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapClaimDivinePupilRewardAck), MapClaimDivinePupilRewardAck.Parser, new string[2] { "GotItems", "LatestDivinePupilInfo" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapAreaUnlockNtf), MapAreaUnlockNtf.Parser, new string[1] { "AreaExplore" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(MapAreaExploreQueryReq), MapAreaExploreQueryReq.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapAreaExploreQueryAck), MapAreaExploreQueryAck.Parser, new string[1] { "AreaExplore" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(MapExploreClaimRewardReq), MapExploreClaimRewardReq.Parser, new string[2] { "AreaType", "AreaId" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapExploreClaimRewardAck), MapExploreClaimRewardAck.Parser, new string[2] { "GotItems", "AreaExplore" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LightMapBlockReq), LightMapBlockReq.Parser, new string[2] { "Wid", "Id" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LightMapBlockAck), LightMapBlockAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(LightedMapBlocksNtf), LightedMapBlocksNtf.Parser, new string[2] { "Wid", "Ids" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapViewLogReq), MapViewLogReq.Parser, new string[2] { "Layer", "Position" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapViewLogAck), MapViewLogAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapViewCompleteLayerReq), MapViewCompleteLayerReq.Parser, new string[3] { "Layer", "AreaID", "ChunkID" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapViewCompleteLayerAck), MapViewCompleteLayerAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(MapViewNtf), MapViewNtf.Parser, new string[3] { "Wid", "MapView", "MapViewFull" }, null, null, null, null)
		}));
	}
}
