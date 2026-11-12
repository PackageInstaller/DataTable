using UnityEngine;

public class AdventureFXPlayer_Trail : AdventureFXPlayer_Component
{
	internal TrailRenderer trail;

	public override void Release()
	{
		Stop();
	}

	public override void Stop()
	{
		if (trail != null)
		{
			trail.Clear();
		}
	}
}
