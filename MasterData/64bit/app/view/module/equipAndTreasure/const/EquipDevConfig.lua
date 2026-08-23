local var_0_0 = g.core.const.ConstMgr
local var_0_1 = {
	DEV_LIST = {
		[g.core.const.ConstMgr.ETConst.DEV_TYPE.STRENGTH] = {
			selectIcon = "ui://equipAndTreasure/icon_zbpy_qianghua_1",
			normalIcon = "ui://equipAndTreasure/icon_zbpy_qianghua_2",
			newRedPointId = 123,
			comp = "equipAndTreasure/EquipStrenghComp",
			title = g.core.lang:get(201511),
			cond = function()
				return g.core.common.ModuleUnlock:getUnlockComment(var_0_0.FUNCTION_TYPE.EQUIP_STRENGTH)
			end,
			show = function()
				return g.core.common.ModuleUnlock:isModuleShow(var_0_0.FUNCTION_TYPE.EQUIP_STRENGTH)
			end,
			index = g.core.const.ConstMgr.ETConst.DEV_TYPE.STRENGTH
		},
		[g.core.const.ConstMgr.ETConst.DEV_TYPE.REFINE] = {
			selectIcon = "ui://equipAndTreasure/icon_zbpy_gaizao_1",
			normalIcon = "ui://equipAndTreasure/icon_zbpy_gaizao_2",
			newRedPointId = 124,
			comp = "equipAndTreasure/EquipRefineComp",
			title = g.core.lang:get(201512),
			cond = function()
				return g.core.common.ModuleUnlock:getUnlockComment(var_0_0.FUNCTION_TYPE.EQUIP_REFINE)
			end,
			show = function()
				return g.core.common.ModuleUnlock:isModuleShow(var_0_0.FUNCTION_TYPE.EQUIP_REFINE)
			end,
			index = g.core.const.ConstMgr.ETConst.DEV_TYPE.REFINE
		},
		[g.core.const.ConstMgr.ETConst.DEV_TYPE.GLYPH] = {
			selectIcon = "ui://equipAndTreasure/icon_zbpy_yanfa_1",
			normalIcon = "ui://equipAndTreasure/icon_zbpy_yanfa_2",
			newRedPointId = 125,
			comp = "equipAndTreasure/EquipGlyphComp",
			title = g.core.lang:get(201513),
			cond = function()
				return g.core.common.ModuleUnlock:getUnlockComment(var_0_0.FUNCTION_TYPE.EQUIP_GLYPH)
			end,
			show = function()
				if var_0_0.EquipConst.EQUIP_GLYPH_OFF then
					return false
				end

				return g.core.common.ModuleUnlock:isModuleShow(var_0_0.FUNCTION_TYPE.EQUIP_GLYPH)
			end,
			index = g.core.const.ConstMgr.ETConst.DEV_TYPE.GLYPH
		},
		[g.core.const.ConstMgr.ETConst.DEV_TYPE.RESONANCE] = {
			selectIcon = "ui://equipAndTreasure/icon_zbpy_yanfa_1",
			normalIcon = "ui://equipAndTreasure/icon_zbpy_yanfa_2",
			newRedPointId = 431,
			comp = "equipAndTreasure/EquipResonanceComp",
			title = g.core.lang:get(201601),
			cond = function()
				return g.core.common.ModuleUnlock:getUnlockComment(var_0_0.FUNCTION_TYPE.EQUIP_RESONANCE)
			end,
			show = function(self)
				return g.core.common.ModuleUnlock:isModuleShow(var_0_0.FUNCTION_TYPE.EQUIP_RESONANCE) and self:hasResonance()
			end,
			index = g.core.const.ConstMgr.ETConst.DEV_TYPE.RESONANCE
		},
		[g.core.const.ConstMgr.ETConst.DEV_TYPE.MAGICAL] = {
			selectIcon = "ui://equipAndTreasure/icon_zbpy_huanhua_1",
			normalIcon = "ui://equipAndTreasure/icon_zbpy_huanhua_2",
			newRedPointId = 827,
			comp = "equipAndTreasure/EquipMagicalComp",
			title = g.core.lang:get(201651),
			cond = function()
				return g.core.common.ModuleUnlock:getUnlockComment(var_0_0.FUNCTION_TYPE.EQUIP_MAGICAL)
			end,
			show = function(self)
				return g.core.common.ModuleUnlock:isModuleShow(var_0_0.FUNCTION_TYPE.EQUIP_MAGICAL) and self:hasMagical()
			end,
			index = g.core.const.ConstMgr.ETConst.DEV_TYPE.MAGICAL
		}
	}
}

function var_0_1.setRedDataByIndex(arg_11_0, arg_11_1)
	var_0_1.DEV_LIST[arg_11_0].red.redData = arg_11_1
end

function var_0_1.getRedDataByIndex(arg_12_0)
	return var_0_1.DEV_LIST[arg_12_0].red.redData
end

function var_0_1.setRedData(arg_13_0)
	for iter_13_0 = 1, #var_0_1.DEV_LIST do
		var_0_1.DEV_LIST[iter_13_0].red.redData = arg_13_0
		var_0_1.DEV_LIST[iter_13_0].red.conditions[1] = var_0_1.DEV_LIST[iter_13_0].red.template[1](arg_13_0)
	end
end

return var_0_1
