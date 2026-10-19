using System;
using Fundamental;

namespace ACT.Battle;

[Serializable]
public abstract class RespawnSetting : IDisposable
{
	public void Dispose()
	{
		if (Singleton<RespawnManager>.instance != null)
		{
			Singleton<RespawnManager>.instance.RemoveRespawnSetting(this);
		}
	}
}
