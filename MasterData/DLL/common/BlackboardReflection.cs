using System;
using Google.Protobuf.Reflection;
using Google.Protobuf.WellKnownTypes;

public static class BlackboardReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static BlackboardReflection()
	{
		byte[] descriptorData = Convert.FromBase64String("ChBCbGFja2JvYXJkLnByb3RvGhlnb29nbGUvcHJvdG9idWYvYW55LnByb3Rv" + "Im0KC1Byb3RvQ29uZmlnEiQKBGRhdGEYASADKAsyFi5Qcm90b0NvbmZpZy5E" + "YXRhRW50cnkaOAoJRGF0YUVudHJ5EgsKA2tleRgBIAEoCRIaCgV2YWx1ZRgC" + "IAEoCzILLlByb3RvVGFibGU6AjgBIoQBCgpQcm90b1RhYmxlEgwKBG5hbWUY" + "ASABKAkSIwoEZGF0YRgCIAMoCzIVLlByb3RvVGFibGUuRGF0YUVudHJ5GkMK" + "CURhdGFFbnRyeRILCgNrZXkYASABKAUSJQoFdmFsdWUYAiABKAsyFi5Qcm90" + "b0JsYWNrYm9hcmRTb3VyY2U6AjgBIocBChVQcm90b0JsYWNrYm9hcmRTb3Vy" + "Y2USLAoDbWFwGAEgAygLMh8uUHJvdG9CbGFja2JvYXJkU291cmNlLk1hcEVu" + "dHJ5GkAKCE1hcEVudHJ5EgsKA2tleRgBIAEoCRIjCgV2YWx1ZRgCIAEoCzIU" + "Lmdvb2dsZS5wcm90b2J1Zi5Bbnk6AjgBIhkKCFByb3RvSW50Eg0KBXZhbHVl" + "GAEgASgFIhgKC1Byb3RvU3RyaW5nEgkKAXMYASABKAkiHAoMUHJvdG9JbnRM" + "aXN0EgwKBGxpc3QYASADKAUiHwoPUHJvdG9TdHJpbmdMaXN0EgwKBGxpc3QY" + "ASADKAkiGgoJUHJvdG9Cb29sEg0KBXZhbHVlGAEgASgIIh0KDVByb3RvQm9v" + "bExpc3QSDAoEbGlzdBgBIAMoCCIsCglQcm90b0ludDMSCQoBeBgBIAEoBRIJ" + "CgF5GAIgASgFEgkKAXoYAyABKAUiKQoNUHJvdG9JbnQzTGlzdBIYCgRsaXN0" + "GAEgAygLMgouUHJvdG9JbnQzIncKD1Byb3RvRW50aXR5RGF0YRIMCgRuYW1l" + "GAEgASgJEgoKAmlkGAIgASgFEioKCmJsYWNrYm9hcmQYAyABKAsyFi5Qcm90" + "b0JsYWNrYm9hcmRTb3VyY2USDAoEdHlwZRgEIAMoCRIQCghpc0VuYWJsZRgF" + "IAEoCCJKCgxQcm90b01hcGRhdGESEwoLbWFwZGF0YU5hbWUYASABKAkSJQoL" + "ZW50aXR5RGF0YXMYAiADKAsyEC5Qcm90b0VudGl0eURhdGFiBnByb3RvMw==");
		descriptor = FileDescriptor.FromGeneratedCode(descriptorData, new FileDescriptor[1] { AnyReflection.Descriptor }, new GeneratedClrTypeInfo(null, new GeneratedClrTypeInfo[13]
		{
			new GeneratedClrTypeInfo(typeof(ProtoConfig), ProtoConfig.Parser, new string[1] { "Data" }, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(ProtoTable), ProtoTable.Parser, new string[2] { "Name", "Data" }, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(ProtoBlackboardSource), ProtoBlackboardSource.Parser, new string[1] { "Map" }, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(ProtoInt), ProtoInt.Parser, new string[1] { "Value" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoString), ProtoString.Parser, new string[1] { "S" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoIntList), ProtoIntList.Parser, new string[1] { "List" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoStringList), ProtoStringList.Parser, new string[1] { "List" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoBool), ProtoBool.Parser, new string[1] { "Value" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoBoolList), ProtoBoolList.Parser, new string[1] { "List" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoInt3), ProtoInt3.Parser, new string[3] { "X", "Y", "Z" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoInt3List), ProtoInt3List.Parser, new string[1] { "List" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoEntityData), ProtoEntityData.Parser, new string[5] { "Name", "Id", "Blackboard", "Type", "IsEnable" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ProtoMapdata), ProtoMapdata.Parser, new string[2] { "MapdataName", "EntityDatas" }, null, null, null)
		}));
	}
}
