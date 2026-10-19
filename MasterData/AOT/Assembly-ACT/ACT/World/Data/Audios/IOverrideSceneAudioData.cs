namespace ACT.World.Data.Audios;

public interface IOverrideSceneAudioData
{
	string BgmSoundAddress { get; }

	int BgmState { get; }

	string EnvSoundAddress { get; }

	string ReverbAddress { get; }

	int StepMaterialId { get; }

	OverrideSceneSoundType OverrideType { get; }
}
