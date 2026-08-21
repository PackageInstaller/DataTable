using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine;

public sealed class ShaderVariantCollection : Object
{
	public struct ShaderVariant
	{
		public Shader shader;

		public PassType passType;

		public string[] keywords;
	}

	public extern int shaderCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int variantCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int warmedUpVariantCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern bool isWarmedUp
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsWarmedUp")]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool AddVariant(Shader shader, PassType passType, [Unmarshalled] string[] keywords);

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool RemoveVariant(Shader shader, PassType passType, [Unmarshalled] string[] keywords);

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool ContainsVariant(Shader shader, PassType passType, [Unmarshalled] string[] keywords);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ClearVariants")]
	public extern void Clear();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("WarmupShaders")]
	public extern void WarmUp();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("WarmupShadersProgressively")]
	public extern bool WarmUpProgressively(int variantCount);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("CreateFromScript")]
	private static extern void Internal_Create([Writable] ShaderVariantCollection svc);

	public ShaderVariantCollection()
	{
		Internal_Create(this);
	}

	public bool Add(ShaderVariant variant)
	{
		return AddVariant(variant.shader, variant.passType, variant.keywords);
	}

	public bool Remove(ShaderVariant variant)
	{
		return RemoveVariant(variant.shader, variant.passType, variant.keywords);
	}

	public bool Contains(ShaderVariant variant)
	{
		return ContainsVariant(variant.shader, variant.passType, variant.keywords);
	}
}
