local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.common.ModuleUnlock

return {
	DevType = g.core.const.ConstMgr.KNIGHT_CONST.DevType,
	DEV_LIST = {
		[g.core.const.ConstMgr.KNIGHT_CONST.DevType.INFO] = {
			comp = "knight/KnightInfoComp",
			resInfoId = 48,
			newRedPointId = 5,
			normalIcon = "ui://base_new/icon_yht_xinxi_2",
			selectIcon = "ui://base_new/icon_yht_xinxi_1",
			title = g.core.lang:get(201097),
			cond = function()
				return "", true
			end,
			show = function()
				return true
			end,
			index = g.core.const.ConstMgr.KNIGHT_CONST.DevType.INFO
		},
		[g.core.const.ConstMgr.KNIGHT_CONST.DevType.STAR_UP] = {
			comp = "knight/KnightStarUpComp",
			resInfoId = 49,
			newRedPointId = 108,
			normalIcon = "ui://base_new/icon_yht_shengxing_2",
			selectIcon = "ui://base_new/icon_yht_shengxing_1",
			title = g.core.lang:get(201098),
			cond = function()
				return var_0_1:getUnlockComment(var_0_0.FUNCTION_TYPE.KNIGHT_STAR_UP)
			end,
			show = function()
				return var_0_1:isModuleShow(var_0_0.FUNCTION_TYPE.KNIGHT_STAR_UP)
			end,
			index = g.core.const.ConstMgr.KNIGHT_CONST.DevType.STAR_UP
		},
		[g.core.const.ConstMgr.KNIGHT_CONST.DevType.SOUL] = {
			comp = "knight/KnightSpSoulComp",
			resInfoId = 374,
			newRedPointId = 942,
			normalIcon = "ui://base_new/icon_mr_lianying2",
			selectIcon = "ui://base_new/icon_mr_lianying1",
			title = g.core.lang:get(201110),
			cond = function(arg_5_0, arg_5_1)
				return "", arg_5_1.knight:isMRQuality()
			end,
			show = function(self)
				return self.knight:isMRQuality()
			end,
			index = g.core.const.ConstMgr.KNIGHT_CONST.DevType.SOUL
		},
		[g.core.const.ConstMgr.KNIGHT_CONST.DevType.PROTECT] = {
			comp = "knight/KnightSpProtectComp",
			resInfoId = 375,
			newRedPointId = 944,
			normalIcon = "ui://base_new/icon_mr_jiaohui2",
			selectIcon = "ui://base_new/icon_mr_jiaohui1",
			title = g.core.lang:get(201111),
			cond = function(arg_7_0, arg_7_1)
				return "", arg_7_1.knight:isMRQuality()
			end,
			show = function(self)
				return self.knight:isMRQuality()
			end,
			index = g.core.const.ConstMgr.KNIGHT_CONST.DevType.PROTECT
		},
		[g.core.const.ConstMgr.KNIGHT_CONST.DevType.ADVANCE] = {
			comp = "knight/KnightAdvanceComp",
			resInfoId = 50,
			newRedPointId = 6,
			normalIcon = "ui://base_new/icon_yht_tupo_2",
			selectIcon = "ui://base_new/icon_yht_tupo_1",
			title = g.core.lang:get(201099),
			cond = function()
				return var_0_1:getUnlockComment(var_0_0.FUNCTION_TYPE.KNIGHT_ADVANCE)
			end,
			show = function()
				return var_0_1:isModuleShow(var_0_0.FUNCTION_TYPE.KNIGHT_ADVANCE)
			end,
			index = g.core.const.ConstMgr.KNIGHT_CONST.DevType.ADVANCE
		},
		[g.core.const.ConstMgr.KNIGHT_CONST.DevType.WEDDING] = {
			comp = "knight/KnightWeddingDevComp",
			resInfoId = 73,
			newRedPointId = 795,
			normalIcon = "ui://base_new/icon_yht_shiyue_2",
			selectIcon = "ui://base_new/icon_yht_shiyue_1",
			title = g.core.lang:get(412001),
			cond = function(arg_11_0, arg_11_1)
				if not arg_11_1.knight then
					return "", false
				end

				return g.core.lang:get(412020), (g.core.model.User.weddingData:isWeddingDevelopByKnightId(arg_11_1.knight:getAdvanceId()))
			end,
			show = function(self)
				if not self.knight then
					return false
				end

				if not g.core.model.User.weddingData:isWeddingVowByKnightId(self.knight:getAdvanceId()) then
					return false
				end

				return var_0_1:isModuleShow(var_0_0.FUNCTION_TYPE.WEDDING_DEVELOP)
			end,
			index = g.core.const.ConstMgr.KNIGHT_CONST.DevType.WEDDING
		}
	}
}
