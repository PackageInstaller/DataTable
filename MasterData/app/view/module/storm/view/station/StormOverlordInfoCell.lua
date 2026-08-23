local StormOverlordInfoCell = class("StormOverlordInfoCell", require("app.fairyGUI.storm.UI_StormOverlordInfoCell"))

function StormOverlordInfoCell:updateView(arg_1_1)
	self.m_roundTxt:setText(g.common.ServerTime:getDateYMDFormat(arg_1_1.time))
	self.m_descTxt:setText(g.core.config.storm_info.get(arg_1_1.city).king_desc .. g.core.lang:get(304619) .. "+" .. arg_1_1.point)
end

return StormOverlordInfoCell
