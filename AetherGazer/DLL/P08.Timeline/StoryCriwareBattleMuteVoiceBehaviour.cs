using UnityEngine;
using UnityEngine.Playables;

public class StoryCriwareBattleMuteVoiceBehaviour : PlayableBehaviour
{
	public bool m_EffectTag = true;

	public bool m_VoiceTag = true;

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
				worldSatetManager.notMuteEffectVoice = m_EffectTag;
				worldSatetManager.notMuteCharacterVoice = m_VoiceTag;
			}
		}
	}
}
