using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/OcclusionArea.h")]
public sealed class OcclusionArea : Component
{
	public Vector3 center
	{
		get
		{
			get_center_Injected(out var ret);
			return ret;
		}
		set
		{
			set_center_Injected(ref value);
		}
	}

	public Vector3 size
	{
		get
		{
			get_size_Injected(out var ret);
			return ret;
		}
		set
		{
			set_size_Injected(ref value);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_center_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_center_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_size_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_size_Injected(ref Vector3 value);
}
