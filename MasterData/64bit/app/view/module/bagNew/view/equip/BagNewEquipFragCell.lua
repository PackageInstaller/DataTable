local BagNewEquipFragCell = class("BagNewEquipFragCell", require("app.fairyGUI.bagNew.UI_BagNewEquipFragCell"))

function BagNewEquipFragCell:ctor()
	self._oldSelectIndex = 0
	self.m_selectTrans = self:getSharedTrans("enter", "CommonSelected", self.m_selectIcon)

	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)

	self.m_buttonController = self:getController("button")

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelfSelectChanged))
end

function BagNewEquipFragCell:_onTouchBegin()
	self._oldSelectIndex = self.m_buttonController:getSelectedIndex()
end

function BagNewEquipFragCell:_onSelfSelectChanged()
	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if var_3_0 == 1 and self._oldSelectIndex ~= var_3_0 then
		self.m_selectTrans:play()
	end
end

function BagNewEquipFragCell:update(arg_4_1)
	if arg_4_1 then
		self.m_iconComp:updateIcon({
			overrideClick = true,
			type = arg_4_1.type,
			value = arg_4_1.value,
			size = arg_4_1.size
		})
	end
end

return BagNewEquipFragCell
