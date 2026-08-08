using P08.CriLipsEx;
using UnityEngine;
using UnityEngine.Playables;

public class CriLipsExPlayerNodePlayable : PlayableBehaviour
{
	public CriLipsExPlayer criLipsExPlayer;

	public CriLipsExCueData criLipsExCueData;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		criLipsExPlayer = (CriLipsExPlayer)playerData;
		if (!(criLipsExPlayer == null) && criLipsExCueData != null)
		{
			_ = Application.isPlaying;
		}
	}
}
