local var_0_0 = g.core.config.tower_reward_info
local var_0_1 = g.core.const.ConstMgr.TowerConst
local var_0_2 = g.core.const.ConstMgr.ShopConst
local var_0_3 = g.core.model.User.shopData
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.model.User.towerHardData
local DebugOneKeyTowerHard = class("DebugOneKeyTowerHard", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyTowerHard:initData()
	self._oneKeyName = "一键源质探索"
	self._needAddEventList = {
		[var_0_4.EVENT_NET_S2C_TOWER_GETINFO] = handler(self, self._onS2CGetInfo),
		[var_0_4.EVENT_NET_S2C_TOWER_HANGUPAWARD] = handler(self, self._onRecHangUpReward),
		[var_0_4.EVENT_NET_S2C_TOWER_HANGUPQUICKAWARD] = handler(self, self._onRecQuickHangUpReward),
		[var_0_4.EVENT_NET_S2C_TOWER_ONEKEYFIRSTPASSAWARD] = handler(self, self._onRecFirstPassReward)
	}
end

function DebugOneKeyTowerHard:doOneKey()
	if not self._isGetInfo then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({
				play_type = 2
			})
		end)

		return
	end

	if #var_0_5:getHangUpRewardData() > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Tower_HangupAward({
				play_type = 2
			})
		end)

		return
	end

	if self:canQuickGetAward() then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Tower_HangupQuickAward({
				play_type = 2,
				count = 1
			})
		end)

		return
	end

	local var_2_0 = self:getFirstPassIds()

	if #var_2_0 > 0 then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Tower_OnekeyFirstPassAward({
				play_type = 2,
				ids = var_2_0
			})
		end)

		return
	end

	self._isFinish = true
end

function DebugOneKeyTowerHard:_onS2CGetInfo(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._isGetInfo = true

	return "信息更新中"
end

function DebugOneKeyTowerHard:_onRecHangUpReward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	return "领取生产平台挂机奖励成功"
end

function DebugOneKeyTowerHard:_onRecQuickHangUpReward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	return "加速领取奖励成功"
end

function DebugOneKeyTowerHard:_onRecFirstPassReward(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	return "一键领取首通奖励成功"
end

function DebugOneKeyTowerHard:getFirstPassIds()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(var_0_1.STAGE_TYPE_HARD) do
		for iter_11_2, iter_11_3 in pairs((var_0_5:getTowerCanAwardIdsByType(iter_11_1))) do
			if not var_0_5:getFirstPassAwardIsGetById(iter_11_3) and var_0_5:getIsFirstPassByStageAndId(iter_11_1, var_0_0.get(iter_11_3).require_value) then
				table.insert(var_11_0, iter_11_3)

				if #var_11_0 >= 20 then
					return var_11_0
				end
			end
		end
	end

	return var_11_0
end

function DebugOneKeyTowerHard:canQuickGetAward()
	if var_0_3:getLeftCount(var_0_2.PLAY_TYPE.TOWER_HARD_ACCELERATE_COUNT) > 0 and table.nums((var_0_5:getQuickHangupReward())) > 0 then
		return true
	end

	return false
end

return DebugOneKeyTowerHard
