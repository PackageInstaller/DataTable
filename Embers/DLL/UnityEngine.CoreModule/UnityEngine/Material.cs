using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/ShaderScriptBindings.h")]
[NativeHeader("Runtime/Shaders/Material.h")]
public class Material : Object
{
	public extern Shader shader
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Color color
	{
		get
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainColor);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				return GetColor(firstPropertyNameIdByAttribute);
			}
			return GetColor("_Color");
		}
		set
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainColor);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				SetColor(firstPropertyNameIdByAttribute, value);
			}
			else
			{
				SetColor("_Color", value);
			}
		}
	}

	public Texture mainTexture
	{
		get
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainTexture);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				return GetTexture(firstPropertyNameIdByAttribute);
			}
			return GetTexture("_MainTex");
		}
		set
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainTexture);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				SetTexture(firstPropertyNameIdByAttribute, value);
			}
			else
			{
				SetTexture("_MainTex", value);
			}
		}
	}

	public Vector2 mainTextureOffset
	{
		get
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainTexture);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				return GetTextureOffset(firstPropertyNameIdByAttribute);
			}
			return GetTextureOffset("_MainTex");
		}
		set
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainTexture);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				SetTextureOffset(firstPropertyNameIdByAttribute, value);
			}
			else
			{
				SetTextureOffset("_MainTex", value);
			}
		}
	}

	public Vector2 mainTextureScale
	{
		get
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainTexture);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				return GetTextureScale(firstPropertyNameIdByAttribute);
			}
			return GetTextureScale("_MainTex");
		}
		set
		{
			int firstPropertyNameIdByAttribute = GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags.MainTexture);
			if (firstPropertyNameIdByAttribute >= 0)
			{
				SetTextureScale(firstPropertyNameIdByAttribute, value);
			}
			else
			{
				SetTextureScale("_MainTex", value);
			}
		}
	}

	public extern int renderQueue
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetActualRenderQueue")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetCustomRenderQueue")]
		set;
	}

	internal extern int rawRenderQueue
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetCustomRenderQueue")]
		get;
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

	public extern MaterialGlobalIlluminationFlags globalIlluminationFlags
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool doubleSidedGI
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("EnableInstancingVariants")]
	public extern bool enableInstancing
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int passCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetShader()->GetPassCount")]
		get;
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

	[Obsolete("Creating materials from shader source string will be removed in the future. Use Shader assets instead.", false)]
	public static Material Create(string scriptContents)
	{
		return new Material(scriptContents);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::CreateWithShader")]
	private static extern void CreateWithShader([Writable] Material self, [NotNull("ArgumentNullException")] Shader shader);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::CreateWithMaterial")]
	private static extern void CreateWithMaterial([Writable] Material self, [NotNull("ArgumentNullException")] Material source);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::CreateWithString")]
	private static extern void CreateWithString([Writable] Material self);

	public Material(Shader shader)
	{
		CreateWithShader(this, shader);
	}

	[RequiredByNativeCode]
	public Material(Material source)
	{
		CreateWithMaterial(this, source);
	}

	[Obsolete("Creating materials from shader source string is no longer supported. Use Shader assets instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public Material(string contents)
	{
		CreateWithString(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Material GetDefaultMaterial();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Material GetDefaultParticleMaterial();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Material GetDefaultLineMaterial();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetFirstPropertyNameIdByAttributeFromScript")]
	private extern int GetFirstPropertyNameIdByAttribute(ShaderPropertyFlags attributeFlag);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasPropertyFromScript")]
	public extern bool HasProperty(int nameID);

	public bool HasProperty(string name)
	{
		return HasProperty(Shader.PropertyToID(name));
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasFloatFromScript")]
	private extern bool HasFloatImpl(int name);

	public bool HasFloat(string name)
	{
		return HasFloatImpl(Shader.PropertyToID(name));
	}

	public bool HasFloat(int nameID)
	{
		return HasFloatImpl(nameID);
	}

	public bool HasInt(string name)
	{
		return HasFloatImpl(Shader.PropertyToID(name));
	}

	public bool HasInt(int nameID)
	{
		return HasFloatImpl(nameID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasIntegerFromScript")]
	private extern bool HasIntImpl(int name);

	public bool HasInteger(string name)
	{
		return HasIntImpl(Shader.PropertyToID(name));
	}

	public bool HasInteger(int nameID)
	{
		return HasIntImpl(nameID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasTextureFromScript")]
	private extern bool HasTextureImpl(int name);

	public bool HasTexture(string name)
	{
		return HasTextureImpl(Shader.PropertyToID(name));
	}

	public bool HasTexture(int nameID)
	{
		return HasTextureImpl(nameID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasMatrixFromScript")]
	private extern bool HasMatrixImpl(int name);

	public bool HasMatrix(string name)
	{
		return HasMatrixImpl(Shader.PropertyToID(name));
	}

	public bool HasMatrix(int nameID)
	{
		return HasMatrixImpl(nameID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasVectorFromScript")]
	private extern bool HasVectorImpl(int name);

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

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasBufferFromScript")]
	private extern bool HasBufferImpl(int name);

	public bool HasBuffer(string name)
	{
		return HasBufferImpl(Shader.PropertyToID(name));
	}

	public bool HasBuffer(int nameID)
	{
		return HasBufferImpl(nameID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("HasConstantBufferFromScript")]
	private extern bool HasConstantBufferImpl(int name);

	public bool HasConstantBuffer(string name)
	{
		return HasConstantBufferImpl(Shader.PropertyToID(name));
	}

	public bool HasConstantBuffer(int nameID)
	{
		return HasConstantBufferImpl(nameID);
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void EnableKeyword(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void DisableKeyword(string keyword);

	[MethodImpl((MethodImplOptions)4096)]
	public extern bool IsKeywordEnabled(string keyword);

	[FreeFunction("MaterialScripting::EnableKeyword", HasExplicitThis = true)]
	private void EnableLocalKeyword(LocalKeyword keyword)
	{
		EnableLocalKeyword_Injected(ref keyword);
	}

	[FreeFunction("MaterialScripting::DisableKeyword", HasExplicitThis = true)]
	private void DisableLocalKeyword(LocalKeyword keyword)
	{
		DisableLocalKeyword_Injected(ref keyword);
	}

	[FreeFunction("MaterialScripting::SetKeyword", HasExplicitThis = true)]
	private void SetLocalKeyword(LocalKeyword keyword, bool value)
	{
		SetLocalKeyword_Injected(ref keyword, value);
	}

	[FreeFunction("MaterialScripting::IsKeywordEnabled", HasExplicitThis = true)]
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
	[FreeFunction("MaterialScripting::GetEnabledKeywords", HasExplicitThis = true)]
	private extern LocalKeyword[] GetEnabledKeywords();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::SetEnabledKeywords", HasExplicitThis = true)]
	private extern void SetEnabledKeywords(LocalKeyword[] keywords);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::SetShaderPassEnabled", HasExplicitThis = true)]
	public extern void SetShaderPassEnabled(string passName, bool enabled);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::GetShaderPassEnabled", HasExplicitThis = true)]
	public extern bool GetShaderPassEnabled(string passName);

	[MethodImpl((MethodImplOptions)4096)]
	public extern string GetPassName(int pass);

	[MethodImpl((MethodImplOptions)4096)]
	public extern int FindPass(string passName);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void SetOverrideTag(string tag, string val);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetTag")]
	private extern string GetTagImpl(string tag, bool currentSubShaderOnly, string defaultValue);

	public string GetTag(string tag, bool searchFallbacks, string defaultValue)
	{
		return GetTagImpl(tag, !searchFallbacks, defaultValue);
	}

	public string GetTag(string tag, bool searchFallbacks)
	{
		return GetTagImpl(tag, !searchFallbacks, "");
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::Lerp", HasExplicitThis = true)]
	[NativeThrows]
	public extern void Lerp(Material start, Material end, float t);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::SetPass", HasExplicitThis = true)]
	public extern bool SetPass(int pass);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::CopyPropertiesFrom", HasExplicitThis = true)]
	public extern void CopyPropertiesFromMaterial(Material mat);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::CopyMatchingPropertiesFrom", HasExplicitThis = true)]
	public extern void CopyMatchingPropertiesFromMaterial(Material mat);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::GetShaderKeywords", HasExplicitThis = true)]
	private extern string[] GetShaderKeywords();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::SetShaderKeywords", HasExplicitThis = true)]
	private extern void SetShaderKeywords(string[] names);

	[MethodImpl((MethodImplOptions)4096)]
	public extern int ComputeCRC();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::GetTexturePropertyNames", HasExplicitThis = true)]
	public extern string[] GetTexturePropertyNames();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::GetTexturePropertyNameIDs", HasExplicitThis = true)]
	public extern int[] GetTexturePropertyNameIDs();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::GetTexturePropertyNamesInternal", HasExplicitThis = true)]
	private extern void GetTexturePropertyNamesInternal(object outNames);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MaterialScripting::GetTexturePropertyNameIDsInternal", HasExplicitThis = true)]
	private extern void GetTexturePropertyNameIDsInternal(object outNames);

	public void GetTexturePropertyNames(List<string> outNames)
	{
		if (outNames == null)
		{
			throw new ArgumentNullException("outNames");
		}
		GetTexturePropertyNamesInternal(outNames);
	}

	public void GetTexturePropertyNameIDs(List<int> outNames)
	{
		if (outNames == null)
		{
			throw new ArgumentNullException("outNames");
		}
		GetTexturePropertyNameIDsInternal(outNames);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetIntFromScript")]
	private extern void SetIntImpl(int name, int value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetFloatFromScript")]
	private extern void SetFloatImpl(int name, float value);

	[NativeName("SetColorFromScript")]
	private void SetColorImpl(int name, Color value)
	{
		SetColorImpl_Injected(name, ref value);
	}

	[NativeName("SetMatrixFromScript")]
	private void SetMatrixImpl(int name, Matrix4x4 value)
	{
		SetMatrixImpl_Injected(name, ref value);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetTextureFromScript")]
	private extern void SetTextureImpl(int name, Texture value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetRenderTextureFromScript")]
	private extern void SetRenderTextureImpl(int name, RenderTexture value, RenderTextureSubElement element);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetBufferFromScript")]
	private extern void SetBufferImpl(int name, ComputeBuffer value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetBufferFromScript")]
	private extern void SetGraphicsBufferImpl(int name, GraphicsBuffer value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetConstantBufferFromScript")]
	private extern void SetConstantBufferImpl(int name, ComputeBuffer value, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetConstantBufferFromScript")]
	private extern void SetConstantGraphicsBufferImpl(int name, GraphicsBuffer value, int offset, int size);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetIntFromScript")]
	private extern int GetIntImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetFloatFromScript")]
	private extern float GetFloatImpl(int name);

	[NativeName("GetColorFromScript")]
	private Color GetColorImpl(int name)
	{
		GetColorImpl_Injected(name, out var ret);
		return ret;
	}

	[NativeName("GetMatrixFromScript")]
	private Matrix4x4 GetMatrixImpl(int name)
	{
		GetMatrixImpl_Injected(name, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetTextureFromScript")]
	private extern Texture GetTextureImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::SetFloatArray", HasExplicitThis = true)]
	private extern void SetFloatArrayImpl(int name, float[] values, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::SetVectorArray", HasExplicitThis = true)]
	private extern void SetVectorArrayImpl(int name, Vector4[] values, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::SetColorArray", HasExplicitThis = true)]
	private extern void SetColorArrayImpl(int name, Color[] values, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::SetMatrixArray", HasExplicitThis = true)]
	private extern void SetMatrixArrayImpl(int name, Matrix4x4[] values, int count);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetFloatArray", HasExplicitThis = true)]
	private extern float[] GetFloatArrayImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetVectorArray", HasExplicitThis = true)]
	private extern Vector4[] GetVectorArrayImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetColorArray", HasExplicitThis = true)]
	private extern Color[] GetColorArrayImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetMatrixArray", HasExplicitThis = true)]
	private extern Matrix4x4[] GetMatrixArrayImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetFloatArrayCount", HasExplicitThis = true)]
	private extern int GetFloatArrayCountImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetVectorArrayCount", HasExplicitThis = true)]
	private extern int GetVectorArrayCountImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetColorArrayCount", HasExplicitThis = true)]
	private extern int GetColorArrayCountImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::GetMatrixArrayCount", HasExplicitThis = true)]
	private extern int GetMatrixArrayCountImpl(int name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::ExtractFloatArray", HasExplicitThis = true)]
	private extern void ExtractFloatArrayImpl(int name, [Out] float[] val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::ExtractVectorArray", HasExplicitThis = true)]
	private extern void ExtractVectorArrayImpl(int name, [Out] Vector4[] val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::ExtractColorArray", HasExplicitThis = true)]
	private extern void ExtractColorArrayImpl(int name, [Out] Color[] val);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MaterialScripting::ExtractMatrixArray", HasExplicitThis = true)]
	private extern void ExtractMatrixArrayImpl(int name, [Out] Matrix4x4[] val);

	[NativeName("GetTextureScaleAndOffsetFromScript")]
	private Vector4 GetTextureScaleAndOffsetImpl(int name)
	{
		GetTextureScaleAndOffsetImpl_Injected(name, out var ret);
		return ret;
	}

	[NativeName("SetTextureOffsetFromScript")]
	private void SetTextureOffsetImpl(int name, Vector2 offset)
	{
		SetTextureOffsetImpl_Injected(name, ref offset);
	}

	[NativeName("SetTextureScaleFromScript")]
	private void SetTextureScaleImpl(int name, Vector2 scale)
	{
		SetTextureScaleImpl_Injected(name, ref scale);
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

	private void SetColorArray(int name, Color[] values, int count)
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
		SetColorArrayImpl(name, values, count);
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

	private void ExtractColorArray(int name, List<Color> values)
	{
		if (values == null)
		{
			throw new ArgumentNullException("values");
		}
		values.Clear();
		int colorArrayCountImpl = GetColorArrayCountImpl(name);
		if (colorArrayCountImpl > 0)
		{
			NoAllocHelpers.EnsureListElemCount(values, colorArrayCountImpl);
			ExtractColorArrayImpl(name, (Color[])NoAllocHelpers.ExtractArrayFromList(values));
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

	public void SetColor(string name, Color value)
	{
		SetColorImpl(Shader.PropertyToID(name), value);
	}

	public void SetColor(int nameID, Color value)
	{
		SetColorImpl(nameID, value);
	}

	public void SetVector(string name, Vector4 value)
	{
		SetColorImpl(Shader.PropertyToID(name), value);
	}

	public void SetVector(int nameID, Vector4 value)
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

	public void SetColorArray(string name, List<Color> values)
	{
		SetColorArray(Shader.PropertyToID(name), NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetColorArray(int nameID, List<Color> values)
	{
		SetColorArray(nameID, NoAllocHelpers.ExtractArrayFromListT(values), values.Count);
	}

	public void SetColorArray(string name, Color[] values)
	{
		SetColorArray(Shader.PropertyToID(name), values, values.Length);
	}

	public void SetColorArray(int nameID, Color[] values)
	{
		SetColorArray(nameID, values, values.Length);
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

	public int GetInt(string name)
	{
		return (int)GetFloatImpl(Shader.PropertyToID(name));
	}

	public int GetInt(int nameID)
	{
		return (int)GetFloatImpl(nameID);
	}

	public float GetFloat(string name)
	{
		return GetFloatImpl(Shader.PropertyToID(name));
	}

	public float GetFloat(int nameID)
	{
		return GetFloatImpl(nameID);
	}

	public int GetInteger(string name)
	{
		return GetIntImpl(Shader.PropertyToID(name));
	}

	public int GetInteger(int nameID)
	{
		return GetIntImpl(nameID);
	}

	public Color GetColor(string name)
	{
		return GetColorImpl(Shader.PropertyToID(name));
	}

	public Color GetColor(int nameID)
	{
		return GetColorImpl(nameID);
	}

	public Vector4 GetVector(string name)
	{
		return GetColorImpl(Shader.PropertyToID(name));
	}

	public Vector4 GetVector(int nameID)
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

	public Color[] GetColorArray(string name)
	{
		return GetColorArray(Shader.PropertyToID(name));
	}

	public Color[] GetColorArray(int nameID)
	{
		return (GetColorArrayCountImpl(nameID) != 0) ? GetColorArrayImpl(nameID) : null;
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

	public void GetColorArray(string name, List<Color> values)
	{
		ExtractColorArray(Shader.PropertyToID(name), values);
	}

	public void GetColorArray(int nameID, List<Color> values)
	{
		ExtractColorArray(nameID, values);
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

	public void SetTextureOffset(string name, Vector2 value)
	{
		SetTextureOffsetImpl(Shader.PropertyToID(name), value);
	}

	public void SetTextureOffset(int nameID, Vector2 value)
	{
		SetTextureOffsetImpl(nameID, value);
	}

	public void SetTextureScale(string name, Vector2 value)
	{
		SetTextureScaleImpl(Shader.PropertyToID(name), value);
	}

	public void SetTextureScale(int nameID, Vector2 value)
	{
		SetTextureScaleImpl(nameID, value);
	}

	public Vector2 GetTextureOffset(string name)
	{
		return GetTextureOffset(Shader.PropertyToID(name));
	}

	public Vector2 GetTextureOffset(int nameID)
	{
		Vector4 textureScaleAndOffsetImpl = GetTextureScaleAndOffsetImpl(nameID);
		return new Vector2(textureScaleAndOffsetImpl.z, textureScaleAndOffsetImpl.w);
	}

	public Vector2 GetTextureScale(string name)
	{
		return GetTextureScale(Shader.PropertyToID(name));
	}

	public Vector2 GetTextureScale(int nameID)
	{
		Vector4 textureScaleAndOffsetImpl = GetTextureScaleAndOffsetImpl(nameID);
		return new Vector2(textureScaleAndOffsetImpl.x, textureScaleAndOffsetImpl.y);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void EnableLocalKeyword_Injected(ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void DisableLocalKeyword_Injected(ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetLocalKeyword_Injected(ref LocalKeyword keyword, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool IsLocalKeywordEnabled_Injected(ref LocalKeyword keyword);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetColorImpl_Injected(int name, ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetMatrixImpl_Injected(int name, ref Matrix4x4 value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetColorImpl_Injected(int name, out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetMatrixImpl_Injected(int name, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetTextureScaleAndOffsetImpl_Injected(int name, out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetTextureOffsetImpl_Injected(int name, ref Vector2 offset);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetTextureScaleImpl_Injected(int name, ref Vector2 scale);
}
