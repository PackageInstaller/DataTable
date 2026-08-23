local var_0_0 = g.core.common.Goods
local GMWishItemIcon = class("GMWishItemIcon", require("app.fairyGUI.newYearWish.UI_GMWishItemIcon"))

function GMWishItemIcon:ctor()
	self._item = nil

	self:addClickListener(handler(self, self._onItemsClick))
end

function GMWishItemIcon:_onItemsClick()
	if self._item then
		local var_2_0 = clone(self._item)

		var_2_0.component = self

		g.core.common.GlobalFunc.pushInfoPop(var_2_0)
	end
end

function GMWishItemIcon:updateCell(arg_3_1, arg_3_2)
	self._item = nil

	if not arg_3_1 or not next(arg_3_1) then
		return
	end

	local var_3_0 = var_0_0:convert(arg_3_1)

	self._item = var_3_0

	self.m_qulityController:setSelectedIndex(math.clamp(var_3_0.quality, 0, 3))
	self.m_iconLoader:setURL(var_3_0.icon)
	self.m_numberText:setText(var_3_0.size or 0)
	self.m_isGetAwardController:setSelectedIndex(arg_3_2 and 1 or 0)
end

return GMWishItemIcon
