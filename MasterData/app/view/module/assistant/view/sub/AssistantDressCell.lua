local AssistantDressCell = class("AssistantDressCell", require("app.fairyGUI.assistant.UI_AssistantDressCell"))
local var_0_1 = g.core.config.knight_base_info
local var_0_2 = g.core.common.Path

function AssistantDressCell:ctor()
	self._index = nil

	self:addClickListener(handler(self, self.onClick))
end

function AssistantDressCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	if arg_2_1 == self.info then
		return
	end

	self.info = arg_2_1
	self._index = arg_2_2

	local var_2_0 = g.core.model.User:getAssistantDressId() or 0

	if arg_2_1.knight then
		self.m_dressNameText:setText(arg_2_1.knight.name)
		self.m_dressPicLoader:setIcon(var_0_2:getKnightPicRes(var_0_1.get(arg_2_1.knight.res_id).painted_id))
	else
		self.m_dressNameText:setText(arg_2_1.skin.name)
		self.m_dressPicLoader:setIcon(var_0_2:getKnightPicRes(var_0_1.get(arg_2_1.skin.res).painted_id))
	end

	if var_2_0 == 0 and arg_2_1.knight then
		self.m_isUseController:setSelectedIndex(1)
	elseif arg_2_1.skin and arg_2_1.skin.res == var_2_0 then
		self.m_isUseController:setSelectedIndex(1)
	else
		self.m_isUseController:setSelectedIndex(0)
	end
end

function AssistantDressCell:getSkinId()
	return (self.info and self.info.skin or nil) and self.info.skin.id
end

function AssistantDressCell:updateIsInUse(arg_4_1)
	self.m_isUseController:setSelectedIndex(arg_4_1 and 1 or 0)
end

function AssistantDressCell:onClick()
	self:dispatchCompEvent("AssistantSkinCellClick", self._index)
end

return AssistantDressCell
