using ACT.Sound;
using EasyCharacterMovement;

namespace ACT.World.Modules.SceneAudios;

public struct SceneAudioUpdateInfo
{
	private AudioEventReference _bgmSoundAddress;

	private int _bgmState;

	private AudioEventReference _envSoundAddress;

	private AudioEventReference _reverb;

	private RoadMaterial _stepMaterialId;

	private SceneSoundType _changeType;

	public AudioEventReference BgmSoundAddress => _bgmSoundAddress;

	public int BgmState => _bgmState;

	public AudioEventReference EnvSoundAddress => _envSoundAddress;

	public AudioEventReference Reverb => _reverb;

	public RoadMaterial StepMaterialId => _stepMaterialId;

	public bool IsBGMChanged => (_changeType & SceneSoundType.BGM) == SceneSoundType.BGM;

	public bool IsBGMStateChanged => (_changeType & SceneSoundType.BGMState) == SceneSoundType.BGMState;

	public bool IsEnvChanged => (_changeType & SceneSoundType.Env) == SceneSoundType.Env;

	public bool IsReverbChanged => (_changeType & SceneSoundType.Reverb) == SceneSoundType.Reverb;

	public bool IsStepMatChanged => (_changeType & SceneSoundType.StepMat) == SceneSoundType.StepMat;

	public void UpdateBgmSound(string bgmSoundEvent, ref string lastBgmSoundEvent)
	{
		if (!(bgmSoundEvent == lastBgmSoundEvent))
		{
			_bgmSoundAddress = new AudioEventReference(bgmSoundEvent);
			_changeType |= SceneSoundType.BGM;
			lastBgmSoundEvent = bgmSoundEvent;
		}
	}

	public void UpdateBgmState(int bgmState, ref int lastBgmState)
	{
		if (bgmState != lastBgmState)
		{
			_bgmState = bgmState;
			_changeType |= SceneSoundType.BGMState;
			lastBgmState = bgmState;
		}
	}

	public void UpdateEnvSound(string envSoundEvent, ref string lastEnvSoundEvent)
	{
		if (!(envSoundEvent == lastEnvSoundEvent))
		{
			_envSoundAddress = new AudioEventReference(envSoundEvent);
			_changeType |= SceneSoundType.Env;
			lastEnvSoundEvent = envSoundEvent;
		}
	}

	public void UpdateReverb(string reverbEvent, ref string lastRevertEvent)
	{
		if (!(reverbEvent == lastRevertEvent))
		{
			_reverb = new AudioEventReference(reverbEvent);
			_changeType |= SceneSoundType.Reverb;
			lastRevertEvent = reverbEvent;
		}
	}

	public void UpdateStepMaterialId(int stepMaterialId, ref int lastStepMaterialId)
	{
		if (stepMaterialId != lastStepMaterialId)
		{
			_stepMaterialId = (RoadMaterial)stepMaterialId;
			_changeType |= SceneSoundType.StepMat;
			lastStepMaterialId = stepMaterialId;
		}
	}
}
