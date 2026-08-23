local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock

return {
	DEV_ARR = {
		[g.core.const.ConstMgr.PreciousConst.DevType.ADVANCE] = {
			selectIcon = "ui://base_new/icon_gzp_jinjie_1",
			resInfoId = 327,
			normalIcon = "ui://base_new/icon_gzp_jinjie_2",
			comp = "precious/PreciousAdvanceComp",
			newRedPointId = 752,
			title = g.core.lang:get(421205),
			cond = function()
				return var_0_1:getUnlockComment(var_0_0.PRECIOUS)
			end,
			show = function()
				return var_0_1:isModuleShow(var_0_0.PRECIOUS)
			end,
			index = g.core.const.ConstMgr.PreciousConst.DevType.ADVANCE
		},
		[g.core.const.ConstMgr.PreciousConst.DevType.STAR_UP] = {
			selectIcon = "ui://base_new/icon_yht_shengxing_1",
			resInfoId = 325,
			normalIcon = "ui://base_new/icon_yht_shengxing_2",
			comp = "precious/PreciousStarUpComp",
			newRedPointId = 756,
			title = g.core.lang:get(421206),
			cond = function()
				return var_0_1:getUnlockComment(var_0_0.PRECIOUS)
			end,
			show = function()
				return var_0_1:isModuleShow(var_0_0.PRECIOUS)
			end,
			index = g.core.const.ConstMgr.PreciousConst.DevType.STAR_UP
		}
	}
}
