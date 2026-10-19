using System;
using ACT.Sound;
using FMODUnity;

namespace ACT.World.Asset;

[Serializable]
public class AreaState
{
	public int stateId;

	public float runTime;

	public EventReference sound;

	public AudioEventReference audioSound;
}
