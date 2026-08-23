local ElderBossPreviewPop = class("ElderBossPreviewPop", require("app.fairyGUI.elderBoss.UI_ElderBossPreviewPop"), function()
	return fgui.GComponent:create({
		resName = "ElderBossPreviewPop",
		pkgName = "elderBoss"
	}, ...)
end)

function ElderBossPreviewPop:ctor()
	self:showAtCenter()
	self:_initMainView()
	self.m_touchArea:setSize(display.width, display.height)
	self.m_touchArea:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function ElderBossPreviewPop:_initMainView()
	for iter_3_0, iter_3_1 in g.core.config.elder_boss_info.ipairs() do
		if self["m_boss" .. iter_3_0] then
			self["m_boss" .. iter_3_0]:updateBossInfo(iter_3_1)
		end
	end
end

function ElderBossPreviewPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return ElderBossPreviewPop
