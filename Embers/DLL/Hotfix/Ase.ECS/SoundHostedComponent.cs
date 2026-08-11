using System.Collections.Generic;
using FMOD.Studio;

namespace Ase.ECS;

public class SoundHostedComponent : BaseComponent
{
	private List<HostedSound> onDeadList = new List<HostedSound>();

	public void HostedSound(HostedSound hostedSound)
	{
		if (hostedSound.DisposeTimings == null)
		{
			return;
		}
		foreach (SoundDisposeTiming disposeTiming in hostedSound.DisposeTimings)
		{
			HostedSound(hostedSound, disposeTiming);
		}
	}

	private void HostedSound(HostedSound hostedSound, SoundDisposeTiming disposeTiming)
	{
		if (disposeTiming == SoundDisposeTiming.OnEntityDead)
		{
			onDeadList.Add(hostedSound);
		}
	}

	public override void OnEntityDead()
	{
		base.OnEntityDead();
		onDeadList?.ForEach(delegate(HostedSound hostedSound)
		{
			//IL_0028: Unknown result type (might be due to invalid IL or missing references)
			//IL_0016: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			if (((EventInstance)(ref hostedSound.Instance)).isValid())
			{
				((EventInstance)(ref hostedSound.Instance)).stop(hostedSound.StopMode);
			}
			((EventInstance)(ref hostedSound.Instance)).release();
		});
		onDeadList?.Clear();
	}
}
