using System.Collections.Generic;
using Entitas;

[Sim]
[IgnoreClone]
public class EntityAIThink : IComponent
{
	public int mThinkTimer;

	public Dictionary<int, AICommand> mAICommandSet;

	public AICommand mCurrentCommand;

	public AICommand mInterruptCommand;

	public bool mReevalute;

	public bool mForceMakeDecision;

	public int mLastThinkTimer;
}
