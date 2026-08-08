using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/LOD/LODGroup.h")]
[NativeHeader("Runtime/Graphics/LOD/LODGroupManager.h")]
[StaticAccessor("GetLODGroupManager()", StaticAccessorType.Dot)]
[NativeHeader("Runtime/Graphics/LOD/LODUtility.h")]
public class LODGroup : Component
{
	public Vector3 localReferencePoint
	{
		get
		{
			get_localReferencePoint_Injected(out var ret);
			return ret;
		}
		set
		{
			set_localReferencePoint_Injected(ref value);
		}
	}

	public extern float size
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int lodCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetLODCount")]
		get;
	}

	public extern bool lastLODBillboard
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetLastLODIsBillboard")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("SetLastLODIsBillboard")]
		set;
	}

	public extern LODFadeMode fadeMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool animateCrossFading
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool enabled
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[StaticAccessor("GetLODGroupManager()")]
	public static extern float crossFadeAnimationDuration
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	internal Vector3 worldReferencePoint
	{
		get
		{
			get_worldReferencePoint_Injected(out var ret);
			return ret;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UpdateLODGroupBoundingBox", HasExplicitThis = true)]
	public extern void RecalculateBounds();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetLODs_Binding", HasExplicitThis = true)]
	public extern LOD[] GetLODs();

	[Obsolete("Use SetLODs instead.")]
	public void SetLODS(LOD[] lods)
	{
		SetLODs(lods);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SetLODs_Binding", HasExplicitThis = true)]
	public extern void SetLODs([Unmarshalled] LOD[] lods);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ForceLODLevel", HasExplicitThis = true)]
	public extern void ForceLOD(int index);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localReferencePoint_Injected(out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_localReferencePoint_Injected(ref Vector3 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_worldReferencePoint_Injected(out Vector3 ret);
}
