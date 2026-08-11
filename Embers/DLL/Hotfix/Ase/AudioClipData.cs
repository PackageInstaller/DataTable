using System;
using FMODUnity;

namespace Ase;

[Serializable]
public struct AudioClipData
{
	public EventReference audioClip;

	public int audioId;

	public float startTime;

	public float endTime;
}
