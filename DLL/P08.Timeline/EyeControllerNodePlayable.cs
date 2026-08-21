using RogoDigital;
using RogoDigital.Lipsync;
using UnityEngine.Playables;

public class EyeControllerNodePlayable : PlayableBehaviour
{
	public bool closeEyeContol;

	public bool openEyeContolWhenFinish;

	private EyeController eye;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		LipSync lipSync = (LipSync)playerData;
		if (!(lipSync == null))
		{
			if (eye == null)
			{
				eye = lipSync.GetComponent<EyeController>();
			}
			if (!(eye == null) && eye.enabled != closeEyeContol)
			{
				eye.enabled = closeEyeContol;
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (openEyeContolWhenFinish && eye != null)
		{
			eye.enabled = true;
		}
	}
}
