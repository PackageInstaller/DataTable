namespace ACT.Battle.Configs;

public enum AIBornBehaviorEnum
{
	IdleBorn = 1,
	SleepBorn = 2,
	JumpIn = 4,
	FallIn = 8,
	RunIn = 0x10,
	LeftRightRunIn = 0x20,
	FlyIn = 0x40
}
