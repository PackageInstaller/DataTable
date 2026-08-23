local var_0_0 = {
	ARMY = 3,
	SYSTEM = 2,
	WORLD = 1,
	EFriendMail = 3,
	ESysMail = 2,
	EAwardMail = 1,
	ANCIENTS = 20,
	ANNIVERSARY = 19,
	NEW_SLG = 18,
	ALLIANCE = 17,
	TEAM_BATTLE_ZONE = 16,
	TEAM_BATTLE = 15,
	BOUNTY = 14,
	AREA = 13,
	GVE = 12,
	GUILD_WAR = 11,
	WRESTALL = 10,
	WRESTAREA = 9,
	STORM = 8,
	ALL = 7,
	SINGLE = 5,
	TROOPS = 4
}

var_0_0.CrossType = {
	[var_0_0.STORM] = 1,
	[var_0_0.WRESTAREA] = 3,
	[var_0_0.WRESTALL] = 4,
	[var_0_0.GUILD_WAR] = 5,
	[var_0_0.GVE] = 6,
	[var_0_0.TROOPS] = 7,
	[var_0_0.AREA] = 11,
	[var_0_0.BOUNTY] = 13,
	[var_0_0.TEAM_BATTLE] = var_0_0.TEAM_BATTLE,
	[var_0_0.TEAM_BATTLE_ZONE] = var_0_0.TEAM_BATTLE_ZONE,
	[var_0_0.ALLIANCE] = var_0_0.ALLIANCE,
	[var_0_0.NEW_SLG] = var_0_0.NEW_SLG,
	[var_0_0.ANNIVERSARY] = var_0_0.ANNIVERSARY,
	[var_0_0.ANCIENTS] = var_0_0.ANCIENTS
}
var_0_0.GroupType = {
	[5] = var_0_0.SYSTEM,
	[0] = var_0_0.SYSTEM
}
var_0_0.SettingFunctionIds = {
	0,
	0,
	0,
	0,
	g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND
}

return var_0_0
