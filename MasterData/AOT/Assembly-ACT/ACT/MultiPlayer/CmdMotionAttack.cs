using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.MultiPlayer;

public struct CmdMotionAttack
{
	public EntityId attacker;

	public int state;

	public byte attackIndex;

	public List<FindTargetResult> targets;

	public List<int> hitRecoveryOrdinals;
}
