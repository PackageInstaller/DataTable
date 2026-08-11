using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Playables;

[NativeHeader("Runtime/Export/Director/PlayableGraph.bindings.h")]
[UsedByNativeCode]
[NativeHeader("Runtime/Director/Core/HPlayableOutput.h")]
[NativeHeader("Runtime/Director/Core/HPlayableGraph.h")]
[NativeHeader("Runtime/Director/Core/HPlayable.h")]
public struct PlayableGraph
{
	internal IntPtr m_Handle;

	internal uint m_Version;

	public Playable GetRootPlayable(int index)
	{
		PlayableHandle rootPlayableInternal = GetRootPlayableInternal(index);
		return new Playable(rootPlayableInternal);
	}

	public bool Connect<U, V>(U source, int sourceOutputPort, V destination, int destinationInputPort) where U : struct, IPlayable where V : struct, IPlayable
	{
		return ConnectInternal(source.GetHandle(), sourceOutputPort, destination.GetHandle(), destinationInputPort);
	}

	public void Disconnect<U>(U input, int inputPort) where U : struct, IPlayable
	{
		DisconnectInternal(input.GetHandle(), inputPort);
	}

	public void DestroyPlayable<U>(U playable) where U : struct, IPlayable
	{
		DestroyPlayableInternal(playable.GetHandle());
	}

	public void DestroySubgraph<U>(U playable) where U : struct, IPlayable
	{
		DestroySubgraphInternal(playable.GetHandle());
	}

	public void DestroyOutput<U>(U output) where U : struct, IPlayableOutput
	{
		DestroyOutputInternal(output.GetHandle());
	}

	public int GetOutputCountByType<T>() where T : struct, IPlayableOutput
	{
		return GetOutputCountByTypeInternal(typeof(T));
	}

	public PlayableOutput GetOutput(int index)
	{
		if (!GetOutputInternal(index, out var handle))
		{
			return PlayableOutput.Null;
		}
		return new PlayableOutput(handle);
	}

	public PlayableOutput GetOutputByType<T>(int index) where T : struct, IPlayableOutput
	{
		if (!GetOutputByTypeInternal(typeof(T), index, out var handle))
		{
			return PlayableOutput.Null;
		}
		return new PlayableOutput(handle);
	}

	public void Evaluate()
	{
		Evaluate(0f);
	}

	public static PlayableGraph Create()
	{
		return Create(null);
	}

	public static PlayableGraph Create(string name)
	{
		Create_Injected(name, out var ret);
		return ret;
	}

	[FreeFunction("PlayableGraphBindings::Destroy", HasExplicitThis = true, ThrowsException = true)]
	public void Destroy()
	{
		Destroy_Injected(ref this);
	}

	public bool IsValid()
	{
		return IsValid_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::IsPlaying", HasExplicitThis = true, ThrowsException = true)]
	public bool IsPlaying()
	{
		return IsPlaying_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::IsDone", HasExplicitThis = true, ThrowsException = true)]
	public bool IsDone()
	{
		return IsDone_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::Play", HasExplicitThis = true, ThrowsException = true)]
	public void Play()
	{
		Play_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::Stop", HasExplicitThis = true, ThrowsException = true)]
	public void Stop()
	{
		Stop_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::Evaluate", HasExplicitThis = true, ThrowsException = true)]
	public void Evaluate([DefaultValue("0")] float deltaTime)
	{
		Evaluate_Injected(ref this, deltaTime);
	}

	[FreeFunction("PlayableGraphBindings::GetTimeUpdateMode", HasExplicitThis = true, ThrowsException = true)]
	public DirectorUpdateMode GetTimeUpdateMode()
	{
		return GetTimeUpdateMode_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::SetTimeUpdateMode", HasExplicitThis = true, ThrowsException = true)]
	public void SetTimeUpdateMode(DirectorUpdateMode value)
	{
		SetTimeUpdateMode_Injected(ref this, value);
	}

	[FreeFunction("PlayableGraphBindings::GetResolver", HasExplicitThis = true, ThrowsException = true)]
	public IExposedPropertyTable GetResolver()
	{
		return GetResolver_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::SetResolver", HasExplicitThis = true, ThrowsException = true)]
	public void SetResolver(IExposedPropertyTable value)
	{
		SetResolver_Injected(ref this, value);
	}

	[FreeFunction("PlayableGraphBindings::GetPlayableCount", HasExplicitThis = true, ThrowsException = true)]
	public int GetPlayableCount()
	{
		return GetPlayableCount_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::GetRootPlayableCount", HasExplicitThis = true, ThrowsException = true)]
	public int GetRootPlayableCount()
	{
		return GetRootPlayableCount_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::SynchronizeEvaluation", HasExplicitThis = true, ThrowsException = true)]
	internal void SynchronizeEvaluation(PlayableGraph playable)
	{
		SynchronizeEvaluation_Injected(ref this, ref playable);
	}

	[FreeFunction("PlayableGraphBindings::GetOutputCount", HasExplicitThis = true, ThrowsException = true)]
	public int GetOutputCount()
	{
		return GetOutputCount_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::CreatePlayableHandle", HasExplicitThis = true, ThrowsException = true)]
	internal PlayableHandle CreatePlayableHandle()
	{
		CreatePlayableHandle_Injected(ref this, out var ret);
		return ret;
	}

	[FreeFunction("PlayableGraphBindings::CreateScriptOutputInternal", HasExplicitThis = true, ThrowsException = true)]
	internal bool CreateScriptOutputInternal(string name, out PlayableOutputHandle handle)
	{
		return CreateScriptOutputInternal_Injected(ref this, name, out handle);
	}

	[FreeFunction("PlayableGraphBindings::GetRootPlayableInternal", HasExplicitThis = true, ThrowsException = true)]
	internal PlayableHandle GetRootPlayableInternal(int index)
	{
		GetRootPlayableInternal_Injected(ref this, index, out var ret);
		return ret;
	}

	[FreeFunction("PlayableGraphBindings::DestroyOutputInternal", HasExplicitThis = true, ThrowsException = true)]
	internal void DestroyOutputInternal(PlayableOutputHandle handle)
	{
		DestroyOutputInternal_Injected(ref this, ref handle);
	}

	[FreeFunction("PlayableGraphBindings::IsMatchFrameRateEnabled", HasExplicitThis = true, ThrowsException = true)]
	internal bool IsMatchFrameRateEnabled()
	{
		return IsMatchFrameRateEnabled_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::EnableMatchFrameRate", HasExplicitThis = true, ThrowsException = true)]
	internal void EnableMatchFrameRate(FrameRate frameRate)
	{
		EnableMatchFrameRate_Injected(ref this, ref frameRate);
	}

	[FreeFunction("PlayableGraphBindings::DisableMatchFrameRate", HasExplicitThis = true, ThrowsException = true)]
	internal void DisableMatchFrameRate()
	{
		DisableMatchFrameRate_Injected(ref this);
	}

	[FreeFunction("PlayableGraphBindings::GetFrameRate", HasExplicitThis = true, ThrowsException = true)]
	internal FrameRate GetFrameRate()
	{
		GetFrameRate_Injected(ref this, out var ret);
		return ret;
	}

	[FreeFunction("PlayableGraphBindings::GetOutputInternal", HasExplicitThis = true, ThrowsException = true)]
	private bool GetOutputInternal(int index, out PlayableOutputHandle handle)
	{
		return GetOutputInternal_Injected(ref this, index, out handle);
	}

	[FreeFunction("PlayableGraphBindings::GetOutputCountByTypeInternal", HasExplicitThis = true, ThrowsException = true)]
	private int GetOutputCountByTypeInternal(Type outputType)
	{
		return GetOutputCountByTypeInternal_Injected(ref this, outputType);
	}

	[FreeFunction("PlayableGraphBindings::GetOutputByTypeInternal", HasExplicitThis = true, ThrowsException = true)]
	private bool GetOutputByTypeInternal(Type outputType, int index, out PlayableOutputHandle handle)
	{
		return GetOutputByTypeInternal_Injected(ref this, outputType, index, out handle);
	}

	[FreeFunction("PlayableGraphBindings::ConnectInternal", HasExplicitThis = true, ThrowsException = true)]
	private bool ConnectInternal(PlayableHandle source, int sourceOutputPort, PlayableHandle destination, int destinationInputPort)
	{
		return ConnectInternal_Injected(ref this, ref source, sourceOutputPort, ref destination, destinationInputPort);
	}

	[FreeFunction("PlayableGraphBindings::DisconnectInternal", HasExplicitThis = true, ThrowsException = true)]
	private void DisconnectInternal(PlayableHandle playable, int inputPort)
	{
		DisconnectInternal_Injected(ref this, ref playable, inputPort);
	}

	[FreeFunction("PlayableGraphBindings::DestroyPlayableInternal", HasExplicitThis = true, ThrowsException = true)]
	private void DestroyPlayableInternal(PlayableHandle playable)
	{
		DestroyPlayableInternal_Injected(ref this, ref playable);
	}

	[FreeFunction("PlayableGraphBindings::DestroySubgraphInternal", HasExplicitThis = true, ThrowsException = true)]
	private void DestroySubgraphInternal(PlayableHandle playable)
	{
		DestroySubgraphInternal_Injected(ref this, ref playable);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Create_Injected(string name, out PlayableGraph ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Destroy_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsValid_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsPlaying_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsDone_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Play_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Stop_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Evaluate_Injected(ref PlayableGraph _unity_self, [DefaultValue("0")] float deltaTime);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern DirectorUpdateMode GetTimeUpdateMode_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetTimeUpdateMode_Injected(ref PlayableGraph _unity_self, DirectorUpdateMode value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IExposedPropertyTable GetResolver_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetResolver_Injected(ref PlayableGraph _unity_self, IExposedPropertyTable value);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetPlayableCount_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetRootPlayableCount_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SynchronizeEvaluation_Injected(ref PlayableGraph _unity_self, ref PlayableGraph playable);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetOutputCount_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void CreatePlayableHandle_Injected(ref PlayableGraph _unity_self, out PlayableHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool CreateScriptOutputInternal_Injected(ref PlayableGraph _unity_self, string name, out PlayableOutputHandle handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetRootPlayableInternal_Injected(ref PlayableGraph _unity_self, int index, out PlayableHandle ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DestroyOutputInternal_Injected(ref PlayableGraph _unity_self, ref PlayableOutputHandle handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsMatchFrameRateEnabled_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void EnableMatchFrameRate_Injected(ref PlayableGraph _unity_self, ref FrameRate frameRate);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DisableMatchFrameRate_Injected(ref PlayableGraph _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetFrameRate_Injected(ref PlayableGraph _unity_self, out FrameRate ret);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetOutputInternal_Injected(ref PlayableGraph _unity_self, int index, out PlayableOutputHandle handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int GetOutputCountByTypeInternal_Injected(ref PlayableGraph _unity_self, Type outputType);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetOutputByTypeInternal_Injected(ref PlayableGraph _unity_self, Type outputType, int index, out PlayableOutputHandle handle);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ConnectInternal_Injected(ref PlayableGraph _unity_self, ref PlayableHandle source, int sourceOutputPort, ref PlayableHandle destination, int destinationInputPort);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DisconnectInternal_Injected(ref PlayableGraph _unity_self, ref PlayableHandle playable, int inputPort);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DestroyPlayableInternal_Injected(ref PlayableGraph _unity_self, ref PlayableHandle playable);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void DestroySubgraphInternal_Injected(ref PlayableGraph _unity_self, ref PlayableHandle playable);
}
