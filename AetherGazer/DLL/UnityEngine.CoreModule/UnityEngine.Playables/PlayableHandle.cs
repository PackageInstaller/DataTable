using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[NativeHeader("Runtime/Director/Core/HPlayable.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Export/Director/PlayableHandle.bindings.h")]
[NativeHeader("Runtime/Director/Core/HPlayableGraph.h")]
public struct PlayableHandle : IEquatable<PlayableHandle>
{
	internal IntPtr m_Handle;

	internal uint m_Version;

	private static readonly PlayableHandle m_Null = default(PlayableHandle);

	public static PlayableHandle Null => m_Null;

	internal T GetObject<T>() where T : class, IPlayableBehaviour
	{
		if (!IsValid())
		{
			return null;
		}
		object scriptInstance = GetScriptInstance();
		if (scriptInstance == null)
		{
			return null;
		}
		return (T)scriptInstance;
	}

	[VisibleToOtherModules]
	internal bool IsPlayableOfType<T>()
	{
		return GetPlayableType() == typeof(T);
	}

	internal Playable GetInput(int inputPort)
	{
		return new Playable(GetInputHandle(inputPort));
	}

	internal Playable GetOutput(int outputPort)
	{
		return new Playable(GetOutputHandle(outputPort));
	}

	internal bool SetInputWeight(int inputIndex, float weight)
	{
		if (CheckInputBounds(inputIndex))
		{
			SetInputWeightFromIndex(inputIndex, weight);
			return true;
		}
		return false;
	}

	internal float GetInputWeight(int inputIndex)
	{
		if (CheckInputBounds(inputIndex))
		{
			return GetInputWeightFromIndex(inputIndex);
		}
		return 0f;
	}

	internal void Destroy()
	{
		GetGraph().DestroyPlayable(new Playable(this));
	}

	public static bool operator ==(PlayableHandle x, PlayableHandle y)
	{
		return CompareVersion(x, y);
	}

	public override bool Equals(object p)
	{
		return p is PlayableHandle && Equals((PlayableHandle)p);
	}

	public bool Equals(PlayableHandle other)
	{
		return CompareVersion(this, other);
	}

	public override int GetHashCode()
	{
		return m_Handle.GetHashCode() ^ m_Version.GetHashCode();
	}

	internal static bool CompareVersion(PlayableHandle lhs, PlayableHandle rhs)
	{
		return lhs.m_Handle == rhs.m_Handle && lhs.m_Version == rhs.m_Version;
	}

	internal bool CheckInputBounds(int inputIndex)
	{
		return CheckInputBounds(inputIndex, acceptAny: false);
	}

	internal bool CheckInputBounds(int inputIndex, bool acceptAny)
	{
		if ((inputIndex == -1) & acceptAny)
		{
			return true;
		}
		if (inputIndex < 0)
		{
			throw new IndexOutOfRangeException("Index must be greater than 0");
		}
		if (GetInputCount() <= inputIndex)
		{
			throw new IndexOutOfRangeException("inputIndex " + inputIndex + " is greater than the number of available inputs (" + GetInputCount() + ").");
		}
		return true;
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

	[FreeFunction("PlayableHandleBindings::GetPlayableType", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal Type GetPlayableType()
	{
		return GetPlayableType_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::GetJobType", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal Type GetJobType()
	{
		return GetJobType_Injected(ref this);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::SetScriptInstance", HasExplicitThis = true, ThrowsException = true)]
	internal void SetScriptInstance(object scriptInstance)
	{
		SetScriptInstance_Injected(ref this, scriptInstance);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::CanChangeInputs", HasExplicitThis = true, ThrowsException = true)]
	internal bool CanChangeInputs()
	{
		return CanChangeInputs_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::CanSetWeights", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal bool CanSetWeights()
	{
		return CanSetWeights_Injected(ref this);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::CanDestroy", HasExplicitThis = true, ThrowsException = true)]
	internal bool CanDestroy()
	{
		return CanDestroy_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::GetPlayState", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal PlayState GetPlayState()
	{
		return GetPlayState_Injected(ref this);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::Play", HasExplicitThis = true, ThrowsException = true)]
	internal void Play()
	{
		Play_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::Pause", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void Pause()
	{
		Pause_Injected(ref this);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::GetSpeed", HasExplicitThis = true, ThrowsException = true)]
	internal double GetSpeed()
	{
		return GetSpeed_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetSpeed", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetSpeed(double value)
	{
		SetSpeed_Injected(ref this, value);
	}

	[FreeFunction("PlayableHandleBindings::GetTime", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal double GetTime()
	{
		return GetTime_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetTime", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetTime(double value)
	{
		SetTime_Injected(ref this, value);
	}

	[FreeFunction("PlayableHandleBindings::IsDone", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal bool IsDone()
	{
		return IsDone_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetDone", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetDone(bool value)
	{
		SetDone_Injected(ref this, value);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::GetDuration", HasExplicitThis = true, ThrowsException = true)]
	internal double GetDuration()
	{
		return GetDuration_Injected(ref this);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::SetDuration", HasExplicitThis = true, ThrowsException = true)]
	internal void SetDuration(double value)
	{
		SetDuration_Injected(ref this, value);
	}

	[FreeFunction("PlayableHandleBindings::GetPropagateSetTime", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal bool GetPropagateSetTime()
	{
		return GetPropagateSetTime_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetPropagateSetTime", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetPropagateSetTime(bool value)
	{
		SetPropagateSetTime_Injected(ref this, value);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::GetGraph", HasExplicitThis = true, ThrowsException = true)]
	internal PlayableGraph GetGraph()
	{
		GetGraph_Injected(ref this, out var ret);
		return ret;
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::GetInputCount", HasExplicitThis = true, ThrowsException = true)]
	internal int GetInputCount()
	{
		return GetInputCount_Injected(ref this);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::SetInputCount", HasExplicitThis = true, ThrowsException = true)]
	internal void SetInputCount(int value)
	{
		SetInputCount_Injected(ref this, value);
	}

	[FreeFunction("PlayableHandleBindings::GetOutputCount", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal int GetOutputCount()
	{
		return GetOutputCount_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetOutputCount", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetOutputCount(int value)
	{
		SetOutputCount_Injected(ref this, value);
	}

	[FreeFunction("PlayableHandleBindings::SetInputWeight", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetInputWeight(PlayableHandle input, float weight)
	{
		SetInputWeight_Injected(ref this, ref input, weight);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::SetDelay", HasExplicitThis = true, ThrowsException = true)]
	internal void SetDelay(double delay)
	{
		SetDelay_Injected(ref this, delay);
	}

	[FreeFunction("PlayableHandleBindings::GetDelay", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal double GetDelay()
	{
		return GetDelay_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::IsDelayed", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal bool IsDelayed()
	{
		return IsDelayed_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::GetPreviousTime", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal double GetPreviousTime()
	{
		return GetPreviousTime_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetLeadTime", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetLeadTime(float value)
	{
		SetLeadTime_Injected(ref this, value);
	}

	[FreeFunction("PlayableHandleBindings::GetLeadTime", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal float GetLeadTime()
	{
		return GetLeadTime_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::GetTraversalMode", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal PlayableTraversalMode GetTraversalMode()
	{
		return GetTraversalMode_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetTraversalMode", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetTraversalMode(PlayableTraversalMode mode)
	{
		SetTraversalMode_Injected(ref this, mode);
	}

	[FreeFunction("PlayableHandleBindings::GetJobData", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal IntPtr GetJobData()
	{
		return GetJobData_Injected(ref this);
	}

	[VisibleToOtherModules]
	[FreeFunction("PlayableHandleBindings::GetTimeWrapMode", HasExplicitThis = true, ThrowsException = true)]
	internal DirectorWrapMode GetTimeWrapMode()
	{
		return GetTimeWrapMode_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::SetTimeWrapMode", HasExplicitThis = true, ThrowsException = true)]
	[VisibleToOtherModules]
	internal void SetTimeWrapMode(DirectorWrapMode mode)
	{
		SetTimeWrapMode_Injected(ref this, mode);
	}

	[FreeFunction("PlayableHandleBindings::GetScriptInstance", HasExplicitThis = true, ThrowsException = true)]
	private object GetScriptInstance()
	{
		return GetScriptInstance_Injected(ref this);
	}

	[FreeFunction("PlayableHandleBindings::GetInputHandle", HasExplicitThis = true, ThrowsException = true)]
	private PlayableHandle GetInputHandle(int index)
	{
		GetInputHandle_Injected(ref this, index, out var ret);
		return ret;
	}

	[FreeFunction("PlayableHandleBindings::GetOutputHandle", HasExplicitThis = true, ThrowsException = true)]
	private PlayableHandle GetOutputHandle(int index)
	{
		GetOutputHandle_Injected(ref this, index, out var ret);
		return ret;
	}

	[FreeFunction("PlayableHandleBindings::SetInputWeightFromIndex", HasExplicitThis = true, ThrowsException = true)]
	private void SetInputWeightFromIndex(int index, float weight)
	{
		SetInputWeightFromIndex_Injected(ref this, index, weight);
	}

	[FreeFunction("PlayableHandleBindings::GetInputWeightFromIndex", HasExplicitThis = true, ThrowsException = true)]
	private float GetInputWeightFromIndex(int index)
	{
		return GetInputWeightFromIndex_Injected(ref this, index);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsNull_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsValid_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Type GetPlayableType_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Type GetJobType_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetScriptInstance_Injected(ref PlayableHandle _unity_self, object scriptInstance);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CanChangeInputs_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CanSetWeights_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CanDestroy_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern PlayState GetPlayState_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Play_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Pause_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double GetSpeed_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetSpeed_Injected(ref PlayableHandle _unity_self, double value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double GetTime_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetTime_Injected(ref PlayableHandle _unity_self, double value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsDone_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetDone_Injected(ref PlayableHandle _unity_self, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double GetDuration_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetDuration_Injected(ref PlayableHandle _unity_self, double value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetPropagateSetTime_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetPropagateSetTime_Injected(ref PlayableHandle _unity_self, bool value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetGraph_Injected(ref PlayableHandle _unity_self, out PlayableGraph ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetInputCount_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetInputCount_Injected(ref PlayableHandle _unity_self, int value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetOutputCount_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetOutputCount_Injected(ref PlayableHandle _unity_self, int value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetInputWeight_Injected(ref PlayableHandle _unity_self, ref PlayableHandle input, float weight);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetDelay_Injected(ref PlayableHandle _unity_self, double delay);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double GetDelay_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsDelayed_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern double GetPreviousTime_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetLeadTime_Injected(ref PlayableHandle _unity_self, float value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern float GetLeadTime_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern PlayableTraversalMode GetTraversalMode_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetTraversalMode_Injected(ref PlayableHandle _unity_self, PlayableTraversalMode mode);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr GetJobData_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern DirectorWrapMode GetTimeWrapMode_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetTimeWrapMode_Injected(ref PlayableHandle _unity_self, DirectorWrapMode mode);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern object GetScriptInstance_Injected(ref PlayableHandle _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetInputHandle_Injected(ref PlayableHandle _unity_self, int index, out PlayableHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetOutputHandle_Injected(ref PlayableHandle _unity_self, int index, out PlayableHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetInputWeightFromIndex_Injected(ref PlayableHandle _unity_self, int index, float weight);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern float GetInputWeightFromIndex_Injected(ref PlayableHandle _unity_self, int index);
}
