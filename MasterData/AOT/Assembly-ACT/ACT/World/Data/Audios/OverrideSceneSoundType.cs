using System;

namespace ACT.World.Data.Audios;

[Flags]
public enum OverrideSceneSoundType
{
	None = 0,
	BGM = 1,
	BGMState = 2,
	Env = 4,
	Reverb = 8,
	StepMat = 0x10,
	All = BGM | BGMState | Env | Reverb | StepMat
}
