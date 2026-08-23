local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_1 = g.core.event.enum
local SpiritHelpArena = class("SpiritHelpArena", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpArena:initData()
	self._cellName = "SpiritHelpCell2"
	self._hasCount = true
	self._isLoadCount = true
	self._isNeedSendAward = false
	self._needAddEventList = {
		[var_0_1.EVENT_NET_S2C_ARENA_ONEKEYCHALLENGE] = handler(self, self._onRcvAllChallenge),
		[var_0_1.EVENT_NET_S2C_GET_MODULE_ONE_KEY_TASK_AWARD] = handler(self, self._onGetModuleAward)
	}
end

function SpiritHelpArena:getAwardText(arg_2_1)
	if not arg_2_1 or not arg_2_1.num then
		return nil
	end

	local var_2_0 = {
		langId = 409505
	}
	local var_2_1 = {}

	var_2_1.count = arg_2_1.num or 0
	var_2_0.param = var_2_1

	return var_2_0
end

function SpiritHelpArena:getMaxCount()
	return g.core.model.User.shopData:getLeftCount(1)
end

function SpiritHelpArena:refreshState()
	self._isTip = false

	if g.core.model.User.shopData:getLeftCount(1) <= 0 then
		self._state = var_0_0.STATE.FINISH
		self._isTip = true
		self._tipStr = g.core.lang:get(109808)

		return
	end

	self._state = var_0_0.STATE.NORMAL
end

function SpiritHelpArena:doing()
	if not self._isNeedSendAward then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_Arena_OneKeyChallenge({
				is_help = true,
				num = self:getCurCount()
			})
		end)
	else
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_GetModuleOneKeyTaskAward({
				module_id = 1
			})
		end)

		self._isFinish = true
	end
end

function SpiritHelpArena:_onRcvAllChallenge(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	for iter_8_0, iter_8_1 in ipairs(arg_8_4.awards or {}) do
		self:addCurDoAward(iter_8_1.detail)
	end

	self:addCurDoAward(arg_8_4.turn_awards)

	self._isNeedSendAward = true
end

function SpiritHelpArena:_onGetModuleAward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self._isNeedSendAward = false

	self:addCurDoAward(arg_9_4.awards)
	self:setDoingState(var_0_0.DOING_STATE.SUCCESS)
end

return SpiritHelpArena
