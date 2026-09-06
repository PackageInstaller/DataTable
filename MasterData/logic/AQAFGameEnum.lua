-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/AQAFGameEnum.lua

module("logic.extensions.aoqiattackforce.minigame.AQAFGameEnum", package.seeall)

local AQAFGameEnum = {}

AQAFGameEnum.WeaponType = {
	Purse = 1,
	Magic = 3,
	Physics = 2,
	Defense = 4,
	None = 0
}
AQAFGameEnum.MonsterAttackType = {
	Ranged = 1,
	Melee = 2,
	None = 0
}
AQAFGameEnum.WeaponTargetType = {
	Last = 1,
	Player = 3,
	Random = 2
}
AQAFGameEnum.UnitTag = {
	Weapon = 4,
	Bullet = 3,
	Monster = 2,
	MainPlayer = 1
}
AQAFGameEnum.AttackDamageType = {
	Normal = 1,
	Magic = 3,
	Physics = 2,
	None = 0
}
AQAFGameEnum.BlockWidthMax = 7
AQAFGameEnum.BlockHeightMax = 5
AQAFGameEnum.PurseEquipmentDefineId = 1
AQAFGameEnum.GameMode = {
	Hero = 3,
	Endless = 2,
	Normal = 1
}

return AQAFGameEnum
