local ArenaAwardCellIconCell = class("ArenaAwardCellIconCell", require("app.fairyGUI.arena.UI_ArenaAwardCellIconCell"))

function ArenaAwardCellIconCell:ctor()
	self._itemData = {}
	self._goods = g.core.common.Goods

	self:addClickListener(handler(self, self._onClick))
end

function ArenaAwardCellIconCell:updateIcon(arg_2_1)
	self._itemData = arg_2_1

	self.m_itemIconComp:updateIcon(arg_2_1)
end

function ArenaAwardCellIconCell:_onClick()
	if not self._itemData or not next(self._itemData) then
		return
	end

	g.core.common.GlobalFunc.pushInfoPop((self._goods:convert(self._itemData)))
end

return ArenaAwardCellIconCell
