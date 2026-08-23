return {
	IGNORE_COMMON_ID = 1,
	RANK_SIZE = 50,
	COMPETITION_SCORE_VALUE = 85,
	AWARD_TYPE = {
		SCORE = 2,
		COMMON = 1
	},
	AWARD_STATE = {
		UNGET = 0,
		GETDONE = 2,
		ACTEND = 3,
		CANGET = 1
	},
	TASK_TAG_ICON = {
		"ui://competition/icon_jingsai_tj_jiaoguo_",
		"ui://competition/icon_jingsai_tj_lindong_",
		"ui://competition/icon_jingsai_tj_dongxi_",
		"ui://competition/icon_jingsai_tj_lijin_"
	},
	RANK_ID = {
		[2] = g.core.network.proto.ARTIFACT_COMPETITION,
		[3] = g.core.network.proto.FURNITURE_COMPETITION,
		[4] = g.core.network.proto.UNITE_TOKEN_COMPETITION,
		[5] = g.core.network.proto.EGG_COMPETITION,
		[6] = g.core.network.proto.PET_COMPETITION,
		[7] = g.core.network.proto.EQUIPMENT_COMPETITION,
		[8] = g.core.network.proto.KSOUL_COMPETITION
	},
	ACTIVITY_FUNC = {
		[2] = g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT,
		[6] = g.core.const.ConstMgr.FUNCTION_TYPE.PET,
		[7] = g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_RESONANCE,
		[8] = g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_SOUL
	}
}
