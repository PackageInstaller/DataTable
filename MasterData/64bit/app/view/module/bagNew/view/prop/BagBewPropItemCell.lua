local BagBewPropItemCell = class("BagBewPropItemCell", require("app.fairyGUI.bagNew.UI_BagBewPropItemCell"))

function BagBewPropItemCell:ctor()
	self._oldSelectIndex = 0
	self.m_selectTrans = self:getSharedTrans("enter", "CommonSelected", self.m_selectIcon)

	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)

	self.m_buttonController = self:getController("button")

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelfSelectChanged))
end

function BagBewPropItemCell:_onTouchBegin()
	self._oldSelectIndex = self.m_buttonController:getSelectedIndex()
end

function BagBewPropItemCell:_onSelfSelectChanged()
	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if var_3_0 == 1 and self._oldSelectIndex ~= var_3_0 then
		self.m_selectTrans:play()
	end
end

function BagBewPropItemCell:updateIcon(arg_4_1)
	local var_4_0 = {
		redPointComp = self.m_redPointComp
	}
	local var_4_1 = {
		type = arg_4_1.type,
		value = arg_4_1.value
	}

	var_4_1.time = arg_4_1.time or 0
	var_4_1.onlyId = arg_4_1.onlyId
	var_4_0.customData = var_4_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, var_4_0)

	local var_4_2 = {
		redPointComp = self.m_redPointComp1
	}
	local var_4_3 = {
		type = arg_4_1.type,
		value = arg_4_1.value
	}

	var_4_3.time = arg_4_1.time or 0
	var_4_2.customData = var_4_3

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, var_4_2)
	self.m_baseItem:updateIcon({
		hideNum = false,
		type = arg_4_1.type,
		value = arg_4_1.value,
		size = arg_4_1.size
	})
end

return BagBewPropItemCell
