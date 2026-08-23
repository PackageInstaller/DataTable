local CrossServerArenaRankResetPop = class("CrossServerArenaRankResetPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaRankResetPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaRankResetPop",
		pkgPath = "ui/crossServerArena/crossServerArena",
		pkgName = "crossServerArena"
	})
end)

function CrossServerArenaRankResetPop:ctor(arg_2_1)
	self:showAtCenter()
	self:_initView(arg_2_1)
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
end

function CrossServerArenaRankResetPop:_initView(arg_3_1)
	self.m_rankResetText:setText(g.core.lang:get(411039, {
		oldRank = arg_3_1.oldRank,
		newRank = arg_3_1.newRank
	}))
end

function CrossServerArenaRankResetPop:_onClickConfirmBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return CrossServerArenaRankResetPop
