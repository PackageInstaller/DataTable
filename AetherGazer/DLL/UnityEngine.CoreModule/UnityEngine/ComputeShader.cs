using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[NativeHeader("Runtime/Shaders/ComputeShader.h")]
[UsedByNativeCode]
public sealed class ComputeShader : Object
{
	public LocalKeywordSpace keywordSpace
	{
		get
		{
			get_keywordSpace_Injected(out var ret);
			return ret;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[RequiredByNativeCode]
	[NativeMethod(Name = "ComputeShaderScripting::FindKernel", HasExplicitThis = true, IsFreeFunction = true, ThrowsException = true)]
	public extern int FindKernel(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetValue<int>", HasExplicitThis = true)]
	public extern void SetInt(int nameID, int val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetConstantBuffer", HasExplicitThis = true)]
	private extern void SetConstantComputeBuffer(int nameID, [NotNull("ArgumentNullException")] ComputeBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::EnableKeyword", HasExplicitThis = true)]
	public extern void EnableKeyword(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::DisableKeyword", HasExplicitThis = true)]
	public extern void DisableKeyword(string keyword);

	private ComputeShader()
	{
	}

	public void SetConstantBuffer(int nameID, ComputeBuffer buffer, int offset, int size)
	{
		SetConstantComputeBuffer(nameID, buffer, offset, size);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_keywordSpace_Injected(out LocalKeywordSpace ret);
}
