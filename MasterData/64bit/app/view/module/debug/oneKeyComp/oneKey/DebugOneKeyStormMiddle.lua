local StormConst = require("app.view.module.storm.const.StormConst")
local var_0_1 = g.core.config.storm_info
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.stormData
local DebugOneKeyStormMiddle = class("DebugOneKeyStormMiddle", require("app.view.module.debug.oneKeyComp.oneKey.DebugOneKeyBase"))

function DebugOneKeyStormMiddle:ctor()
	self._idList = {}

	self.super.ctor(self)
end

function DebugOneKeyStormMiddle:initData()
	self._oneKeyName = "一键信仰解放核心区重置"
	self._needAddEventList = {
		[var_0_2.EVENT_NET_S2C_STORM_INFO] = handler(self, self._onS2CGetInfo),
		[var_0_2.EVENT_NET_S2C_STORM_CLEAR] = handler(self, self._onS2CClear)
	}
end

function DebugOneKeyStormMiddle:doOneKey()
	if not var_0_3:isMiddleCityInOpenTime() then
		self._isFinish = true

		return "未达开启时间"
	end

	if self:hasSending() then
		return
	end

	if not self._isGetInfo then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Storm_Info({})
		end)

		return
	end

	for iter_3_0, iter_3_1 in pairs(self._idList) do
		local var_3_0 = iter_3_1.id

		if var_0_3:isUnlockBlitz(iter_3_1.id) then
			if not var_0_3:isMiddleCityCleared(iter_3_1.id) then
				self:send(function()
					g.core.network.GameNetProxy:send_C2S_Storm_Clear({
						storm_id = var_3_0
					})
				end)
				self:addDailyStep(24)

				return
			else
				self:insertLog(iter_3_1.name .. "已经完成")
			end
		end
	end

	self._isFinish = true
end

function DebugOneKeyStormMiddle:_onS2CGetInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._isGetInfo = true
	self._idList = {}

	for iter_6_0, iter_6_1 in ipairs(var_0_3:getUnlockMiddleCityList()) do
		table.insert(self._idList, iter_6_1.info)
	end

	return "信息更新中"
end

function DebugOneKeyStormMiddle:_onS2CClear(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return "重置且委托作战成功: " .. var_0_1.get(arg_7_4.storm_id).name
end

return DebugOneKeyStormMiddle
