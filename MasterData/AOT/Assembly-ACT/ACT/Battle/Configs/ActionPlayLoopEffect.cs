using System;

namespace ACT.Battle.Configs;

[Serializable]
[AbilityTypeMetadata("播放循环特效（新）", "Action", new string[] { "play", "loop", "effect", "fx", "particle" })]
public sealed class ActionPlayLoopEffect : ActionPlayEffectBase
{
	public EffectStopBehavior stopBehavior;
}
