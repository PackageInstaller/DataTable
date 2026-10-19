using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class ArchiveReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static ArchiveReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("Cg1hcmNoaXZlLnByb3RvEgJwYhoMY29tbW9uLnByb3RvIioKCkFyY2hpdmVO" + "dGYSHAoHYXJjaGl2ZRgBIAEoCzILLnBiLkFyY2hpdmUiMAoQQXJjaGl2ZUNo" + "YW5nZU50ZhIcCgdhcmNoaXZlGAEgASgLMgsucGIuQXJjaGl2ZSIqChBBcmNo" + "aXZlVXBkYXRlUmVxEhYKDnVubG9ja01vbnN0ZXJzGAEgAygFIhIKEEFyY2hp" + "dmVVcGRhdGVBY2siLgoOQXJjaGl2ZVJlYWRSZXESHAoHYXJjaGl2ZRgBIAEo" + "CzILLnBiLkFyY2hpdmUiEAoOQXJjaGl2ZVJlYWRBY2tiBnByb3RvMw=="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[6]
		{
			new GeneratedClrTypeInfo(typeof(ArchiveNtf), ArchiveNtf.Parser, new string[1] { "Archive" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ArchiveChangeNtf), ArchiveChangeNtf.Parser, new string[1] { "Archive" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ArchiveUpdateReq), ArchiveUpdateReq.Parser, new string[1] { "UnlockMonsters" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ArchiveUpdateAck), ArchiveUpdateAck.Parser, null, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ArchiveReadReq), ArchiveReadReq.Parser, new string[1] { "Archive" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(ArchiveReadAck), ArchiveReadAck.Parser, null, null, null, null, null)
		}));
	}
}
