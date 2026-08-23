local var_0_0 = g.core.model.User.elderBossData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local ElderBattleReportPop = class("ElderBattleReportPop", require("app.fairyGUI.elderBoss.UI_ElderBattleReportPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/elderBoss/elderBoss",
		resName = "ElderBattleReportPop",
		pkgName = "elderBoss"
	}, ...)
end)

function ElderBattleReportPop:ctor()
	self._reportList = {}

	self:showAtCenter()
	self.m_reportList:setVirtual()
	self.m_reportList:setItemRenderer(handler(self, self._onReportListRenderer))
end

function ElderBattleReportPop:_onReportListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateText(self._reportList[arg_3_1 + 1])
end

function ElderBattleReportPop:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_ELDER_BOSS_GETREPORT, self._updateList, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateList, self)
	g.core.network.GameNetProxy:send_C2S_ElderBoss_GetReport({})
end

function ElderBattleReportPop:_updateList(arg_5_1, arg_5_2, arg_5_3)
	self._reportList = var_0_0:getReportList()

	if self._reportList == nil or #self._reportList == 0 then
		self.m_emptyController:setSelectedIndex(0)

		return
	else
		self.m_emptyController:setSelectedIndex(1)
		self.m_reportList:setNumItems(#self._reportList)
	end
end

return ElderBattleReportPop
