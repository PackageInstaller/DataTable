using System;
using System.CodeDom.Compiler;
using System.ComponentModel;
using System.Runtime.CompilerServices;

[CompilerGenerated]
[EditorBrowsable(EditorBrowsableState.Never)]
[GeneratedCode("Unity.MonoScriptGenerator.MonoScriptInfoGenerator", null)]
internal class UnitySourceGeneratedAssemblyMonoScriptTypes_v1
{
	private struct MonoScriptData
	{
		public byte[] FilePathsData;

		public byte[] TypesData;

		public int TotalTypes;

		public int TotalFiles;

		public bool IsEditorOnly;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static MonoScriptData Get()
	{
		//IL_0036: Field data (rva=0x490) could not be found in any section!
		//IL_0036: Field data (rva=0x490) could not be found in any section!
		//IL_001a: Field data (rva=0x7c8) could not be found in any section!
		//IL_001a: Field data (rva=0x7c8) could not be found in any section!
		MonoScriptData result = default(MonoScriptData);
		byte[] array = new byte[1857];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		result.FilePathsData = array;
		byte[] array2 = new byte[824];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		result.TypesData = array2;
		result.TotalFiles = 26;
		result.TotalTypes = 30;
		result.IsEditorOnly = false;
		return result;
	}
}
