local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.common.Path
local AllianceRankCell = class("AllianceRankCell", require("app.fairyGUI.alliance.UI_AllianceRankCell"))

function AllianceRankCell:ctor()
	self._allianceData = nil

	self.getSharedTrans(self, "enter_up", "CommonLongCellList", self)
	self.m_touchComp:addClickListener(handler(self, self._onClickAlliance))
end

function AllianceRankCell:_onClickAlliance()
	if self._allianceData then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceInfoPop").new({
			allianceSnapshot = self._allianceData
		}), {
			touchDisappear = true
		})
	end
end

function AllianceRankCell:updateRankCell(arg_3_1, arg_3_2)
	self._allianceData = arg_3_2

	if arg_3_1 % 2 == 0 then
		self.m_bg:setVisible(false)
	else
		self.m_bg:setVisible(true)
	end

	self.m_allianceName:setText(arg_3_2.name)

	if arg_3_1 <= 3 then
		self.m_rankController:setSelectedIndex(arg_3_1)
	else
		self.m_rankController:setSelectedIndex(0)
		self.m_rankTxt:setText(arg_3_1)
	end

	self.m_flag:setURL(var_0_1:getAllianceFlag128(var_0_0:getFlagRes(arg_3_2.flag)))
	self.m_levelTxt:setText(g.core.lang:get(109501, {
		level = arg_3_2.level
	}))
	self.m_forceTxt:setText(arg_3_2.fight_value)
	self.m_memberSize:setText(g.core.lang:get(109544, {
		num1 = #arg_3_2.guild_ids,
		num2 = var_0_0:getAllianceGuildMaxNumByLv(arg_3_2.level)
	}))
end

return AllianceRankCell
