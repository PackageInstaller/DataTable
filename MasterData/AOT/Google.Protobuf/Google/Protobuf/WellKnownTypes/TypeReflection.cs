using System;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public static class TypeReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static TypeReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Chpnb29nbGUvcHJvdG9idWYvdHlwZS5wcm90bxIPZ29vZ2xlLnByb3RvYnVm" + "Ghlnb29nbGUvcHJvdG9idWYvYW55LnByb3RvGiRnb29nbGUvcHJvdG9idWYv" + "c291cmNlX2NvbnRleHQucHJvdG8i1wEKBFR5cGUSDAoEbmFtZRgBIAEoCRIm" + "CgZmaWVsZHMYAiADKAsyFi5nb29nbGUucHJvdG9idWYuRmllbGQSDgoGb25l" + "b2ZzGAMgAygJEigKB29wdGlvbnMYBCADKAsyFy5nb29nbGUucHJvdG9idWYu" + "T3B0aW9uEjYKDnNvdXJjZV9jb250ZXh0GAUgASgLMh4uZ29vZ2xlLnByb3Rv" + "YnVmLlNvdXJjZUNvbnRleHQSJwoGc3ludGF4GAYgASgOMhcuZ29vZ2xlLnBy" + "b3RvYnVmLlN5bnRheCLVBQoFRmllbGQSKQoEa2luZBgBIAEoDjIbLmdvb2ds" + "ZS5wcm90b2J1Zi5GaWVsZC5LaW5kEjcKC2NhcmRpbmFsaXR5GAIgASgOMiIu" + "Z29vZ2xlLnByb3RvYnVmLkZpZWxkLkNhcmRpbmFsaXR5Eg4KBm51bWJlchgD" + "IAEoBRIMCgRuYW1lGAQgASgJEhAKCHR5cGVfdXJsGAYgASgJEhMKC29uZW9m" + "X2luZGV4GAcgASgFEg4KBnBhY2tlZBgIIAEoCBIoCgdvcHRpb25zGAkgAygL" + "MhcuZ29vZ2xlLnByb3RvYnVmLk9wdGlvbhIRCglqc29uX25hbWUYCiABKAkS" + "FQoNZGVmYXVsdF92YWx1ZRgLIAEoCSLIAgoES2luZBIQCgxUWVBFX1VOS05P" + "V04QABIPCgtUWVBFX0RPVUJMRRABEg4KClRZUEVfRkxPQVQQAhIOCgpUWVBF" + "X0lOVDY0EAMSDwoLVFlQRV9VSU5UNjQQBBIOCgpUWVBFX0lOVDMyEAUSEAoM" + "VFlQRV9GSVhFRDY0EAYSEAoMVFlQRV9GSVhFRDMyEAcSDQoJVFlQRV9CT09M" + "EAgSDwoLVFlQRV9TVFJJTkcQCRIOCgpUWVBFX0dST1VQEAoSEAoMVFlQRV9N" + "RVNTQUdFEAsSDgoKVFlQRV9CWVRFUxAMEg8KC1RZUEVfVUlOVDMyEA0SDQoJ" + "VFlQRV9FTlVNEA4SEQoNVFlQRV9TRklYRUQzMhAPEhEKDVRZUEVfU0ZJWEVE" + "NjQQEBIPCgtUWVBFX1NJTlQzMhAREg8KC1RZUEVfU0lOVDY0EBIidAoLQ2Fy" + "ZGluYWxpdHkSFwoTQ0FSRElOQUxJVFlfVU5LTk9XThAAEhgKFENBUkRJTkFM" + "SVRZX09QVElPTkFMEAESGAoUQ0FSRElOQUxJVFlfUkVRVUlSRUQQAhIYChRD" + "QVJESU5BTElUWV9SRVBFQVRFRBADIs4BCgRFbnVtEgwKBG5hbWUYASABKAkS" + "LQoJZW51bXZhbHVlGAIgAygLMhouZ29vZ2xlLnByb3RvYnVmLkVudW1WYWx1" + "ZRIoCgdvcHRpb25zGAMgAygLMhcuZ29vZ2xlLnByb3RvYnVmLk9wdGlvbhI2" + "Cg5zb3VyY2VfY29udGV4dBgEIAEoCzIeLmdvb2dsZS5wcm90b2J1Zi5Tb3Vy" + "Y2VDb250ZXh0EicKBnN5bnRheBgFIAEoDjIXLmdvb2dsZS5wcm90b2J1Zi5T" + "eW50YXgiUwoJRW51bVZhbHVlEgwKBG5hbWUYASABKAkSDgoGbnVtYmVyGAIg" + "ASgFEigKB29wdGlvbnMYAyADKAsyFy5nb29nbGUucHJvdG9idWYuT3B0aW9u" + "IjsKBk9wdGlvbhIMCgRuYW1lGAEgASgJEiMKBXZhbHVlGAIgASgLMhQuZ29v" + "Z2xlLnByb3RvYnVmLkFueSouCgZTeW50YXgSEQoNU1lOVEFYX1BST1RPMhAA" + "EhEKDVNZTlRBWF9QUk9UTzMQAUJ7ChNjb20uZ29vZ2xlLnByb3RvYnVmQglU" + "eXBlUHJvdG9QAVotZ29vZ2xlLmdvbGFuZy5vcmcvcHJvdG9idWYvdHlwZXMv" + "a25vd24vdHlwZXBi+AEBogIDR1BCqgIeR29vZ2xlLlByb3RvYnVmLldlbGxL" + "bm93blR5cGVzYgZwcm90bzM="), new FileDescriptor[2]
		{
			AnyReflection.Descriptor,
			SourceContextReflection.Descriptor
		}, new GeneratedClrTypeInfo(new System.Type[1] { typeof(Syntax) }, null, new GeneratedClrTypeInfo[5]
		{
			new GeneratedClrTypeInfo(typeof(Type), Type.Parser, new string[6] { "Name", "Fields", "Oneofs", "Options", "SourceContext", "Syntax" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Field), Field.Parser, new string[10] { "Kind", "Cardinality", "Number", "Name", "TypeUrl", "OneofIndex", "Packed", "Options", "JsonName", "DefaultValue" }, null, new System.Type[2]
			{
				typeof(Field.Types.Kind),
				typeof(Field.Types.Cardinality)
			}, null, null),
			new GeneratedClrTypeInfo(typeof(Enum), Enum.Parser, new string[5] { "Name", "Enumvalue", "Options", "SourceContext", "Syntax" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(EnumValue), EnumValue.Parser, new string[3] { "Name", "Number", "Options" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Option), Option.Parser, new string[2] { "Name", "Value" }, null, null, null, null)
		}));
	}
}
