using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[NativeHeader("Runtime/Director/Core/HPlayableOutput.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Export/Director/PlayableOutputHandle.bindings.h")]
public struct PlayableOutputHandle : IEquatable<PlayableOutputHandle>
{
	internal IntPtr m_Handle;

	internal uint m_Version;

	private static readonly PlayableOutputHandle m_Null = default(PlayableOutputHandle);

	public static PlayableOutputHandle Null => m_Null;

	[VisibleToOtherModules]
	internal bool IsPlayableOutputOfType<T>()
	{
		return GetPlayableOutputType() == typeof(T);
	}

	public override int GetHashCode()
	{
		return m_Handle.GetHashCode() ^ m_Version.GetHashCode();
	}

	public static bool operator ==(PlayableOutputHandle lhs, PlayableOutputHandle rhs)
	{
		return CompareVersion(lhs, rhs);
	}

	public override bool Equals(object p)
	{
		return p is PlayableOutputHandle && Equals((PlayableOutputHandle)p);
	}

	public bool Equals(PlayableOutputHandle other)
	{
		return CompareVersion(this, other);
	}

	internal static bool CompareVersion(PlayableOutputHandle lhs, PlayableOutputHandle rhs)
	{
		return lhs.m_Handle == rhs.m_Handle && lhs.m_Version == rhs.m_Version;
	}

	[VisibleToOtherModules]
	internal bool IsNull()
	{
		return IsNull_Injected(ref this);
	}

	[VisibleToOtherModules]
	internal bool IsValid()
	{
		return IsValid_Injected(ref this);
	}

	[FreeFunction("PlayableOutputHandleBindings::GetPlayableOutputType", HasExplicitThis = true, ThrowsException = true)]
	internal Type GetPlayableOutputType()
	{
		return GetPlayableOutputType_Injected(ref this);
	}

	[FreeFunction("PlayableOutputHandleBindings::GetReferenceObject", HasExplicitThis = true, ThrowsException = true)]
	internal Object GetReferenceObject()
	{
		return GetReferenceObject_Injected(ref this);
	}

	[FreeFunction("PlayableOutputHandleBindings::SetReferenceObject", HasExplicitThis = true, ThrowsException = true)]
	internal void SetReferenceObject(Object target)
	{
		SetReferenceObject_Injected(ref this, target);
	}

	[FreeFunction("PlayableOutputHandleBindings::GetUserData", HasExplicitThis = true, ThrowsException = true)]
	internal Object GetUserData()
	{
		return GetUserData_Injected(ref this);
	}

	[FreeFunction("PlayableOutputHandleBindings::SetUserData", HasExplicitThis = true, ThrowsException = true)]
	internal void SetUserData([Writable] Object target)
	{
		SetUserData_Injected(ref this, target);
	}

	[FreeFunction("PlayableOutputHandleBindings::GetSourcePlayable", HasExplicitThis = true, ThrowsException = true)]
	internal PlayableHandle GetSourcePlayable()
	{
		GetSourcePlayable_Injected(ref this, out var ret);
		return ret;
	}

	[FreeFunction("PlayableOutputHandleBindings::SetSourcePlayable", HasExplicitThis = true, ThrowsException = true)]
	internal void SetSourcePlayable(PlayableHandle target, int port)
	{
		SetSourcePlayable_Injected(ref this, ref target, port);
	}

	[FreeFunction("PlayableOutputHandleBindings::GetSourceOutputPort", HasExplicitThis = true, ThrowsException = true)]
	internal int GetSourceOutputPort()
	{
		return GetSourceOutputPort_Injected(ref this);
	}

	[FreeFunction("PlayableOutputHandleBindings::GetWeight", HasExplicitThis = true, ThrowsException = true)]
	internal float GetWeight()
	{
		return GetWeight_Injected(ref this);
	}

	[FreeFunction("PlayableOutputHandleBindings::SetWeight", HasExplicitThis = true, ThrowsException = true)]
	internal void SetWeight(float weight)
	{
		SetWeight_Injected(ref this, weight);
	}

	[FreeFunction("PlayableOutputHandleBindings::PushNotification", HasExplicitThis = true, ThrowsException = true)]
	internal void PushNotification(PlayableHandle origin, INotification notification, object context)
	{
		PushNotification_Injected(ref this, ref origin, notification, context);
	}

	[FreeFunction("PlayableOutputHandleBindings::GetNotificationReceivers", HasExplicitThis = true, ThrowsException = true)]
	internal INotificationReceiver[] GetNotificationReceivers()
	{
		return GetNotificationReceivers_Injected(ref this);
	}

	[FreeFunction("PlayableOutputHandleBindings::AddNotificationReceiver", HasExplicitThis = true, ThrowsException = true)]
	internal void AddNotificationReceiver(INotificationReceiver receiver)
	{
		AddNotificationReceiver_Injected(ref this, receiver);
	}

	[FreeFunction("PlayableOutputHandleBindings::RemoveNotificationReceiver", HasExplicitThis = true, ThrowsException = true)]
	internal void RemoveNotificationReceiver(INotificationReceiver receiver)
	{
		RemoveNotificationReceiver_Injected(ref this, receiver);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsNull_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsValid_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Type GetPlayableOutputType_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Object GetReferenceObject_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetReferenceObject_Injected(ref PlayableOutputHandle _unity_self, Object target);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Object GetUserData_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetUserData_Injected(ref PlayableOutputHandle _unity_self, [Writable] Object target);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetSourcePlayable_Injected(ref PlayableOutputHandle _unity_self, out PlayableHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetSourcePlayable_Injected(ref PlayableOutputHandle _unity_self, ref PlayableHandle target, int port);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetSourceOutputPort_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern float GetWeight_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetWeight_Injected(ref PlayableOutputHandle _unity_self, float weight);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void PushNotification_Injected(ref PlayableOutputHandle _unity_self, ref PlayableHandle origin, INotification notification, object context);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern INotificationReceiver[] GetNotificationReceivers_Injected(ref PlayableOutputHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void AddNotificationReceiver_Injected(ref PlayableOutputHandle _unity_self, INotificationReceiver receiver);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void RemoveNotificationReceiver_Injected(ref PlayableOutputHandle _unity_self, INotificationReceiver receiver);
}
