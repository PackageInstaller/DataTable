local DungeonCommonLinkBtn = class("DungeonCommonLinkBtn", require("app.fairyGUI.dungeon.UI_DungeonLinkCommonBtn"))

function DungeonCommonLinkBtn:ctor()
	self:addClickListener(handler(self, self._onClick))
end

function DungeonCommonLinkBtn:initBtnInfo(arg_2_1)
	self._goods = g.core.common.Goods:convert(arg_2_1)

	self.m_nameText:setText(self._goods.name)
	self.m_bgLoader:setURL("ui://base_new/bg_zm_pinzhi_" .. self._goods.quality + 1)
	self.m_qualityTextLoader:setURL("ui://text_new/pic_pinzhi_" .. self._goods.quality + 1)
end

function DungeonCommonLinkBtn:_onClick()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

return DungeonCommonLinkBtn
