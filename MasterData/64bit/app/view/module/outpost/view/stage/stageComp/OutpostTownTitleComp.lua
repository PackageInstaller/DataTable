local var_0_0 = g.core.model.User.outpostData
local OutpostTownTitleComp = class("OutpostTownTitleComp", require("app.fairyGUI.outpost.UI_OutpostTownTitleComp"))

function OutpostTownTitleComp:ctor()
	self:updateTownView()
	self.m_titleStr:setText(g.core.lang:get(432649, {
		name = g.core.model.User:getName()
	}))
	self.m_icon:updateAsUser(g.core.model.User:getUserData())
end

function OutpostTownTitleComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_ENTRANCE, handler(self, self.updateTownView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_KNIGHT_EXIT, handler(self, self.updateTownView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self.updateTownView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BATTLEFINISH, handler(self, self.updateTownView), self)
end

function OutpostTownTitleComp:updateTownView()
	self.m_fightValueTxt:setText(var_0_0:getFightValue())
end

return OutpostTownTitleComp
