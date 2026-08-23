local MineResultRankCell = class("MineResultRankCell", require("app.fairyGUI.mine.UI_MineResultRankCell"))

function MineResultRankCell:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function MineResultRankCell:updateCell(arg_2_1, arg_2_2)
	if arg_2_2 < 4 then
		self.m_rankController:setSelectedIndex(arg_2_2 - 1)
	else
		self.m_rankController:setSelectedIndex(3)
		self.m_rankTxt:setText(arg_2_2)
	end

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1:getCfg()

	self.m_buildIcon:setURL(g.core.common.Path:getCityBuildingPic(var_2_1.city_pic))
	self.m_qualityIcon:setURL((g.core.common.Path:getMineCityBuildingIconQualityPic(var_2_1.quality)))
	self.m_cityNameTxt:setText(var_2_1.name)

	if var_2_0:isInBonusEvent() then
		self.m_goodProductController:setSelectedIndex(1)
	else
		self.m_goodProductController:setSelectedIndex(0)
	end

	local var_2_2 = var_2_0:isCityOccu()

	self.m_hasGuildController:setSelectedIndex(var_2_2 and 1 or 0)

	if var_2_2 then
		local var_2_3 = var_2_0:getGuildData()

		if var_2_3 then
			self.m_guildNameTxt:setText(var_2_3.name)
			self.m_leaderNameTxt:setText(var_2_3.leader_name)
		end
	end
end

return MineResultRankCell
