local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.model.User.totalRechargeData
local TotalRechargeLayer = class("TotalRechargeLayer", require("app.fairyGUI.totalRecharge.UI_TotalRechargeLayer"), function()
	return fgui.GComponent:create({
		resName = "TotalRechargeLayer",
		pkgName = "totalRecharge",
		isFullScreen = true,
		pkgPath = "ui/totalRecharge/totalRecharge"
	}, ...)
end)

function TotalRechargeLayer:ctor(arg_2_1)
	self._totalChargeData = {}

	self:addBg("bg/activity/bg_tzfl_touzifanlibg.jpg")
	self.m_totalRechargeList:setVirtual()
	self.m_totalRechargeList:doFairyBatching(false)
	self.m_totalRechargeList:setItemRenderer(handler(self, self._onChargeItemRenderer))
	self.m_topBarComp:setResInfoById(81)
	self.m_topBarComp:setHelpId(var_0_0.HelpConst.HELP_TYPE.TOTAL_RECHARGE)
end

function TotalRechargeLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECHARGE_GETTOTALRECHARGEAWARD, handler(self, self._onRecGetAward), self)
	self:_updateList()

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function TotalRechargeLayer:_updateList()
	self._totalChargeData = var_0_1:getInfoArr()

	self.m_totalRechargeList:setNumItems(#self._totalChargeData)
	self.m_totalRechargeList:transitionShowCells("enter_right", 0.03, 1)
end

function TotalRechargeLayer:_onChargeItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._totalChargeData[arg_5_1 + 1])
end

function TotalRechargeLayer:_onRecGetAward(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4 and arg_6_4.awards then
		for iter_6_0 = #arg_6_4.awards, 1, -1 do
			if arg_6_4.awards[iter_6_0].type > 10000 then
				table.remove(arg_6_4.awards, iter_6_0)
			else
				arg_6_4.awards[iter_6_0].changeControllers = true
				arg_6_4.awards[iter_6_0].nameRow = 2
			end
		end

		g.core.module.ModuleManager:awardSummary(arg_6_4.awards)
	end

	self:_updateList()
end

return TotalRechargeLayer
