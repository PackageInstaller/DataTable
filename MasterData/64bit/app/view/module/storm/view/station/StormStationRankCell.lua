local StormStationRankCell = class("StormStationRankCell", require("app.fairyGUI.storm.UI_StormStationRankCell"))

function StormStationRankCell:ctor()
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function StormStationRankCell:updateCell(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 < 4 then
		self.m_rankController:setSelectedIndex(arg_2_2 - 1)
	else
		self.m_rankController:setSelectedIndex(3)
		self.m_rankTxt:setText(arg_2_2)
	end

	self.m_bgController:setSelectedIndex(arg_2_2 % 2 == 1 and 0 or 1)

	if arg_2_1 then
		self.m_robotController:setSelectedIndex(0)

		local var_2_0 = arg_2_1.user

		self.m_IconComp:updateAsUser(arg_2_1.user)
		self.m_playerNameTxt:setText(var_2_0.name)
		self.m_fightValueTxt:setText(var_2_0.fight_value)

		if arg_2_3 then
			self.m_stillUp:setVisible(false)
			self.m_titleTxt:setText(g.core.config.storm_info.get(arg_2_1.city).name)
			self.m_titleNullTxt:setText("")
		else
			local var_2_1 = g.core.config.storm_city_lord_info.fetch(var_2_0.storm_city_lord)

			if var_2_1 then
				self.m_titleNullTxt:setText("")
				self.m_titleTxt:setText(var_2_1.name)
				self.m_rankIcon:setURL(g.core.common.Path:getOfficialIcon(var_2_1.res))
			else
				self.m_titleNullTxt:setText(g.core.lang:get(304611))
				self.m_titleTxt:setText("")
				self.m_rankIcon:setURL("")
			end

			local var_2_2 = var_2_0.param or 0

			if var_2_2 > 0 and not g.core.model.User.stormCityData:isProcess() then
				self.m_upTimeTxt:setText(g.core.lang:get(304536, {
					num = g.core.utils.Number.toChineseNumber(var_2_2)
				}))
				self.m_stillUp:setVisible(true)
			else
				self.m_stillUp:setVisible(false)
			end
		end
	else
		self.m_robotController:setSelectedIndex(1)
	end
end

return StormStationRankCell
