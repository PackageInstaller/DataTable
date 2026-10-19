using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Shaders/ComputeShader.h")]
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

	public string[] shaderKeywords
	{
		get
		{
			return GetShaderKeywords();
		}
		set
		{
			SetShaderKeywords(value);
		}
	}

	public LocalKeyword[] enabledKeywords
	{
		get
		{
			return GetEnabledKeywords();
		}
		set
		{
			SetEnabledKeywords(value);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[RequiredByNativeCode]
	[NativeMethod(Name = "ComputeShaderScripting::FindKernel", HasExplicitThis = true, IsFreeFunction = true, ThrowsException = true)]
	public extern int FindKernel(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::HasKernel", HasExplicitThis = true)]
	public extern bool HasKernel(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetValue<float>", HasExplicitThis = true)]
	public extern void SetFloat(int nameID, float val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetValue<int>", HasExplicitThis = true)]
	public extern void SetInt(int nameID, int val);

	[FreeFunction(Name = "ComputeShaderScripting::SetValue<Vector4f>", HasExplicitThis = true)]
	public void SetVector(int nameID, Vector4 val)
	{
		SetVector_Injected(nameID, ref val);
	}

	[FreeFunction(Name = "ComputeShaderScripting::SetValue<Matrix4x4f>", HasExplicitThis = true)]
	public void SetMatrix(int nameID, Matrix4x4 val)
	{
		SetMatrix_Injected(nameID, ref val);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetArray<float>", HasExplicitThis = true)]
	private extern void SetFloatArray(int nameID, float[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetArray<int>", HasExplicitThis = true)]
	private extern void SetIntArray(int nameID, int[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetArray<Vector4f>", HasExplicitThis = true)]
	public extern void SetVectorArray(int nameID, Vector4[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetArray<Matrix4x4f>", HasExplicitThis = true)]
	public extern void SetMatrixArray(int nameID, Matrix4x4[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ComputeShaderScripting::SetTexture", HasExplicitThis = true, IsFreeFunction = true, ThrowsException = true)]
	public extern void SetTexture(int kernelIndex, int nameID, [NotNull("ArgumentNullException")] Texture texture, int mipLevel);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ComputeShaderScripting::SetRenderTexture", HasExplicitThis = true, IsFreeFunction = true, ThrowsException = true)]
	private extern void SetRenderTexture(int kernelIndex, int nameID, [NotNull("ArgumentNullException")] RenderTexture texture, int mipLevel, RenderTextureSubElement element);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ComputeShaderScripting::SetTextureFromGlobal", HasExplicitThis = true, IsFreeFunction = true, ThrowsException = true)]
	public extern void SetTextureFromGlobal(int kernelIndex, int nameID, int globalTextureNameID);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetBuffer", HasExplicitThis = true)]
	private extern void Internal_SetBuffer(int kernelIndex, int nameID, [NotNull("ArgumentNullException")] ComputeBuffer buffer);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetBuffer", HasExplicitThis = true)]
	private extern void Internal_SetGraphicsBuffer(int kernelIndex, int nameID, [NotNull("ArgumentNullException")] GraphicsBuffer buffer);

	public void SetBuffer(int kernelIndex, int nameID, ComputeBuffer buffer)
	{
		Internal_SetBuffer(kernelIndex, nameID, buffer);
	}

	public void SetBuffer(int kernelIndex, int nameID, GraphicsBuffer buffer)
	{
		Internal_SetGraphicsBuffer(kernelIndex, nameID, buffer);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetConstantBuffer", HasExplicitThis = true)]
	private extern void SetConstantComputeBuffer(int nameID, [NotNull("ArgumentNullException")] ComputeBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::SetConstantBuffer", HasExplicitThis = true)]
	private extern void SetConstantGraphicsBuffer(int nameID, [NotNull("ArgumentNullException")] GraphicsBuffer buffer, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "ComputeShaderScripting::GetKernelThreadGroupSizes", HasExplicitThis = true, IsFreeFunction = true, ThrowsException = true)]
	public extern void GetKernelThreadGroupSizes(int kernelIndex, out uint x, out uint y, out uint z);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("DispatchComputeShader")]
	public extern void Dispatch(int kernelIndex, int threadGroupsX, int threadGroupsY, int threadGroupsZ);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::DispatchIndirect", HasExplicitThis = true)]
	private extern void Internal_DispatchIndirect(int kernelIndex, [NotNull("ArgumentNullException")] ComputeBuffer argsBuffer, uint argsOffset);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ComputeShaderScripting::DispatchIndirect", HasExplicitThis = true)]
	private extern void Internal_DispatchIndirectGraphicsBuffer(int kernelIndex, [NotNull("ArgumentNullException")] GraphicsBuffer argsBuffer, uint argsOffset);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::EnableKeyword", HasExplicitThis = true)]
	public extern void EnableKeyword(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::DisableKeyword", HasExplicitThis = true)]
	public extern void DisableKeyword(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::IsKeywordEnabled", HasExplicitThis = true)]
	public extern bool IsKeywordEnabled(string keyword);

	[FreeFunction("ComputeShaderScripting::EnableKeyword", HasExplicitThis = true)]
	private void EnableLocalKeyword(LocalKeyword keyword)
	{
		EnableLocalKeyword_Injected(ref keyword);
	}

	[FreeFunction("ComputeShaderScripting::DisableKeyword", HasExplicitThis = true)]
	private void DisableLocalKeyword(LocalKeyword keyword)
	{
		DisableLocalKeyword_Injected(ref keyword);
	}

	[FreeFunction("ComputeShaderScripting::SetKeyword", HasExplicitThis = true)]
	private void SetLocalKeyword(LocalKeyword keyword, bool value)
	{
		SetLocalKeyword_Injected(ref keyword, value);
	}

	[FreeFunction("ComputeShaderScripting::IsKeywordEnabled", HasExplicitThis = true)]
	private bool IsLocalKeywordEnabled(LocalKeyword keyword)
	{
		return IsLocalKeywordEnabled_Injected(ref keyword);
	}

	public void EnableKeyword(in LocalKeyword keyword)
	{
		EnableLocalKeyword(keyword);
	}

	public void DisableKeyword(in LocalKeyword keyword)
	{
		DisableLocalKeyword(keyword);
	}

	public void SetKeyword(in LocalKeyword keyword, bool value)
	{
		SetLocalKeyword(keyword, value);
	}

	public bool IsKeywordEnabled(in LocalKeyword keyword)
	{
		return IsLocalKeywordEnabled(keyword);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::IsSupported", HasExplicitThis = true)]
	public extern bool IsSupported(int kernelIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::GetShaderKeywords", HasExplicitThis = true)]
	private extern string[] GetShaderKeywords();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::SetShaderKeywords", HasExplicitThis = true)]
	private extern void SetShaderKeywords(string[] names);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::GetEnabledKeywords", HasExplicitThis = true)]
	private extern LocalKeyword[] GetEnabledKeywords();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ComputeShaderScripting::SetEnabledKeywords", HasExplicitThis = true)]
	private extern void SetEnabledKeywords(LocalKeyword[] keywords);

	private ComputeShader()
	{
	}

	public void SetFloat(string name, float val)
	{
		SetFloat(Shader.PropertyToID(name), val);
	}

	public void SetInt(string name, int val)
	{
		SetInt(Shader.PropertyToID(name), val);
	}

	public void SetVector(string name, Vector4 val)
	{
		SetVector(Shader.PropertyToID(name), val);
	}

	public void SetMatrix(string name, Matrix4x4 val)
	{
		SetMatrix(Shader.PropertyToID(name), val);
	}

	public void SetVectorArray(string name, Vector4[] values)
	{
		SetVectorArray(Shader.PropertyToID(name), values);
	}

	public void SetMatrixArray(string name, Matrix4x4[] values)
	{
		SetMatrixArray(Shader.PropertyToID(name), values);
	}

	public void SetFloats(string name, params float[] values)
	{
		SetFloatArray(Shader.PropertyToID(name), values);
	}

	public void SetFloats(int nameID, params float[] values)
	{
		SetFloatArray(nameID, values);
	}

	public void SetInts(string name, params int[] values)
	{
		SetIntArray(Shader.PropertyToID(name), values);
	}

	public void SetInts(int nameID, params int[] values)
	{
		SetIntArray(nameID, values);
	}

	public void SetBool(string name, bool val)
	{
		SetInt(Shader.PropertyToID(name), val ? 1 : 0);
	}

	public void SetBool(int nameID, bool val)
	{
		SetInt(nameID, val ? 1 : 0);
	}

	public void SetTexture(int kernelIndex, int nameID, Texture texture)
	{
		SetTexture(kernelIndex, nameID, texture, 0);
	}

	public void SetTexture(int kernelIndex, string name, Texture texture)
	{
		SetTexture(kernelIndex, Shader.PropertyToID(name), texture, 0);
	}

	public void SetTexture(int kernelIndex, string name, Texture texture, int mipLevel)
	{
		SetTexture(kernelIndex, Shader.PropertyToID(name), texture, mipLevel);
	}

	public void SetTexture(int kernelIndex, int nameID, RenderTexture texture, int mipLevel, RenderTextureSubElement element)
	{
		SetRenderTexture(kernelIndex, nameID, texture, mipLevel, element);
	}

	public void SetTexture(int kernelIndex, string name, RenderTexture texture, int mipLevel, RenderTextureSubElement element)
	{
		SetRenderTexture(kernelIndex, Shader.PropertyToID(name), texture, mipLevel, element);
	}

	public void SetTextureFromGlobal(int kernelIndex, string name, string globalTextureName)
	{
		SetTextureFromGlobal(kernelIndex, Shader.PropertyToID(name), Shader.PropertyToID(globalTextureName));
	}

	public void SetBuffer(int kernelIndex, string name, ComputeBuffer buffer)
	{
		SetBuffer(kernelIndex, Shader.PropertyToID(name), buffer);
	}

	public void SetBuffer(int kernelIndex, string name, GraphicsBuffer buffer)
	{
		SetBuffer(kernelIndex, Shader.PropertyToID(name), buffer);
	}

	public void SetConstantBuffer(int nameID, ComputeBuffer buffer, int offset, int size)
	{
		SetConstantComputeBuffer(nameID, buffer, offset, size);
	}

	public void SetConstantBuffer(string name, ComputeBuffer buffer, int offset, int size)
	{
		SetConstantBuffer(Shader.PropertyToID(name), buffer, offset, size);
	}

	public void SetConstantBuffer(int nameID, GraphicsBuffer buffer, int offset, int size)
	{
		SetConstantGraphicsBuffer(nameID, buffer, offset, size);
	}

	public void SetConstantBuffer(string name, GraphicsBuffer buffer, int offset, int size)
	{
		SetConstantBuffer(Shader.PropertyToID(name), buffer, offset, size);
	}

	public void DispatchIndirect(int kernelIndex, ComputeBuffer argsBuffer, [DefaultValue("0")] uint argsOffset)
	{
		if (argsBuffer == null)
		{
			throw new ArgumentNullException("argsBuffer");
		}
		if (argsBuffer.m_Ptr == IntPtr.Zero)
		{
			throw new ObjectDisposedException("argsBuffer");
		}
		if (SystemInfo.graphicsDeviceType == GraphicsDeviceType.Metal && !SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		Internal_DispatchIndirect(kernelIndex, argsBuffer, argsOffset);
	}

	[ExcludeFromDocs]
	public void DispatchIndirect(int kernelIndex, ComputeBuffer argsBuffer)
	{
		DispatchIndirect(kernelIndex, argsBuffer, 0u);
	}

	public void DispatchIndirect(int kernelIndex, GraphicsBuffer argsBuffer, [DefaultValue("0")] uint argsOffset)
	{
		if (argsBuffer == null)
		{
			throw new ArgumentNullException("argsBuffer");
		}
		if (argsBuffer.m_Ptr == IntPtr.Zero)
		{
			throw new ObjectDisposedException("argsBuffer");
		}
		if (SystemInfo.graphicsDeviceType == GraphicsDeviceType.Metal && !SystemInfo.supportsIndirectArgumentsBuffer)
		{
			throw new InvalidOperationException("Indirect argument buffers are not supported.");
		}
		Internal_DispatchIndirectGraphicsBuffer(kernelIndex, argsBuffer, argsOffset);
	}

	[ExcludeFromDocs]
	public void DispatchIndirect(int kernelIndex, GraphicsBuffer argsBuffer)
	{
		DispatchIndirect(kernelIndex, argsBuffer, 0u);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetVector_Injected(int nameID, ref Vector4 val);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetMatrix_Injected(int nameID, ref Matrix4x4 val);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_keywordSpace_Injected(out LocalKeywordSpace ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EnableLocalKeyword_Injected(ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void DisableLocalKeyword_Injected(ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetLocalKeyword_Injected(ref LocalKeyword keyword, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool IsLocalKeywordEnabled_Injected(ref LocalKeyword keyword);
}
