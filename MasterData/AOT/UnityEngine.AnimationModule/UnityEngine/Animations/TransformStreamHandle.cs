using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.Animations;

[NativeHeader("Modules/Animation/Director/AnimationStreamHandles.h")]
[NativeHeader("Modules/Animation/ScriptBindings/AnimationStreamHandles.bindings.h")]
[MovedFrom("UnityEngine.Experimental.Animations")]
public struct TransformStreamHandle
{
	private uint m_AnimatorBindingsVersion;

	private int handleIndex;

	private int skeletonIndex;

	private bool createdByNative => animatorBindingsVersion != 0;

	private bool hasHandleIndex => handleIndex != -1;

	private bool hasSkeletonIndex => skeletonIndex != -1;

	internal uint animatorBindingsVersion
	{
		get
		{
			return m_AnimatorBindingsVersion;
		}
		private set
		{
			m_AnimatorBindingsVersion = value;
		}
	}

	public bool IsValid(AnimationStream stream)
	{
		return IsValidInternal(ref stream);
	}

	private bool IsValidInternal(ref AnimationStream stream)
	{
		return stream.isValid && createdByNative && hasHandleIndex;
	}

	private bool IsSameVersionAsStream(ref AnimationStream stream)
	{
		return animatorBindingsVersion == stream.animatorBindingsVersion;
	}

	public void Resolve(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
	}

	public bool IsResolved(AnimationStream stream)
	{
		return IsResolvedInternal(ref stream);
	}

	private bool IsResolvedInternal(ref AnimationStream stream)
	{
		return IsValidInternal(ref stream) && IsSameVersionAsStream(ref stream) && hasSkeletonIndex;
	}

	private void CheckIsValidAndResolve(ref AnimationStream stream)
	{
		stream.CheckIsValid();
		if (!IsResolvedInternal(ref stream))
		{
			if (!createdByNative || !hasHandleIndex)
			{
				throw new InvalidOperationException("The TransformStreamHandle is invalid. Please use proper function to create the handle.");
			}
			if (!IsSameVersionAsStream(ref stream) || (hasHandleIndex && !hasSkeletonIndex))
			{
				ResolveInternal(ref stream);
			}
			if (hasHandleIndex && !hasSkeletonIndex)
			{
				throw new InvalidOperationException("The TransformStreamHandle cannot be resolved.");
			}
		}
	}

	public Vector3 GetPosition(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetPositionInternal(ref stream);
	}

	public void SetPosition(AnimationStream stream, Vector3 position)
	{
		CheckIsValidAndResolve(ref stream);
		SetPositionInternal(ref stream, position);
	}

	public Quaternion GetRotation(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetRotationInternal(ref stream);
	}

	public void SetRotation(AnimationStream stream, Quaternion rotation)
	{
		CheckIsValidAndResolve(ref stream);
		SetRotationInternal(ref stream, rotation);
	}

	public Vector3 GetLocalPosition(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetLocalPositionInternal(ref stream);
	}

	public void SetLocalPosition(AnimationStream stream, Vector3 position)
	{
		CheckIsValidAndResolve(ref stream);
		SetLocalPositionInternal(ref stream, position);
	}

	public Quaternion GetLocalRotation(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetLocalRotationInternal(ref stream);
	}

	public void SetLocalRotation(AnimationStream stream, Quaternion rotation)
	{
		CheckIsValidAndResolve(ref stream);
		SetLocalRotationInternal(ref stream, rotation);
	}

	public Vector3 GetLocalScale(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetLocalScaleInternal(ref stream);
	}

	public void SetLocalScale(AnimationStream stream, Vector3 scale)
	{
		CheckIsValidAndResolve(ref stream);
		SetLocalScaleInternal(ref stream, scale);
	}

	public Matrix4x4 GetLocalToParentMatrix(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetLocalToParentMatrixInternal(ref stream);
	}

	public bool GetPositionReadMask(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetPositionReadMaskInternal(ref stream);
	}

	public bool GetRotationReadMask(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetRotationReadMaskInternal(ref stream);
	}

	public bool GetScaleReadMask(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetScaleReadMaskInternal(ref stream);
	}

	public void GetLocalTRS(AnimationStream stream, out Vector3 position, out Quaternion rotation, out Vector3 scale)
	{
		CheckIsValidAndResolve(ref stream);
		GetLocalTRSInternal(ref stream, out position, out rotation, out scale);
	}

	public void SetLocalTRS(AnimationStream stream, Vector3 position, Quaternion rotation, Vector3 scale, bool useMask)
	{
		CheckIsValidAndResolve(ref stream);
		SetLocalTRSInternal(ref stream, position, rotation, scale, useMask);
	}

	public void GetGlobalTR(AnimationStream stream, out Vector3 position, out Quaternion rotation)
	{
		CheckIsValidAndResolve(ref stream);
		GetGlobalTRInternal(ref stream, out position, out rotation);
	}

	public Matrix4x4 GetLocalToWorldMatrix(AnimationStream stream)
	{
		CheckIsValidAndResolve(ref stream);
		return GetLocalToWorldMatrixInternal(ref stream);
	}

	public void SetGlobalTR(AnimationStream stream, Vector3 position, Quaternion rotation, bool useMask)
	{
		CheckIsValidAndResolve(ref stream);
		SetGlobalTRInternal(ref stream, position, rotation, useMask);
	}

	[NativeMethod(Name = "Resolve", IsThreadSafe = true)]
	private void ResolveInternal(ref AnimationStream stream)
	{
		ResolveInternal_Injected(ref this, ref stream);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetPositionInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private Vector3 GetPositionInternal(ref AnimationStream stream)
	{
		GetPositionInternal_Injected(ref this, ref stream, out var ret);
		return ret;
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::SetPositionInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void SetPositionInternal(ref AnimationStream stream, Vector3 position)
	{
		SetPositionInternal_Injected(ref this, ref stream, ref position);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetRotationInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private Quaternion GetRotationInternal(ref AnimationStream stream)
	{
		GetRotationInternal_Injected(ref this, ref stream, out var ret);
		return ret;
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::SetRotationInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void SetRotationInternal(ref AnimationStream stream, Quaternion rotation)
	{
		SetRotationInternal_Injected(ref this, ref stream, ref rotation);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetLocalPositionInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private Vector3 GetLocalPositionInternal(ref AnimationStream stream)
	{
		GetLocalPositionInternal_Injected(ref this, ref stream, out var ret);
		return ret;
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::SetLocalPositionInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void SetLocalPositionInternal(ref AnimationStream stream, Vector3 position)
	{
		SetLocalPositionInternal_Injected(ref this, ref stream, ref position);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetLocalRotationInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private Quaternion GetLocalRotationInternal(ref AnimationStream stream)
	{
		GetLocalRotationInternal_Injected(ref this, ref stream, out var ret);
		return ret;
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::SetLocalRotationInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void SetLocalRotationInternal(ref AnimationStream stream, Quaternion rotation)
	{
		SetLocalRotationInternal_Injected(ref this, ref stream, ref rotation);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetLocalScaleInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private Vector3 GetLocalScaleInternal(ref AnimationStream stream)
	{
		GetLocalScaleInternal_Injected(ref this, ref stream, out var ret);
		return ret;
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::SetLocalScaleInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void SetLocalScaleInternal(ref AnimationStream stream, Vector3 scale)
	{
		SetLocalScaleInternal_Injected(ref this, ref stream, ref scale);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetLocalToParentMatrixInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private Matrix4x4 GetLocalToParentMatrixInternal(ref AnimationStream stream)
	{
		GetLocalToParentMatrixInternal_Injected(ref this, ref stream, out var ret);
		return ret;
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetPositionReadMaskInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private bool GetPositionReadMaskInternal(ref AnimationStream stream)
	{
		return GetPositionReadMaskInternal_Injected(ref this, ref stream);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetRotationReadMaskInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private bool GetRotationReadMaskInternal(ref AnimationStream stream)
	{
		return GetRotationReadMaskInternal_Injected(ref this, ref stream);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetScaleReadMaskInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private bool GetScaleReadMaskInternal(ref AnimationStream stream)
	{
		return GetScaleReadMaskInternal_Injected(ref this, ref stream);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetLocalTRSInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void GetLocalTRSInternal(ref AnimationStream stream, out Vector3 position, out Quaternion rotation, out Vector3 scale)
	{
		GetLocalTRSInternal_Injected(ref this, ref stream, out position, out rotation, out scale);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::SetLocalTRSInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void SetLocalTRSInternal(ref AnimationStream stream, Vector3 position, Quaternion rotation, Vector3 scale, bool useMask)
	{
		SetLocalTRSInternal_Injected(ref this, ref stream, ref position, ref rotation, ref scale, useMask);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetGlobalTRInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void GetGlobalTRInternal(ref AnimationStream stream, out Vector3 position, out Quaternion rotation)
	{
		GetGlobalTRInternal_Injected(ref this, ref stream, out position, out rotation);
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::GetLocalToWorldMatrixInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private Matrix4x4 GetLocalToWorldMatrixInternal(ref AnimationStream stream)
	{
		GetLocalToWorldMatrixInternal_Injected(ref this, ref stream, out var ret);
		return ret;
	}

	[NativeMethod(Name = "TransformStreamHandleBindings::SetGlobalTRInternal", IsFreeFunction = true, HasExplicitThis = true, IsThreadSafe = true)]
	private void SetGlobalTRInternal(ref AnimationStream stream, Vector3 position, Quaternion rotation, bool useMask)
	{
		SetGlobalTRInternal_Injected(ref this, ref stream, ref position, ref rotation, useMask);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ResolveInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetPositionInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetPositionInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, ref Vector3 position);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetRotationInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Quaternion ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetRotationInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, ref Quaternion rotation);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetLocalPositionInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetLocalPositionInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, ref Vector3 position);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetLocalRotationInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Quaternion ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetLocalRotationInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, ref Quaternion rotation);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetLocalScaleInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Vector3 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetLocalScaleInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, ref Vector3 scale);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetLocalToParentMatrixInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetPositionReadMaskInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetRotationReadMaskInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetScaleReadMaskInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetLocalTRSInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Vector3 position, out Quaternion rotation, out Vector3 scale);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetLocalTRSInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, ref Vector3 position, ref Quaternion rotation, ref Vector3 scale, bool useMask);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetGlobalTRInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Vector3 position, out Quaternion rotation);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetLocalToWorldMatrixInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetGlobalTRInternal_Injected(ref TransformStreamHandle _unity_self, ref AnimationStream stream, ref Vector3 position, ref Quaternion rotation, bool useMask);
}
