using System;

namespace ACT.Battle.Configs;

[Serializable]
public class AttackFSMVariant
{
	public string id;

	public AttackFSMVariantMode mode;

	public ConfigAttackStateMachine fsm;

	public ConfigAttackFSMOverlay overlay;
}
