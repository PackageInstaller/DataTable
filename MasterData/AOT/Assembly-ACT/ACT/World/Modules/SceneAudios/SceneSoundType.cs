using System;

namespace ACT.World.Modules.SceneAudios;

[Flags]
public enum SceneSoundType
{
	None = 0,
	BGM = 1,
	BGMState = 2,
	Env = 4,
	Reverb = 8,
	StepMat = 0x10
}
