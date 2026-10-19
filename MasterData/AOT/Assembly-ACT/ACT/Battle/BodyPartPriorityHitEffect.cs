using System;

namespace ACT.Battle;

[Serializable]
public struct BodyPartPriorityHitEffect
{
	public byte priority;

	public AniPartControl.PartType partType;

	public string trigger;
}
