using System;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public static class SourceContextReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static SourceContextReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CiRnb29nbGUvcHJvdG9idWYvc291cmNlX2NvbnRleHQucHJvdG8SD2dvb2ds" + "ZS5wcm90b2J1ZiIiCg1Tb3VyY2VDb250ZXh0EhEKCWZpbGVfbmFtZRgBIAEo" + "CUKKAQoTY29tLmdvb2dsZS5wcm90b2J1ZkISU291cmNlQ29udGV4dFByb3Rv" + "UAFaNmdvb2dsZS5nb2xhbmcub3JnL3Byb3RvYnVmL3R5cGVzL2tub3duL3Nv" + "dXJjZWNvbnRleHRwYqICA0dQQqoCHkdvb2dsZS5Qcm90b2J1Zi5XZWxsS25v" + "d25UeXBlc2IGcHJvdG8z"), new FileDescriptor[0], new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[1]
		{
			new GeneratedClrTypeInfo(typeof(SourceContext), SourceContext.Parser, new string[1] { "FileName" }, null, null, null, null)
		}));
	}
}
