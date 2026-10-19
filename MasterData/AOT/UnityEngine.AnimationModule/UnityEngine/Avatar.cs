using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[NativeHeader("Modules/Animation/Avatar.h")]
public class Avatar : Object
{
	public extern bool isValid
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsValid")]
		get;
	}

	public extern bool isHuman
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsHuman")]
		get;
	}

	public HumanDescription humanDescription
	{
		get
		{
			get_humanDescription_Injected(out var ret);
			return ret;
		}
	}

	private Avatar()
	{
	}

	internal float GetAxisLength(int humanId)
	{
		return Internal_GetAxisLength(HumanTrait.GetBoneIndexFromMono(humanId));
	}

	internal Quaternion GetPostRotation(int humanId)
	{
		return Internal_GetPostRotation(HumanTrait.GetBoneIndexFromMono(humanId));
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("GetAxisLength")]
	internal extern float Internal_GetAxisLength(int humanId);

	[NativeMethod("GetPostRotation")]
	internal Quaternion Internal_GetPostRotation(int humanId)
	{
		Internal_GetPostRotation_Injected(humanId, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_humanDescription_Injected(out HumanDescription ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void Internal_GetPostRotation_Injected(int humanId, out Quaternion ret);
}
