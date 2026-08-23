local AnniversaryShareCell = class("AnniversaryShareCell", require("app.fairyGUI.anniversary.UI_AnniversaryShareCell"))

function AnniversaryShareCell:updateCell(arg_1_1)
	self:setIcon(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = arg_1_1.jigsawId
	}).icon)
	self.m_numTxt:setText(g.core.lang:get(109066, {
		num = arg_1_1.num
	}))
end

return AnniversaryShareCell
