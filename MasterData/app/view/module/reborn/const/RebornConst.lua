local var_0_0 = {
	TYPE_EQUIP = 3,
	TYPE_ARTIFACT = 6,
	PET_EQUIP = 8,
	DRESS = 4,
	TYPE_UNITE_TOKEN = 2,
	TYPE_TREASURE = 4,
	EQUIP = 2,
	TYPE_KNIGHT_SOUL = 9,
	TYPE_FURNITURE = 10,
	TYPE_CUSTOM_FRAG = 11,
	OP_TYPE_REBORN = 1,
	TYPE_PET_EQUIP = 7,
	ARTIFACT = 6,
	OP_TYPE_SUBQULITY = 99,
	TREASURE = 3,
	TYPE_PET = 8,
	PET = 7,
	UNITE_TOKEN = 5,
	KNIGHT = 1,
	TYPE_DRESS = 5,
	TYPE_KNIGHT = 1,
	OP_TYPE_DECOMPOSE = 2,
	SELECT_INDEX_MAP = {
		KNIGHT = 1,
		TOKEN = 4,
		EQUIP = 2,
		TREASURE = 3,
		FURNITURE = 7,
		PET = 6,
		CUSTOM_FRAG = 8,
		ARTIFACT = 5
	}
}

var_0_0.SERVER_TYPE_CFG_MAP = {
	[var_0_0.TYPE_KNIGHT] = {
		redPointId = 155,
		type = 1,
		index = var_0_0.SELECT_INDEX_MAP.KNIGHT,
		name = g.core.lang:get(103028),
		show = function()
			return true
		end
	},
	[var_0_0.TYPE_UNITE_TOKEN] = {
		redPointId = 156,
		type = 1,
		index = var_0_0.SELECT_INDEX_MAP.TOKEN,
		name = g.core.lang:get(103031),
		show = function()
			return true
		end
	},
	[var_0_0.TYPE_EQUIP] = {
		redPointId = 158,
		type = 1,
		index = var_0_0.SELECT_INDEX_MAP.EQUIP,
		name = g.core.lang:get(103029),
		show = function()
			return true
		end
	},
	[var_0_0.TYPE_TREASURE] = {
		redPointId = 157,
		type = 1,
		index = var_0_0.SELECT_INDEX_MAP.TREASURE,
		name = g.core.lang:get(103030),
		show = function()
			return true
		end
	},
	[var_0_0.TYPE_ARTIFACT] = {
		redPointId = 249,
		type = 1,
		index = var_0_0.SELECT_INDEX_MAP.ARTIFACT,
		name = g.core.lang:get(103032),
		show = function()
			return true
		end
	},
	[var_0_0.TYPE_FURNITURE] = {
		redPointId = 0,
		type = 2,
		index = var_0_0.SELECT_INDEX_MAP.FURNITURE,
		name = g.core.lang:get(103033),
		show = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FURNITURE)
		end
	},
	[var_0_0.TYPE_PET] = {
		redPointId = 391,
		type = 1,
		index = var_0_0.SELECT_INDEX_MAP.PET,
		name = g.core.lang:get(103034),
		show = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET)
		end
	},
	[var_0_0.TYPE_CUSTOM_FRAG] = {
		type = 99,
		index = var_0_0.SELECT_INDEX_MAP.CUSTOM_FRAG,
		name = g.core.lang:get(103043),
		show = function()
			return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_BAG)
		end
	}
}

return var_0_0
