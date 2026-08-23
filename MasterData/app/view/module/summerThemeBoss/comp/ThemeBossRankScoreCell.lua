local var_0_0 = g.core.model.User
local ThemeBossRankScoreCell = class("ThemeBossRankScoreCell", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossRankScoreCell"))

function ThemeBossRankScoreCell:ctor(arg_1_1)
	self.getSharedTrans(self, "enter_up", "CommonLongCellList", self)
end

function ThemeBossRankScoreCell:refreshRankCell(arg_2_1, arg_2_2, arg_2_3)
	self.m_haveBgController:setSelectedIndex(arg_2_2 % 2)

	if arg_2_1.rank < 4 then
		self.m_numController:setSelectedIndex(arg_2_1.rank)
	else
		self.m_numController:setSelectedIndex(0)
	end

	self.m_numTxt:setText(arg_2_1.rank)
	self.m_dmgTxt:setText(arg_2_1.score)

	if arg_2_3 then
		self.m_nameTxt:setText(arg_2_3.name)
		self.m_levelTxt:setText("Lv." .. arg_2_3.level)
		self.m_powerTxt:setText(arg_2_3.fight_value)

		if arg_2_3.id == var_0_0:getId() then
			arg_2_3.avata_id = var_0_0:getAvataId()
		end

		self.m_headComp:updateAsUser(arg_2_3)
	end
end

return ThemeBossRankScoreCell
