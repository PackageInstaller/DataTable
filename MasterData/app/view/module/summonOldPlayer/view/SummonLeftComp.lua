local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_1 = g.core.model.User.summonOldPlayerData
local var_0_2 = g.core.common.ServerTime
local SummonLeftComp = class("SummonLeftComp", require("app.fairyGUI.summonOldPlayer.UI_SummonLeftComp"))

function SummonLeftComp:ctor()
	self:_initView()
	self.m_eff:addEffectSpine({
		remove = true,
		name = "eff_ui_oldPlayer_bg",
		isLoop = false
	})
end

function SummonLeftComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OLD_PLAYER_BACK_GETINFO, self._onPlayerGetInfo, self)
	g.core.network.GameNetProxy:send_C2S_OldPlayerBack_GetInfo({})
	self:newSchedule(handler(self, self._onUpdateTime), 1)
	self:_onUpdateTime()
end

function SummonLeftComp:_onUpdateTime()
	local var_3_0, var_3_1, var_3_2, var_3_3 = var_0_2:getLeftTimeParts((var_0_1:getActivityCloseTime()))

	self.m_timeTxt:setText(g.core.lang:get(500120, {
		day = var_3_0,
		hour = var_3_1
	}))

	if var_3_0 + var_3_1 + var_3_2 + var_3_3 <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		self:closeSummonPnl()
	end
end

function SummonLeftComp:_initView()
	self.m_restartBtn:addClickListener(handler(self, self.onRestartBtnClick))
	self.m_ignoreBtn:addClickListener(handler(self, self._onSelectedNoPop))
	self.m_ignoreBtn:setSelected(g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_OLD_PLAYER_SUMMON_TIP))
end

function SummonLeftComp:_onSelectedNoPop()
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_OLD_PLAYER_SUMMON_TIP, (self.m_ignoreBtn:isSelected()))
end

function SummonLeftComp:_onPlayerGetInfo()
	self.m_state1Controller:setSelectedIndex(var_0_1:isSubscribe() and 1 or 0)
	self.m_state2Controller:setSelectedIndex(var_0_1:getRechargeAmount() > 0 and 1 or 0)
	self.m_state2Txt:setText(var_0_1:getRechargeAmount())
	self.m_stateRealController:setSelectedIndex(var_0_1:getInheritServerId() > 0 and 1 or 0)

	if var_0_1:getInheritServerId() > 0 then
		local var_6_0, var_6_1 = g.core.platform.ServerListProxy:getServerById(tonumber(var_0_1:getInheritServerId()))

		self.m_state3Txt:setText(var_6_0.name)
	end
end

function SummonLeftComp:onRestartBtnClick()
	var_0_1:setLoginNewSvr()
	g.core.platform.PlatformProxy:logout()
end

function SummonLeftComp:_onGiftRender(arg_8_1, arg_8_2)
	arg_8_2:updateSummonGiftCell(self._giftCfgData[arg_8_1 + 1])
end

function SummonLeftComp:_onSignRender(arg_9_1, arg_9_2)
	arg_9_2:updateSummonSignCell(self._signCfgData[arg_9_1 + 1])
end

function SummonLeftComp:setParent(arg_10_1)
	self._parent = arg_10_1
end

function SummonLeftComp:closeSummonPnl()
	self._parent:closeSummonPnl()
end

return SummonLeftComp
