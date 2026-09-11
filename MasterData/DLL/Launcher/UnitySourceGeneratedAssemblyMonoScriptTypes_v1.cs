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
		//IL_0030: Field data (rva=0x490) could not be found in any section!
		//IL_0030: Field data (rva=0x490) could not be found in any section!
		//IL_0017: Field data (rva=0x4c8) could not be found in any section!
		//IL_0017: Field data (rva=0x4c8) could not be found in any section!
		MonoScriptData result = default(MonoScriptData);
		byte[] array = new byte[45];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		result.FilePathsData = array;
		byte[] array2 = new byte[50];
		RuntimeHelpers.InitializeArray(array2, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		result.TypesData = array2;
		result.TotalFiles = 1;
		result.TotalTypes = 1;
		result.IsEditorOnly = false;
		return result;
	}
}
