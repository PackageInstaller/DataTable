local activity_manager = require("controller.activity_manager")
local autochess_conf_data = require("data.autochess_conf_data")
local activity_conf_data = require("data.activity_conf_data")
local playermodel = require("model.playermodel")
local network = require("network.network")
local item_manager = require("controller.item_manager")

function ACTIVITY_OBJ_NEW:get_activity_jumptower_info()
	network:rpc("get_activity_jumptower_info", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			self.jumpTowerLockList = arg_2_0.arrays or {}
			self.jumpTowerCurLevel = arg_2_0.curlevel
			self.jumpTowerMaxLevel = arg_2_0.maxlevel
			self.jumpTowerResetTime = arg_2_0.times

			activity_manager:fireEvent(activity_manager.activityEventId.JUMPTOWER_LIST_UPDATE)
		end
	end)
end

function ACTIVITY_OBJ_NEW:reset_jumptower()
	LayerManager:pushInLayer("PopDoLayer", {
		labels = {
			title = L_BATTLEPASS_BUY.title,
			des = string.format(L_JUMP_TOWER_RESET_DES.des, (self:getCurResetJumptowerCost())),
			button = L_BATTLEPASS_BUY.button
		},
		surecallback = function()
			network:rpc("reset_jumptower", {
				activityid = self._id
			}, function(arg_5_0)
				if arg_5_0.result == 1 then
					self:get_activity_jumptower_info()
				end
			end)
		end
	})
end

function ACTIVITY_OBJ_NEW:getJumpTowerCurLevel()
	return self.jumpTowerCurLevel
end

function ACTIVITY_OBJ_NEW:getJumpTowerMaxLevel()
	return self.jumpTowerMaxLevel
end

function ACTIVITY_OBJ_NEW:getJumpTowerArrayByIndex(arg_8_1)
	if not self.jumpTowerLockList[arg_8_1] then
		return
	end

	return self.jumpTowerLockList[arg_8_1].servants
end

function ACTIVITY_OBJ_NEW:getJumptowerLockServants()
	local var_9_0 = {}
	local var_9_1 = self:getJumptowerUnlockServant()

	for iter_9_0, iter_9_1 in ipairs(self.jumpTowerLockList) do
		for iter_9_2, iter_9_3 in ipairs(iter_9_1.servants) do
			if iter_9_3 ~= var_9_1 then
				table.insert(var_9_0, iter_9_3)
			end
		end
	end

	return var_9_0
end

function ACTIVITY_OBJ_NEW:getCurResetJumptowerCost()
	local var_10_0 = require("data.levelmode_data")[ACTIVITY_ID_TO_MODETYPE_FUNC.jump_tower(self._id) * 10 + 1].free_reset_time or 0
	local sign_mend_data

	if var_10_0 > self.jumpTowerResetTime then
		do return 0 end

		sign_mend_data = require("data.sign_mend_data")
	end

	if sign_mend_data[self.jumpTowerResetTime - var_10_0 + 1] then
		return sign_mend_data[self.jumpTowerResetTime - var_10_0 + 1].costdiamond
	else
		return 120
	end
end

function ACTIVITY_OBJ_NEW:getJumptowerUnlockServant()
	return require("data.levelmode_data")[ACTIVITY_ID_TO_MODETYPE_FUNC.jump_tower(self._id) * 10 + 1].unlock_servant
end
