local AssistantKnightIcon = class("AssistantKnightIcon", require("app.fairyGUI.assistant.UI_AssistantKnightIcon"))
local var_0_1 = g.core.common.Path

function AssistantKnightIcon:ctor()
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
end

function AssistantKnightIcon:updateIcon(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1:getBaseInfo()

	self.m_knightIconLoader:setURL(var_0_1:getKnightIconById(g.core.config.knight_base_info.get(var_2_0.res_id).icon_id))
	self:_setIsUse(var_2_0.id == arg_2_2)
	self:setSelected(var_2_0.advance_id == arg_2_3)
end

function AssistantKnightIcon:_setIsUse(arg_3_1)
	self.m_isUseController:setSelectedIndex(arg_3_1 and 1 or 0)
end

function AssistantKnightIcon:setNominate(arg_4_1)
	arg_4_1 = arg_4_1 or 0

	self.m_isNominateController:setSelectedIndex(arg_4_1 > 0 and 1 or 0)
	self.m_selNumText:setText(arg_4_1)
end

return AssistantKnightIcon
