local var_0_0 = g.core.common.Path
local BaseWeddingKnightIcon = class("BaseWeddingKnightIcon", require("app.fairyGUI.base_new.UI_BaseWeddingKnightIcon"))

function BaseWeddingKnightIcon:updateIconComp(arg_1_1)
	self.m_knightIcon:setIcon(var_0_0:getKnightIconById(g.core.config.knight_base_info.get(arg_1_1).icon_id))
end

return BaseWeddingKnightIcon
