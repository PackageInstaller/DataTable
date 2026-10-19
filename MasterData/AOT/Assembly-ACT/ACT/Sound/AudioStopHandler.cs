using System.Collections.Generic;
using ACT.Sound.Management;

namespace ACT.Sound;

internal class AudioStopHandler
{
	private readonly AudioInstancePool _instancePool;

	private readonly List<PooledAudioInstance> _channelInstances;

	public AudioStopHandler(AudioInstancePool instancePool, List<PooledAudioInstance> channelInstances)
	{
		_instancePool = instancePool;
		_channelInstances = channelInstances;
	}

	public void Stop(uint id, bool fadeOut = true)
	{
		_instancePool.GetInstance(id)?.Instance?.Stop(fadeOut);
	}

	public void StopAll()
	{
		foreach (PooledAudioInstance channelInstance in _channelInstances)
		{
			channelInstance.Instance?.Stop();
		}
	}
}
