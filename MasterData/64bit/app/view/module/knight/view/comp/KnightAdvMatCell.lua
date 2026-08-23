local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST.ADVANCE_COMMON_CONVERT_ITEM_ID
local var_0_1 = g.core.common.Goods
local KnightAdvMatCell = class("KnightAdvMatCell", require("app.fairyGUI.knight.UI_KnightAdvMatCell"))

function KnightAdvMatCell:ctor()
	self:addClickListener(handler(self, self._onClicked))
end

function KnightAdvMatCell:updateCell(arg_2_1, arg_2_2)
	self._data = arg_2_1
	self._stage = arg_2_2

	self.m_matIcon:updateIcon(arg_2_1)

	if arg_2_1.size < arg_2_1.numCost then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end
end

function KnightAdvMatCell:_onClicked()
	local var_3_0 = math.max(self._data.numCost - self._data.size, 0)
	local var_3_1 = g.core.model.User.bagData:getCountById(var_0_1.TYPE_ITEM, var_0_0)

	self:addPopup(require("app.view.module.knight.view.KnightShortcutBlitzPop").new({
		matId = self._data.value,
		needNum = var_3_0,
		stage = self._stage,
		cost = self._data.numCost,
		isShowConvert = var_3_0 > 0 and var_3_1 > 0
	}))
end

return KnightAdvMatCell
