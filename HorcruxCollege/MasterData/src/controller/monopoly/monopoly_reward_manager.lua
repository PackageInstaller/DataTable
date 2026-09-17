local MonopolyRewardManager = class("MonopolyRewardManager", (require("controller.base_manager")))

MonopolyRewardManager.MULTITON_MSG = "MonopolyRewardManager instancealready constructed!"

function MonopolyRewardManager:ctor()
	MonopolyRewardManager.super.ctor(self)

	self._data = {}
end

function MonopolyRewardManager:requestInfo(arg_2_1)
	return
end

function MonopolyRewardManager:handlerInfo(arg_3_1)
	return
end

function MonopolyRewardManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MonopolyRewardManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MonopolyRewardManager:getLevelShowRewardInfo()
	local item_data = require("data/item_data")
	local drop_manager = require("controller/drop_manager")
	local var_6_2 = require("controller.monopoly.monopoly_manager"):getInstance()
	local var_6_3 = var_6_2:getAllLevel()
	local var_6_4 = {}

	for iter_6_0 = 1, #var_6_3 do
		var_6_4[iter_6_0] = {
			reward = {},
			lv = var_6_3[iter_6_0]
		}

		local var_6_5 = drop_manager:getAllDrops(var_6_2:getLevelConfigByLevel(var_6_3[iter_6_0]).finish_drop)

		for iter_6_1 = 1, #var_6_5 do
			var_6_4[iter_6_0].reward[iter_6_1] = {
				id = var_6_5[iter_6_1].dropid,
				num = var_6_5[iter_6_1].dropNum
			}
		end
	end

	return var_6_4
end

return MonopolyRewardManager
