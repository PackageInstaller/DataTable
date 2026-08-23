local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.wushData
local SpiritHelpWush = class("SpiritHelpWush", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpWush:initData()
	self._cellName = "SpiritHelpCell1"
	self._needAddEventList = {
		[var_0_1.EVENT_NET_S2C_DEAD_BATTLE_ALLCHALLENGE] = handler(self, self._onRcvAllBlitz)
	}
end

function SpiritHelpWush:getCostText(arg_2_1)
	local var_2_0 = {
		langId = 409509
	}
	local var_2_1 = {}

	var_2_1.star = (arg_2_1.add_star or 0) - var_0_2:getAddedStar()
	var_2_0.param = var_2_1

	return var_2_0
end

function SpiritHelpWush:getAwardText(arg_3_1)
	local var_3_0 = {
		langId = 409508
	}
	local var_3_1 = {}

	var_3_1.star = arg_3_1.add_star or 0
	var_3_0.param = var_3_1

	return var_3_0
end

function SpiritHelpWush:getMaxCount()
	return var_0_2:getLeftFailTimes()
end

function SpiritHelpWush:refreshState()
	self._isTip = false

	if var_0_2:getLeftFailTimes() <= 0 then
		self._state = var_0_0.STATE.FINISH
		self._isTip = true
		self._tipStr = g.core.lang:get(303025)

		return
	end

	local var_5_0 = self:getServerState()

	if var_5_0 == var_0_0.SERVER_STATE.NORMAL then
		if #g.core.model.User.equipmentData:getAllEquipList() >= g.core.config.role_info.get(g.core.model.User:getLevel()).equipment_bag_num_client then
			self._state = var_0_0.STATE.LOCK
			self._isTip = true
			self._tipStr = (g.core.config.net_msg_error.fetch(47) or {}).error_msg

			return
		end

		self._state = var_0_0.STATE.NORMAL
	elseif var_5_0 == var_0_0.SERVER_STATE.FINISH then
		self._state = var_0_0.STATE.FINISH
	else
		self._isTip = true
		self._tipStr = g.core.lang:get(409511)
		self._state = var_0_0.STATE.LOCK
	end
end

function SpiritHelpWush:doing()
	if self:getServerState() == var_0_0.SERVER_STATE.NORMAL then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_DeadBattle_AllChallenge({
				is_helper = true
			})
		end)
	end

	self._isFinish = true
end

function SpiritHelpWush:_onRcvAllBlitz(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	for iter_8_0, iter_8_1 in ipairs(arg_8_4.awards or {}) do
		self:addCurDoAward(iter_8_1.award)
	end

	self:addCurDoAward(arg_8_4.box_awards)
	self:setDoingState(var_0_0.DOING_STATE.SUCCESS)
end

return SpiritHelpWush
