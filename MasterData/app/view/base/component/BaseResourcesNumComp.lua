local BaseResourcesNumComp = class("BaseResourcesNumComp", require("app.fairyGUI.base.UI_BaseResourcesNumComp"))
local var_0_1 = {
	[0] = cc.c3b(63, 63, 73),
	g.core.common.Color.origin
}

function BaseResourcesNumComp:ctor()
	self.m_icon = self:getChild("icon")
	self.m_title = self:getChild("title")
	self._type = 0
	self._value = 0
	self._size = 0
	self._showLack = false
	self._lackColor = nil
	self._isOwnConsumeType = false
	self._editorColorIndex = self.m_colorController:getSelectedIndex()
end

function BaseResourcesNumComp:updateByTVS(arg_2_1)
	if arg_2_1 then
		self._type = arg_2_1.type or 1
	end

	if arg_2_1 then
		self._value = arg_2_1.value or 1
	end

	if arg_2_1 then
		self._size = arg_2_1.size or 0
	end

	if arg_2_1 then
		self._showLack = arg_2_1.showLack or false
	end

	self._isOwnConsumeType = arg_2_1.ownConsumeType or false

	self.m_icon:setURL((g.core.common.Path:getIconByTypeValue(self._type, self._value, true)))
	self.m_title:setText(self._size)
	self:_updateLackState()
end

function BaseResourcesNumComp:updateIcon(arg_3_1)
	self.m_icon:setURL((arg_3_1 or nil) and (arg_3_1.icon or ""))
end

function BaseResourcesNumComp:updateNum(arg_4_1)
	if arg_4_1 then
		self._size = arg_4_1.num or 0
	end

	self.m_title:setText(self._size)
	self:_updateLackState()
end

function BaseResourcesNumComp:_updateLackState()
	if self._showLack then
		if not self._isOwnConsumeType then
			if g.core.model.User.bagData:getOwnNum(self._type, self._value) >= tonumber(self._size) then
				self.m_title:setColor((self:_getColor(self._editorColorIndex)))
			else
				local var_5_0 = g.core.common.Color

				self.m_title:setColor(self._lackColor or var_5_0.hexToCC3(var_5_0.ui[3]))
			end
		else
			self.m_colorController:setSelectedIndex(self._editorColorIndex)
		end
	else
		self.m_colorController:setSelectedIndex(self._editorColorIndex)
	end
end

function BaseResourcesNumComp:setLackColor(arg_6_1)
	self._lackColor = arg_6_1
end

function BaseResourcesNumComp:_getColor(arg_7_1)
	return var_0_1[arg_7_1]
end

return BaseResourcesNumComp
