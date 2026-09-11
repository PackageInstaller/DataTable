using System;

namespace BilliardGame.Spell;

[Serializable]
public abstract class BActionNode : BNode
{
	public abstract BTNodeStatus Run(BTEnv env);
}
