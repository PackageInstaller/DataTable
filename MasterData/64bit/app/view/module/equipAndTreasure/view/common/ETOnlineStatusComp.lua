local ETOnlineStatusComp = class("ETOnlineStatusComp", require("app.fairyGUI.equipAndTreasure.UI_ETOnlineStatusComp"))

function ETOnlineStatusComp:updateView(arg_1_1)
	if arg_1_1 ~= nil then
		self.m_icon:setURL((g.core.common.Path:getKnightIconById(g.core.config.knight_base_info.get(arg_1_1:getBaseInfo().res_id).icon_id)))
	end
end

return ETOnlineStatusComp
