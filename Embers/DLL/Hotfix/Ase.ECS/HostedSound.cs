using System.Collections.Generic;
using FMOD.Studio;

namespace Ase.ECS;

public struct HostedSound
{
	public EventInstance Instance;

	public STOP_MODE StopMode;

	public List<SoundDisposeTiming> DisposeTimings;
}
