namespace ACT.Battle;

internal enum PlayerInputBitType
{
	Move = 0,
	Move_Horizontal = Move,
	Move_Vertical = 1,
	Dodge = 2,
	RegularAttack = 3,
	SkillAttack = 4,
	Jump = 5,
	Vibrate = 6,
	Claw = 7,
	ItemShortcut = 8,
	SwitchCharacter_1 = 9,
	SwitchCharacter_2 = 10,
	SwitchCharacter_3 = 11,
	Interact = 12,
	InteractSwitch = 13,
	Max = 14
}
