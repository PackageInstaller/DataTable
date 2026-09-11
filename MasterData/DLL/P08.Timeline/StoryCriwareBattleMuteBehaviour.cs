using UnityEngine;
using UnityEngine.Playables;

public class StoryCriwareBattleMuteBehaviour : PlayableBehaviour
{
	public bool m_SwitchTag = true;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying || SceneDirector.Instance == null)
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (!(battleScene == null) && battleScene.GetBattleSimulatorSystem() != null)
		{
			WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
			if (worldSatetManager != null)
			{
				worldSatetManager.notMuteBattleVoice = m_SwitchTag;
			}
		}
	}
}
