using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Shaders/ComputeShader.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
public sealed class ComputeShader : Object
{
	[MethodImpl((MethodImplOptions)4096)]
	[RequiredByNativeCode]
	[NativeMethod(Name = "ComputeShaderScripting::FindKernel", HasExplicitThis = true, IsFreeFunction = true, ThrowsException = true)]
	public extern int FindKernel(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetValue<int>", HasExplicitThis = true)]
	public extern void SetInt(int nameID, int val);

	[FreeFunction(Name = "ComputeShaderScripting::SetValue<Vector4f>", HasExplicitThis = true)]
	public void SetVector(int nameID, Vector4 val)
	{
		SetVector_Injected(nameID, ref val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetBuffer", HasExplicitThis = true)]
	private extern void Internal_SetBuffer(int kernelIndex, int nameID, [NotNull("ArgumentNullException")] ComputeBuffer buffer);

	public void SetBuffer(int kernelIndex, int nameID, ComputeBuffer buffer)
	{
		Internal_SetBuffer(kernelIndex, nameID, buffer);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetConstantBuffer", HasExplicitThis = true)]
	private extern void SetConstantComputeBuffer(int nameID, [NotNull("ArgumentNullException")] ComputeBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("DispatchComputeShader")]
	public extern void Dispatch(int kernelIndex, int threadGroupsX, int threadGroupsY, int threadGroupsZ);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::EnableKeyword", HasExplicitThis = true)]
	public extern void EnableKeyword(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::DisableKeyword", HasExplicitThis = true)]
	public extern void DisableKeyword(string keyword);

	public void SetInt(string name, int val)
	{
		SetInt(Shader.PropertyToID(name), val);
	}

	public void SetVector(string name, Vector4 val)
	{
		SetVector(Shader.PropertyToID(name), val);
	}

	public void SetBuffer(int kernelIndex, string name, ComputeBuffer buffer)
	{
		SetBuffer(kernelIndex, Shader.PropertyToID(name), buffer);
	}

	public void SetConstantBuffer(int nameID, ComputeBuffer buffer, int offset, int size)
	{
		SetConstantComputeBuffer(nameID, buffer, offset, size);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetVector_Injected(int nameID, ref Vector4 val);
}
