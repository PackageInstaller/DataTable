using System;
using ACT.Game.Data;
using Google.Protobuf.Reflection;

namespace Pb;

public static class RecipeReflection
{
	private static FileDescriptor descriptor;

	public static FileDescriptor Descriptor => descriptor;

	static RecipeReflection()
	{
		descriptor = FileDescriptor.FromGeneratedCode(Convert.FromBase64String("CgxyZWNpcGUucHJvdG8SAnBiGgxjb21tb24ucHJvdG8iKgoNUmVjaXBlTWFr" + "ZVJlcRIKCgJpZBgBIAEoBRINCgVjb3VudBgCIAEoBSIqCg1SZWNpcGVNYWtl" + "QWNrEhkKB2NoYW5nZXMYASADKAsyCC5wYi5JdGVtYgZwcm90bzM="), new FileDescriptor[1] { CommonReflection.Descriptor }, new GeneratedClrTypeInfo(null, null, new GeneratedClrTypeInfo[2]
		{
			new GeneratedClrTypeInfo(typeof(RecipeMakeReq), RecipeMakeReq.Parser, new string[2] { "Id", "Count" }, null, null, null, null),
			new GeneratedClrTypeInfo(typeof(RecipeMakeAck), RecipeMakeAck.Parser, new string[1] { "Changes" }, null, null, null, null)
		}));
	}
}
