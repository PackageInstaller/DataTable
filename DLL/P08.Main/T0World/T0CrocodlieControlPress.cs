using UnityEngine;

namespace T0World;

public class T0CrocodlieControlPress : MonoBehaviour
{
	public string biteAnimName = "104402_prop_shayuwanju_X206_crocodile_interaction_113";

	public void TriggerPressAnim()
	{
		T0CrocodileGame.crocodileGame.TriggerPressAnim();
	}

	public void TrggerBiteAnim()
	{
		if (T0CrocodileGame.crocodileGame.context.gameState == T0CrocodileGameStateEnum.lose)
		{
			T0CrocodileGame.crocodileGame.PlayPressTimeline(biteAnimName);
		}
	}
}
