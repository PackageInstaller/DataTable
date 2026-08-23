local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock

return {
	DEV_ARR = {
		[g.core.const.ConstMgr.PetConst.DevType.INFO] = {
			comp = "pet/PetInfoComp",
			resInfoId = 185,
			newRedPointId = 379,
			normalIcon = "ui://base_new/icon_yht_xinxi_2",
			selectIcon = "ui://base_new/icon_yht_xinxi_1",
			title = g.core.lang:get(201097),
			cond = function()
				return var_0_1:getUnlockComment(var_0_0.PET_UPGRADE)
			end,
			show = function()
				return var_0_1:isModuleShow(var_0_0.PET_UPGRADE)
			end,
			index = g.core.const.ConstMgr.PetConst.DevType.INFO
		},
		[g.core.const.ConstMgr.PetConst.DevType.STAR_UP] = {
			comp = "pet/PetStarUpComp",
			resInfoId = 186,
			newRedPointId = 385,
			normalIcon = "ui://base_new/icon_yht_shengxing_2",
			selectIcon = "ui://base_new/icon_yht_shengxing_1",
			title = g.core.lang:get(201098),
			cond = function()
				return var_0_1:getUnlockComment(var_0_0.PET_STAR_UP)
			end,
			show = function()
				return var_0_1:isModuleShow(var_0_0.PET_STAR_UP)
			end,
			index = g.core.const.ConstMgr.PetConst.DevType.STAR_UP
		},
		[g.core.const.ConstMgr.PetConst.DevType.ADVANCE] = {
			comp = "pet/PetAdvanceComp",
			resInfoId = 187,
			newRedPointId = 380,
			normalIcon = "ui://base_new/icon_yzs_zengfu_2",
			selectIcon = "ui://base_new/icon_yzs_zengfu_1",
			title = g.core.lang:get(201099),
			cond = function()
				return var_0_1:getUnlockComment(var_0_0.PET_ADVANCE)
			end,
			show = function()
				return var_0_1:isModuleShow(var_0_0.PET_ADVANCE)
			end,
			index = g.core.const.ConstMgr.PetConst.DevType.ADVANCE
		}
	}
}
