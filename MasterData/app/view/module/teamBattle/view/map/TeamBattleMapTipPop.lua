local TeamBattleMapTipPop = class("TeamBattleMapTipPop", require("app.fairyGUI.exploration.UI_TeamBattleMapTipPop"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleMapTipPop",
		pkgPath = "ui/exploration/exploration",
		pkgName = "exploration"
	})
end)

function TeamBattleMapTipPop:ctor(arg_2_1, arg_2_2)
	self:showAtCenter()

	self._callback = arg_2_2

	self.m_title:setText(arg_2_1)
end

function TeamBattleMapTipPop:onLoad()
	self.m_enterTransition:play(handler(self, self._onEnterEnd))
end

function TeamBattleMapTipPop:_onEnterEnd()
	self.m_backTransition:play(handler(self, self._onBackEnd))
end

function TeamBattleMapTipPop:_onBackEnd()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

	if self._callback then
		self._callback()
	end
end

return TeamBattleMapTipPop
