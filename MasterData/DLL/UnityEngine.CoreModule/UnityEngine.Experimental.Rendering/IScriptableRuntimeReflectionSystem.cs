using System;

namespace UnityEngine.Experimental.Rendering;

public interface IScriptableRuntimeReflectionSystem : IDisposable
{
	bool TickRealtimeProbes();
}
