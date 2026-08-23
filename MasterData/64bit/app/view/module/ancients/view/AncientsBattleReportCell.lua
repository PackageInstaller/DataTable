local AncientsBattleReportCell = class("AncientsBattleReportCell", require("app.fairyGUI.ancients.UI_AncientsBattleReportCell"))
local var_0_2 = g.core.common.Goods

function var_0_0:ctor()
	self.m_Btn_detail:addClickListener(handler(self, self._onClickBtnDetail))
end

function var_0_0:updateCell(arg_2_1)
	self._report = arg_2_1.report

	local var_2_0 = g.core.config.ancients_pet_info.fetch(self._report.def_pet_id)

	if var_2_0 then
		local var_2_1 = var_0_2:convert({
			type = var_0_2.TYPE_PET,
			value = var_2_0.advance_id
		})

		var_2_1.overrideClick = true

		self.m_Comp_pet_Equip:updateIcon(var_2_1)
		self.m_Comp_pet_Equip:setTouchFunc(handler(self, self._onClickEquip))
	end

	self.m_Txt_date:setText(g.core.common.ServerTime:getDateYMDFormat(self._report.battle_time))

	local var_2_2 = g.core.config.knight_info.fetch(self._report.def_base_id or 0)

	self.m_Comp_name:setText(self._report.def_name or "")
	self.m_Txt_score:setText(self._report.score or 0)

	local var_2_3 = {}

	var_2_3.addAction = self._report.add_score or 0

	self.m_Txt_add:setText(g.core.lang:get(309025, var_2_3))
	self.m_isWinController:setSelectedIndex(self._report.is_win and 1 or 0)
end

function var_0_0:_onClickBtnDetail()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_BATTLE_DETAIL_POP, {
		report = self._report
	})
end

function var_0_0:_onClickEquip()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INFO_POP, {
		teamId = self._report.def_team_id
	})
end

return var_0_0
