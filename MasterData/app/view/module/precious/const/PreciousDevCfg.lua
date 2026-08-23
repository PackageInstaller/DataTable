local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock

return {
	DEV_ARR = {
		[g.core.const.ConstMgr.PreciousConst.DevType.ADVANCE] = {
			comp = "precious/PreciousAdvanceComp",
			resInfoId = 327,
			newRedPointId = 752,
			normalIcon = "ui://base_new/icon_gzp_jinjie_2",
			selectIcon = "ui://base_new/icon_gzp_jinjie_1",
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
			comp = "precious/PreciousStarUpComp",
			resInfoId = 325,
			newRedPointId = 756,
			normalIcon = "ui://base_new/icon_yht_shengxing_2",
			selectIcon = "ui://base_new/icon_yht_shengxing_1",
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
