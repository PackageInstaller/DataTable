local BlazingArenaRankUpPop = class("BlazingArenaRankUpPop", require("app.fairyGUI.blazingArena.UI_BlazingArenaRankUpPop"), function()
	return fgui.GComponent:create({
		pkgName = "blazingArena",
		resName = "BlazingArenaRankUpPop"
	}, ...)
end)

function BlazingArenaRankUpPop:ctor(arg_2_1)
	self._curRank = arg_2_1.curRank or 0
	self._breakAwards = arg_2_1.break_awards

	self:showAtCenter()
	self:_initView()
end

function BlazingArenaRankUpPop:onLoad()
	self.m_enterTransition:play(handler(self, self._openRankUpAwardPop))
end

function BlazingArenaRankUpPop:_initView(arg_4_1)
	self.m_promotedRankTxt:setText(self._curRank)
end

function BlazingArenaRankUpPop:_openRankUpAwardPop()
	if self._breakAwards then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		g.core.module.ModuleManager:showFeedBackTipsPop({
			title = g.core.lang:get(302513),
			award = self._breakAwards,
			showComp = fgui.UIPackage:createObject("blazingArena", "BlazingArenaRankUpAwardComp")
		})
	end
end

return BlazingArenaRankUpPop
