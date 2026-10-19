using System;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public static class StructReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static StructReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Chxnb29nbGUvcHJvdG9idWYvc3RydWN0LnByb3RvEg9nb29nbGUucHJvdG9i" + "dWYihAEKBlN0cnVjdBIzCgZmaWVsZHMYASADKAsyIy5nb29nbGUucHJvdG9i" + "dWYuU3RydWN0LkZpZWxkc0VudHJ5GkUKC0ZpZWxkc0VudHJ5EgsKA2tleRgB" + "IAEoCRIlCgV2YWx1ZRgCIAEoCzIWLmdvb2dsZS5wcm90b2J1Zi5WYWx1ZToC" + "OAEi6gEKBVZhbHVlEjAKCm51bGxfdmFsdWUYASABKA4yGi5nb29nbGUucHJv" + "dG9idWYuTnVsbFZhbHVlSAASFgoMbnVtYmVyX3ZhbHVlGAIgASgBSAASFgoM" + "c3RyaW5nX3ZhbHVlGAMgASgJSAASFAoKYm9vbF92YWx1ZRgEIAEoCEgAEi8K" + "DHN0cnVjdF92YWx1ZRgFIAEoCzIXLmdvb2dsZS5wcm90b2J1Zi5TdHJ1Y3RI" + "ABIwCgpsaXN0X3ZhbHVlGAYgASgLMhouZ29vZ2xlLnByb3RvYnVmLkxpc3RW" + "YWx1ZUgAQgYKBGtpbmQiMwoJTGlzdFZhbHVlEiYKBnZhbHVlcxgBIAMoCzIW" + "Lmdvb2dsZS5wcm90b2J1Zi5WYWx1ZSobCglOdWxsVmFsdWUSDgoKTlVMTF9W" + "QUxVRRAAQn8KE2NvbS5nb29nbGUucHJvdG9idWZCC1N0cnVjdFByb3RvUAFa" + "L2dvb2dsZS5nb2xhbmcub3JnL3Byb3RvYnVmL3R5cGVzL2tub3duL3N0cnVj" + "dHBi+AEBogIDR1BCqgIeR29vZ2xlLlByb3RvYnVmLldlbGxLbm93blR5cGVz" + "YgZwcm90bzM="), new FileDescriptor[0], new GeneratedClrTypeInfo(new System.Type[1] { typeof(NullValue) }, null, new GeneratedClrTypeInfo[3]
		{
			new GeneratedClrTypeInfo(typeof(Struct), Struct.Parser, new string[1] { "Fields" }, null, null, null, new GeneratedClrTypeInfo[1]),
			new GeneratedClrTypeInfo(typeof(Value), Value.Parser, new string[6] { "NullValue", "NumberValue", "StringValue", "BoolValue", "StructValue", "ListValue" }, new string[1] { "Kind" }, null, null, null),
			new GeneratedClrTypeInfo(typeof(ListValue), ListValue.Parser, new string[1] { "Values" }, null, null, null, null)
		}));
	}
}
