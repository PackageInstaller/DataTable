local var_0_0 = {
	DEV_TYPE = {
		REFINE = 2,
		GLYPH = 4,
		STRENGTH = 1,
		PURIFY = 3
	}
}
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")

var_0_0.DEV_LIST = {
	[var_0_0.DEV_TYPE.STRENGTH] = {
		comp = "equipAndTreasure/TreasureStrengthComp",
		newRedPointId = 131,
		normalIcon = "ui://equipAndTreasure/icon_zbpy_qianghua_2",
		selectIcon = "ui://equipAndTreasure/icon_zbpy_qianghua_1",
		title = g.core.lang:get(202006),
		cond = function()
			return g.core.common.ModuleUnlock:getUnlockComment(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_STRENGTH)
		end,
		show = function()
			return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_STRENGTH)
		end,
		index = var_0_0.DEV_TYPE.STRENGTH
	},
	[var_0_0.DEV_TYPE.REFINE] = {
		comp = "equipAndTreasure/TreasureRefineComp",
		newRedPointId = 132,
		normalIcon = "ui://equipAndTreasure/icon_zbpy_gaizao_2",
		selectIcon = "ui://equipAndTreasure/icon_zbpy_gaizao_1",
		title = g.core.lang:get(202007),
		cond = function()
			return g.core.common.ModuleUnlock:getUnlockComment(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_REFINE)
		end,
		show = function(self)
			if self and self.id and #g.core.model.User.treasureData:getTreasureSpecialAttrsList(self.id) <= 0 then
				return false
			end

			return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_REFINE)
		end,
		index = var_0_0.DEV_TYPE.REFINE
	},
	[var_0_0.DEV_TYPE.GLYPH] = {
		comp = "equipAndTreasure/TreasureGlyphComp",
		newRedPointId = 133,
		normalIcon = "ui://equipAndTreasure/icon_zbpy_yanfa_2",
		selectIcon = "ui://equipAndTreasure/icon_zbpy_yanfa_1",
		title = g.core.lang:get(202008),
		cond = function()
			return g.core.common.ModuleUnlock:getUnlockComment(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_GLYPH)
		end,
		show = function()
			if not TreasureConst.IS_FORBID_GLYPH then
				return false
			end

			return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.TREASURE_GLYPH)
		end,
		index = var_0_0.DEV_TYPE.GLYPH
	},
	[var_0_0.DEV_TYPE.PURIFY] = {
		comp = "equipAndTreasure/TreasureRefineAutoComp",
		topId = 268,
		newRedPointId = 624,
		normalIcon = "ui://equipAndTreasure/icon_zbpy_xilian_2",
		selectIcon = "ui://equipAndTreasure/icon_zbpy_xilian_1",
		title = g.core.lang:get(202061),
		cond = function()
			return g.core.common.ModuleUnlock:getUnlockComment(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_CAST)
		end,
		show = function(self)
			return #g.core.model.User.treasureData:getPurifyCfg(self.id) > 0 and g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_CAST)
		end,
		index = var_0_0.DEV_TYPE.PURIFY
	}
}

function var_0_0.setRedDataByIndex(arg_9_0, arg_9_1)
	var_0_0.DEV_LIST[arg_9_0].red.redData = arg_9_1
end

function var_0_0.setRedData(arg_10_0)
	for iter_10_0 = 1, #var_0_0.DEV_LIST do
		var_0_0.DEV_LIST[iter_10_0].red.redData = arg_10_0
		var_0_0.DEV_LIST[iter_10_0].red.conditions[1] = var_0_0.DEV_LIST[iter_10_0].red.temp[1](arg_10_0)
	end
end

function var_0_0.setShow(arg_11_0, arg_11_1)
	var_0_0.DEV_LIST[arg_11_0].show = arg_11_1
end

return var_0_0
