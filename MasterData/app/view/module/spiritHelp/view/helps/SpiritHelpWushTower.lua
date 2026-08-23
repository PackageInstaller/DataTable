local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_1 = g.core.event.enum
local SpiritHelpWushTower = class("SpiritHelpWushTower", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpWushTower:initData()
	self._cellName = "SpiritHelpCell1"
	self._needAddEventList = {
		[var_0_1.EVENT_NET_S2C_DEAD_TOWER_ONEKEYSWEEP] = handler(self, self._onRcvAllBlitz)
	}
end

function SpiritHelpWushTower:getAwardText(arg_2_1)
	local var_2_0 = {
		langId = 409524
	}
	local var_2_1 = {}

	var_2_1.floor = arg_2_1.zone_id or 0
	var_2_1.stage = arg_2_1.grid_id or 0
	var_2_0.param = var_2_1

	return var_2_0
end

function SpiritHelpWushTower:refreshState()
	self._isTip = false

	local var_3_0 = self:getServerState()

	if var_3_0 == var_0_0.SERVER_STATE.NORMAL then
		self._state = var_0_0.STATE.NORMAL
	elseif var_3_0 == var_0_0.SERVER_STATE.FINISH then
		self._state = var_0_0.STATE.FINISH
	else
		self._isTip = true
		self._tipStr = g.core.lang:get(409511)
		self._state = var_0_0.STATE.LOCK
	end
end

function SpiritHelpWushTower:doing()
	if self:getServerState() == var_0_0.SERVER_STATE.NORMAL then
		self:send(function()
			g.core.network.GameNetProxy:send_C2S_DeadTower_OneKeySweep({})
		end)
	end

	self._isFinish = true
end

function SpiritHelpWushTower:_onRcvAllBlitz(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:addCurDoAward(arg_6_4.awards)
	self:setDoingState(var_0_0.DOING_STATE.SUCCESS)
end

return SpiritHelpWushTower
