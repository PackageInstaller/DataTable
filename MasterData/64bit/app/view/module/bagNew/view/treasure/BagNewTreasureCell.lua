local BagNewTreasureCell = class("BagNewTreasureCell", require("app.fairyGUI.bagNew.UI_BagNewTreasureCell"))

function BagNewTreasureCell:ctor()
	self._oldSelectIndex = 0
	self.m_selectTrans = self:getSharedTrans("enter", "CommonSelected", self.m_selectIcon)

	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)

	self.m_buttonController = self:getController("button")

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelfSelectChanged))
end

function BagNewTreasureCell:_onTouchBegin()
	self._oldSelectIndex = self.m_buttonController:getSelectedIndex()
end

function BagNewTreasureCell:_onSelfSelectChanged()
	local var_3_0 = self.m_buttonController:getSelectedIndex()

	if var_3_0 == 1 and self._oldSelectIndex ~= var_3_0 then
		self.m_selectTrans:play()
	end
end

function BagNewTreasureCell:updateIconView(arg_4_1)
	local var_4_0 = {
		changeControllers = true,
		type = g.core.common.Goods.TYPE_TREASURE,
		value = arg_4_1.base_id,
		level = arg_4_1.level,
		stage = arg_4_1.refining_level,
		refineLevel = arg_4_1.refining_level,
		glyphLevel = arg_4_1.glyph_level,
		treasureOnlyId = arg_4_1.id
	}

	if arg_4_1.itemNum then
		var_4_0.size = arg_4_1.itemNum or nil
	end

	self.m_iconComp:updateIcon(var_4_0)
	self.m_iconComp:setTouchable(false)

	if arg_4_1.position ~= 0 then
		self.m_isWearController:setSelectedIndex(1)
		self.m_knightIcon:setURL(arg_4_1.res)
	else
		self.m_isWearController:setSelectedIndex(0)
	end
end

return BagNewTreasureCell
