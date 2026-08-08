using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine;

[NativeHeader("Runtime/Shaders/ShaderPropertySheet.h")]
[NativeHeader("Runtime/Shaders/ComputeShader.h")]
[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[NativeHeader("Runtime/Math/SphericalHarmonicsL2.h")]
public sealed class MaterialPropertyBlock
{
	internal IntPtr m_Ptr;

	public extern bool isEmpty
	{
		[MethodImpl((MethodImplOptions)4096)]
		[ThreadSafe]
		[NativeName("IsEmpty")]
		get;
	}

	[Obsolete("Use SetFloat instead (UnityUpgradable) -> SetFloat(*)", false)]
	public void AddFloat(string name, float value)
	{
		SetFloat(Shader.PropertyToID(name), value);
	}

	[Obsolete("Use SetFloat instead (UnityUpgradable) -> SetFloat(*)", false)]
	public void AddFloat(int nameID, float value)
	{
		SetFloat(nameID, value);
	}

	[Obsolete("Use SetVector instead (UnityUpgradable) -> SetVector(*)", false)]
	public void AddVector(string name, Vector4 value)
	{
		SetVector(Shader.PropertyToID(name), value);
	}

	[Obsolete("Use SetVector instead (UnityUpgradable) -> SetVector(*)", false)]
	public void AddVector(int nameID, Vector4 value)
	{
		SetVector(nameID, value);
	}

	[Obsolete("Use SetColor instead (UnityUpgradable) -> SetColor(*)", false)]
	public void AddColor(string name, Color value)
	{
		SetColor(Shader.PropertyToID(name), value);
	}

	[Obsolete("Use SetColor instead (UnityUpgradable) -> SetColor(*)", false)]
	public void AddColor(int nameID, Color value)
	{
		SetColor(nameID, value);
	}

	[Obsolete("Use SetMatrix instead (UnityUpgradable) -> SetMatrix(*)", false)]
	public void AddMatrix(string name, Matrix4x4 value)
	{
		SetMatrix(Shader.PropertyToID(name), value);
	}

	[Obsolete("Use SetMatrix instead (UnityUpgradable) -> SetMatrix(*)", false)]
	public void AddMatrix(int nameID, Matrix4x4 value)
	{
		SetMatrix(nameID, value);
	}

	[Obsolete("Use SetTexture instead (UnityUpgradable) -> SetTexture(*)", false)]
	public void AddTexture(string name, Texture value)
	{
		SetTexture(Shader.PropertyToID(name), value);
	}

	[Obsolete("Use SetTexture instead (UnityUpgradable) -> SetTexture(*)", false)]
	public void AddTexture(int nameID, Texture value)
	{
		SetTexture(nameID, value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("GetIntFromScript")]
	private extern int GetIntImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("GetFloatFromScript")]
	private extern float GetFloatImpl(int name);

	[ThreadSafe]
	[NativeName("GetVectorFromScript")]
	private Vector4 GetVectorImpl(int name)
	{
		GetVectorImpl_Injected(name, out var ret);
		return ret;
	}

	[ThreadSafe]
	[NativeName("GetColorFromScript")]
	private Color GetColorImpl(int name)
	{
		GetColorImpl_Injected(name, out var ret);
		return ret;
	}

	[NativeName("GetMatrixFromScript")]
	[ThreadSafe]
	private Matrix4x4 GetMatrixImpl(int name)
	{
		GetMatrixImpl_Injected(name, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetTextureFromScript")]
	[ThreadSafe]
	private extern Texture GetTextureImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasPropertyFromScript")]
	private extern bool HasPropertyImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasFloatFromScript")]
	private extern bool HasFloatImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasIntegerFromScript")]
	private extern bool HasIntImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasTextureFromScript")]
	private extern bool HasTextureImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasMatrixFromScript")]
	private extern bool HasMatrixImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasVectorFromScript")]
	private extern bool HasVectorImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasBufferFromScript")]
	private extern bool HasBufferImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasConstantBufferFromScript")]
	private extern bool HasConstantBufferImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("SetIntFromScript")]
	private extern void SetIntImpl(int name, int value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetFloatFromScript")]
	[ThreadSafe]
	private extern void SetFloatImpl(int name, float value);

	[ThreadSafe]
	[NativeName("SetVectorFromScript")]
	private void SetVectorImpl(int name, Vector4 value)
	{
		SetVectorImpl_Injected(name, ref value);
	}

	[NativeName("SetColorFromScript")]
	[ThreadSafe]
	private void SetColorImpl(int name, Color value)
	{
		SetColorImpl_Injected(name, ref value);
	}

	[NativeName("SetMatrixFromScript")]
	[ThreadSafe]
	private void SetMatrixImpl(int name, Matrix4x4 value)
	{
		SetMatrixImpl_Injected(name, ref value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("SetTextureFromScript")]
	private extern void SetTextureImpl(int name, [NotNull("ArgumentNullException")] Texture value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetRenderTextureFromScript")]
	[ThreadSafe]
	private extern void SetRenderTextureImpl(int name, [NotNull("ArgumentNullException")] RenderTexture value, RenderTextureSubElement element);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("SetBufferFromScript")]
	private extern void SetBufferImpl(int name, ComputeBuffer value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetBufferFromScript")]
	[ThreadSafe]
	private extern void SetGraphicsBufferImpl(int name, GraphicsBuffer value);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("SetConstantBufferFromScript")]
	private extern void SetConstantBufferImpl(int name, ComputeBuffer value, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("SetConstantBufferFromScript")]
	private extern void SetConstantGraphicsBufferImpl(int name, GraphicsBuffer value, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("SetFloatArrayFromScript")]
	private extern void SetFloatArrayImpl(int name, float[] values, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetVectorArrayFromScript")]
	[ThreadSafe]
	private extern void SetVectorArrayImpl(int name, Vector4[] values, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetMatrixArrayFromScript")]
	[ThreadSafe]
	private extern void SetMatrixArrayImpl(int name, Matrix4x4[] values, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetFloatArrayFromScript")]
	[ThreadSafe]
	private extern float[] GetFloatArrayImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("GetVectorArrayFromScript")]
	private extern Vector4[] GetVectorArrayImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("GetMatrixArrayFromScript")]
	private extern Matrix4x4[] GetMatrixArrayImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetFloatArrayCountFromScript")]
	[ThreadSafe]
	private extern int GetFloatArrayCountImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetVectorArrayCountFromScript")]
	[ThreadSafe]
	private extern int GetVectorArrayCountImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetMatrixArrayCountFromScript")]
	[ThreadSafe]
	private extern int GetMatrixArrayCountImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ExtractFloatArrayFromScript")]
	[ThreadSafe]
	private extern void ExtractFloatArrayImpl(int name, [Out] float[] val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("ExtractVectorArrayFromScript")]
	private extern void ExtractVectorArrayImpl(int name, [Out] Vector4[] val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[NativeName("ExtractMatrixArrayFromScript")]
	private extern void ExtractMatrixArrayImpl(int name, [Out] Matrix4x4[] val);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	[FreeFunction("ConvertAndCopySHCoefficientArraysToPropertySheetFromScript")]
	internal static extern void Internal_CopySHCoefficientArraysFrom(MaterialPropertyBlock properties, SphericalHarmonicsL2[] lightProbes, int sourceStart, int destStart, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CopyProbeOcclusionArrayToPropertySheetFromScript")]
	[ThreadSafe]
	internal static extern void Internal_CopyProbeOcclusionArrayFrom(MaterialPropertyBlock properties, Vector4[] occlusionProbes, int sourceStart, int destStart, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "MaterialPropertyBlockScripting::Create", IsFreeFunction = true)]
	private static extern IntPtr CreateImpl();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "MaterialPropertyBlockScripting::Destroy", IsFreeFunction = true, IsThreadSafe = true)]
	private static extern void DestroyImpl(IntPtr mpb);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	private extern void Clear(bool keepMemory);

	public void Clear()
	{
		Clear(keepMemory: true);
	}

	private void SetFloatArray(int name, float[] values, int count)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		if (values.Length == 0)
		{
			throw new ArgumentException("Zero-sized array is not allowed.");
		}
		if (values.Length < count)
		{
			throw new ArgumentException("array has less elements than passed count.");
		}
		SetFloatArrayImpl(name, values, count);
	}

	private void SetVectorArray(int name, Vector4[] values, int count)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		if (values.Length == 0)
		{
			throw new ArgumentException("Zero-sized array is not allowed.");
		}
		if (values.Length < count)
		{
			throw new ArgumentException("array has less elements than passed count.");
		}
		SetVectorArrayImpl(name, values, count);
	}

	private void SetMatrixArray(int name, Matrix4x4[] values, int count)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		if (values.Length == 0)
		{
			throw new ArgumentException("Zero-sized array is not allowed.");
		}
		if (values.Length < count)
		{
			throw new ArgumentException("array has less elements than passed count.");
		}
		SetMatrixArrayImpl(name, values, count);
	}

	private void ExtractFloatArray(int name, List<float> values)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		values.Clear();
		int floatArrayCountImpl = GetFloatArrayCountImpl(name);
		if (floatArrayCountImpl > 0)
		{
			NoAllocHelpers.EnsureListElemCount(values, floatArrayCountImpl);
			ExtractFloatArrayImpl(name, (float[])NoAllocHelpers.ExtractArrayFromList(values));
		}
	}

	private void ExtractVectorArray(int name, List<Vector4> values)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		values.Clear();
		int vectorArrayCountImpl = GetVectorArrayCountImpl(name);
		if (vectorArrayCountImpl > 0)
		{
			NoAllocHelpers.EnsureListElemCount(values, vectorArrayCountImpl);
			ExtractVectorArrayImpl(name, (Vector4[])NoAllocHelpers.ExtractArrayFromList(values));
		}
	}

	private void ExtractMatrixArray(int name, List<Matrix4x4> values)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		values.Clear();
		int matrixArrayCountImpl = GetMatrixArrayCountImpl(name);
		if (matrixArrayCountImpl > 0)
		{
			NoAllocHelpers.EnsureListElemCount(values, matrixArrayCountImpl);
			ExtractMatrixArrayImpl(name, (Matrix4x4[])NoAllocHelpers.ExtractArrayFromList(values));
		}
	}

	public MaterialPropertyBlock()
	{
		m_Ptr = CreateImpl();
	}

	~MaterialPropertyBlock()
	{
		Dispose();
	}

	private void Dispose()
	{
		if (m_Ptr != IntPtr.Zero)
		{
			DestroyImpl(m_Ptr);
			m_Ptr = IntPtr.Zero;
		}
		GC.SuppressFinalize(this);
	}

	public void SetInt(string name, int value)
	{
		SetFloatImpl(Shader.PropertyToID(name), value);
	}

	public void SetInt(int nameID, int value)
	{
		SetFloatImpl(nameID, value);
	}

	public void SetFloat(string name, float value)
	{
		SetFloatImpl(Shader.PropertyToID(name), value);
	}

	public void SetFloat(int nameID, float value)
	{
		SetFloatImpl(nameID, value);
	}

	public void SetInteger(string name, int value)
	{
		SetIntImpl(Shader.PropertyToID(name), value);
	}

	public void SetInteger(int nameID, int value)
	{
		SetIntImpl(nameID, value);
	}

	public void SetVector(string name, Vector4 value)
	{
		SetVectorImpl(Shader.PropertyToID(name), value);
	}

	public void SetVector(int nameID, Vector4 value)
	{
		SetVectorImpl(nameID, value);
	}

	public void SetColor(string name, Color value)
	{
		SetColorImpl(Shader.PropertyToID(name), value);
	}

	public void SetColor(int nameID, Color value)
	{
		SetColorImpl(nameID, value);
	}

	public void SetMatrix(string name, Matrix4x4 value)
	{
		SetMatrixImpl(Shader.PropertyToID(name), value);
	}

	public void SetMatrix(int nameID, Matrix4x4 value)
	{
		SetMatrixImpl(nameID, value);
	}

	public void SetBuffer(string name, ComputeBuffer value)
	{
		SetBufferImpl(Shader.PropertyToID(name), value);
	}

	public void SetBuffer(int nameID, ComputeBuffer value)
	{
		SetBufferImpl(nameID, value);
	}

	public void SetBuffer(string name, GraphicsBuffer value)
	{
		SetGraphicsBufferImpl(Shader.PropertyToID(name), value);
	}

	public void SetBuffer(int nameID, GraphicsBuffer value)
	{
		SetGraphicsBufferImpl(nameID, value);
	}

	public void SetTexture(string name, Texture value)
	{
		SetTextureImpl(Shader.PropertyToID(name), value);
	}

	public void SetTexture(int nameID, Texture value)
	{
		SetTextureImpl(nameID, value);
	}

	public void SetTexture(string name, RenderTexture value, RenderTextureSubElement element)
	{
		SetRenderTextureImpl(Shader.PropertyToID(name), value, element);
	}

	public void SetTexture(int nameID, RenderTexture value, RenderTextureSubElement element)
	{
		SetRenderTextureImpl(nameID, value, element);
	}

	public void SetConstantBuffer(string name, ComputeBuffer value, int offset, int size)
	{
		SetConstantBufferImpl(Shader.PropertyToID(name), value, offset, size);
	}

	public void SetConstantBuffer(int nameID, ComputeBuffer value, int offset, int size)
	{
		SetConstantBufferImpl(nameID, value, offset, size);
	}

	public void SetConstantBuffer(string name, GraphicsBuffer value, int offset, int size)
	{
		SetConstantGraphicsBufferImpl(Shader.PropertyToID(name), value, offset, size);
	}

	public void SetConstantBuffer(int nameID, GraphicsBuffer value, int offset, int size)
	{
		SetConstantGraphicsBufferImpl(nameID, value, offset, size);
	}

	public void SetFloatArray(string name, List<float> values)
	{
		SetFloatArray(Shader.PropertyToID(name), NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetFloatArray(int nameID, List<float> values)
	{
		SetFloatArray(nameID, NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetFloatArray(string name, float[] values)
	{
		SetFloatArray(Shader.PropertyToID(name), values, values.Length);
	}

	public void SetFloatArray(int nameID, float[] values)
	{
		SetFloatArray(nameID, values, values.Length);
	}

	public void SetVectorArray(string name, List<Vector4> values)
	{
		SetVectorArray(Shader.PropertyToID(name), NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetVectorArray(int nameID, List<Vector4> values)
	{
		SetVectorArray(nameID, NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetVectorArray(string name, Vector4[] values)
	{
		SetVectorArray(Shader.PropertyToID(name), values, values.Length);
	}

	public void SetVectorArray(int nameID, Vector4[] values)
	{
		SetVectorArray(nameID, values, values.Length);
	}

	public void SetMatrixArray(string name, List<Matrix4x4> values)
	{
		SetMatrixArray(Shader.PropertyToID(name), NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetMatrixArray(int nameID, List<Matrix4x4> values)
	{
		SetMatrixArray(nameID, NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetMatrixArray(string name, Matrix4x4[] values)
	{
		SetMatrixArray(Shader.PropertyToID(name), values, values.Length);
	}

	public void SetMatrixArray(int nameID, Matrix4x4[] values)
	{
		SetMatrixArray(nameID, values, values.Length);
	}

	public bool HasProperty(string name)
	{
		return HasPropertyImpl(Shader.PropertyToID(name));
	}

	public bool HasProperty(int nameID)
	{
		return HasPropertyImpl(nameID);
	}

	public bool HasInt(string name)
	{
		return HasFloatImpl(Shader.PropertyToID(name));
	}

	public bool HasInt(int nameID)
	{
		return HasFloatImpl(nameID);
	}

	public bool HasFloat(string name)
	{
		return HasFloatImpl(Shader.PropertyToID(name));
	}

	public bool HasFloat(int nameID)
	{
		return HasFloatImpl(nameID);
	}

	public bool HasInteger(string name)
	{
		return HasIntImpl(Shader.PropertyToID(name));
	}

	public bool HasInteger(int nameID)
	{
		return HasIntImpl(nameID);
	}

	public bool HasTexture(string name)
	{
		return HasTextureImpl(Shader.PropertyToID(name));
	}

	public bool HasTexture(int nameID)
	{
		return HasTextureImpl(nameID);
	}

	public bool HasMatrix(string name)
	{
		return HasMatrixImpl(Shader.PropertyToID(name));
	}

	public bool HasMatrix(int nameID)
	{
		return HasMatrixImpl(nameID);
	}

	public bool HasVector(string name)
	{
		return HasVectorImpl(Shader.PropertyToID(name));
	}

	public bool HasVector(int nameID)
	{
		return HasVectorImpl(nameID);
	}

	public bool HasColor(string name)
	{
		return HasVectorImpl(Shader.PropertyToID(name));
	}

	public bool HasColor(int nameID)
	{
		return HasVectorImpl(nameID);
	}

	public bool HasBuffer(string name)
	{
		return HasBufferImpl(Shader.PropertyToID(name));
	}

	public bool HasBuffer(int nameID)
	{
		return HasBufferImpl(nameID);
	}

	public bool HasConstantBuffer(string name)
	{
		return HasConstantBufferImpl(Shader.PropertyToID(name));
	}

	public bool HasConstantBuffer(int nameID)
	{
		return HasConstantBufferImpl(nameID);
	}

	public float GetFloat(string name)
	{
		return GetFloatImpl(Shader.PropertyToID(name));
	}

	public float GetFloat(int nameID)
	{
		return GetFloatImpl(nameID);
	}

	public int GetInt(string name)
	{
		return (int)GetFloatImpl(Shader.PropertyToID(name));
	}

	public int GetInt(int nameID)
	{
		return (int)GetFloatImpl(nameID);
	}

	public int GetInteger(string name)
	{
		return GetIntImpl(Shader.PropertyToID(name));
	}

	public int GetInteger(int nameID)
	{
		return GetIntImpl(nameID);
	}

	public Vector4 GetVector(string name)
	{
		return GetVectorImpl(Shader.PropertyToID(name));
	}

	public Vector4 GetVector(int nameID)
	{
		return GetVectorImpl(nameID);
	}

	public Color GetColor(string name)
	{
		return GetColorImpl(Shader.PropertyToID(name));
	}

	public Color GetColor(int nameID)
	{
		return GetColorImpl(nameID);
	}

	public Matrix4x4 GetMatrix(string name)
	{
		return GetMatrixImpl(Shader.PropertyToID(name));
	}

	public Matrix4x4 GetMatrix(int nameID)
	{
		return GetMatrixImpl(nameID);
	}

	public Texture GetTexture(string name)
	{
		return GetTextureImpl(Shader.PropertyToID(name));
	}

	public Texture GetTexture(int nameID)
	{
		return GetTextureImpl(nameID);
	}

	public float[] GetFloatArray(string name)
	{
		return GetFloatArray(Shader.PropertyToID(name));
	}

	public float[] GetFloatArray(int nameID)
	{
		return (GetFloatArrayCountImpl(nameID) != 0) ? GetFloatArrayImpl(nameID) : null;
	}

	public Vector4[] GetVectorArray(string name)
	{
		return GetVectorArray(Shader.PropertyToID(name));
	}

	public Vector4[] GetVectorArray(int nameID)
	{
		return (GetVectorArrayCountImpl(nameID) != 0) ? GetVectorArrayImpl(nameID) : null;
	}

	public Matrix4x4[] GetMatrixArray(string name)
	{
		return GetMatrixArray(Shader.PropertyToID(name));
	}

	public Matrix4x4[] GetMatrixArray(int nameID)
	{
		return (GetMatrixArrayCountImpl(nameID) != 0) ? GetMatrixArrayImpl(nameID) : null;
	}

	public void GetFloatArray(string name, List<float> values)
	{
		ExtractFloatArray(Shader.PropertyToID(name), values);
	}

	public void GetFloatArray(int nameID, List<float> values)
	{
		ExtractFloatArray(nameID, values);
	}

	public void GetVectorArray(string name, List<Vector4> values)
	{
		ExtractVectorArray(Shader.PropertyToID(name), values);
	}

	public void GetVectorArray(int nameID, List<Vector4> values)
	{
		ExtractVectorArray(nameID, values);
	}

	public void GetMatrixArray(string name, List<Matrix4x4> values)
	{
		ExtractMatrixArray(Shader.PropertyToID(name), values);
	}

	public void GetMatrixArray(int nameID, List<Matrix4x4> values)
	{
		ExtractMatrixArray(nameID, values);
	}

	public void CopySHCoefficientArraysFrom(List<SphericalHarmonicsL2> lightProbes)
	{
		if (lightProbes == null)
		{
			throw new ArgumentNullException("lightProbes");
		}
		CopySHCoefficientArraysFrom(NoAllocHelpers.ExtractArrayFromListT(lightProbes), 0, 0, lightProbes.Count);
	}

	public void CopySHCoefficientArraysFrom(SphericalHarmonicsL2[] lightProbes)
	{
		if (lightProbes == null)
		{
			throw new ArgumentNullException("lightProbes");
		}
		CopySHCoefficientArraysFrom(lightProbes, 0, 0, lightProbes.Length);
	}

	public void CopySHCoefficientArraysFrom(List<SphericalHarmonicsL2> lightProbes, int sourceStart, int destStart, int count)
	{
		CopySHCoefficientArraysFrom(NoAllocHelpers.ExtractArrayFromListT(lightProbes), sourceStart, destStart, count);
	}

	public void CopySHCoefficientArraysFrom(SphericalHarmonicsL2[] lightProbes, int sourceStart, int destStart, int count)
	{
		if (lightProbes == null)
		{
			throw new ArgumentNullException("lightProbes");
		}
		if (sourceStart < 0)
		{
			throw new ArgumentOutOfRangeException("sourceStart", "Argument sourceStart must not be negative.");
		}
		if (destStart < 0)
		{
			throw new ArgumentOutOfRangeException("sourceStart", "Argument destStart must not be negative.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Argument count must not be negative.");
		}
		if (lightProbes.Length < sourceStart + count)
		{
			throw new ArgumentOutOfRangeException("The specified source start index or count is out of the range.");
		}
		Internal_CopySHCoefficientArraysFrom(this, lightProbes, sourceStart, destStart, count);
	}

	public void CopyProbeOcclusionArrayFrom(List<Vector4> occlusionProbes)
	{
		if (occlusionProbes == null)
		{
			throw new ArgumentNullException("occlusionProbes");
		}
		CopyProbeOcclusionArrayFrom(NoAllocHelpers.ExtractArrayFromListT(occlusionProbes), 0, 0, occlusionProbes.Count);
	}

	public void CopyProbeOcclusionArrayFrom(Vector4[] occlusionProbes)
	{
		if (occlusionProbes == null)
		{
			throw new ArgumentNullException("occlusionProbes");
		}
		CopyProbeOcclusionArrayFrom(occlusionProbes, 0, 0, occlusionProbes.Length);
	}

	public void CopyProbeOcclusionArrayFrom(List<Vector4> occlusionProbes, int sourceStart, int destStart, int count)
	{
		CopyProbeOcclusionArrayFrom(NoAllocHelpers.ExtractArrayFromListT(occlusionProbes), sourceStart, destStart, count);
	}

	public void CopyProbeOcclusionArrayFrom(Vector4[] occlusionProbes, int sourceStart, int destStart, int count)
	{
		if (occlusionProbes == null)
		{
			throw new ArgumentNullException("occlusionProbes");
		}
		if (sourceStart < 0)
		{
			throw new ArgumentOutOfRangeException("sourceStart", "Argument sourceStart must not be negative.");
		}
		if (destStart < 0)
		{
			throw new ArgumentOutOfRangeException("sourceStart", "Argument destStart must not be negative.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Argument count must not be negative.");
		}
		if (occlusionProbes.Length < sourceStart + count)
		{
			throw new ArgumentOutOfRangeException("The specified source start index or count is out of the range.");
		}
		Internal_CopyProbeOcclusionArrayFrom(this, occlusionProbes, sourceStart, destStart, count);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetVectorImpl_Injected(int name, out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetColorImpl_Injected(int name, out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetMatrixImpl_Injected(int name, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetVectorImpl_Injected(int name, ref Vector4 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetColorImpl_Injected(int name, ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetMatrixImpl_Injected(int name, ref Matrix4x4 value);
}
