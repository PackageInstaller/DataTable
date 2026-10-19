using System;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public static class WrappersReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static WrappersReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Ch5nb29nbGUvcHJvdG9idWYvd3JhcHBlcnMucHJvdG8SD2dvb2dsZS5wcm90" + "b2J1ZiIcCgtEb3VibGVWYWx1ZRINCgV2YWx1ZRgBIAEoASIbCgpGbG9hdFZh" + "bHVlEg0KBXZhbHVlGAEgASgCIhsKCkludDY0VmFsdWUSDQoFdmFsdWUYASAB" + "KAMiHAoLVUludDY0VmFsdWUSDQoFdmFsdWUYASABKAQiGwoKSW50MzJWYWx1" + "ZRINCgV2YWx1ZRgBIAEoBSIcCgtVSW50MzJWYWx1ZRINCgV2YWx1ZRgBIAEo" + "DSIaCglCb29sVmFsdWUSDQoFdmFsdWUYASABKAgiHAoLU3RyaW5nVmFsdWUS" + "DQoFdmFsdWUYASABKAkiGwoKQnl0ZXNWYWx1ZRINCgV2YWx1ZRgBIAEoDEKD" + "AQoTY29tLmdvb2dsZS5wcm90b2J1ZkINV3JhcHBlcnNQcm90b1ABWjFnb29n" + "bGUuZ29sYW5nLm9yZy9wcm90b2J1Zi90eXBlcy9rbm93bi93cmFwcGVyc3Bi" + "+AEBogIDR1BCqgIeR29vZ2xlLlByb3RvYnVmLldlbGxLbm93blR5cGVzYgZw" + "cm90bzM="), new FileDescriptor[0], new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[9]
		{
			new GeneratedClrTypeInfo(typeof(DoubleValue), DoubleValue.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(FloatValue), FloatValue.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Int64Value), Int64Value.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UInt64Value), UInt64Value.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(Int32Value), Int32Value.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(UInt32Value), UInt32Value.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BoolValue), BoolValue.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(StringValue), StringValue.Parser, new string[1] { "Value" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(BytesValue), BytesValue.Parser, new string[1] { "Value" }, null, null, null, null)
		}));
	}
}
