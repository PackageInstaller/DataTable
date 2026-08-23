local DungeonYoungLinkPop = class("DungeonYoungLinkPop", require("app.fairyGUI.dungeon.UI_DungeonYoungLinkPop"), function()
	return fgui.GComponent:create({
		pkgName = "dungeon",
		resName = "DungeonYoungLinkPop",
		pkgPath = "ui/dungeon/dungeon"
	})
end)

function DungeonYoungLinkPop:ctor()
	self:showAtCenter()
	self.m_goodDescArea:addClickListener(handler(self, self._onClickGoodArea))
	self.m_iconLoader:addClickListener(handler(self, self._onClickGoodArea))
	self:_initMainView()
	self.m_enterTransition:play()
end

function DungeonYoungLinkPop:_initMainView()
	self._goods = g.core.common.Goods:convert({
		value = 52001,
		type = g.core.common.Goods.TYPE_TITLE
	})

	self.m_iconLoader:setURL(self._goods.bigIcon)
	self.m_passDescTxt:setText(g.core.lang:get(108457, {
		num = g.core.config.achievement_info.get(10029).num
	}))
end

function DungeonYoungLinkPop:_onClickGoodArea()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

function DungeonYoungLinkPop:uniqueStyleOutTrans(arg_5_1)
	self.m_backTransition:play(arg_5_1)
end

return DungeonYoungLinkPop
