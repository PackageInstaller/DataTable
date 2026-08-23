local var_0_0 = {
	WRESTAREA = 9,
	TROOPS = 4,
	WRESTALL = 10,
	GVE = 12,
	ANCIENTS = 20,
	TEAM_BATTLE = 15,
	AREA = 13,
	TEAM_BATTLE_ZONE = 16,
	EAwardMail = 1,
	BOUNTY = 14,
	WORLD = 1,
	GUILD_WAR = 11,
	STORM = 8,
	EFriendMail = 3,
	NEW_SLG = 18,
	ALL = 7,
	ANNIVERSARY = 19,
	ALLIANCE = 17,
	SINGLE = 5,
	ARMY = 3,
	ESysMail = 2,
	SYSTEM = 2
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
