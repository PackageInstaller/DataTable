namespace ACT.Battle;

public enum FindTargetType
{
	opposingCampsAttackable,
	opposingCampsCantAttackable,
	opposingCampsAttackableAndCantAttackable,
	selfCampsAttackable,
	selfCampsCantAttackable,
	selfCampsAttackableAndCantAttackable,
	teamer,
	teamerFilterSelf,
	self
}
