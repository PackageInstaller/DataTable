local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.common.ModuleUnlock

return {
	DEV_ARR = {
		[g.core.const.ConstMgr.PetConst.DevType.INFO] = {
			resInfoId = 185,
			selectIcon = "ui://base_new/icon_yht_xinxi_1",
			normalIcon = "ui://base_new/icon_yht_xinxi_2",
			comp = "pet/PetInfoComp",
			newRedPointId = 379,
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
			resInfoId = 186,
			selectIcon = "ui://base_new/icon_yht_shengxing_1",
			normalIcon = "ui://base_new/icon_yht_shengxing_2",
			comp = "pet/PetStarUpComp",
			newRedPointId = 385,
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
			resInfoId = 187,
			selectIcon = "ui://base_new/icon_yzs_zengfu_1",
			normalIcon = "ui://base_new/icon_yzs_zengfu_2",
			comp = "pet/PetAdvanceComp",
			newRedPointId = 380,
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
