local RebornItemCell = class("RebornItemCell", require("app.fairyGUI.reborn.UI_RebornItemCell"))

function RebornItemCell:ctor()
	self._recordTable = nil
	self._index = 0
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonStageChange))
	self:addClickListener(handler(self, self._onClick))
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
end

function RebornItemCell:_onClick()
	self._isClick = true

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.CLICK_ENTER)
end

function RebornItemCell:updateItem(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._recordTable = arg_3_4
	self._index = arg_3_1

	self.m_itemComp:updateIcon({
		changeControllers = true,
		resonanceState = 1,
		type = arg_3_3,
		value = arg_3_2.base_id,
		level = arg_3_2.level,
		stage = arg_3_2.refining_level,
		refineLevel = arg_3_2.refining_level,
		glyphLevel = arg_3_2.glyph_level,
		resonanceLevel = (arg_3_3 == g.core.common.Goods.TYPE_EQUIP or nil) and (arg_3_2.resonance_level or 0)
	})
	self.m_itemComp:setTouchable(false)

	if self._recordTable[arg_3_1] then
		self.m_buttonController:setSelectedIndex(1)
	else
		self.m_buttonController:setSelectedIndex(0)
	end
end

function RebornItemCell:_onButtonStageChange()
	if not self._isClick then
		return
	end

	self._isClick = false
	self._recordTable[self._index] = self.m_buttonController:getSelectedIndex() == 1 and true or nil

	self:dispatchCompEvent("RebornItemStateChange")
end

return RebornItemCell
