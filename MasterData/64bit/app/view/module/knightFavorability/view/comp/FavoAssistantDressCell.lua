local var_0_0 = g.core.config.knight_base_info
local var_0_1 = g.core.common.Path
local FavoAssistantDressCell = class("FavoAssistantDressCell", require("app.fairyGUI.knightFavorability.UI_FavoAssistantDressCell"))

function FavoAssistantDressCell:ctor()
	self._resId = 0
end

function FavoAssistantDressCell:updateCell(arg_2_1)
	if arg_2_1 == self._resId then
		return
	else
		self._resId = arg_2_1
	end

	if arg_2_1 then
		self.m_dressPicLoader:setIcon((var_0_1:getKnightBookPicRes(var_0_0.get(arg_2_1).painted_id)))
	end
end

function FavoAssistantDressCell:getResId()
	return self._resId
end

return FavoAssistantDressCell
