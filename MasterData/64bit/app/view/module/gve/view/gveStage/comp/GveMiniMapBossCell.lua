local GveMiniMapBossCell = class("GveMiniMapBossCell", require("app.fairyGUI.gve.UI_GveMiniMapBossCell"))

function GveMiniMapBossCell:updateCellInfo(arg_1_1)
	if arg_1_1.boss_type == 1 then
		self.m_bossIcon:setURL(g.core.common.Path:getKnightIconById(arg_1_1.image))
	else
		self.m_bossIcon:setURL("ui://gve/icon_pshc_map_boss")
	end

	self.m_nameTxt:setText(arg_1_1.name)

	local var_1_0 = g.core.model.User.gveDataMgr:getGveData():getBossData(arg_1_1.id, arg_1_1.x, arg_1_1.y):getExpireTime()

	if var_1_0 > 0 then
		local var_1_1 = g.core.common.ServerTime:getDateObject(var_1_0)

		self.m_timeTxt:setText(g.core.lang:get(309205, {
			month = var_1_1.month,
			day = var_1_1.day,
			hour = string.format("%02d", var_1_1.hour),
			min = string.format("%02d", var_1_1.min)
		}))
	else
		self.m_timeTxt:setText("")
	end
end

return GveMiniMapBossCell
