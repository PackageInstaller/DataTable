local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.stormData
local SpiritHelpStormMiddle = class("SpiritHelpStormMiddle", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpStormMiddle:initData()
	self._cellName = "SpiritHelpCell1"
	self._needAddEventList = {
		[var_0_1.EVENT_NET_S2C_STORM_ONEKEY_CLEAR] = handler(self, self._onRcvAllBlitz)
	}
end

function SpiritHelpStormMiddle:getAwardText(arg_2_1)
	local var_2_0 = arg_2_1.storm_awards or {}

	return {
		langId = 409510,
		param = {
			count = #var_2_0
		}
	}
end

function SpiritHelpStormMiddle:refreshState()
	self._isTip = false

	if not var_0_2:isMiddleCityInOpenTime() then
		self._isTip = true
		self._tipStr = g.core.lang:get(304526)
		self._state = var_0_0.STATE.LOCK

		return
	end

	local var_3_0 = false

	for iter_3_0, iter_3_1 in pairs(var_0_2:getUnlockMiddleCityList()) do
		if var_0_2:isUnlockBlitz(iter_3_1.info.id) then
			var_3_0 = true

			if not var_0_2:isMiddleCityCleared(iter_3_1.info.id) then
				self._state = var_0_0.STATE.NORMAL

				return
			end
		end
	end

	if var_3_0 then
		self._state = var_0_0.STATE.FINISH
	else
		self._isTip = true
		self._tipStr = g.core.lang:get(409511)
		self._state = var_0_0.STATE.LOCK
	end
end

function SpiritHelpStormMiddle:doing()
	for iter_4_0, iter_4_1 in pairs(var_0_2:getUnlockMiddleCityList()) do
		if var_0_2:isUnlockBlitz(iter_4_1.info.id) and not var_0_2:isMiddleCityCleared(iter_4_1.info.id) then
			self:send(function()
				g.core.network.GameNetProxy:send_C2S_Storm_OneKey_Clear({
					is_helper = true
				})
			end)

			break
		end
	end

	self._isFinish = true
end

function SpiritHelpStormMiddle:_onRcvAllBlitz(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	for iter_6_0, iter_6_1 in ipairs(arg_6_4.storm_awards or {}) do
		self:addCurDoAward(iter_6_1.awards)

		for iter_6_2, iter_6_3 in pairs(iter_6_1.challenge_awards or {}) do
			self:addCurDoAward(iter_6_3.detail)
		end
	end

	self:setDoingState(var_0_0.DOING_STATE.SUCCESS)
end

return SpiritHelpStormMiddle
