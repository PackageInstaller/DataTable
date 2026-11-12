using UnityEngine;

public class AdventureFXPlayer_AnimationEventReceiver : MonoBehaviour
{
	public AdventureFXPlayer ownerPlayer;

	private void PlaySelfFX(string fxName)
	{
		ownerPlayer.PlaySelfFX(fxName);
	}

	private void StopSelfFX(string fxName)
	{
		ownerPlayer.StopSelfFX(fxName);
	}
}
