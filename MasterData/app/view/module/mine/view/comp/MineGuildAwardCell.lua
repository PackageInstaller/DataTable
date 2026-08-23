local MineGuildAwardCell = class("MineGuildAwardCell", require("app.fairyGUI.mine.UI_MineGuildAwardCell"))

function MineGuildAwardCell:ctor()
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRender))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function MineGuildAwardCell:updateCell(arg_2_1, arg_2_2)
	self.m_bgController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)

	if arg_2_2 < 4 then
		self.m_rankController:setSelectedIndex(arg_2_2 - 1)
	else
		self.m_rankController:setSelectedIndex(3)
		self.m_rankTxt:setText(arg_2_2)
	end

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1:getCfg()
	local var_2_2 = arg_2_1:getRankInfo()

	self.m_bulidIcon:setURL(g.core.common.Path:getCityBuildingPic(var_2_1.city_pic))
	self.m_qualityIcon:setURL((g.core.common.Path:getMineCityBuildingIconQualityPic(var_2_1.quality)))
	self.m_CityNameTxt:setText(var_2_1.name)

	if var_2_0:isInBonusEvent() then
		self.m_highController:setSelectedIndex(1)
	else
		self.m_highController:setSelectedIndex(0)
	end

	local var_2_3 = var_2_0:isCityOccu()

	self.m_occuStateController:setSelectedIndex(var_2_3 and 0 or 1)

	if var_2_3 then
		local var_2_5 = var_2_0:getGuildData()

		if var_2_5 then
			self.m_guideName:setText(var_2_5.name)
			self.m_svrName:setText(var_2_5.server_name)

			if g.core.model.User:getUserData().guild_id == var_2_5.id then
				-- block empty
			end
		end
	end

	self._awards = g.core.common.Drops:getGoodsArray(var_2_2.dorp_id)

	self.m_awardList:setNumItems(#self._awards)
end

function MineGuildAwardCell:_onAwardListRender(arg_3_1, arg_3_2)
	if self._awards[arg_3_1 + 1] then
		arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
	end
end

return MineGuildAwardCell
