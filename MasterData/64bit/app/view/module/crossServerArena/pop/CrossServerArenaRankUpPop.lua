local CrossServerArenaRankUpPop = class("CrossServerArenaRankUpPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaRankUpPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/crossServerArena/crossServerArena",
		resName = "CrossServerArenaRankUpPop",
		pkgName = "crossServerArena",
		isFullScreen = true
	})
end)

function CrossServerArenaRankUpPop:ctor(arg_2_1)
	self._curRank = arg_2_1.curRank or 0
	self._breakAwards = arg_2_1.break_awards
end

function CrossServerArenaRankUpPop:onLoad()
	self.m_promotedRankTxt:setText(self._curRank)
	self.m_enterTransition:play(handler(self, self._openRankUpAwardPop))
end

function CrossServerArenaRankUpPop:_openRankUpAwardPop()
	if self._breakAwards then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		g.core.module.ModuleManager:showFeedBackTipsPop({
			title = g.core.lang:get(302513),
			award = self._breakAwards,
			showComp = fgui.UIPackage:createObject("crossServerArena", "CrossServerArenaRankUpAwardComp")
		})
	end
end

return CrossServerArenaRankUpPop
