local AncientsBattleReportPop = class("AncientsBattleReportPop", require("app.fairyGUI.ancients.UI_AncientsBattleReportPop"), function()
	return fgui.GComponent:create({
		pkgName = "ancients",
		resName = "AncientsBattleReportPop",
		pkgPath = "ui/ancients/ancients"
	}, ...)
end)
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self:getView():center(true)
	self.m_List_report:setVirtual(self)
	self.m_List_report:setItemRenderer(handler(self, self._onRenderListReportCell))
end

function var_0_0:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_BATTLEREPORTS, handler(self, self._onRcvBattleReports), self)

	self._reportsData = {}

	if g.core.model.User.ancientsData:getAncientsState() == var_0_2.ANCIENT_STATUS.COOP then
		self:_updateView()
	else
		g.core.network.GameNetProxy:send_C2S_Ancient_BattleReports({})
	end
end

function var_0_0:_updateView()
	self.m_Txt_count:setText(self._reportsData.team_battle_times or 0)

	local var_4_1 = {}

	var_4_1.num = self._reportsData.team_win_rate or 0

	self.m_Txt_rate:setText(g.core.lang:get(408537, var_4_1))
	self.m_Txt_kill:setText(self._reportsData.self_kill or 0)
	self.m_Txt_score:setText(self._reportsData.self_score or 0)

	local var_4_2 = self._reportsData.reports or {}

	self.m_List_report:setNumItems(#var_4_2)
	self.m_is_emptyController:setSelectedIndex(#var_4_2 <= 0 and 1 or 0)
end

function var_0_0:_onRenderListReportCell(arg_5_1, arg_5_2)
	local var_5_0 = self._reportsData.reports or {}

	arg_5_2:updateCell({
		report = var_5_0[arg_5_1 + 1]
	})
end

function var_0_0:_onRcvBattleReports(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._reportsData = arg_6_4 or {}

	self:_updateView()
end

function var_0_0._getDebugReportsData(arg_7_0)
	local var_7_0 = g.core.common.ServerTime:getTime()

	return {
		self_kill = 8,
		team_win_rate = 66,
		self_score = 2400,
		team_battle_times = 12,
		reports = {
			{
				add_score = 50,
				score = 200,
				def_name = "TestPlayer1",
				def_base_id = 2001,
				def_pet_id = 1001,
				def_team_id = 10001,
				battle_time = var_7_0 - 3600
			},
			{
				add_score = 30,
				score = 180,
				def_name = "TestPlayer2",
				def_base_id = 2002,
				def_pet_id = 1002,
				def_team_id = 10002,
				battle_time = var_7_0 - 7200
			},
			{
				add_score = 20,
				score = 150,
				def_name = "TestPlayer3",
				def_base_id = 2003,
				def_pet_id = 1003,
				def_team_id = 10003,
				battle_time = var_7_0 - 10800
			}
		}
	}
end

return var_0_0
