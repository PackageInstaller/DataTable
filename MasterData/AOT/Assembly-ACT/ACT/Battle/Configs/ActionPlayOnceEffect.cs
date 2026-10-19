using System;

namespace ACT.Battle.Configs;

[Serializable]
[AbilityTypeMetadata("播放一次特效（新）", "Action", new string[] { "play", "once", "effect", "fx", "particle" })]
public sealed class ActionPlayOnceEffect : ActionPlayEffectBase
{
	public EffectOnceOwnership ownership = EffectOnceOwnership.Detached;

	public MemoryEntityRef lifetimeEntity = MemoryEntityRef.Target;

	public bool removeWhenMotionExit = true;

	public bool removeWhenConfigMotionExit;

	public EffectStopBehavior stopBehavior = EffectStopBehavior.ClearImmediately;

	[NonSerialized]
	internal MotionState motionState;

	[NonSerialized]
	internal string configMotionName;
}
