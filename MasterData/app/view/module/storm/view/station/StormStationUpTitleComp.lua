local StormStationUpTitleComp = class("StormStationUpTitleComp", require("app.fairyGUI.storm.UI_StormStationUpTitleComp"))

function StormStationUpTitleComp:update(arg_1_1)
	local var_1_0 = arg_1_1.data.curData

	if arg_1_1.data.preData then
		local var_1_1 = g.core.config.storm_city_lord_info.get(arg_1_1.data.preData.lordInfo.id)

		self.m_preIcon:setURL(g.core.common.Path:getOfficialIcon(var_1_1.res))
		self.m_preTitle:setText(var_1_1.name)
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	if var_1_0 then
		local var_1_2 = g.core.config.storm_city_lord_info.get(var_1_0.lordInfo.id)

		self.m_curIcon:setURL(g.core.common.Path:getOfficialIcon(var_1_2.res))
		self.m_curTitle:setText(var_1_2.name)
	end

	if var_1_0 and var_1_0.rank then
		self.m_rank:setText(var_1_0.rank)
	end
end

return StormStationUpTitleComp
