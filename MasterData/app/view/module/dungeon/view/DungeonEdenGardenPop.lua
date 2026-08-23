local DungeonEdenGardenPop = class("DungeonEdenGardenPop", require("app.fairyGUI.dungeon.UI_DungeonEdenGardenPop"), function()
	return fgui.GComponent:create({
		resName = "DungeonEdenGardenPop",
		pkgPath = "ui/dungeon/dungeon",
		pkgName = "dungeon"
	})
end)

function DungeonEdenGardenPop:ctor()
	self:showAtCenter()
	self.m_goodDescArea:addClickListener(handler(self, self._onClickGoodArea))
	self.m_iconLoader:addClickListener(handler(self, self._onClickGoodArea))
	self:_initMainView()
	self.m_enterTransition:play()
end

function DungeonEdenGardenPop:_initMainView()
	self._goods = g.core.common.Goods:convert({
		value = 52002,
		type = g.core.common.Goods.TYPE_TITLE
	})

	self.m_iconLoader:setURL(self._goods.bigIcon)
	self.m_passDescTxt:setText(g.core.lang:get(108457, {
		num = g.core.config.achievement_info.get(10030).num
	}))
	self.m_linkDescBtn:initBtnInfo({
		value = 600170,
		type = g.core.common.Goods.TYPE_KNIGHT
	})
end

function DungeonEdenGardenPop:_onClickGoodArea()
	if self._goods then
		g.core.common.GlobalFunc.pushInfoPop(self._goods)
	end
end

function DungeonEdenGardenPop:uniqueStyleOutTrans(arg_5_1)
	self.m_backTransition:play(arg_5_1)
end

return DungeonEdenGardenPop
