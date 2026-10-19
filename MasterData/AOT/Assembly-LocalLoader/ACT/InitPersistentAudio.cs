using ACT.LocalLoader;

namespace ACT;

internal class InitPersistentAudio : GameLoadingFlowBase
{
	private LocalAudioManager _audioManger;

	internal override EGameLoadingStage Stage => EGameLoadingStage.PersistentAudio;

	internal InitPersistentAudio(LocalAudioManager audioManger)
	{
		_audioManger = audioManger;
	}

	internal override void Init(GameLoadingData data)
	{
		if (_audioManger == null)
		{
			Error("AudioManager为空");
			return;
		}
		_audioManger.enabled = true;
		base.Init(data);
	}
}
