namespace AIScript;

public enum MonsterEventType
{
	SelfReceiveDamage,
	MonsterDie,
	MonsterSpawn,
	SelfLostControl,
	SelfBulletSpawn,
	SelfBulletFinish,
	SelfToughnessBroken,
	SelfHpChanged,
	DamageToOthers,
	BattleLevelChange,
	CustomEventOnlySelfOrSummoner,
	GroupController,
	CustomEvent,
	BossEnergyChange
}
