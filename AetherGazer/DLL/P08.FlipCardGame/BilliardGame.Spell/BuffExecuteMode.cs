namespace BilliardGame.Spell;

public enum BuffExecuteMode
{
	Immediate = 1,
	TickTime = 2,
	TurnStart = 4,
	TurnEnd = 8,
	OnCollision = 0x10,
	OnTeammateCollision = 0x20,
	BeCollision = 0x40,
	EnemyAction = 0x80,
	Shoot = 0x100,
	AttackEnd = 0x200,
	Persistent = 0x400,
	Bullet = 0x800,
	Enemy = 0x1000,
	Mech = 0x2000,
	OnPenetrate = 0x4000,
	OnAOEDamage = 0x8000
}
